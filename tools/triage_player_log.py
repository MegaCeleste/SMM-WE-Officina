"""汇总 tests/test_player.tscn 的日志：按 "== RUN …" 分段，统计每段里的 SCRIPT ERROR（去重后的 错误信息 @ 位置）。
用法：tools/.venv/Scripts/python.exe tools/triage_player_log.py <log>
"""
from __future__ import annotations

import collections
import re
import sys

runs: dict[str, list[str]] = collections.OrderedDict()
cur = "(before first run)"
runs[cur] = []
lines = open(sys.argv[1], encoding="utf-8", errors="replace").read().splitlines()
for i, ln in enumerate(lines):
    m = re.match(r"== RUN (.*) ==", ln)
    if m:
        cur = m.group(1)
        runs.setdefault(cur, [])
    elif "SCRIPT ERROR" in ln or ln.startswith("FAIL "):
        at = ""
        for nx in lines[i + 1 : i + 4]:
            if nx.strip().startswith("at:"):
                at = nx.strip()
                break
        runs[cur].append(f"{ln.strip()}  {at}")

by_err: dict[str, list[str]] = collections.OrderedDict()
for run, errs in runs.items():
    for e in dict.fromkeys(errs):
        by_err.setdefault(e, []).append(run)
print(f"{len(runs) - 1} runs, {sum(1 for r, e in runs.items() if e)} with errors, {len(by_err)} distinct errors")
for e, rs in sorted(by_err.items(), key=lambda kv: -len(kv[1])):
    print(f"[{len(rs)} runs] {e}")
    print("      " + "; ".join(rs[:12]) + (" …" if len(rs) > 12 else ""))
