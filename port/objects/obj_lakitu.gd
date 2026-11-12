# from objects/obj_lakitu（第 6e 批移植，已核对）
extends "res://objects/obj_enemyparent.gd"

var sprite_cloud: float = 0.0
var sprite_wings: float = 0.0
var lurerange: float = 0.0
var throw_anim: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var sprout: float = 0.0
var enemyturn: float = 0.0
var cloud_index: float = 0.0
var dir: float = 0.0
var timer: float = 0.0
var activated: float = 0.0
var canthrow: float = 0.0
var object = null


# from objects/obj_lakitu/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_lakitu
			sprite_cloud = A.spr_SMB_cloud_latiku
			sprite_wings = A.spr_SMB_wings
			image_speed = 0.0
		1.0:
			sprite_index = A.spr_SMB3_lakitu
			sprite_cloud = A.spr_SMB3_cloud_latiku
			sprite_wings = A.spr_SMB3_wings
			image_speed = 0.1
		2.0:
			sprite_index = A.spr_lakitu
			sprite_cloud = A.spr_cloud_latiku
			sprite_wings = A.spr_wings
			image_speed = 0.1
		3.0:
			sprite_index = A.spr_NSMBU_lakitu
			sprite_cloud = A.spr_NSMBU_cloud_latiku
			sprite_wings = A.spr_NSMBU_wings_enemigos
			image_speed = 0.5
	lurerange = 32.0
	throw_anim = 0.0
	hardness = 0.0
	stomp = 0.0
	edible = 2.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	sprout = 0.0
	enemyturn = 0.0
	cloud_index = 0.0
	hspeed = 0.0
	dir = 1.0
	timer = 0.0
	direct = -1.0
	activated = 0.0
	canthrow = 0.0
	innave = 0.0
	dead_h = 0.0
	apilar = 0.0
	swimming = 0.0
	modo_lava = 0.0


# from objects/obj_lakitu/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0
	var i_lm = GM.instance_find(A.obj_levelmanager, 0)
	if i_lm.editor == 0.0:
		GM.instance_create(x, y, A.obj_cloud_lakitu)


# from objects/obj_lakitu/Step_0.gml
func _step() -> void:
	# PORT: 原版 view_current 兼容层没有；Step 事件里它恒为 0（只在 Draw 事件里非 0），全部写成 GM.view_get_camera(0)
	if G.bg_level == "underwater" or (GM.instance_exists(A.obj_lava_water) and (y + 8.0) >= (GM.instance_find(A.obj_lava_water, 0).y - 12.0)) or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 4.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if G.apariencia == 1.0 and throw_anim == 1.0 and image_index >= 2.9:
		image_speed = 0.0
		image_index = 2.0
		throw_anim = 0.0
	cloud_index += 0.125
	if activated == 1.0:
		if GM.instance_exists(A.obj_mario):
			if x >= (GM.camera_get_view_x(GM.view_get_camera(0)) + ((GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0) + lurerange)):
				dir = 1.0
			elif x <= ((GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0)) - lurerange):
				dir = -1.0
			if x > GM.instance_find(A.obj_mario, 0).x:
				direct = -1.0
			else:
				direct = 1.0
		var accel = 0.0375
		if wings == 1.0:
			accel = 0.0875
		if dir == 1.0:
			hspeed -= accel
		else:
			hspeed += accel
		var hspcap = 2.0
		if hspeed >= 2.0:
			hspeed = hspcap
		if hspeed <= -2.0:
			hspeed = (-hspcap)
		if wings == 1.0 and GM.instance_exists(A.obj_mario):
			if G.apariencia == 3.0:
				wings_anim += 0.8
			else:
				wings_anim += 0.12
			y = (ystart + (sin((timer * 0.06375)) * 12.0))
			timer += 1.0
	if x >= ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) + 64.0):
		if activated == 1.0:
			x = (GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) + 64.0))
	elif x <= (GM.camera_get_view_x(GM.view_get_camera(0)) - 64.0):
		if activated == 1.0:
			x = (GM.camera_get_view_x(GM.view_get_camera(0)) - 64.0)
	if x < (GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) + 64.0)) and x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 64.0):
		if activated == 0.0:
			activated = 1.0
			if canthrow == 0.0:
				canthrow = 1.0
	if activated > 0.5 and canthrow == 1.0:
		alarm[0] = 180.0
		canthrow = 2.0


