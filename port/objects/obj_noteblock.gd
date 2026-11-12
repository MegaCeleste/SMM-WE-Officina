# from objects/obj_noteblock（第 5 批移植，已核对）
extends "res://objects/obj_blockparent.gd"

var sound_block: float = 0.0
var up: float = 0.0
var down: float = 0.0
var sprout: float = 0.0
var sonido: float = 0.0
var ready2: float = 0.0
var disabled: float = 0.0
var index: float = 0.0


# from objects/obj_noteblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_noteblock
			image_speed = 0.0
			sprite_wings = A.spr_SMB_wings_16x16
			sound_block = A.snd_SMB3_spring
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				_:
					if G.modo_noche == 1.0:
						image_index = 1.0
					else:
						image_index = 0.0
		1.0:
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_noteblock_ice
					else:
						sprite_index = A.spr_SMB3_noteblock
				"castle":
					sprite_index = A.spr_SMB3_noteblock_dark
				"ghost":
					sprite_index = A.spr_SMB3_noteblock_night
				"underground":
					sprite_index = A.spr_SMB3_noteblock_night
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_noteblock_night
					else:
						sprite_index = A.spr_SMB3_noteblock
			image_speed = 0.15
			sprite_wings = A.spr_SMB3_wings2
			sound_block = A.snd_SMB3_spring
		2.0:
			sprite_index = A.spr_noteblock
			image_speed = 0.15
			sprite_wings = A.spr_wings_items
			sound_block = A.snd_spring
		3.0:
			sprite_index = A.spr_NSMBU_noteblock
			image_speed = 0.25
			sprite_wings = A.spr_NSMBU_wings_items
			sound_block = A.snd_NSMBU_noteblock
	up = 0.0
	down = 0.0
	sprout = -1.0
	sonido = 0.0
	ready_v = 0.0
	ready2 = 0.0
	downwards = 0.0
	wings = 0.0
	wings_anim = 0.0
	expand = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	disabled = 1.0
	index = A.snd_mb_mario


# from objects/obj_noteblock/Step_0.gml
func _step() -> void:
	if ready_v == 1.0:
		if vspeed < 0.0 and down == 0.0 and y <= (ystart - 8.0):
			vspeed = 2.0
			down = 1.0
		elif vspeed > 0.0 and down == 1.0 and y >= ystart:
			down = 0.0
			downwards = 0.0
			alarm[1] = 1.0
		if vspeed > 0.0 and up == 0.0 and y >= (ystart + 8.0):
			up = 1.0
			vspeed = -2.0
		elif vspeed < 0.0 and up == 1.0 and y <= ystart:
			up = 0.0
			downwards = 1.0
			alarm[1] = 1.0
	if ready_v == 0.0:
		if collision_rectangle(bbox_left, (bbox_top - 3.0), bbox_right, bbox_top, A.obj_mario, false, false) != null and GM.instance_find(A.obj_mario, 0).bbox_bottom < bbox_top and GM.instance_find(A.obj_mario, 0).vspeed >= 0.0 and ready2 == 0.0:
			ready_v = 1.0
			ready2 = 1.0
			vspeed = 2.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(A.obj_mario):
				inst.hspeed = 0.0
				inst.event_user(15)
				inst.groundpount = 0.0
			GM.other = _o
	if ready2 == 1.0 and GM.instance_exists(A.obj_mario) and collision_rectangle(bbox_left, (bbox_top - 3.0), bbox_right, bbox_top, A.obj_mario, false, false) != null:
		for inst in GM.with_list(A.obj_mario):
			inst.y = ((y - 32.0) + vspeed)
		for inst in GM.with_list(A.obj_mario):
			inst.state = 0.0
		for inst in GM.with_list(A.obj_mario):
			inst.vspeed = 0.0
	_user_4()


# from objects/obj_noteblock/Alarm_0.gml
func _alarm_0() -> void:
	alarm[1] = 10.0
	vspeed = 2.0


# from objects/obj_noteblock/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	event_user(int(downwards))
	if ready2 == 1.0 and GM.instance_exists(A.obj_mario) and place_meeting(x, (y - 16.0), A.obj_mario):
		ready2 = 0.0
		for inst in GM.with_list(A.obj_mario):
			GM.audio_stop_sound(int(sound_block))
			GM.audio_play_sound(int(sound_block), 0.0, false)
			inst.vspeed = (-(5.0 - (2.0 * inst.isswim)))
			inst.y -= 1.0
			inst.state = 2.0
			inst.helice_fly = 0.0
			if GM.keyboard_check(int(G.saltar)):
				inst.jumpnow = 1.0
			elif GM.keyboard_check(int(G.saltar_spin)) and inst.holding == 0.0 and G.apariencia > 1.0:
				if G.apariencia == 3.0:
					GM.audio_stop_sound(A.snd_NSMBU_spinjump)
					GM.audio_play_sound(A.snd_NSMBU_spinjump, 0.0, false)
				else:
					GM.audio_stop_sound(A.snd_spin)
					GM.audio_play_sound(A.snd_spin, 0.0, false)
				inst.stompstyle = 1.0
			else:
				inst.jumpnow = 2.0
	ready2 = 0.0
	alarm[4] = 2.0


