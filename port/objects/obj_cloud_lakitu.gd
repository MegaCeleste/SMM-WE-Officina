# from objects/obj_cloud_lakitu（第 6e 批移植，已核对）
extends "res://objects/obj_deactivation.gd"

var timer: float = 0.0
var inmario: float = 0.0
var direct: float = 0.0
var v_duck_small = null


# from objects/obj_cloud_lakitu/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_cloud_latiku
		1.0:
			sprite_index = A.spr_SMB3_cloud_latiku
		2.0:
			sprite_index = A.spr_cloud_latiku
		3.0:
			sprite_index = A.spr_NSMBU_cloud_latiku
	timer = 0.0
	image_speed = 0.125
	inmario = 2.0
	alarm[2] = 10.0
	direct = 1.0
	alarm[0] = 840.0
	alarm[1] = 900.0


# from objects/obj_cloud_lakitu/Destroy_0.gml
func _destroy() -> void:
	if inmario == 1.0 and GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.inclown = 0.0


# from objects/obj_cloud_lakitu/Step_0.gml
func _step() -> void:
	if inmario == 1.0:
		if G.powerup == -82.0 or GM.instance_exists(A.obj_frozenmario):
			inmario = 2.0
			hspeed = 0.0
			alarm[2] = 40.0
			for inst in GM.with_list(A.obj_mario):
				inst.inclown = 0.0
		depth = -11.0
		if x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0):
			x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0)
			if hspeed < 0.0:
				hspeed = 0.0
		elif x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 16.0):
			x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 16.0)
			if hspeed > 0.0:
				hspeed = 0.0
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.vspeed = 0.0
				inst.hspeed = 0.0
				inst.gravity = 0.0
				inst.state = 0.0
				inst.jumpnow = 0.0
				inst.isup = 0.0
				inst.isuphold = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.x = x
			for inst in GM.with_list(A.obj_mario):
				inst.y = (y - 24.0)
			for inst in GM.with_list(A.obj_mario):
				inst.direct = direct
			if GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)):
				hspeed -= 0.1
				if hspeed < -1.5:
					hspeed = -1.5
				gravity = 0.0
				direct = -1.0
			elif GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)):
				hspeed += 0.1
				if hspeed > 1.5:
					hspeed = 1.5
				gravity = 0.0
				direct = 1.0
			else:
				if hspeed > 0.0:
					hspeed -= 0.1
				elif hspeed < 0.0:
					hspeed += 0.1
				if absf(hspeed) < 0.1:
					hspeed = 0.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)):
				vspeed -= 0.1
				if vspeed < -1.5:
					vspeed = -1.5
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)):
				vspeed += 0.1
				if vspeed > 1.5:
					vspeed = 1.5
			else:
				if vspeed > 0.0:
					vspeed -= 0.1
				elif vspeed < 0.0:
					vspeed += 0.1
				if absf(vspeed) < 0.1:
					vspeed = 0.0
			if GM.keyboard_check_pressed(G.saltar) or (GM.keyboard_check_pressed(G.saltar_spin) and G.apariencia < 2.0):
				inmario = 2.0
				hspeed = 0.0
				ystart = y
				alarm[2] = 10.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_mario):
					if inst.isswim == 1.0:
						inst.vspeed = -2.0
					else:
						inst.vspeed = -3.75
					GM.audio_play_sound(Scr.scr_jump(inst), 0.0, false)
					inst.jumpnow = 1.0
					inst.state = 2.0
					inst.inclown = 0.0
				GM.other = _o
			elif GM.keyboard_check_pressed(G.saltar_spin) and G.apariencia > 1.0:
				inmario = 2.0
				hspeed = 0.0
				ystart = y
				alarm[2] = 10.0
				for inst in GM.with_list(A.obj_mario):
					if inst.isswim == 1.0:
						inst.vspeed = -2.0
					else:
						inst.vspeed = -3.0
					GM.audio_play_sound(A.snd_spin, 0.0, false)
					inst.jumpnow = 1.0
					inst.state = 2.0
					inst.isduck = 0.0
					inst.isduckhold = 0.0
					inst.y -= 1.0
					inst.stompstyle = 1.0
					inst.inclown = 0.0
			_user_3()
			_user_4()
		else:
			inmario = 0.0
			ystart = y
	else:
		hspeed = 0.0
		if vspeed > 0.0:
			vspeed -= 0.1
		# ORIG-BUG: 判断的是 hspeed（上一句刚置 0，永远为假），应为 vspeed，照搬
		elif hspeed < 0.0:
			vspeed += 0.1
		if absf(vspeed) < 0.1:
			vspeed = 0.0
		y = (ystart + (sin((timer * 0.04375)) * 2.0))
		timer += 1.0


