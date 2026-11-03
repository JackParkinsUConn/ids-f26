"""Tiny tool-calling agent used in the LLM Agents deck."""

import ast
import html
import json
import operator
from pathlib import Path

import pandas as pd

HERE = Path(__file__).parent
PRICES = pd.read_csv(HERE / "data" / "prices.csv", parse_dates=["date"])
TICKERS = sorted(PRICES["ticker"].unique())


# ---- tools ---------------------------------------------------------------

def get_prices(ticker, start, end):
    """First and last close in a date window."""
    if ticker not in TICKERS:
        raise ValueError(
            f"unknown ticker '{ticker}'. Valid tickers: {', '.join(TICKERS)}"
        )
    start, end = pd.Timestamp(start), pd.Timestamp(end)
    if start > end:
        raise ValueError("start date is after end date; swap them")
    first_day, last_day = PRICES["date"].min(), PRICES["date"].max()
    if start > last_day:
        raise ValueError(f"no data after {last_day:%Y-%m-%d}")
    df = PRICES[(PRICES["ticker"] == ticker)
                & PRICES["date"].between(start, end)]
    if df.empty:
        raise ValueError(
            f"no trading days from {start:%Y-%m-%d} to {end:%Y-%m-%d}; "
            f"data covers weekdays {first_day:%Y-%m-%d} to "
            f"{last_day:%Y-%m-%d}, so try a wider window"
        )
    first, final = df.iloc[0], df.iloc[-1]
    return {
        "ticker": ticker,
        "start_date": f"{first['date']:%Y-%m-%d}",
        "start_close": float(first["close"]),
        "end_date": f"{final['date']:%Y-%m-%d}",
        "end_close": float(final["close"]),
    }


_OPS = {
    ast.Add: operator.add, ast.Sub: operator.sub, ast.Mult: operator.mul,
    ast.Div: operator.truediv, ast.USub: operator.neg,
}


def calculator(expression):
    """Limited floating-point arithmetic: numbers and + - * / only."""
    if len(expression) > 200:
        raise ValueError("expression too long (200 characters max)")

    def ev(node):
        if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
            return node.value
        if isinstance(node, ast.BinOp) and type(node.op) in _OPS:
            return _OPS[type(node.op)](ev(node.left), ev(node.right))
        if isinstance(node, ast.UnaryOp) and type(node.op) in _OPS:
            return _OPS[type(node.op)](ev(node.operand))
        raise ValueError("only numbers and + - * / are allowed")
    return round(ev(ast.parse(expression, mode="eval").body), 4)


TOOLS = {"get_prices": get_prices, "calculator": calculator}

TOOL_SCHEMAS = [
    {
        "name": "get_prices",
        "description": "First and last daily close for a ticker in a window.",
        "input_schema": {
            "type": "object",
            "properties": {
                "ticker": {"type": "string"},
                "start": {"type": "string", "description": "YYYY-MM-DD"},
                "end": {"type": "string", "description": "YYYY-MM-DD"},
            },
            "required": ["ticker", "start", "end"],
        },
    },
    {
        "name": "calculator",
        "description": "Floating-point arithmetic with + - * / only.",
        "input_schema": {
            "type": "object",
            "properties": {"expression": {"type": "string"}},
            "required": ["expression"],
        },
    },
]


# ---- the agent loop ------------------------------------------------------

def run_agent(question, llm, tools=TOOLS, max_steps=8):
    messages = [{"role": "user", "content": question}]
    trace = []
    for _ in range(max_steps):
        turn = llm(messages)                      # model picks next action
        if "final" in turn:
            trace.append(turn)
            return trace
        try:
            result = tools[turn["tool"]](**turn["args"])   # we run the tool
        except Exception as e:
            result = {"error": str(e)}
        trace.append({**turn, "result": result})
        messages += [{"role": "assistant", "content": turn},
                     {"role": "tool", "content": result}]  # model sees it
    trace.append({"stopped": f"hit max_steps={max_steps}"})
    return trace


class ReplayLLM:
    """Scripted stand-in for a model.

    Returns pre-written turns in order and ignores `messages`, so it shows
    the loop's mechanics, not a model's planning. Turns come from
    data/traces.json (scripted by make_data.py, or recorded by record.py).
    """

    def __init__(self, turns):
        self.turns, self.i = turns, 0

    def __call__(self, messages):
        turn = self.turns[self.i]
        self.i += 1
        return turn


def load_traces():
    return json.loads((HERE / "data" / "traces.json").read_text())


def replay(name):
    """Run a recorded scenario through the real loop and real tools."""
    sc = load_traces()["scenarios"][name]
    trace = run_agent(sc["question"], ReplayLLM(sc["turns"]),
                      max_steps=sc.get("max_steps", 8))
    return sc, trace


# ---- in-slide trace player -----------------------------------------------

def _show(res):
    """Readable tool result for the slides."""
    if isinstance(res, dict) and "error" in res:
        return res["error"]
    if isinstance(res, dict) and "end_close" in res:
        d = lambda x: f"{pd.Timestamp(x):%b} {pd.Timestamp(x).day}"
        return (f"{res['ticker']}: ${res['start_close']:.2f} "
                f"({d(res['start_date'])}) \u2192 ${res['end_close']:.2f} "
                f"({d(res['end_date'])})")
    return str(res)


def _events(trace):
    ev = []
    for t in trace:
        if t.get("thought"):
            ev.append({"node": "llm", "kind": "thought", "text": t["thought"]})
        if "final" in t:
            ev.append({"node": "llm", "kind": "final", "text": t["final"]})
        elif "stopped" in t:
            ev.append({"node": "loop", "kind": "stopped", "text": t["stopped"]})
        else:
            args = ", ".join(f"{k}={v!r}" for k, v in t["args"].items())
            ev.append({"node": "tool", "kind": "call",
                       "text": f"{t['tool']}({args})"})
            res = t["result"]
            kind = "error" if isinstance(res, dict) and "error" in res else "obs"
            ev.append({"node": "obs", "kind": kind, "text": _show(res)})
    return ev


def _render(uid, height, data, cls=""):
    tpl = (HERE / "player.tpl").read_text()
    return (tpl.replace("__UID__", uid).replace("__CLS__", cls)
               .replace("__H__", str(height))
               .replace("__DATA__", html.escape(json.dumps(data), quote=True)))


def player(name, uid=None, height=430):
    """Raw HTML for a click-through agent trace."""
    sc, trace = replay(name)
    return _render(uid or f"p-{name}", height,
                   {"q": sc["question"], "src": sc["source"],
                    "ev": _events(trace)})


def player_bare(height=430):
    """Same player, but the model has no tools."""
    pl = load_traces()["plain"]
    ev = [{"node": "llm", "kind": "bare", "text": pl["answer"]}]
    return _render("p-bare", height,
                   {"q": pl["question"], "src": pl["source"], "ev": ev},
                   cls="notools")


def ci_widget():
    """Raw HTML for the live confidence-interval explorer."""
    return (HERE / "ci.tpl").read_text()
