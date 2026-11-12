extends GMObject

var int_v: float = 0.0  # 原名 int（GDScript 关键字）
var anim_magic: float = 0.0
var angle: float = 0.0
var disappear_meta: float = 0.0


# from objects/obj_magic/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_magic
		1.0:
			sprite_index = A.spr_SMB3_magic
		2.0:
			sprite_index = A.spr_magic
		3.0:
			sprite_index = A.spr_NSMBU_magic
	int_v = 0.0
	anim_magic = 0.0
	image_speed = 0.15
	angle = 0.0
	alarm[0] = 4.0
	disappear_meta = 0.0
	if GM.instance_exists(A.obj_mario):
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
			move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0), 0.5)
		else:
			move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 16.0), 1.0)
	elif G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		move_towards_point(GM.instance_find(A.obj_levelmanager, 0).x, GM.instance_find(A.obj_levelmanager, 0).y, 0.5)
	else:
		move_towards_point(GM.instance_find(A.obj_levelmanager, 0).x, GM.instance_find(A.obj_levelmanager, 0).y, 1.0)


# from objects/obj_magic/Step_0.gml
func _step() -> void:
	var flip
	var itemblock
	var block_rock
	var block_ice
	var powerups
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0
	if not GM.instance_exists(A.obj_deadmario):
		image_angle -= (5.0 * GM.gm_sign(hspeed))
	if G.apariencia == 3.0:
		anim_magic += 0.15
	flip = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_flipblock, false, false)
	itemblock = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_block, false, false)
	block_rock = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_block_rock, false, false)
	block_ice = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_block_ice, false, false)
	powerups = collision_rectangle((bbox_left - 2.0), (bbox_top - 2.0), (bbox_right + 2.0), (bbox_bottom + 2.0), A.obj_powerupparent, false, false)
	if itemblock != null and (itemblock.sprite_index == A.spr_SMB_empty_block or itemblock.sprite_index == A.spr_SMB3_empty_block or itemblock.sprite_index == A.spr_qblock_empty):
		var _o: GMObject = GM.other  # with 块里 instance_create/instance_destroy 会触发别的 object 的事件
		GM.other = self
		for inst in GM.with_list(itemblock):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			self.int_v = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0)
			match self.int_v:
				1.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.0
						inst2.hspeed = 0.6
				3.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				5.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
						inst2.hspeed = 1.1
				_:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
			inst.instance_destroy()
		GM.other = _o
		_user_0()
	elif flip != null:
		var _o: GMObject = GM.other  # with 块里 instance_create/instance_destroy 会触发别的 object 的事件
		GM.other = self
		for inst in GM.with_list(flip):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			self.int_v = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0)
			match self.int_v:
				1.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.0
						inst2.hspeed = 0.6
				3.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				5.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
						inst2.hspeed = 1.1
				_:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
			inst.instance_destroy()
		GM.other = _o
		_user_0()
	elif block_rock != null:
		var _o: GMObject = GM.other  # with 块里 instance_create/instance_destroy 会触发别的 object 的事件
		GM.other = self
		for inst in GM.with_list(block_rock):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			self.int_v = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0)
			match self.int_v:
				1.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				3.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				5.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
						inst2.hspeed = 1.1
				_:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
			inst.instance_destroy()
		GM.other = _o
		_user_0()
	elif block_ice != null:
		var _o: GMObject = GM.other  # with 块里 instance_create/instance_destroy 会触发别的 object 的事件
		GM.other = self
		for inst in GM.with_list(block_ice):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			self.int_v = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0)
			match self.int_v:
				1.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				3.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				5.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
						inst2.hspeed = 1.1
				_:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
			inst.instance_destroy()
		GM.other = _o
		_user_0()
	elif powerups != null:
		var _o: GMObject = GM.other  # with 块里 instance_create/instance_destroy 会触发别的 object 的事件
		GM.other = self
		for inst in GM.with_list(powerups):
			GM.instance_create(inst.x, inst.y, A.obj_smoke)
			self.int_v = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0)
			match self.int_v:
				1.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				3.0:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.5
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = -0.7
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin_pow)):
						inst2.vspeed = -1.5
						inst2.hspeed = 0.6
				5.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
						inst2.hspeed = 1.1
				_:
					GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)
			inst.instance_destroy()
		GM.other = _o
		_user_0()
	_user_3()
	_user_4()
	if Scr.outside_view(self) > 0.5:
		instance_destroy()


# from objects/obj_magic/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create(((x - 6.0) + GM.random(12.0)), ((y - 6.0) + GM.random(12.0)), A.obj_smoke)):
		inst.image_speed = 0.2
		inst.sprite_index = A.spr_boltspark_magic
	alarm[0] = 10.0


# from objects/obj_magic/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	_user_0()


# from objects/obj_magic/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if GM.instance_exists(A.obj_invincibility):
		_user_0()
	elif other.invincible == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_magic/Other_10.gml
func _user_0() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_NSMBU_magic_destroy)
		GM.audio_play_sound(A.snd_NSMBU_magic_destroy, 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_magic
	for inst in GM.with_list(GM.instance_create((x - 8.0), (y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_magic
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_magic
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_magic
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 8.0), A.obj_smoke)):
		inst.sprite_index = A.spr_boltspark_magic
	instance_destroy()


# from objects/obj_magic/Other_13.gml
func _user_3() -> void:
	if (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_muncher, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_muncher, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_pinchos, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_pinchos, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_pinchos, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_pinchos, true, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_block_pow_hold, true, false) != null):
		_user_0()


# from objects/obj_magic/Other_14.gml
func _user_4() -> void:
	if (vspeed > 0.0 and collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null) or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
		_user_0()
	if vspeed < 0.0 and collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_solid, true, false) != null:
		_user_0()


# from objects/obj_magic/Draw_0.gml
func _gm_draw() -> void:
	if G.apariencia == 3.0:
		GM.draw_sprite(A.spr_NSMBU_magic_effect, anim_magic, x, y)
	GM.draw_sprite_ext(sprite_index, -1.0, x, y, 1.0, 1.0, image_angle, GM.c_white, 1.0)
