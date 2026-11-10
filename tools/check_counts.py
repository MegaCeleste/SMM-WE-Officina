"""自查：各表条目数与清单（docs/inventory.md §1.2）一致。"""
from __future__ import annotations

import json
import sys

from gmlib import ASSETS, TABLES

EXPECT = {"objects": 811, "sprites": 4645, "sounds": 707, "rooms": 10, "scripts": 294}


def load(name: str) -> dict:
    return json.loads((TABLES / name).read_text(encoding="utf-8"))


def main() -> int:
    an = load("asset_names.json")
    got = {
        "objects.json": (load("objects.json")["count"], EXPECT["objects"]),
        "sprites.json": (load("sprites.json")["count"], EXPECT["sprites"]),
        "sounds.json": (load("sounds.json")["count"], EXPECT["sounds"]),
        "rooms.json": (load("rooms.json")["count"], EXPECT["rooms"]),
        "object_depths.json depth_by_object": (len(load("object_depths.json")["depth_by_object"]), EXPECT["objects"]),
        "asset_names objects": (len(an["objects"]), EXPECT["objects"]),
        "asset_names sprites": (len(an["sprites"]), EXPECT["sprites"]),
        "asset_names sounds": (len(an["sounds"]), EXPECT["sounds"]),
        "asset_names rooms": (len(an["rooms"]), EXPECT["rooms"]),
        "asset_names scripts": (len(an["scripts"]), EXPECT["scripts"]),
        "assets/sprites/*.png": (len(list((ASSETS / "sprites").glob("*.png"))), EXPECT["sprites"]),
        "assets/sounds/*": (len([p for p in (ASSETS / "sounds").iterdir() if p.suffix != ".import"]), EXPECT["sounds"]),
        "fonts.json calls": (load("fonts.json")["call_count"], 11),
    }
    bad = 0
    for k, (g, e) in got.items():
        ok = g == e
        bad += 0 if ok else 1
        print(f"  {'OK ' if ok else 'BAD'} {k}: {g} (期望 {e})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
