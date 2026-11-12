# from objects/obj_firebar（第 6b 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var spin_angle: float = 0.0
var direct_t: float = 0.0  # scr_edit_to_play 写入
var xExtra: float = 0.0
var yExtra: float = 0.0
var fireballs: float = 0.0  # scr_edit_to_play 写入
var mysolid = null


# from objects/obj_firebar/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	spin_angle = 0.0
	direct_t = 0.0
	xExtra = 0.0
	yExtra = 0.0
	fireballs = 4.0
	mysolid = GM.instance_create((x - 8.0), (y - 8.0), A.obj_solid)


# from objects/obj_firebar/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(mysolid):
		for inst in GM.with_list(mysolid):
			inst.instance_destroy()


# from objects/obj_firebar/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		if direct_t == 0.0:
			spin_angle += 15.0
			direction += 1.0
		else:
			spin_angle -= 15.0
			direction -= 1.0


# from objects/obj_firebar/Draw_0.gml
func _gm_draw() -> void:
	var i: float
	GM.draw_sprite(A.spr_firebar_base, G.apariencia, (x - 8.0), (y - 8.0))
	i = 0.0
	while i < fireballs:
		xExtra = GM.lengthdir_x((i * 8.0), direction)
		yExtra = GM.lengthdir_y((i * 8.0), direction)
		GM.draw_sprite_ext(A.spr_firebar, G.apariencia, (x + xExtra), (y + yExtra), 1.0, 1.0, spin_angle, GM.c_white, 1.0)
		if GM.instance_exists(A.obj_mario) and (not GM.instance_exists(A.obj_invincibility)) and (position_meeting(((x - 4.0) + xExtra), ((y - 4.0) + yExtra), A.obj_mario) or position_meeting(((x + 4.0) + xExtra), ((y + 4.0) + yExtra), A.obj_mario)):
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_mario):
				inst.event_user(0)
			GM.other = _o
		i += 1.0
