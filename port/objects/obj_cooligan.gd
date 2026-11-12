extends "res://objects/obj_deactenemyparent.gd"

var s_idle: int = 0
var s_fly: int = 0
var s_hurt: int = 0
var s_deads: int = 0
var s_gafas: int = 0
var search_mario: float = 0.0
var touch_ground: float = 0.0
var edible: float = 0.0
var para_rot: float = 0.0
var jumping: float = 0.0
var anim: float = 0.0
var hurted: float = 0.0
var can_walk: float = 0.0
var mebelow = null
var activate_move: float = 0.0


# from objects/obj_cooligan/Create_0.gml
func _create() -> void:
	# / @description Cooligan
	match G.apariencia:
		0.0:
			s_idle = A.spr_SMB_cooligan_idle
			s_fly = A.spr_SMB_cooligan_fly
			s_hurt = A.spr_SMB_cooligan_hurt
		1.0:
			if (G.modo_noche == 0.0) and (G.bg_level != "underground") and (G.bg_level != "ghost"):
				s_idle = A.spr_SMB3_cooligan_idle
				s_fly = A.spr_SMB3_cooligan_fly
				s_hurt = A.spr_SMB3_cooligan_hurt
			else:
				s_idle = A.spr_SMB3_cooligan_idle_n
				s_fly = A.spr_SMB3_cooligan_fly_n
				s_hurt = A.spr_SMB3_cooligan_hurt_n
		2.0:
			s_idle = A.spr_cooligan_idle
			s_fly = A.spr_cooligan_fly
			s_hurt = A.spr_cooligan_hurt
		3.0:
			s_idle = A.spr_NSMBU_cooligan_idle
			s_fly = A.spr_NSMBU_cooligan_fly
			s_hurt = A.spr_NSMBU_cooligan_hurt
	if G.apariencia == 3.0:
		s_deads = A.spr_NSMBU_cooligan_deads
	elif G.apariencia != 3.0:
		s_deads = A.spr_cooligan_deads
	if G.apariencia == 3.0:
		mask_index = A.spr_NSMBU_cooligan_mask
	else:
		mask_index = A.spr_cooligan_mask
	if G.apariencia == 3.0:
		s_gafas = A.spr_NSMBU_cooligan_gafas
	elif G.apariencia != 3.0:
		s_gafas = A.spr_cooligan_gafas
	sprite_index = s_idle
	# How vulnerable is this enemy to various items?
	hardness = 0.0
	# How vulnerable is this enemy to Mario?
	stomp = 0.0
	# Facing direction
	direct = -1.0
	# Serach mario
	search_mario = 0.0
	touch_ground = 0.0
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
	hurted = 0.0
	can_walk = 0.0
	if G.apariencia == 3.0:
		image_speed = 0.5
	else:
		image_speed = 0.15
	apilar = 0.0
	mebelow = null
	activate_move = 1.0
	alarm[0] = 120.0


