extends "res://objects/obj_solid.gd"

var sprite: int = 0  ## sprite 编号
var sound: int = 0  ## sound 编号
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var index: float = 0.0
var scale: float = 1.0


# from objects/obj_bouncycloud/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"snow":
					sprite = A.spr_SMB_bouncycloud_snow
				"underwater":
					sprite = A.spr_SMB_bouncycloud_water
				"castle":
					sprite = A.spr_SMB_bouncycloud_dark
				"underground":
					sprite = A.spr_SMB_bouncycloud_night
				"ghost":
					sprite = A.spr_SMB_bouncycloud_night
				_:
					if G.modo_noche == 1.0:
						sprite = A.spr_SMB_bouncycloud_night
					else:
						sprite = A.spr_SMB_bouncycloud
			sound = A.snd_SMB3_spring
		1.0:
			match G.bg_level:
				"snow":
					sprite = A.spr_SMB3_bouncycloud_snow
				"underwater":
					sprite = A.spr_SMB3_bouncycloud_water
				"castle":
					sprite = A.spr_SMB3_bouncycloud_dark
				"underground":
					sprite = A.spr_SMB3_bouncycloud_night
				"ghost":
					sprite = A.spr_SMB3_bouncycloud_night
				_:
					if G.modo_noche == 1.0:
						sprite = A.spr_SMB3_bouncycloud_night
					else:
						sprite = A.spr_SMB3_bouncycloud
			sound = A.snd_SMB3_spring
		2.0:
			if G.bg_level == "underwater":
				sprite = A.spr_bouncycloud_water
			else:
				sprite = A.spr_bouncycloud
			sound = A.snd_spring
		3.0:
			sprite = A.spr_NSMBU_bouncycloud_idle
			sound = A.snd_NSMBU_bouncycloud
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	index = 0.0
	scale = 1.0


# from objects/obj_bouncycloud/Step_0.gml
func _step() -> void:
	if G.apariencia != 3.0:
		if ready_v == 1.0:
			index = 1.0
			scale += 0.04
			if scale > 1.2:
				ready_v = 2.0
		elif ready_v == 2.0:
			scale -= 0.04
			if scale < 1.0:
				scale = 1.0
				ready_v = 0.0
				index = 0.0
	else:
		index += 0.5
		if sprite == A.spr_NSMBU_bouncycloud_b and index >= 12.5:
			sprite = A.spr_NSMBU_bouncycloud_idle
			index = 0.0
	var mario = GM.instance_find(A.obj_mario, 0)  # PORT: 原版写 obj_mario.xxx（第一个实例）
	if collision_rectangle(bbox_left, (bbox_top - 3.0), bbox_right, bbox_top, A.obj_mario, false, false) != null and mario.bbox_bottom < bbox_top and mario.vspeed >= 0.0:
		ready_v = 1.0
		scale = 1.0
		if G.apariencia == 3.0:
			sprite = A.spr_NSMBU_bouncycloud_b
			index = 0.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(15)
			inst.groundpount = 0.0
			GM.audio_stop_sound(self.sound)
			GM.audio_play_sound(self.sound, 0.0, false)
			inst.vspeed = (-(5.62 - (2.5 * inst.isswim)))
			inst.y -= 1.0
			inst.yview = (inst.y + 32.0)
			inst.camera_jump = 1.0
			inst.alarm[0] = 4.0
			inst.state = 2.0
			inst.helice_fly = 0.0
			if GM.keyboard_check(G.saltar):
				inst.jumpnow = 1.0
			else:
				inst.jumpnow = 2.0
		GM.other = _o


# from objects/obj_bouncycloud/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite, index, (x + 32.0), (y + 8.0), scale, scale, 0.0, GM.c_white, 1.0)
