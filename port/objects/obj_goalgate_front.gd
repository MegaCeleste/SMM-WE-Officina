# from objects/obj_goalgate_front（第 7 批移植，已核对）
extends GMObject

var alpha: float = 0.0
var bonus: float = 0.0
var bonus_a: float = 0.0  # obj_goalgate_tape 写入
var bonus_b: float = 0.0  # obj_goalgate_tape 写入
var sprite_anim: int = 0  ## sprite 编号


# from objects/obj_goalgate_front/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 1.0
	alpha = 0.0
	bonus = 0.0
	bonus_a = 0.0
	bonus_b = 0.0
	sprite_anim = A.spr_bonus_number_red


# from objects/obj_goalgate_front/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_ground3):
		x = (GM.instance_find(A.obj_ground3, 0).x + 32.0)
		y = (GM.instance_find(A.obj_ground3, 0).y - 137.0)
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		sprite_index = A.spr_goalgate
	else:
		sprite_index = A.spr_goalgate_disabled


# from objects/obj_goalgate_front/Alarm_0.gml
func _alarm_0() -> void:
	bonus = 0.0
	alarm[2] = -1.0


# from objects/obj_goalgate_front/Alarm_1.gml
func _alarm_1() -> void:
	if sprite_anim == A.spr_bonus_number_red:
		sprite_anim = A.spr_bonus_number_yellow
	else:
		sprite_anim = A.spr_bonus_number_red
	alarm[1] = 5.0


# from objects/obj_goalgate_front/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_ground3):
		GM.draw_sprite_ext(sprite_index, -1.0, (GM.instance_find(A.obj_ground3, 0).x + 32.0), (GM.instance_find(A.obj_ground3, 0).y - 136.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (y + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if bonus == 1.0:
		if bonus_a == -1.0:
			GM.draw_sprite(sprite_anim, bonus_b, (x - 31.0), (y + 39.0))
		else:
			GM.draw_sprite(sprite_anim, bonus_a, (x - 51.0), (y + 39.0))
			GM.draw_sprite(sprite_anim, bonus_b, (x - 11.0), (y + 39.0))
