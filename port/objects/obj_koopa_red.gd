extends "res://objects/obj_deactenemyparent.gd"

var sprite_wings: float = 0.0
var para_y: float = 0.0
var edible: float = 0.0
var wings_anim: float = 0.0
var dontplatform: float = 0.0
var wake: float = 0.0
var startTime: float = 0.0
var imheld = null


# from objects/obj_koopa_red/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_koopa_red
			sprite_wings = A.spr_SMB_wings
			para_y = 2.0
			image_speed = 0.1
		1.0:
			sprite_index = A.spr_SMB3_koopa_red
			sprite_wings = A.spr_SMB3_wings
			para_y = 0.0
			image_speed = 0.1
		2.0:
			para_y = 0.0
			image_speed = 0.15
			sprite_wings = A.spr_wings
		3.0:
			sprite_index = A.spr_NSMBU_koopa_red
			image_speed = 0.5
			para_y = 0.0
			sprite_wings = A.spr_NSMBU_wings_enemigos
	hardness = 0.0
	stomp = 0.0
	edible = 1.0
	wings = 0.0
	wings_anim = 0.0
	paracaidas = 0.0
	key = 0.0
	direct = -1.0
	dead_h = 0.0
	innave = 0.0
	swimming = 0.0
	modo_lava = 0.0
	apilar = 0.0
	dontplatform = 0.0
	wake = 0.0
	startTime = GM.current_time
	alarm[10] = 1.0


# from objects/obj_koopa_red/Destroy_0.gml
func _destroy() -> void:
	if wings == 1.0:
		if direct == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = 1.0
		else:
			for inst in GM.with_list(GM.instance_create((x + 9.0), (y + 9.0), A.obj_wings_dead)):
				inst.direct = -1.0


# from objects/obj_koopa_red/Step_0.gml
func _step() -> void:
	if wake == 1.0:
		if image_index >= 37.5:
			if object_index == A.obj_koopa_red_b:
				sprite_index = A.spr_NSMBU_koopa_red_b
			else:
				sprite_index = A.spr_NSMBU_koopa_red
			image_index = 0.0
			image_speed = 0.5
			wake = 0.0
			alarm[10] = 1.0
		else:
			image_speed = 0.5
		dontplatform = 1.0
	else:
		dontplatform = 0.0
	if wings == 0.0 or paracaidas == 1.0:
		super._step()
		_user_6()
	if wings == 1.0 and GM.instance_exists(A.obj_mario):
		if G.apariencia == 3.0:
			wings_anim += 0.5
		else:
			wings_anim += 0.12
	if wings == 1.0 and paracaidas == 0.0:
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
		if y > (ystart + 32.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.015
		elif y < (ystart - 32.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.015
		if collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null):
			if vspeed > 0.0:
				vspeed = -0.4
		elif vspeed < 0.0 and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_hurtsolid2, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solidphy, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_bullebill_base, true, false) != null or collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null):
			vspeed = 0.4
	if paracaidas == 1.0:
		direct = -1.0
		if x > (xstart + 16.0):
			if hspeed < -0.5:
				hspeed = -0.5
			else:
				hspeed -= 0.015
		elif x < (xstart - 16.0):
			if hspeed > 0.5:
				hspeed = 0.5
			else:
				hspeed += 0.015
		if gravity == 0.0:
			_user_7()
			GM.instance_create((x + (3.0 * direct)), (y + para_y), A.obj_paracaidas_go)
			paracaidas = 0.0
			ystart = (y - 32.0)
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


# from objects/obj_koopa_red/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 0.0:
		if hspeed == 0.0:
			if wake == 1.0:
				image_speed = 0.5
			elif paracaidas == 1.0 or vspeed < 0.0 or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, false, false) != null:
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					hspeed = (0.3 * direct)
				else:
					hspeed = (0.5 * direct)
			else:
				alarm[10] = 2.0
	elif wings == 1.0 and paracaidas == 0.0:
		vspeed = 0.5
		if (not GM.instance_exists(A.obj_mario)) or GM.instance_find(A.obj_mario, 0).x < x:
			direct = -1.0
		else:
			direct = 1.0
	if G.apariencia == 3.0 and (wings == 1.0 or paracaidas == 1.0):
		sprite_index = A.spr_NSMBU_koopa_red_fly


