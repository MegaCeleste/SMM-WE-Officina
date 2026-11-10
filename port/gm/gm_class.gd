class_name GMClass
extends RefCounted
## 一个 object（类）的运行时信息：表里的默认值 + 扫描脚本得到的事件表。

var id: int = -1
var name: String = ""
var parent_id: int = -1
var gd: GDScript = null
var sprite: int = -1
var mask: int = -1
var visible: bool = true
var persistent: bool = false
var depth: float = 0.0
## is_a[obj_id] != 0 表示本类是 obj_id 或其后代
var is_a: PackedByteArray = PackedByteArray()

var scanned: bool = false
## 该类实例要进哪些阶段表（位掩码，见 GM._list_add）
var list_mask: int = 0
var has_create: bool = false
var has_destroy: bool = false
var has_cleanup: bool = false
var has_step_begin: bool = false
var has_step: bool = false
var has_step_end: bool = false
var has_animation_end: bool = false
var has_outside_room: bool = false
var has_outside_view0: bool = false
var has_path_end: bool = false
var has_draw: bool = false
var has_draw_gui: bool = false
var has_room_start: bool = false
var has_room_end: bool = false
var has_game_start: bool = false
var has_game_end: bool = false
## 有事件的 alarm 编号（GMS 里没有对应事件的 alarm 不会走时）
var alarms: PackedInt32Array = PackedInt32Array()
## [[目标 object 编号, 方法名], …]，含继承来的
var collisions: Array = []
## 以实例为目标的鼠标事件（0–11）：事件号 → 方法名
var mouse_inst: Dictionary = {}
## 全局鼠标事件（50–61）
var mouse_global: Dictionary = {}
## KeyPress：vk 码 → 方法名
var keypress: Dictionary = {}


func scan(inst: Object, name_to_id: Dictionary) -> void:
	scanned = true
	has_create = inst.has_method(&"_create")
	has_destroy = inst.has_method(&"_destroy")
	has_cleanup = inst.has_method(&"_cleanup")
	has_step_begin = inst.has_method(&"_step_begin")
	has_step = inst.has_method(&"_step")
	has_step_end = inst.has_method(&"_step_end")
	has_animation_end = inst.has_method(&"_animation_end")
	has_outside_room = inst.has_method(&"_outside_room")
	has_outside_view0 = inst.has_method(&"_outside_view_0")
	has_path_end = inst.has_method(&"_path_end")
	has_draw = inst.has_method(&"_gm_draw")
	has_draw_gui = inst.has_method(&"_gm_draw_gui")
	has_room_start = inst.has_method(&"_room_start")
	has_room_end = inst.has_method(&"_room_end")
	has_game_start = inst.has_method(&"_game_start")
	has_game_end = inst.has_method(&"_game_end")
	alarms = PackedInt32Array()
	collisions = []
	mouse_inst = {}
	mouse_global = {}
	keypress = {}
	var seen: Dictionary = {}
	for m: Dictionary in inst.get_method_list():
		var mn: String = m["name"]
		if seen.has(mn) or not mn.begins_with("_"):
			continue
		seen[mn] = true
		if mn.begins_with("_alarm_"):
			alarms.append(int(mn.substr(7)))
		elif mn.begins_with("_collision_"):
			var target: String = mn.substr(11)
			if name_to_id.has(target):
				collisions.append([name_to_id[target], StringName(mn)])
			else:
				push_error("GMClass %s: 碰撞事件 %s 的目标 object 不存在" % [name, mn])
		elif mn.begins_with("_mouse_"):
			var n: int = int(mn.substr(7))
			if n < 50:
				mouse_inst[n] = StringName(mn)
			else:
				mouse_global[n] = StringName(mn)
		elif mn.begins_with("_keypress_"):
			keypress[int(mn.substr(10))] = StringName(mn)
	alarms.sort()
	list_mask = 0
	if has_step_begin:
		list_mask |= 1
	if has_step:
		list_mask |= 2
	if has_step_end:
		list_mask |= 4
	if not alarms.is_empty():
		list_mask |= 8
	if not collisions.is_empty():
		list_mask |= 16
	if not mouse_inst.is_empty() or not mouse_global.is_empty():
		list_mask |= 32
	if not keypress.is_empty():
		list_mask |= 64
	if has_outside_room or has_outside_view0:
		list_mask |= 128
	if has_animation_end:
		list_mask |= 256
	collisions.sort_custom(func(a: Array, b: Array) -> bool: return a[0] < b[0])