# from objects/obj_lakitu/Alarm_0.gml
func _alarm_0() -> void:
	match G.apariencia:
		0.0:
			image_index = 1.0
		1.0:
			sprite_index = A.spr_SMB3_lakitu_throw
			image_speed = 0.1
		2.0:
			sprite_index = A.spr_lakitu_throw
			image_speed = 0.1
		3.0:
			sprite_index = A.spr_NSMBU_lakitu_throw
			image_index = 0.0
			image_speed = 0.5
	throw_anim = 1.0
	if G.apariencia == 3.0:
		alarm[1] = 10.0
	else:
		alarm[1] = 30.0


# from objects/obj_lakitu/Alarm_1.gml
func _alarm_1() -> void:
	if sprout == 0.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_spiny_thrown)):
			if inst.place_meeting(inst.x, inst.y, A.obj_solid):
				inst.instance_destroy()
			else:
				inst.vspeed = -3.5
				inst.hspeed = ((absf(self.hspeed) + 1.4) * self.direct)
				inst.direct = self.direct
		if G.apariencia == 2.0:
			image_speed = 0.15
			alarm[2] = 1.0
		else:
			alarm[2] = 10.0
	else:
		var sprite = Scr.scr_constant_get_sprite(self, sprout)
		if sprout == -1.0:
			var i = 0.0
			while i < 10.0:
				for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_coin_pow)):
					var spd_h = GM.random_range(-2.0, 2.0)
					var spd_v = GM.random_range(0.5, 1.4)
					inst.vspeed = (-(spd_v - (2.5 * self.swimming)))
					inst.hspeed = ((absf(self.hspeed) + spd_h) * self.direct)
				i += 1.0
		else:
			object = Scr.scr_sprite_make_object(self, x, (y - 8.0), sprite)
			for inst in GM.with_list(object):
				if inst.place_meeting(inst.x, inst.y, A.obj_solid):
					inst.instance_destroy()
				else:
					if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2 or inst.object_index == A.obj_mushroom or inst.object_index == A.obj_1up or inst.object_index == A.obj_star or inst.object_index == A.obj_hen_mushroom or inst.object_index == A.obj_megamushroom:
						inst.alarm[10] = -1.0
					if inst.object_index == A.obj_cheepcheep or inst.object_index == A.obj_cheepcheep2:
						inst.direct = self.direct
					if inst.object_index == A.obj_1up:
						inst.alarm[11] = 4.0
					inst.vspeed = (-((3.5 - (2.5 * self.swimming))))
					if inst.object_index == A.obj_shell_empty or inst.object_index == A.obj_spiny_empty:
						inst.hspeed = (absf(self.hspeed) * self.direct)
					else:
						inst.hspeed = ((absf(self.hspeed) + 1.4) * self.direct)
			if G.apariencia == 2.0:
				image_speed = 0.15
				alarm[2] = 1.0
			else:
				alarm[2] = 10.0
	if G.apariencia == 2.0:
		image_speed = 0.15
		alarm[2] = 1.0
	else:
		alarm[2] = 10.0


# from objects/obj_lakitu/Alarm_2.gml
func _alarm_2() -> void:
	match G.apariencia:
		0.0:
			image_index = 0.0
		1.0:
			image_speed = 0.1
	alarm[0] = 180.0


# from objects/obj_lakitu/Other_7.gml
func _animation_end() -> void:
	match sprite_index:
		A.spr_SMB3_lakitu_throw:
			sprite_index = A.spr_SMB3_lakitu
		A.spr_lakitu_throw:
			sprite_index = A.spr_lakitu
			image_speed = 0.1
		A.spr_NSMBU_lakitu_throw:
			sprite_index = A.spr_NSMBU_lakitu


# from objects/obj_lakitu/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 3.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_lakitu_deads
	imdead.image_index = G.apariencia
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: 括号位置错（other.bbox_left + bbox_right / 2，other/self 混用），照搬
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_lakitu/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead)):
			inst.direct = -1.0
		for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.direct = -1.0
		wings = 0.0
	else:
		_user_0()


# from objects/obj_lakitu/Draw_0.gml
func _gm_draw() -> void:
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - 13.0), (y - 26.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x + 13.0), (y - 26.0), -1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_cloud, cloud_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, 0.0, GM.c_white, 1.0)
