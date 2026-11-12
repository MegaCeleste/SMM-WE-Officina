# from objects/obj_tuberia（第 7 批移植，已核对）
extends "res://objects/obj_solid.gd"

var sprite: float = 0.0  ## sprite 编号；scr_edit_to_play 也写它
var part: float = 0.0  ## sprite 编号
var color: float = 0.0
var rotacion: float = 0.0
var direct: float = 0.0
var size: float = 0.0
var direct_t: float = 0.0
var index: float = 0.0
var holding: float = 0.0
var helmet: float = 0.0
var m_posx: float = 0.0
var m_posy: float = 0.0
var warp: float = 0.0
var w_x_pos: float = 0.0
var w_y_pos: float = 0.0
var w_direct: float = 0.0
var w_size: float = 0.0
var w_rotacion: float = 0.0
var w_s_scalex: float = 0.0
var w_color: float = 0.0
var w_xscale: float = 0.0
var w_yscale: float = 0.0
var w_posx: float = 0.0
var w_posy: float = 0.0
var player = null  ## 实例或 null（collision_rectangle 的结果）
var warpme = null  ## obj_player_warp 实例


# from objects/obj_tuberia/Create_0.gml
func _create() -> void:
	var dark: float
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			sprite = A.spr_SMB_pipes
			part = A.spr_SMB_pipes_part
		1.0:
			if dark == 1.0:
				sprite = A.spr_SMB3_pipes_night
				part = A.spr_SMB3_pipes_part_night
			else:
				sprite = A.spr_SMB3_pipes
				part = A.spr_SMB3_pipes_part
		2.0:
			sprite = A.spr_pipes
			part = A.spr_pipes_part
		3.0:
			sprite = A.spr_NSMBU_pipes
			part = A.spr_NSMBU_pipes_part
	image_speed = 0.0
	image_index = 0.0
	color = 0.0
	rotacion = 0.0
	direct = 1.0
	size = 0.0
	direct_t = 0.0
	index = 0.0
	holding = 0.0
	helmet = 0.0
	m_posx = x
	m_posy = y
	warp = 0.0
	w_x_pos = (x + 32.0)
	w_y_pos = y
	w_direct = 0.0
	w_size = 0.0
	w_rotacion = 0.0
	w_s_scalex = 1.0
	w_color = 0.0
	w_xscale = 1.0
	w_yscale = 1.0
	w_posx = x
	w_posy = y


