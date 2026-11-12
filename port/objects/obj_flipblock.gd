extends "res://objects/obj_blockparent.gd"

var flips: float = 0.0
var convertirse: float = 0.0
var spd_temp = null  # 第 4 批补：由别的 object 写入


# from objects/obj_flipblock/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_qblock
			image_speed = 0.0
			match G.bg_level:
				"snow":
					if G.modo_noche == 1.0:
						image_index = 4.0
					else:
						image_index = 3.0
				"castle":
					image_index = 2.0
				"mountain":
					if G.modo_noche == 1.0:
						image_index = 0.0
					else:
						image_index = 0.0
				"ghost":
					image_index = 1.0
				"underground":
					image_index = 1.0
				_:
					image_index = 0.0
		1.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_SMB3_qblock_dark
				"ghost":
					sprite_index = A.spr_SMB3_qblock_night
				"underground":
					sprite_index = A.spr_SMB3_qblock_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_qblock_dark
					else:
						sprite_index = A.spr_SMB3_qblock
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_qblock_night
					else:
						sprite_index = A.spr_SMB3_qblock
			image_speed = 0.15
		2.0:
			image_speed = 0.0
			sprite_index = A.spr_flipblock
		3.0:
			match G.bg_level:
				"castle":
					sprite_index = A.spr_NSMBU_block_dark
				"ghost":
					sprite_index = A.spr_NSMBU_block_night
				"underground":
					sprite_index = A.spr_NSMBU_block_night
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_block_dark
					else:
						sprite_index = A.spr_NSMBU_block
				_:
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_block_night
					else:
						sprite_index = A.spr_NSMBU_block
			image_speed = 0.2
	ready_v = 0.0
	downwards = 0.0
	flips = 0.0
	convertirse = 1.0
	wings = 0.0
	wings_anim = 0.0
	s_scalex = 1.0
	s_scaley = 1.0
	expand = 0.0
	expand2 = 0.0
	expand3 = 0.0
	if G.apariencia == 0.0:
		sprite_wings = A.spr_SMB_wings_16x16
	elif G.apariencia == 1.0:
		sprite_wings = A.spr_SMB3_wings2
	else:
		sprite_wings = A.spr_wings_items
	alarm[10] = 4.0
	_user_10()


# from objects/obj_flipblock/Step_0.gml
func _step() -> void:
	super._step()
	var _mario = GM.instance_find(A.obj_mario, 0)
	var _marioU = GM.instance_find(A.obj_marioU, 0)
	if convertirse == 1.0:
		if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			for inst in GM.with_list(GM.instance_create(x, ystart, A.obj_coin)):
				inst.convertirse = 0.0
			instance_destroy()
	elif convertirse == 0.0:
		if not GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			for inst in GM.with_list(GM.instance_create(x, ystart, A.obj_coin)):
				inst.convertirse = 1.0
			instance_destroy()
	if place_meeting(x, y, A.obj_skewertrunk):
		alarm[2] = 1.0
	if ready_v == 0.0 and G.powerup != 0.0 and G.yoshi == 0.0 and GM.instance_exists(A.obj_mario) and _mario.stompstyle == 1.0 and G.apariencia == 2.0 and _mario.vspeed > 0.0 and place_meeting(x, (y - (_mario.vspeed * 2.5)), A.obj_mario):
		GM.audio_play_sound(A.snd_break, 0.0, false)
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(1)
		GM.other = _o1
		instance_destroy()
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(45.0, 6.0)
			inst.sprite_index = A.spr_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(60.0, 6.0)
			inst.sprite_index = A.spr_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(120.0, 6.0)
			inst.sprite_index = A.spr_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(135.0, 6.0)
			inst.sprite_index = A.spr_shard
	if ready_v == 0.0 and G.apariencia == 3.0 and G.yoshi == 0.0 and GM.instance_exists(A.obj_marioU) and _marioU.get("helice_fly") == 4.0 and _marioU.vspeed > 1.0 and place_meeting(x, (y - (_marioU.vspeed * 2.5)), A.obj_marioU):  # obj_marioU 本批不移植（空壳），自定义变量用 get
		GM.audio_play_sound(A.snd_NSMBU_break, 0.0, false)
		for inst in GM.with_list(A.obj_marioU):
			inst.vspeed = 0.0
		instance_destroy()
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(45.0, 6.0)
			inst.sprite_index = A.spr_NSMBU_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(60.0, 6.0)
			inst.sprite_index = A.spr_NSMBU_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(120.0, 6.0)
			inst.sprite_index = A.spr_NSMBU_shard
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_shard)):
			inst.motion_set(135.0, 6.0)
			inst.sprite_index = A.spr_NSMBU_shard
	#
	# //Flying block
	#    if (y > (ystart + 16))
	#    {
	#        if (vspeed < -0.5)
	#            vspeed = -0.5
	#        else
	#            vspeed -= 0.085
	#    }
	#    else if (y < (ystart - 16))
	#    {
	#        if (vspeed > 0.5)
	#            vspeed = 0.5
	#        else
	#            vspeed += 0.085
	#    }
	# 	/*