# from objects/obj_koopa_red/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	match G.apariencia:
		0.0:
			imdead.sprite_index = A.spr_SMB_shell_red_deads
		1.0:
			imdead.sprite_index = A.spr_SMB3_koopa_red_deads
		2.0:
			imdead.sprite_index = A.spr_shell_red_deads
		3.0:
			imdead.sprite_index = A.spr_NSMBU_shell_red_deads
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


# from objects/obj_koopa_red/Other_11.gml
func _user_1() -> void:
	if wings == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(1)
		GM.other = _o
		match G.apariencia:
			0.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_SMB_shell_red
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
			1.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_SMB3_shell_red
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
			2.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_shell_red
				var mario = GM.instance_find(A.obj_mario, 0)
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_beachkoopa_red)):
					inst.sprite_index = A.spr_beachkoopa_red
					if (mario.bbox_left + (inst.bbox_right / 2.0)) <= (inst.bbox_left + (inst.bbox_right / 2.0)):
						inst.hspeed = 3.0
					elif (mario.bbox_left + (inst.bbox_right / 2.0)) >= (inst.bbox_left + (inst.bbox_right / 2.0)):
						inst.hspeed = -3.0
					else:
						inst.hspeed = (3.0 * mario.direct)
					inst.alarm[11] = 30.0
					# PORT: ready 与 Node 的信号同名，移植版变量名为 ready_v
					inst.set("ready_v", 0.0)
					inst.set("key", self.key)
			3.0:
				for inst in GM.with_list(GM.instance_create(x, y, A.obj_shell)):
					inst.sprite_index = A.spr_NSMBU_shell_red
					inst.direct = self.direct
					inst.key = self.key
					inst.alarm[3] = 540.0
					inst.alarm[4] = 640.0
		instance_destroy()
	else:
		for inst in GM.with_list(GM.instance_create((x + (9.0 * direct)), (y + 9.0), A.obj_wings_dead)):
			inst.direct = self.direct
		wings = 0.0
		if G.apariencia == 3.0:
			sprite_index = A.spr_NSMBU_koopa_red
		alarm[10] = 2.0


# from objects/obj_koopa_red/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_enemyparent_held, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if wings == 0.0:
			hspeed = (-hspeed)
		else:
			hspeed = 0.0
		if (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) == null):
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
		if (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) == null):
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0


# from objects/obj_koopa_red/Other_15.gml
func _user_5() -> void:
	imheld = GM.instance_create(x, (y - 2.0), A.obj_shell)
	match G.apariencia:
		0.0:
			imheld.sprite_index = A.spr_SMB_shell_red
		1.0:
			imheld.sprite_index = A.spr_SMB3_shell_red
		2.0:
			imheld.sprite_index = A.spr_shell_red_inside
			imheld.alarm[5] = 120.0
			imheld.koopainside = 2.0
		3.0:
			imheld.sprite_index = A.spr_NSMBU_shell_red
	imheld.flip = 1.0
	imheld.key = key
	imheld.alarm[3] = 540.0
	imheld.alarm[4] = 600.0
	if (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_physicssolid, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solidphy, true, false) == null) and (collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_bullebill_base, true, false) == null):
		if swimming == 1.0:
			imheld.vspeed = -1.8
		else:
			imheld.vspeed = -3.0
	if (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) <= (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = 0.5
	elif (GM.other.bbox_left + (GM.other.bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
		imheld.hspeed = -0.5
	instance_destroy()


# from objects/obj_koopa_red/Other_17.gml
func _user_7() -> void:
	if G.apariencia == 3.0:
		if object_index == A.obj_koopa_red_b:
			sprite_index = A.spr_NSMBU_koopa_red_b
		else:
			sprite_index = A.spr_NSMBU_koopa_red


# from objects/obj_koopa_red/Draw_0.gml
func _gm_draw() -> void:
	if paracaidas == 1.0:
		GM.draw_sprite_ext(A.spr_paracaidas, G.apariencia, (x - (3.0 * direct)), (y + para_y), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, wings_anim, (x - (9.0 * direct)), (y - 25.0), direct, 1.0, image_angle, GM.c_white, 1.0)
