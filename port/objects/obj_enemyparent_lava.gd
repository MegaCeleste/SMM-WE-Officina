extends GMObject

var direct: float = 0.0


# from objects/obj_enemyparent_lava/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	direct = 1.0
	alarm[0] = 2.0


# from objects/obj_enemyparent_lava/Step_0.gml
func _step() -> void:
	hspeed = 0.0
	if sprite_index == A.spr_bowser_walk or sprite_index == A.spr_SMB3_bowser_dead or sprite_index == A.spr_bowser_walk:
		gravity = 0.1
		if vspeed > 0.05:
			vspeed = 0.04
	else:
		gravity = 0.03
		if vspeed > 0.03:
			vspeed = 0.03
	if GM.instance_exists(A.obj_lava_water) and y <= (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and GM.instance_find(A.obj_lava_water, 0).vspeed > 0.0:
		y = (GM.instance_find(A.obj_lava_water, 0).y + 16.0)
	if y >= (GM.room_height + 16.0) or (vspeed > 0.0 and GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0))):
		instance_destroy()


# from objects/obj_enemyparent_lava/Alarm_0.gml
func _alarm_0() -> void:
	if sprite_index != A.spr_rocky_idle and sprite_index != A.spr_rocky_idle2 and sprite_index != A.spr_rocky_throw:
		image_speed = 0.15


# from objects/obj_enemyparent_lava/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var _o: GMObject = GM.other
	var o = other
	if (o.invincible != -1.0 and (not GM.instance_exists(A.obj_slider)) and o.bbox_bottom < ((bbox_top - vspeed) + 6.0) and o.stompstyle == 1.0) or G.yoshi > 0.0:
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o


# from objects/obj_enemyparent_lava/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