# from objects/obj_flipblock/Alarm_0.gml
func _alarm_0() -> void:
	alarm[1] = 4.0
	vspeed = 2.0


# from objects/obj_flipblock/Alarm_1.gml
func _alarm_1() -> void:
	vspeed = 0.0
	y = ystart
	if G.apariencia == 2.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_flipblock_anim)):
			inst.set("convertirse", convertirse)
		instance_destroy()
	else:
		ready_v = 0.0


# from objects/obj_flipblock/Other_11.gml
func _user_1() -> void:
	ready_v = 1.0
	vspeed = -2.0
	alarm[0] = 4.0
	event_user(0)


# from objects/obj_flipblock/Other_20.gml
func _user_10() -> void:
	var col_enemy
	var col_enemy_held
	var col_munchers
	var col_bosses
	var col_clown
	var col_bullet
	var col_powerup
	var col_cannon
	var col_held
	var _o: GMObject = GM.other
	GM.other = self
	col_enemy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_enemyparent, false, false)
	col_enemy_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_enemyparent_held, false, false)
	col_munchers = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_muncher, false, false)
	col_bosses = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bossparent, false, false)
	col_clown = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_clown, false, false)
	col_bullet = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false)
	col_powerup = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_powerupparent, false, false)
	col_cannon = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_cannon, false, false)
	col_held = collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_holdparent, false, false)
	if col_enemy != null and place_meeting(x, y, A.obj_enemyparent):
		if col_enemy.object_index != A.obj_grinder and col_enemy.object_index != A.obj_podoboo and col_enemy.object_index != A.obj_boo and col_enemy.object_index != A.obj_banzaibill and col_enemy.object_index != A.obj_bulletbill and col_enemy.object_index != A.obj_cannonball and col_enemy.object_index != A.obj_cannonball_red and col_enemy.object_index != A.obj_cheepcheep:
			if col_enemy.object_index == A.obj_bobomb or col_enemy.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(col_enemy):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				for inst in GM.with_list(col_enemy):
					inst.event_user(0)
	if col_enemy_held != null and col_enemy_held.held == 0.0 and place_meeting(x, y, A.obj_enemyparent_held):
		if col_enemy_held.object_index == A.obj_bobomb_hold:
			for inst in GM.with_list(col_enemy_held):
				GM.instance_create(inst.x, inst.y, A.obj_explosion)
				inst.instance_destroy()
		else:
			for inst in GM.with_list(col_enemy_held):
				inst.event_user(0)
	if col_munchers != null and place_meeting(x, y, A.obj_muncher):
		for inst in GM.with_list(col_munchers):
			inst.event_user(0)
	if col_bosses != null and place_meeting(x, y, A.obj_bossparent):
		for inst in GM.with_list(col_bosses):
			inst.event_user(0)
	if col_clown != null and place_meeting(x, y, A.obj_clown):
		for inst in GM.with_list(col_clown):
			inst.event_user(0)
	if col_bullet != null and place_meeting(x, y, A.obj_bullebill_base):
		for inst in GM.with_list(col_bullet):
			inst.event_user(0)
	if col_powerup != null and place_meeting(x, y, A.obj_powerupparent):
		for inst in GM.with_list(col_powerup):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_held != null and place_meeting(x, y, A.obj_holdparent):
		for inst in GM.with_list(col_held):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			inst.instance_destroy()
	if col_cannon != null and place_meeting(x, y, A.obj_cannon):
		for inst in GM.with_list(col_cannon):
			inst.event_user(0)
	GM.other = _o


# from objects/obj_flipblock/Draw_0.gml
func _gm_draw() -> void:
	var anim
	var sprited
	if image_speed == 0.0:
		anim = image_index
	else:
		var lm = GM.instance_find(A.obj_levelmanager, 0)
		anim = lm.banim
	Scr.draw_sprite_custom_origin(self, sprite_index, anim, GM.gm_round(x), y, 8.0, 16.0, s_scalex, s_scaley, 0.0, GM.c_white, 1.0)
	# draw_sprite_stretched(sprite_index,anim,round(x)-(ystart-y)/4,y-(ystart-y)/4,16+(ystart-y)/2,16+(ystart-y)/2)
