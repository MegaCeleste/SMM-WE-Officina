class_name GMSprite
extends RefCounted
## 一个 sprite 的元数据、贴图和碰撞遮罩。数据来自 tables/runtime.json 和 tables/masks.bin。

## 运行时碰撞类型（与 GameMaker runner 的 colcheck 一致）
const COL_AABB: int = 0
const COL_PRECISE: int = 1
const COL_ROTRECT: int = 2

var index: int = -1
var name: String = ""
var frames: int = 1
var width: int = 0
var height: int = 0
var xo: float = 0.0
var yo: float = 0.0
## 包围盒，四个值都是闭区间像素下标
var bl: int = 0
var bt: int = 0
var br: int = 0
var bb: int = 0
var kind: int = 1
var colcheck: int = COL_AABB
## 每 tick 的帧推进量（已按 playbackSpeedType 折算到 60 tick）
var tick_speed: float = 1.0

## 遮罩：每个元素是一张按位压缩的遮罩；空数组表示“无遮罩 = 包围盒内全实心”
var masks: Array[PackedByteArray] = []
var mask_stride: int = 0
var _tex: Texture2D = null
## 原点到四角的最大距离，绘制时做视野裁剪用
var cull_r: float = 0.0
var _tex_tried: bool = false


func texture() -> Texture2D:
	if not _tex_tried:
		_tex_tried = true
		var path: String = "res://assets/sprites/%s.png" % name
		if ResourceLoader.exists(path):
			_tex = load(path) as Texture2D
		else:
			push_warning("GMSprite: 找不到贴图 %s" % path)
	return _tex


## 遮罩在 (u, v)（sprite 像素坐标）处是否实心。与 runner 的 ColMaskSet 相同：
## use_floor 为真时向下取整，否则向零截断。
func mask_set(img: int, u: float, v: float, use_floor: bool) -> bool:
	if masks.is_empty():
		return true
	var iu: int
	var iv: int
	if use_floor:
		iu = floori(u)
		iv = floori(v)
	else:
		iu = int(u)
		iv = int(v)
	if iu < bl or iu > br or iv < bt or iv > bb:
		return false
	iu -= bl
	iv -= bt
	var m: PackedByteArray = masks[img]
	return (m[iv * mask_stride + (iu >> 3)] & (1 << (7 - (iu & 7)))) != 0


## 把帧号折到遮罩数组范围内
func wrap_mask_index(img: int) -> int:
	var n: int = masks.size()
	if n <= 1:
		return 0
	img = img % n
	if img < 0:
		img += n
	return img