# from objects/obj_cooligan/Step_1.gml
func _step_begin() -> void:
	# Inherit the parent event
	super._step_begin()
	match G.apariencia:
		0.0:
			s_idle = A.spr_SMB_cooligan_idle
			s_fly = A.spr_SMB_cooligan_fly
			s_hurt = A.spr_SMB_cooligan_hurt
		1.0:
			if (G.modo_noche == 0.0) and (G.bg_level != "underground") and (G.bg_level != "ghost"):
				s_idle = A.spr_SMB3_cooligan_idle
				s_fly = A.spr_SMB3_cooligan_fly
				s_hurt = A.spr_SMB3_cooligan_hurt
			else:
				s_idle = A.spr_SMB3_cooligan_idle_n
				s_fly = A.spr_SMB3_cooligan_fly_n
				s_hurt = A.spr_SMB3_cooligan_hurt_n
		2.0:
			s_idle = A.spr_cooligan_idle
			s_fly = A.spr_cooligan_fly
			s_hurt = A.spr_cooligan_hurt
		3.0:
			s_idle = A.spr_NSMBU_cooligan_idle
			sprite_index = A.spr_NSMBU_cooligan_idle
			s_fly = A.spr_NSMBU_cooligan_fly
			s_hurt = A.spr_NSMBU_cooligan_hurt
	# Make the Cooligan move
	if (touch_ground == 0.0) and (hurted == 0.0):
		if not place_meeting(x, y + 1.0, A.obj_solidtop) and not place_meeting(x, y + 1.0, A.obj_physicssolid) or place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_pinchos):
			hspeed = 0.0  # Set hspeed to 0
			vspeed *= 0.9  # Decrease vspeed by 10%
			sprite_index = s_fly
	elif (touch_ground == 0.0) and (hurted == 1.0):
		if not place_meeting(x, y + 1.0, A.obj_solidtop) and not place_meeting(x, y + 1.0, A.obj_physicssolid) or place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_pinchos):
			hspeed = 0.0  # Set hspeed to 0
			vspeed *= 0.9  # Decrease vspeed by 10%
			sprite_index = s_hurt
	if place_meeting(x, y + 1.0, A.obj_solidtop) or place_meeting(x, y + 1.0, A.obj_physicssolid) or place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_pinchos):
		if hurted == 0.0:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.3 * direct)
			else:
				hspeed = (2.0 * direct)
			sprite_index = s_idle
		elif hurted == 1.0:
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.15 * direct)
			else:
				hspeed = (1.0 * direct)
			sprite_index = s_hurt
		if touch_ground == 0.0:
			touch_ground = 1.0
	else:
		if touch_ground == 1.0:
			# If there is no collision, decrease vspeed
			if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				hspeed = (0.3 * direct)
			else:
				hspeed = (2.0 * direct)
			vspeed *= 0.9  # Decrease vspeed by 10%
			if hurted == 0.0:
				# If there is no collision, decrease vspeed
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					hspeed = (0.3 * direct)
				else:
					hspeed = (2.0 * direct)
				sprite_index = s_fly
			else:
				# If there is no collision, decrease vspeed
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					hspeed = (0.15 * direct)
				else:
					hspeed = (1.0 * direct)
				sprite_index = s_hurt


# from objects/obj_cooligan/Step_0.gml
func _step() -> void:
	super._step()


# from objects/obj_cooligan/Step_2.gml
func _step_end() -> void:
	super._step_end()


# from objects/obj_cooligan/Alarm_0.gml
func _alarm_0() -> void:
	if wings == 1.0:
		if gravity == 0.0:
			jumping = 1.0
			if swimming == 0.0:
				vspeed = -2.5
			else:
				vspeed = -1.25
		else:
			alarm[0] = 10.0


# from objects/obj_cooligan/Alarm_1.gml
func _alarm_1() -> void:
	if search_mario == 0.0:
		search_mario = 1.0
	else:
		search_mario = 0.0


# from objects/obj_cooligan/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = s_deads
	match G.apariencia:
		0.0:
			imdead.image_index = 0.0
		1.0:
			if (G.modo_noche != 1.0) and (G.bg_level != "underground") and (G.bg_level != "ghost"):
				imdead.image_index = 1.0
			else:
				imdead.image_index = 3.0
		2.0:
			imdead.image_index = 2.0
		3.0:
			imdead.image_index = 0.0
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


# from objects/obj_cooligan/Other_11.gml
func _user_1() -> void:
	# /Cooligan flattening
	# If cooligan is tall, flatten somewhat
	if sprite_index == s_idle and hurted == 0.0:
		sprite_index = s_hurt
		mask_index = A.spr_cooligan_mask
		hurted = 1.0  # with id -> self
		_user_15()
	elif sprite_index == s_fly and hurted == 0.0:
		sprite_index = s_hurt
		mask_index = A.spr_cooligan_mask
		hurted = 1.0  # with id -> self
		_user_15()
	# Otherwise, dead
	else:
		_user_0()


# from objects/obj_cooligan/Other_15.gml
func _user_5() -> void:
	_user_0()


# from objects/obj_cooligan/Other_25.gml
func _user_15() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.direct = direct
	imdead.sprite_index = s_gafas
	match G.apariencia:
		0.0:
			imdead.image_index = 0.0
		1.0:
			if (G.modo_noche != 1.0) and (G.bg_level != "underground") and (G.bg_level != "ghost"):
				imdead.image_index = 1.0
			else:
				imdead.image_index = 3.0
		2.0:
			imdead.image_index = 2.0
		3.0:
			imdead.image_index = 0.0
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


# from objects/obj_cooligan/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, image_yscale, image_angle, GM.c_white, 1.0)
