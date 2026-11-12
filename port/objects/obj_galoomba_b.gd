extends "res://objects/obj_galoomba.gd"

var goomba_stomped: int = 0
# ORIG-BUG: 原版 Create 里 case 4 读 spr_SMB2_redshyguy(_night)，这两个资源不存在（A 里没有），
# GML 里读未定义变量会直接报错；apariencia 取 0~3 时走不到。声明成 null 保持“只有走到 case 4 才出错”
var spr_SMB2_redshyguy_night = null
var spr_SMB2_redshyguy = null


# from objects/obj_galoomba_b/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_goomba_b
			goomba_stomped = A.snd_goomba_stomped
		1.0:
			sprite_index = A.spr_SMB3_goomba_b
			goomba_stomped = A.snd_goomba_stomped
		2.0:
			sprite_index = A.spr_galoomba_b
			goomba_stomped = A.snd_goomba_stomped
		3.0:
			sprite_index = A.spr_NSMBU_goomba_b
			goomba_stomped = A.snd_NSMBU_goomba_stomped
		4.0:
			if (G.bg_level == "castle") or ((G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0))):
				sprite_index = spr_SMB2_redshyguy_night
			else:
				sprite_index = spr_SMB2_redshyguy
			goomba_stomped = A.snd_goomba_stomped
	hardness = 0.0
	stomp = 0.0
	search_mario = 0.0
	direct = -1.0
	edible = 1.0
	wings = 0.0
	paracaidas = 0.0
	para_rot = 0.0
	key = 0.0
	jumping = 0.0
	anim = 0.0
	innave = 0.0
	dead_h = 0.0
	swimming = 0.0
	modo_lava = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	apilar = 0.0
	mebelow = null
	startTime = GM.current_time
	alarm[10] = 2.0
	alarm[0] = 120.0


# from objects/obj_galoomba_b/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead_b)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead_b)):
				inst.set("direct", -1.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead_b)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0)


# from objects/obj_galoomba_b/Step_0.gml
func _step() -> void:
	super._step()
	if paracaidas == 1.0:
		image_speed = 0.1
		if G.apariencia == 3.0:
			anim += 0.5
		else:
			anim += 0.15
		match G.apariencia:
			0.0:
				if object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_SMB_goomba2_float_b
				else:
					sprite_index = A.spr_SMB_goomba_float_b
			1.0:
				if object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_SMB3_goomba2_float_b
				else:
					sprite_index = A.spr_SMB3_goomba_float_b
			2.0:
				if object_index == A.obj_galoomba2_b:
					sprite_index = A.spr_goomba2_float_b
				else:
					sprite_index = A.spr_goomba_float_b
		direct = -1.0
		if x > (xstart + 16.0):
			if hspeed < -1.0:
				hspeed = -1.0
			else:
				hspeed -= 0.030
		elif x < (xstart - 16.0):
			if hspeed > 1.0:
				hspeed = 1.0
			else:
				hspeed += 0.030
		if gravity == 0.0:
			match G.apariencia:
				0.0:
					if object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_SMB_goomba2_b
					else:
						sprite_index = A.spr_SMB_goomba_b
				1.0:
					if object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_SMB3_goomba2_b
					else:
						sprite_index = A.spr_SMB3_goomba_b
				2.0:
					if object_index == A.obj_galoomba2_b:
						sprite_index = A.spr_galoomba2_b
					else:
						sprite_index = A.spr_galoomba_b
			GM.instance_create(x, y, A.obj_paracaidas_go)
			paracaidas = 0.0
			anim = 0.0
			if G.apariencia == 3.0:
				image_speed = 0.5
			else:
				image_speed = 0.15
			hspeed = 0.0
			alarm[10] = 10.0
	if paracaidas == 1.0:
		var oscillationSpeed = -0.1
		var elapsedTime = (GM.current_time - startTime) / GM.room_speed
		# Calcola l'angolo oscillante tra -30 e 30 gradi
		var oscillation = (sin(oscillationSpeed * elapsedTime) * 12.0)
		image_angle = oscillation
	else:
		image_angle = 0.0
	if wings == 1.0 and paracaidas == 0.0:
		if gravity == 0.0:
			if object_index == A.obj_galoomba2_b and cambio_gombaya == 1.0:
				hspeed = (-hspeed)
				cambio_gombaya = 0.0
			if jumping > 0.0 and jumping < 4.0:
				jumping += 1.0
				if swimming == 0.0:
					vspeed = -2.5
				else:
					vspeed = -1.25
			elif jumping == 4.0:
				jumping = 5.0
				if swimming == 0.0:
					vspeed = -4.0
				else:
					vspeed = -2.0
			elif jumping == 5.0:
				jumping = 0.0
				cambio_gombaya = 1.0
				alarm[0] = 120.0