# from objects/obj_noteblock/Alarm_3.gml
func _alarm_3() -> void:
	alarm[1] = 10.0
	vspeed = -2.0


# from objects/obj_noteblock/Alarm_4.gml
func _alarm_4() -> void:
	ready_v = 0.0


# from objects/obj_noteblock/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	return


# from objects/obj_noteblock/Other_10.gml
func _user_0() -> void:
	if sprout != -1.0:
		if sprout == -28.0:
			GM.audio_play_sound(Scr.scr_snd_sprout(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, ystart, A.obj_beanstalk)):
				inst.ready_v = 0.0  # PORT: GML 的 ready 在移植里统一改名 ready_v（obj_beanstalk 第 7 批已移植，同名声明）
				inst.alarm[2] = 60.0
			sprout = -1.0
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_powerupsprout_note)):
				var _o: GMObject = GM.other
				GM.other = self
				inst.sprite_index = int(Scr.scr_constant_get_sprite(inst, sprout))
				GM.other = _o
				inst.wings = wings
				inst.s_sprout = sprout
			sprout = -1.0


# from objects/obj_noteblock/Other_11.gml
func _user_1() -> void:
	if sprout != -1.0:
		if sprout == -28.0:
			GM.audio_play_sound(Scr.scr_snd_sprout(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, ystart, A.obj_beanstalk)):
				inst.ready_v = 0.0  # PORT: 同上，ready 改名 ready_v
				inst.downwards = 1.0
				inst.alarm[2] = 60.0
			sprout = -1.0
		else:
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_powerupsprout_note)):
				var _o: GMObject = GM.other
				GM.other = self
				inst.sprite_index = int(Scr.scr_constant_get_sprite(inst, sprout))
				GM.other = _o
				inst.downwards = 1.0
				inst.wings = wings
				inst.s_sprout = sprout
			sprout = -1.0