# from objects/obj_cloud_lakitu/Step_2.gml
func _step_end() -> void:
	if inmario == 1.0:
		if GM.instance_exists(A.obj_mario):
			var i_mario = GM.instance_find(A.obj_mario, 0)
			match G.jugador:
				0.0:
					v_duck_small = (i_mario.y + 12.0)
				1.0:
					v_duck_small = (i_mario.y + 12.0)
				2.0:
					v_duck_small = (i_mario.y + 12.0)
				3.0:
					v_duck_small = (i_mario.y + 12.0)
			if GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)) and G.apariencia == 2.0:
				if i_mario.holding == 2.0:
					var _spr: int = int(Scr.scr_marioduckhold(self))
					for inst in GM.with_list(A.obj_mario):  # obj_mario.sprite_index = …（§3.3 第 16 条：写全部实例）
						inst.sprite_index = _spr
					if GM.instance_exists(A.obj_helmet):
						if G.powerup == 0.0:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 2.0)
						else:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 5.0)
				else:
					var _spr: int = int(Scr.scr_marioduck(self))
					for inst in GM.with_list(A.obj_mario):  # obj_mario.sprite_index = …（§3.3 第 16 条：写全部实例）
						inst.sprite_index = _spr
					if GM.instance_exists(A.obj_helmet):
						if G.powerup == 0.0:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = v_duck_small
						else:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 1.0)


# from objects/obj_cloud_lakitu/Alarm_0.gml
func _alarm_0() -> void:
	if image_alpha == 1.0:
		image_alpha = 0.0
	else:
		image_alpha = 1.0
	alarm[0] = 4.0


# from objects/obj_cloud_lakitu/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_cloud_lakitu/Alarm_2.gml
func _alarm_2() -> void:
	inmario = 0.0


# from objects/obj_cloud_lakitu/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if inmario == 0.0 and other.inclown == 0.0 and ((not GM.instance_exists(A.obj_kuribo_drybones)) or (GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).gran_golpe == 0.0)):
		if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0 and other.state == 2.0 and G.powerup != -82.0:
			other.inclown = 1.0
			inmario = 1.0
			vspeed = 1.0
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.gravity = 0.0
				inst.stompstyle = 0.0
				inst.isduck = 0.0
				inst.isduckhold = 0.0
				inst.isup = 0.0
				inst.isuphold = 0.0
				inst.groundpount = 0.0
				inst.event_user(15)
			GM.other = _o


# from objects/obj_cloud_lakitu/Other_13.gml
func _user_3() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(i_mario.bbox_right, (i_mario.bbox_top + 1.0), (i_mario.bbox_right + 1.0), (i_mario.bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((i_mario.bbox_left - 1.0), (i_mario.bbox_top + 1.0), i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o_col_one_left: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o_col_one_left
		if hspeed < 0.0 and col_one_right != null:
			var _o_col_one_right: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o_col_one_right
		hspeed = 0.0


# from objects/obj_cloud_lakitu/Other_14.gml
func _user_4() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var semisolid
	var col_one_top
	var col_one_bottom
	if vspeed >= 0.0:
		semisolid = collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom - 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + vspeed), A.obj_solidtop, false, false)
		if semisolid != null and i_mario.bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - 8.0)
		if vspeed > 4.0:
			vspeed = 4.0
	if collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom - 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom - 4.0), i_mario.bbox_right, (i_mario.bbox_bottom - 4.0), A.obj_solidtop, false, false) == null):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			col_one_top = collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom + 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o_col_one_top: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o_col_one_top
	if vspeed < 0.0:
		if collision_rectangle(i_mario.bbox_left, i_mario.bbox_top, i_mario.bbox_right, i_mario.bbox_top, A.obj_solid, true, false) != null or collision_rectangle(i_mario.bbox_left, i_mario.bbox_top, i_mario.bbox_right, i_mario.bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(i_mario.bbox_left, i_mario.bbox_top, i_mario.bbox_right, i_mario.bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(i_mario.bbox_left, i_mario.bbox_top, i_mario.bbox_right, i_mario.bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(i_mario.bbox_left, i_mario.bbox_top, i_mario.bbox_right, i_mario.bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top + 1.0), i_mario.bbox_right, (i_mario.bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(i_mario.x, i_mario.y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top + 1.0), i_mario.bbox_right, (i_mario.bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(i_mario.x, i_mario.y, A.obj_hurtsolid2)):
				y += 1.0
			while collision_rectangle(i_mario.bbox_left, (i_mario.bbox_top + 1.0), i_mario.bbox_right, (i_mario.bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(i_mario.x, i_mario.y, A.obj_solidphy)):
				y += 1.0
			col_one_bottom = collision_rectangle((i_mario.bbox_left + 1.0), ((i_mario.bbox_top + vspeed) - 1.0), (i_mario.bbox_right - 1.0), (i_mario.bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o_col_one_bottom: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o_col_one_bottom
			vspeed = 0.0
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).camlock == 1.0:
		if y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0):
			y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0)


# from objects/obj_cloud_lakitu/Draw_0.gml
func _gm_draw() -> void:
	if inmario == 1.0 and GM.instance_exists(A.obj_mario):
		GM.draw_sprite_ext(sprite_index, image_index, GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 24.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (GM.gm_round(x) - hspeed), (GM.gm_round(y) - vspeed), direct, 1.0, 0.0, GM.c_white, image_alpha)