# from objects/obj_galoomba_b/Alarm_10.gml
func _alarm_10() -> void:
	if hspeed == 0.0:
		if paracaidas == 1.0 or vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.6 * direct)
			else:
				hspeed = (1.0 * direct)
		else:
			alarm[10] = 2.0


# from objects/obj_galoomba_b/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = A.spr_galoomba_deads_b
	imdead.image_index = G.apariencia
	var lm = GM.instance_find(A.obj_levelmanager, 0)
	if key == 1.0 and lm.editor == 0.0:
		for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
			inst.vspeed = -4.0
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			# ORIG-BUG: other.bbox_left 与 self 的 bbox_right / 2 混用，照搬
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


# from objects/obj_galoomba_b/Other_11.gml
func _user_1() -> void:
	if wings == 1.0:
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 8.0), A.obj_wings_dead_b)):
				inst.set("direct", self.direct)
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 8.0), A.obj_wings_dead_b)):
				inst.set("direct", -1.0 * 2.0)
			for inst in GM.with_list(GM.instance_create((x - 11.0), (y + 8.0), A.obj_wings_dead_b)):
				inst.sprite_index = A.spr_wings_dead2
				inst.set("direct", -1.0 * 2.0)
		hspeed = 0.0
		alarm[10] = 2.0
		wings = 0.0
	else:
		if G.apariencia == 2.0:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_galoomba_hold_b)):
				inst.set("key", self.key)
				inst.set("direct", self.direct)
			key = 0.0
			if key == 1.0 and G.apariencia != 2.0:
				for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_key_appear)):
					inst.vspeed = -4.0
				key = 0.0
			instance_destroy()
		elif G.apariencia != 2.0:
			for inst in GM.with_list(GM.instance_create_depth(x - 32.0, y - 32.0, -2.0, A.obj_smoke_goomba)):
				if G.apariencia != 3.0:
					inst.direct = inst.direct * 2.0
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
				else:
					inst.direct = inst.direct * 2.0
					inst.image_xscale = 2.0
					inst.image_yscale = 2.0
			GM.audio_stop_sound(goomba_stomped)
			GM.audio_play_sound(goomba_stomped, 0.0, false)
			for inst in GM.with_list(GM.instance_create_depth(x + 24.0, y, 0.0, A.obj_galoomba)):
				inst.vspeed = -3.0
				inst.hspeed = 0.5
			for inst in GM.with_list(GM.instance_create_depth(x - 24.0, y, 0.0, A.obj_galoomba)):
				inst.vspeed = -3.0
				inst.hspeed = -0.5
		instance_destroy()


# from objects/obj_galoomba_b/Other_17.gml
func _user_7() -> void:
	match G.apariencia:
		0.0:
			if object_index == A.obj_galoomba2_b:
				sprite_index = A.spr_SMB_goomba2_b
			else:
				sprite_index = A.spr_SMB_goomba_b
		1.0:
			if object_index == A.obj_galoomba2_b:
				sprite_index = A.spr_SMB3_goomba2_b
			else:
				sprite_index = A.spr_SMB3_goomba_b
		2.0:
			if object_index == A.obj_galoomba2_b:
				sprite_index = A.spr_galoomba2_b
			else:
				sprite_index = A.spr_galoomba_b


# from objects/obj_galoomba_b/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		match G.apariencia:
			0.0:
				GM.draw_sprite_ext(A.spr_SMB_wings_16x16, anim, GM.gm_round(x), y, direct * 2.0, 2.0, image_angle, GM.c_white, 1.0)
			1.0:
				GM.draw_sprite_ext(A.spr_SMB3_wings2, anim, GM.gm_round(x), y, direct * 2.0, 2.0, image_angle, GM.c_white, 1.0)
			2.0:
				GM.draw_sprite_ext(A.spr_wings2, anim, GM.gm_round(x), y, direct * 2.0, 2.0, image_angle, GM.c_white, 1.0)
			3.0:
				GM.draw_sprite_ext(A.spr_NSMBU_wings_enemigos_b, anim, (x - (4.5 * direct)), (y + 10.0), direct, 1.0, image_angle, GM.c_white, 1.0)
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, x, y, 2.0, 2.0, image_angle, GM.c_white, 1.0)
