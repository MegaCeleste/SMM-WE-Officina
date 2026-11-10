"""第 1 批：生成精确碰撞遮罩 port/tables/masks.bin + masks.json（读 port/assets 和 port/tables）。

yy 的 collisionKind → 运行时处理（docs/port-plan.md §5）：
  0 Precise          全部帧合成一张遮罩（alpha > tolerance）
  4 Precise per frame 每帧一张
  2 Ellipse          在包围盒里生成椭圆      # UNVERIFIED(U6)：GMS 编译器的栅格化规则未知
  3 Diamond          在包围盒里生成菱形（本工程 0 个）
  1 Rectangle / 5 Rotated rect 不需要遮罩

遮罩只覆盖包围盒区域，按行存放、每像素 1 位、高位在前，行跨度 (bw + 7) >> 3 字节
（与 GameMaker HTML5 runner 的 colmask 布局相同）。包围盒内全部为实心的遮罩不存数据，
masks.json 里记 offset = -1，运行时当作“无遮罩 = 全实心”。

masks.json: {"sprites": {sprite_index(str): [mask_count, offset, bytes_per_mask]}}
"""
from __future__ import annotations

import json
import sys

from PIL import Image

from gmlib import PORT, TABLES, write_bytes_if_changed, write_json


def _pack(bits: list[list[bool]], bw: int, bh: int) -> bytes:
    stride = (bw + 7) >> 3
    out = bytearray(stride * bh)
    for r in range(bh):
        row = bits[r]
        base = r * stride
        for c in range(bw):
            if row[c]:
                out[base + (c >> 3)] |= 1 << (7 - (c & 7))
    return bytes(out)


def main() -> int:
    sprites = json.loads((TABLES / "sprites.json").read_text(encoding="utf-8"))["sprites"]
    blob = bytearray()
    index: dict[str, list[int]] = {}
    stats = {"precise": 0, "per_frame": 0, "ellipse": 0, "diamond": 0, "full": 0, "empty_bbox": 0}
    for name, s in sprites.items():
        kind = s["collisionKind"]
        if kind in (1, 5):
            continue
        bl, bt, br, bb = s["bbox_left"], s["bbox_top"], s["bbox_right"], s["bbox_bottom"]
        w, h, frames = s["width"], s["height"], s["frames"]
        bw, bh = br - bl + 1, bb - bt + 1
        if bw <= 0 or bh <= 0:
            stats["empty_bbox"] += 1
            index[str(s["index"])] = [0, -1, 0]
            continue
        masks: list[list[list[bool]]] = []
        if kind in (0, 4):
            tol = s["collisionTolerance"]
            img = Image.open(PORT / s["file"]).convert("RGBA")
            alpha = img.getchannel("A")
            ax = alpha.load()
            iw, ih = img.size

            def frame_bits(f: int) -> list[list[bool]]:
                rows = []
                for r in range(bh):
                    y = bt + r
                    row = []
                    for c in range(bw):
                        x = f * w + bl + c
                        row.append(0 <= x < iw and 0 <= y < ih and bl + c < w and ax[x, y] > tol)
                    rows.append(row)
                return rows

            if kind == 4:
                masks = [frame_bits(f) for f in range(frames)]
                stats["per_frame"] += 1
            else:
                acc = [[False] * bw for _ in range(bh)]
                for f in range(frames):
                    fb = frame_bits(f)
                    for r in range(bh):
                        ar, fr = acc[r], fb[r]
                        for c in range(bw):
                            if fr[c]:
                                ar[c] = True
                masks = [acc]
                stats["precise"] += 1
        elif kind == 2:
            # UNVERIFIED(U6)：像素中心落在椭圆内即为实心
            rx, ry = bw / 2.0, bh / 2.0
            masks = [[[((c + 0.5 - rx) / rx) ** 2 + ((r + 0.5 - ry) / ry) ** 2 <= 1.0 for c in range(bw)]
                      for r in range(bh)]]
            stats["ellipse"] += 1
        elif kind == 3:
            rx, ry = bw / 2.0, bh / 2.0
            masks = [[[abs(c + 0.5 - rx) / rx + abs(r + 0.5 - ry) / ry <= 1.0 for c in range(bw)]
                      for r in range(bh)]]
            stats["diamond"] += 1
        else:
            print(f"gen_masks: {name} 的 collisionKind={kind} 未知")
            return 1
        if all(all(row) for m in masks for row in m):
            stats["full"] += 1
            index[str(s["index"])] = [len(masks), -1, 0]
            continue
        stride = (bw + 7) >> 3
        index[str(s["index"])] = [len(masks), len(blob), stride * bh]
        for m in masks:
            blob += _pack(m, bw, bh)
    write_bytes_if_changed(TABLES / "masks.bin", bytes(blob))
    write_json(TABLES / "masks.json", {"sprites": index, "stats": stats, "bytes": len(blob)})
    print(f"gen_masks: {stats}, {len(blob)} bytes")
    return 0


if __name__ == "__main__":
    sys.exit(main())
