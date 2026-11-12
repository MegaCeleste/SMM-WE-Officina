"""按顺序运行第 0 批全部导入/生成脚本。用法：tools/.venv/Scripts/python.exe tools/run_all.py"""
from __future__ import annotations

import importlib
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

STEPS = ["import_sprites", "import_sounds", "import_fonts", "gen_objects", "gen_depths", "gen_rooms", "gen_globals", "gen_asset_names", "check_counts", "gen_runtime", "gen_masks", "gen_paths"]


def main() -> int:
    for s in STEPS:
        mod = importlib.import_module(s)
        rc = mod.main()
        if rc:
            print(f"{s} 失败，返回 {rc}")
            return rc
    return 0


if __name__ == "__main__":
    sys.exit(main())
