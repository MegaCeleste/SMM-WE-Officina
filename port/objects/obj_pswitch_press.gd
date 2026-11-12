# from objects/obj_pswitch_press（第 5 批移植，已核对）
# PORT: mytop 在“没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例。
# GDScript 里 Object 和 int 用 ==/!= 比较会报运行时错误，所以占位判断统一写 is_same()。
extends "res://objects/obj_physicsparent.gd"

var modo_lava: float = 0.0
var mytop = null


# from objects/obj_pswitch_press/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = G.apariencia
	alarm[0] = 5.0
	alarm[1] = 8.0
	swimming = 0.0
	modo_lava = 0.0
	mytop = GM.instance_create(x, y, A.obj_solidtop)


# from objects/obj_pswitch_press/Destroy_0.gml
func _destroy() -> void:
	if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()


# from objects/obj_pswitch_press/Step_0.gml
func _step() -> void:
	super._step()
	if GM.instance_exists(mytop):
		# ORIG-BUG: Alarm_0 之后 mytop == obj_lighting（object 编号），此处 instance_exists 为真时会把所有 obj_lighting 实例挪到本实例位置。照搬：对 mytop 的所有实例赋值。
		for inst in GM.with_list(mytop):
			inst.x = x
		for inst in GM.with_list(mytop):
			inst.y = y


# from objects/obj_pswitch_press/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(mytop):
		inst.instance_destroy()
	mytop = A.obj_lighting


# from objects/obj_pswitch_press/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()