# from objects/obj_tuberia/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario) and warp > 0.0:
		if direct_t == 0.0 and GM.keyboard_check(G.abajo) and (collision_rectangle((x + 8.0), (y - 8.0), (x + 24.0), (y - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((x + 8.0), (y - 8.0), (x + 24.0), (y - 4.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((x + 8.0), (y - 8.0), (x + 24.0), (y - 4.0), A.obj_bullebill_base, false, false) == null):
			player = collision_rectangle((x + 13.0), (y - 4.0), (x + 19.0), (y - 4.0), A.obj_mario, false, false)
			if player != null:
				warpme = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_warp)
				warpme.direct = player.direct
				warpme.direction = 270.0
				warpme.destruir = 1.0
				warpme.pos_center = (x + 16.0)
				holding = GM.instance_find(A.obj_mario, 0).holding
				helmet = GM.instance_find(A.obj_mario, 0).helmet
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(warpme):
					inst.event_user(0)
				GM.other = _o
				G.warp_x = m_posx
				G.warp_y = m_posy
				alarm[1] = 35.0
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()
		elif direct_t == 1.0 and GM.keyboard_check(G.izquierda) and (GM.instance_find(A.obj_mario, 0).state < 2.0 or G.powerup == -82.0) and (collision_rectangle((bbox_right + 8.0), (y + 8.0), (bbox_right + 8.0), (y + 24.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_right + 8.0), (y + 8.0), (bbox_right + 8.0), (y + 24.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((bbox_right + 8.0), (y + 8.0), (bbox_right + 8.0), (y + 24.0), A.obj_bullebill_base, false, false) == null):
			player = collision_rectangle((bbox_right + 2.0), (y + 28.0), (bbox_right + 2.0), (y + 32.0), A.obj_mario, false, false)
			if player != null and GM.instance_find(A.obj_mario, 0).y <= (y + 8.0):
				warpme = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y - 2.0), A.obj_player_warp)
				warpme.direct = player.direct
				warpme.direction = 180.0
				warpme.destruir = 1.0
				holding = GM.instance_find(A.obj_mario, 0).holding
				helmet = GM.instance_find(A.obj_mario, 0).helmet
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(warpme):
					inst.event_user(0)
				GM.other = _o
				G.warp_x = m_posx
				G.warp_y = m_posy
				alarm[1] = 45.0
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()
		elif direct_t == 2.0 and GM.keyboard_check(G.arriba) and (collision_rectangle((x + 8.0), (bbox_bottom + 8.0), (x + 24.0), (bbox_bottom + 8.0), A.obj_solid, false, false) == null) and (collision_rectangle((x + 8.0), (bbox_bottom + 8.0), (x + 24.0), (bbox_bottom + 8.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((x + 8.0), (bbox_bottom + 8.0), (x + 24.0), (bbox_bottom + 8.0), A.obj_bullebill_base, false, false) == null):
			player = collision_rectangle((x + 13.0), (bbox_bottom + 2.0), (x + 19.0), (bbox_bottom + 2.0), A.obj_mario, false, false)
			if player != null:
				warpme = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_player_warp)
				warpme.direct = player.direct
				warpme.direction = 90.0
				warpme.destruir = 1.0
				warpme.pos_center = (x + 16.0)
				holding = GM.instance_find(A.obj_mario, 0).holding
				helmet = GM.instance_find(A.obj_mario, 0).helmet
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(warpme):
					inst.event_user(0)
				GM.other = _o
				G.warp_x = m_posx
				G.warp_y = m_posy
				alarm[1] = 35.0
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()
		elif direct_t == 3.0 and GM.keyboard_check(G.derecha) and (GM.instance_find(A.obj_mario, 0).state < 2.0 or G.powerup == -82.0) and (collision_rectangle((x - 8.0), (y + 8.0), (x - 8.0), (y + 24.0), A.obj_solid, false, false) == null) and (collision_rectangle((x - 8.0), (y + 8.0), (x - 8.0), (y + 24.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle((x - 8.0), (y + 8.0), (x - 8.0), (y + 24.0), A.obj_bullebill_base, false, false) == null):
			player = collision_rectangle((x - 2.0), (y + 28.0), (x - 2.0), (y + 32.0), A.obj_mario, false, false)
			if player != null and GM.instance_find(A.obj_mario, 0).y <= (y + 8.0):
				warpme = GM.instance_create(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y - 2.0), A.obj_player_warp)
				warpme.direct = player.direct
				warpme.direction = 0.0
				warpme.destruir = 1.0
				holding = GM.instance_find(A.obj_mario, 0).holding
				helmet = GM.instance_find(A.obj_mario, 0).helmet
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(warpme):
					inst.event_user(0)
				GM.other = _o
				G.warp_x = m_posx
				G.warp_y = m_posy
				alarm[1] = 45.0
				for inst in GM.with_list(A.obj_mario):
					inst.instance_destroy()


# from objects/obj_tuberia/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create(w_x_pos, w_y_pos, A.obj_tuberia)):
		inst.warp = 2.0
		inst.size = self.w_size
		inst.direct = self.w_s_scalex
		inst.direct_t = self.w_direct
		inst.rotacion = self.w_rotacion
		inst.index = self.w_color
		inst.image_xscale = self.w_xscale
		inst.image_yscale = self.w_yscale
		inst.w_posx = self.m_posx
		inst.w_posy = self.m_posy
		inst.w_direct = self.direct_t
		match inst.direct_t:
			0.0:
				inst.m_posx = (inst.x + 16.0)
				inst.m_posy = inst.y
			1.0:
				inst.m_posx = (inst.x + (16.0 + (inst.size * 16.0)))
				inst.m_posy = inst.y
			2.0:
				inst.m_posx = (inst.x + 16.0)
				inst.m_posy = (inst.y + (16.0 + (inst.size * 16.0)))
			3.0:
				inst.m_posx = (inst.x + 16.0)
				inst.m_posy = inst.y


# from objects/obj_tuberia/Alarm_1.gml
func _alarm_1() -> void:
	var pipe = null  # PORT: w_direct 不是 0–3 时原版读未赋值的局部变量会报错；这里 with_list(null) 什么都不做
	for inst in GM.with_list(GM.instance_create(w_posx, w_posy, A.obj_curtainin)):
		inst.fallow = 1.0
	if GM.instance_exists(A.obj_autoscroll):
		for inst in GM.with_list(A.obj_autoscroll):
			if (self.w_posx + 16.0) < 192.0:
				inst.x = 192.0
			else:
				inst.x = (self.w_posx + 16.0)
			inst.hspeed = inst.velocidad
	match w_direct:
		0.0:
			pipe = GM.instance_create(w_posx, w_posy, A.obj_player_warp)
			for inst in GM.with_list(pipe):
				inst.direction = 90.0
				inst.direct = 1.0
		1.0:
			pipe = GM.instance_create(w_posx, (w_posy - 1.0), A.obj_player_warp)
			for inst in GM.with_list(pipe):
				inst.direction = 0.0
				inst.direct = 1.0
		2.0:
			pipe = GM.instance_create(w_posx, (w_posy - 16.0), A.obj_player_warp)
			for inst in GM.with_list(pipe):
				inst.direction = 270.0
				inst.direct = 1.0
		3.0:
			pipe = GM.instance_create(w_posx, (w_posy - 1.0), A.obj_player_warp)
			for inst in GM.with_list(pipe):
				inst.direction = 180.0
				inst.direct = -1.0
	for inst in GM.with_list(pipe):
		inst.canmove = 0.0
		inst.alarm[0] = 30.0
		inst.salir = 1.0
		inst.holding = self.holding
		inst.helmet = self.helmet
		inst.myitem = G.warp_item
		inst.alarm[2] = 1.0
		inst.w_posx = self.m_posx
		inst.w_posy = self.m_posy
		inst.w_direct = self.direct_t
	for inst in GM.with_list(A.obj_levelmanager):
		inst.barrier = 1.0
		inst.alarm[6] = 2.0
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_persistent):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_tuberia/Draw_0.gml
func _gm_draw() -> void:
	match direct_t:
		0.0:
			GM.draw_sprite_ext(sprite, index, (x + 16.0), (y + 16.0), direct, 1.0, rotacion, GM.c_white, 1.0)
		1.0:
			GM.draw_sprite_ext(sprite, index, (x + (16.0 + (size * 16.0))), (y + 16.0), direct, 1.0, rotacion, GM.c_white, 1.0)
		2.0:
			GM.draw_sprite_ext(sprite, index, (x + 16.0), (y + (16.0 + (size * 16.0))), direct, 1.0, rotacion, GM.c_white, 1.0)
		3.0:
			GM.draw_sprite_ext(sprite, index, (x + 16.0), (y + 16.0), direct, 1.0, rotacion, GM.c_white, 1.0)
	if size > 0.0:
		var i: float = 1.0
		while i < (size + 1.0):
			match direct_t:
				0.0:
					GM.draw_sprite_ext(part, index, (x + 16.0), ((y + 16.0) + (i * 16.0)), direct, 1.0, rotacion, GM.c_white, 1.0)
				1.0:
					GM.draw_sprite_ext(part, index, ((x + (16.0 + (size * 16.0))) - (i * 16.0)), (y + 16.0), direct, 1.0, rotacion, GM.c_white, 1.0)
				2.0:
					GM.draw_sprite_ext(part, index, (x + 16.0), ((y + (16.0 + (size * 16.0))) - (i * 16.0)), direct, 1.0, rotacion, GM.c_white, 1.0)
				3.0:
					GM.draw_sprite_ext(part, index, ((x + 16.0) + (i * 16.0)), (y + 16.0), direct, 1.0, rotacion, GM.c_white, 1.0)
			i += 1.0