# from objects/obj_noteblock/Other_14.gml
func _user_4() -> void:
	var objeto
	var bullet_base
	var physolido
	var solidphy
	var spd
	if x > (float(Scr.__view_get(self, Scr.e__VW.XView, 0)) - 128.0) and (x + 16.0) < ((float(Scr.__view_get(self, Scr.e__VW.XView, 0)) + float(Scr.__view_get(self, Scr.e__VW.WView, 0))) + 128.0):
		objeto = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, bbox_top, A.obj_physicsparent, false, false)
		if objeto != null and ((objeto.object_index == A.obj_pswitch and (objeto.held == 1.0 or objeto.inup == 1.0)) or (objeto.object_index == A.obj_block_pow_hold and objeto.held == 1.0) or (objeto.object_index == A.obj_spring and objeto.held == 1.0) or (objeto.object_index == A.obj_bobomb_hold and objeto.held == 1.0) or (objeto.object_index == A.obj_galoomba_hold and objeto.held == 1.0) or (objeto.object_index == A.obj_galoomba_hold2 and objeto.held == 1.0) or (objeto.object_index == A.obj_buzzybeetle and objeto.inup == 1.0) or (objeto.object_index == A.obj_jumppiranha and objeto.inup > 0.0) or (objeto.object_index == A.obj_buzzybeetle_b and objeto.inup == 1.0) or (objeto.object_index == A.obj_spiny and objeto.inup == 1.0) or (objeto.object_index == A.obj_mushroom and objeto.wings == 1.0) or (objeto.object_index == A.obj_1up and objeto.wings == 1.0) or (objeto.object_index == A.obj_fireflower and objeto.wings == 1.0) or (objeto.object_index == A.obj_superflower and objeto.wings == 1.0) or (objeto.object_index == A.obj_hen_mushroom and objeto.wings == 1.0) or (objeto.object_index == A.obj_egg and objeto.wings == 1.0) or (objeto.object_index == A.obj_egg_red and objeto.wings == 1.0) or (objeto.object_index == A.obj_megamushroom and objeto.wings == 1.0) or (objeto.object_index == A.obj_star and objeto.wings == 1.0) or objeto.object_index == A.obj_propellershroom or (objeto.object_index == A.obj_frogsuit and objeto.wings == 1.0) or (objeto.object_index == A.obj_hammersuit and objeto.wings == 1.0) or (objeto.object_index == A.obj_penguin_suit and objeto.wings == 1.0) or (objeto.object_index == A.obj_superarcon and objeto.wings == 1.0)):
			return
		if objeto != null and (objeto.object_index == A.obj_banzaibill or objeto.object_index == A.obj_billbanzai_red or objeto.object_index == A.obj_bulletbill or objeto.object_index == A.obj_bulletbull_red or objeto.object_index == A.obj_fire_clown or objeto.object_index == A.obj_fireball or objeto.object_index == A.obj_snowball or objeto.object_index == A.obj_podoboo or objeto.object_index == A.obj_podoboo_b or objeto.object_index == A.obj_angrysun or objeto.object_index == A.obj_yoshifire or objeto.object_index == A.obj_yoshifire_one or objeto.object_index == A.obj_cheepcheep or objeto.object_index == A.obj_cheepcheep2 or objeto.object_index == A.obj_thwomp or objeto.object_index == A.obj_grinder or objeto.object_index == A.obj_boo or objeto.object_index == A.obj_floruga or objeto.object_index == A.obj_floruga_body or objeto.object_index == A.obj_cannonball or objeto.object_index == A.obj_cannonball_red or objeto.object_index == A.obj_magikoopa or objeto.object_index == A.obj_piranhaplant or objeto.object_index == A.obj_rocky or objeto.object_index == A.obj_lakitu or objeto.object_index == A.obj_cap):
			return
		if objeto != null and ready_v == 0.0 and objeto.bbox_bottom < (bbox_top + 5.0) and objeto.vspeed >= 0.0:
			bullet_base = collision_rectangle(objeto.bbox_left, (objeto.bbox_top - 1.0), objeto.bbox_right, objeto.bbox_top, A.obj_bullebill_base, true, false)
			physolido = collision_rectangle(objeto.bbox_left, (objeto.bbox_top - 1.0), objeto.bbox_right, objeto.bbox_top, A.obj_physicssolid, true, false)
			solidphy = collision_rectangle(objeto.bbox_left, (objeto.bbox_top - 1.0), objeto.bbox_right, objeto.bbox_top, A.obj_solidphy, true, false)
			if ((collision_rectangle(objeto.bbox_left, (objeto.bbox_top - 1.0), objeto.bbox_right, objeto.bbox_top, A.obj_solid, true, false) == null) and (bullet_base == null)) or (bullet_base != null and bullet_base == objeto and (physolido == null)) or (physolido != null and physolido == objeto and (solidphy == null)) or (solidphy != null and solidphy == objeto):
				spd = 5.225
			else:
				spd = 0.5
			if objeto.object_index == A.obj_clown or objeto.object_index == A.obj_clown_fire:
				spd = (spd / 10.0)
			elif objeto.object_index == A.obj_jumppiranha and G.apariencia == 2.0:
				spd = (spd / 3.5)
			objeto.vspeed = 0.0
			if G.bg_level == "underwater" or ((G.bg_level == "sky" or G.bg_level == "airship") and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and objeto.y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
				objeto.vspeed = (-(spd / 2.0))
			else:
				objeto.vspeed = (-spd)
			ready_v = 1.0
			vspeed = 2.0
			if object_index == A.obj_musicblock:
				match objeto.object_index:
					A.obj_galoomba:
						index = A.snd_mb_goomba
					A.obj_galoomba2:
						index = A.snd_mb_goombrat
					A.obj_koopa:
						index = A.snd_mb_green_koopa
					A.obj_koopa_b:
						index = A.snd_mb_green_koopa
					A.obj_koopa_red:
						index = A.snd_mb_red_koopa
					A.obj_koopa_red_b:
						index = A.snd_mb_red_koopa
					A.obj_muncher:
						index = A.snd_mb_muncher
					A.obj_mushroom:
						index = A.snd_mb_mushroom
					A.obj_megamushroom:
						index = A.snd_mb_megamushroom
					A.obj_fireflower:
						index = A.snd_mb_fireflower
					A.obj_superflower:
						index = A.snd_mb_superflower
					A.obj_superarcon:
						index = A.snd_mb_arcon
					A.obj_frogsuit:
						index = A.snd_mb_frogsuit
					A.obj_1up:
						index = A.snd_mb_1up
					A.obj_star:
						index = A.snd_mb_star
					A.obj_jumppiranha:
						index = A.snd_mb_plant
					A.obj_plant_fire:
						index = A.snd_mb_fireplant
					_:
						index = A.snd_mb_mario
				_user_5()
			else:
				GM.audio_stop_sound(int(sound_block))
				GM.audio_play_sound(int(sound_block), 0.0, false)


# from objects/obj_noteblock/Other_15.gml
func _user_5() -> void:
	var tono: float
	var pitch: float
	tono = GM.gm_round((y / 16.0))
	tono -= 13.0
	if tono >= 1.0 or tono <= -1.0:
		tono = (tono * -1.0)
		pitch = pow(2.0, ((0.0 + tono) / 12.0))
		GM.audio_sound_pitch(int(index), pitch)  # UNVERIFIED: GML 此处传的是音效资源编号，兼容层 audio_sound_pitch 的参数含义未实测
	else:
		GM.audio_sound_pitch(int(index), 1.0)  # UNVERIFIED: 同上
	GM.audio_play_sound(int(index), 0.0, false)


# from objects/obj_noteblock/Draw_0.gml
func _gm_draw() -> void:
	var anim
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, x, y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
