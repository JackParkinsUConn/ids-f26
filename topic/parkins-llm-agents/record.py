"""Re-record the 'main' and 'plain' traces from a real Claude model.

Optional. The deck never calls an API; it replays data/traces.json.
Usage: set ANTHROPIC_API_KEY, then  python record.py
"""

import datetime as dt
import json
import os
import urllib.request

from agent import HERE, TOOL_SCHEMAS, TOOLS

MODEL = os.environ.get("MODEL", "claude-haiku-5-5")
SYSTEM = ("Use the tools for every number; never guess prices or do "
          "arithmetic yourself. Before each tool call, say in one short "
          "sentence what you are doing. Final answer: one sentence.")


def call(messages, tools=True):
    body = {"model": MODEL, "max_tokens": 512, "messages": messages}
    if tools:
        body |= {"system": SYSTEM, "tools": TOOL_SCHEMAS,
                 "tool_choice": {"type": "auto",
                                 "disable_parallel_tool_use": True}}
    req = urllib.request.Request(
        "https://api.anthropic.com/v1/messages",
        data=json.dumps(body).encode(),
        headers={"x-api-key": os.environ["ANTHROPIC_API_KEY"],
                 "anthropic-version": "2023-06-01",
                 "content-type": "application/json"})
    with urllib.request.urlopen(req) as r:
        return json.load(r)


def record(question, max_steps=8):
    messages, turns = [{"role": "user", "content": question}], []
    for _ in range(max_steps):
        resp = call(messages)
        text = " ".join(b["text"] for b in resp["content"]
                        if b["type"] == "text").strip()
        use = next((b for b in resp["content"] if b["type"] == "tool_use"),
                   None)
        if use is None:
            turns.append({"thought": "", "final": text})
            break
        turns.append({"thought": text, "tool": use["name"],
                      "args": use["input"]})
        try:
            result, err = TOOLS[use["name"]](**use["input"]), False
        except Exception as e:
            result, err = {"error": str(e)}, True
        messages += [
            {"role": "assistant", "content": resp["content"]},
            {"role": "user", "content": [{
                "type": "tool_result", "tool_use_id": use["id"],
                "content": json.dumps(result), "is_error": err}]},
        ]
    return turns


if __name__ == "__main__":
    path = HERE / "data" / "traces.json"
    traces = json.loads(path.read_text())
    src = f"recorded from {MODEL} on {dt.date.today()}"
    q = traces["scenarios"]["main"]["question"]
    traces["scenarios"]["main"] |= {"source": src, "turns": record(q)}
    plain = call([{"role": "user", "content": q}], tools=False)
    traces["plain"] |= {"source": src, "answer": " ".join(
        b["text"] for b in plain["content"] if b["type"] == "text").strip()}
    path.write_text(json.dumps(traces, indent=1))
    print(json.dumps(traces["scenarios"]["main"]["turns"], indent=1))
