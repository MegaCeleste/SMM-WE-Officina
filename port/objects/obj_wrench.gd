# from objects/obj_wrench（第 5 批移植，已核对）
extends GMObject

var angle: float = 0.0
var height: float = 0.0
var imdead = null


# from objects/obj_wrench/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_wrench
		1.0:
			sprite_index = A.spr_SMB3_wrench
		2.0:
			sprite_index = A.spr_wrench
		3.0:
			sprite_index = A.spr_NSMBU_wrench
	angle = 0.0
	height = 0.0
	image_speed = 0.2
	alarm[0] = 360.0
	alarm[1] = 480.0


# from objects/obj_wrench/Step_0.gml
func _step() -> void:
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0) or (x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 128.0) and y < (GM.camera_get_view_y(GM.view_get_camera(0)) - 128.0)) or y > ((GM.camera_get_view_y(GM.view_get_camera(0)) + GM.camera_get_view_height(GM.view_get_camera(0))) + 128.0):
		instance_destroy()
	if G.apariencia == 3.0 and (not GM.instance_exists(A.obj_deadmario)):
		angle -= (15.0 * GM.gm_sign(hspeed))
	if GM.instance_exists(A.obj_deadmario):
		speed = 0.0
	match height:
		1.0:
			vspeed -= 0.05
			if vspeed < -0.5:
				vspeed = -0.5
			if y <= (ystart - 5.0):
				vspeed = 0.0
				height = 0.0
		2.0:
			vspeed -= 0.05
			if vspeed < -0.5:
				vspeed = -0.5
			if y <= (ystart - 13.0):
				vspeed = 0.0
				height = 0.0
		3.0:
			vspeed -= 0.05
			if vspeed < -0.5:
				vspeed = -0.5
			if y <= (ystart - 21.0):
				vspeed = 0.0
				height = 0.0
		4.0:
			vspeed -= 0.05
			if vspeed < -0.5:
				vspeed = -0.5
			if y <= (ystart - 29.0):
				vspeed = 0.0
				height = 0.0


# from objects/obj_wrench/Alarm_0.gml
func _alarm_0() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[0] = 7.0


# from objects/obj_wrench/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_wrench/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	_user_0()


# from objects/obj_wrench/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if not GM.instance_exists(A.obj_invincibility):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_wrench/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = sprite_index
	GM.audio_stop_sound(Scr.scr_snd_stomp(self))
	GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_wrench/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, angle, GM.c_white, image_alpha)
