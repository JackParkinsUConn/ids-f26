"""Build simulated prices and the seed traces. Run once: python make_data.py"""

import json
from pathlib import Path

import numpy as np
import pandas as pd

HERE = Path(__file__).parent
(HERE / "data").mkdir(exist_ok=True)

# fictional tickers, geometric Brownian motion, fixed seed
rng = np.random.default_rng(3255)
dates = pd.bdate_range("2026-01-02", "2026-06-30")
spec = {"HSKY": (100.0, 0.12, 0.28), "JNTH": (80.0, 0.20, 0.35)}
rows = []
for tk, (s0, mu, sig) in spec.items():
    z = rng.standard_normal(len(dates))
    dt = 1 / 252
    logret = (mu - sig**2 / 2) * dt + sig * np.sqrt(dt) * z
    close = s0 * np.exp(np.cumsum(np.r_[0, logret[1:]]))
    rows += [{"date": f"{d:%Y-%m-%d}", "ticker": tk, "close": round(c, 2)}
             for d, c in zip(dates, close)]
pd.DataFrame(rows).to_csv(HERE / "data" / "prices.csv", index=False)

from agent import get_prices  # noqa: E402  (needs the CSV above)

Q = ("Which stock had the higher return from 2026-01-02 to 2026-06-30, "
     "HSKY or JNTH, and by how many percentage points?")
S, E = "2026-01-02", "2026-06-30"
h, j = get_prices("HSKY", S, E), get_prices("JNTH", S, E)
expr = lambda p: f"({p['end_close']} / {p['start_close']} - 1) * 100"
rh = round(eval(expr(h)), 4)
rj = round(eval(expr(j)), 4)
win, lose = ("HSKY", "JNTH") if rh > rj else ("JNTH", "HSKY")
gap = abs(rh - rj)
final = (f"{win} had the higher return: HSKY {rh:+.2f}% vs JNTH {rj:+.2f}%, "
         f"a gap of {gap:.2f} percentage points.")

calls = [
    ("I need both stocks' prices over the window.", "get_prices",
     {"ticker": "HSKY", "start": S, "end": E}),
    ("Now the same window for JNTH.", "get_prices",
     {"ticker": "JNTH", "start": S, "end": E}),
    ("Compute HSKY's percent return exactly.", "calculator",
     {"expression": expr(h)}),
    ("Compute JNTH's percent return exactly.", "calculator",
     {"expression": expr(j)}),
]
main = [{"thought": t, "tool": n, "args": a} for t, n, a in calls]
main.append({"thought": "I have both returns.", "final": final})

bad = [{"thought": "Look up Husky's prices first.", "tool": "get_prices",
        "args": {"ticker": "HUSKY", "start": S, "end": E}},
       {"thought": "The error lists valid tickers. Use HSKY.",
        "tool": "get_prices", "args": {"ticker": "HSKY", "start": S, "end": E}}]
bad += main[1:]

loop = [{"thought": "Look up HSKY on 2026-07-10.", "tool": "get_prices",
         "args": {"ticker": "HSKY", "start": "2026-07-10",
                  "end": "2026-07-10"}}]
for s, t in [("2026-07-09", "Maybe that day is missing. Try a wider window."),
             ("2026-07-06", "Still nothing. Widen the window again."),
             ("2026-07-01", "Try starting right after the last date."),
             ("2026-07-01", "Try once more.")]:
    loop.append({"thought": t, "tool": "get_prices",
                 "args": {"ticker": "HSKY", "start": s, "end": "2026-07-10"}})

seed = "scripted seed (run record.py to record a real model)"
traces = {
    "plain": {
        "source": seed, "question": Q,
        "answer": ("I don't have access to price data for HSKY or JNTH, so I "
                   "can't compute their returns. Typically you would divide "
                   "the ending price by the starting price and subtract 1."),
    },
    "scenarios": {
        "main": {"source": seed, "question": Q, "max_steps": 8,
                 "turns": main},
        "bad_args": {"source": "scripted to show a failure mode",
                     "question": Q, "max_steps": 8, "turns": bad},
        "loop": {"source": "scripted to show a failure mode",
                 "question": "What will HSKY close at on 2026-07-10?",
                 "max_steps": 4, "turns": loop},
    },
}
(HERE / "data" / "traces.json").write_text(json.dumps(traces, indent=1))
print(final)
