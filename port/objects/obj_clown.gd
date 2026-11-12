# 第 7 批移植，已核对。
extends "res://objects/obj_physicsparent.gd"

var inmario: float = 0.0
var v_duck_small: float = 0.0
var s_clown: float = 0.0
var s_clown_eyes: float = 0.0
var s_clown_evil: float = 0.0
var s_clown_damage: float = 0.0
var s_clown_link: float = 0.0
var s_clown_bounce: float = 0.0
var s_clown_evil_bounce: float = 0.0
var inenemy: float = 0.0
var enemyobject = null  # PORT: 存 object 编号（obj_lighting 当“没有”的占位）或实例，不带类型
var enablecontrol: float = 0.0
var modo_lava: float = 0.0
var x_scale: float = 0.0
var y_scale: float = 0.0
var rotacion: float = 0.0
var rot: float = 0.0
var up: float = 0.0
var rot_angle: float = 0.0
var carga: float = 0.0  # PORT: obj_clown 里只在 Step 赋值（仅 obj_clown_fire 走到），obj_clown_fire 的 Create 也赋值；没人用 variable_instance_exists 查，声明成 float
var audio_charge: float = 0.0  # PORT: 同 carga
var imdead = null


# from objects/obj_clown/Create_0.gml
func _create() -> void:
	image_speed = 0.4
	alarm[0] = 120.0
	inmario = 0.0
	v_duck_small = 0.0
	match G.apariencia:
		0.0:
			s_clown = A.spr_SMB_clown
			s_clown_eyes = A.spr_SMB_clown_eyes
			s_clown_evil = A.spr_SMB_clown_evil
			s_clown_damage = A.spr_SMB_clown_damage
		1.0:
			s_clown = A.spr_SMB3_clown
			s_clown_eyes = A.spr_SMB3_clown_eyes
			s_clown_evil = A.spr_SMB3_clown_evil
			s_clown_damage = A.spr_SMB3_clown_damage
		2.0:
			s_clown = A.spr_clown
			s_clown_eyes = A.spr_clown_eyes
			s_clown_evil = A.spr_clown_evil
			s_clown_damage = A.spr_clown_damage
		3.0:
			s_clown = A.spr_NSMBU_clown
			s_clown_eyes = A.spr_NSMBU_clown_eyes
			s_clown_evil = A.spr_NSMBU_clown_evil
			s_clown_damage = A.spr_NSMBU_clown_damage
	s_clown_link = A.spr_SMB_clown_link
	s_clown_bounce = 0.0
	s_clown_evil_bounce = 0.0
	inenemy = 0.0
	enemyobject = A.obj_lighting
	enablecontrol = 1.0
	swimming = 0.0
	modo_lava = 0.0
	direct = -1.0
	x_scale = 1.0
	y_scale = 1.0
	rotacion = 0.0
	rot = 0.0
	up = 0.0
	rot_angle = 0.0


# from objects/obj_clown/Destroy_0.gml
func _destroy() -> void:
	inmario = 0.0
	GM.audio_stop_sound(A.snd_NSMBU_clown_fly)
	GM.audio_stop_sound(A.snd_NSMBU_clown_charge_end)


# from objects/obj_clown/Step_0.gml
func _step() -> void:
	if inmario == 1.0:
		if G.powerup == -82.0 or GM.instance_exists(A.obj_frozenmario):
			inmario = 2.0
			hspeed = 0.0
			alarm[1] = 40.0
			for inst in GM.with_list(A.obj_mario):
				inst.inclown = 0.0
		depth = -12.0
		if sprite_index != s_clown_damage and sprite_index != s_clown_evil and sprite_index != s_clown_eyes and sprite_index != s_clown_link:
			sprite_index = s_clown
		if x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0):
			x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0)
			if hspeed < 0.0:
				hspeed = 0.0
		elif x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0)) - 16.0)):
			x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0)) - 16.0))
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
				inst.y = (y - 38.0)
			for inst in GM.with_list(A.obj_mario):
				inst.direct = direct
			if GM.keyboard_check(G.izquierda) and (not GM.keyboard_check(G.derecha)) and enablecontrol == 1.0 and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bumper, false, false) == null):
				hspeed -= 0.05
				if hspeed < -1.0:
					hspeed = -1.0
				gravity = 0.0
				direct = -1.0
			elif GM.keyboard_check(G.derecha) and (not GM.keyboard_check(G.izquierda)) and enablecontrol == 1.0 and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bumper, false, false) == null):
				hspeed += 0.05
				if hspeed > 1.0:
					hspeed = 1.0
				gravity = 0.0
				direct = 1.0
			elif sprite_index != s_clown_damage:
				if hspeed > 0.0:
					hspeed -= 0.05
				elif hspeed < 0.0:
					hspeed += 0.05
				if absf(hspeed) < 0.05:
					hspeed = 0.0
			if GM.keyboard_check(G.arriba) and (not GM.keyboard_check(G.abajo)) and enablecontrol == 1.0:
				vspeed -= 0.05
				if vspeed < -1.0:
					vspeed = -1.0
			elif GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)) and enablecontrol == 1.0 and gravity != 0.0 and vspeed != 0.0:
				vspeed += 0.05
				if vspeed > 1.0:
					vspeed = 1.0
			if GM.keyboard_check_pressed(G.saltar) or (GM.keyboard_check_pressed(G.saltar_spin) and G.apariencia != 2.0):
				inmario = 2.0
				hspeed = 0.0
				alarm[1] = 40.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_mario):
					if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (inst.y + 16.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
						inst.vspeed = -2.0
					else:
						inst.vspeed = -3.75
					GM.audio_stop_sound(Scr.scr_jump(inst))
					GM.audio_play_sound(Scr.scr_jump(inst), 0.0, false)
					inst.jumpnow = 1.0
					inst.state = 2.0
					inst.inclown = 0.0
					inst.gp_limit = 8.0
				GM.other = _o
			elif GM.keyboard_check_pressed(G.saltar_spin) and (G.apariencia == 2.0 or G.apariencia == 3.0):
				inmario = 2.0
				hspeed = 0.0
				alarm[1] = 40.0
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_mario):
					if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (GM.instance_exists(A.obj_lava_water) and (inst.y + 16.0) > GM.instance_find(A.obj_lava_water, 0).y and G.bg_level == "forest" and G.modo_noche == 0.0):
						inst.vspeed = -2.0
					else:
						inst.vspeed = -3.0
					GM.audio_stop_sound(Scr.scr_snd_spinjump(inst))
					GM.audio_play_sound(Scr.scr_snd_spinjump(inst), 0.0, false)
					inst.jumpnow = 1.0
					inst.state = 2.0
					inst.isduck = 0.0
					inst.isduckhold = 0.0
					inst.y -= 1.0
					inst.stompstyle = 1.0
					inst.inclown = 0.0
				GM.other = _o
			if G.powerup == -85.0 and (not GM.instance_exists(A.obj_link_bomb)) and object_index != A.obj_clown_fire and GM.keyboard_check(G.lanzar_agarrar):
				if GM.keyboard_check_pressed(G.abajo):
					GM.audio_play_sound(A.snd_SMB_link_throw, 0.0, false)
					sprite_index = s_clown_link
					alarm[4] = 30.0
					alarm[0] = 30.0
					for inst in GM.with_list(GM.instance_create(x, (y + 16.0), A.obj_link_bomb)):
						inst.held = 0.0
						inst.bouncy = 1.0
						if inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 8.0), inst.bbox_right, inst.bbox_bottom, A.obj_solid, false, false) != null or inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 8.0), inst.bbox_right, inst.bbox_bottom, A.obj_bullebill_base, false, false) != null or inst.collision_rectangle(inst.bbox_left, (inst.bbox_top + 8.0), inst.bbox_right, inst.bbox_bottom, A.obj_physicssolid, false, false) != null:
							inst.y -= 16.0
		else:
			inmario = 0.0
			inenemy = 0.0
			enemyobject = A.obj_lighting
			enablecontrol = 1.0
		if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("camlock") == 1.0:
			if y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 22.0):
				y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 22.0)
	elif inenemy == 1.0:
		if GM.instance_exists(A.obj_mario):
			if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 1.0), A.obj_mario, false, false) != null and GM.instance_find(A.obj_mario, 0).get("state") == 2.0 and GM.instance_find(A.obj_mario, 0).vspeed < 0.0:
				GM.audio_stop_sound(A.snd_stomp)
				GM.audio_play_sound(A.snd_stomp, 0.0, false)
				vspeed = -2.0
		if sprite_index != s_clown_damage:
			sprite_index = s_clown_evil
		depth = -4.0
		if GM.instance_exists(enemyobject):
			# PORT: 原版没有任何地方把 inenemy 设成 1（只有 Create/Alarm_3 设 0），这一支走不到；
			# 走到时 enemyobject 应是实例，下面的 enemyobject.xxx 照原样直接访问
			for inst in GM.with_list(enemyobject):
				inst.vspeed = 0.0
				inst.hspeed = 0.0
				inst.gravity = 0.0
				inst.depth = (self.depth + 1.0)
			enemyobject.x = x
			if enemyobject.object_index != A.obj_jumppiranha and enemyobject.object_index != A.obj_thwomp and enemyobject.object_index != A.obj_mushroom and enemyobject.object_index != A.obj_fireflower and enemyobject.object_index != A.obj_blooper and enemyobject.object_index != A.obj_cap and enemyobject.object_index != A.obj_star:
				enemyobject.direct = direct
			if enemyobject.object_index == A.obj_brohammer or enemyobject.object_index == A.obj_sledgebro:
				enemyobject.y = (y - 19.0)
			elif enemyobject.object_index == A.obj_koopa or enemyobject.object_index == A.obj_koopa_red:
				enemyobject.y = (y - 23.0)
			elif enemyobject.object_index == A.obj_shell_held or enemyobject.object_index == A.obj_shell:
				enemyobject.image_speed = 0.0
				enemyobject.image_index = 0.0
				enemyobject.y = (y - 23.0)
				enemyobject.x = (x - 8.0)
			elif enemyobject.object_index == A.obj_pswitch:
				enemyobject.image_speed = 0.0
				enemyobject.image_index = 0.0
				enemyobject.y = (y - 26.0)
				enemyobject.x = (x - 8.0)
			elif enemyobject.object_index == A.obj_mushroom or enemyobject.object_index == A.obj_blooper or enemyobject.object_index == A.obj_fireflower or enemyobject.object_index == A.obj_cap or enemyobject.object_index == A.obj_star:
				enemyobject.y = (y - 23.0)
				enemyobject.x = (x - 8.0)
			elif enemyobject.object_index == A.obj_boo:
				enemyobject.y = (y - 15.0)
			elif enemyobject.object_index == A.obj_thwomp or enemyobject.object_index == A.obj_boomboom:
				enemyobject.y = (y - 16.0)
			else:
				enemyobject.y = (y - 23.0)
			if GM.instance_exists(A.obj_mario):
				if GM.instance_find(A.obj_mario, 0).x > (x + 8.0) and enablecontrol == 1.0:
					hspeed = 0.7
					direct = 1.0
				elif GM.instance_find(A.obj_mario, 0).x < (x - 8.0) and enablecontrol == 1.0:
					hspeed = -0.7
					direct = -1.0
				if GM.instance_find(A.obj_mario, 0).y > (y - 8.0) and enablecontrol == 1.0:
					vspeed = 0.7
				elif GM.instance_find(A.obj_mario, 0).y < y and enablecontrol == 1.0:
					vspeed = -0.7
		else:
			hspeed = 0.0
			inenemy = 2.0
			enemyobject = A.obj_lighting
			alarm[3] = 60.0
	else:
		if object_index == A.obj_clown_fire:
			carga = 0.0
			audio_charge = 0.0
			GM.audio_stop_sound(Scr.scr_snd_clown_fire_charge(self))
			GM.audio_stop_sound(A.snd_NSMBU_clown_charge_end)
		GM.audio_stop_sound(A.snd_NSMBU_clown_fly)
		depth = 0.0
		if sprite_index != s_clown_damage:
			if sprite_index != s_clown_eyes:
				sprite_index = s_clown
			if hspeed > 0.0:
				hspeed -= 0.05
			if hspeed < 0.0:
				hspeed += 0.05
			if absf(hspeed) < 0.05:
				hspeed = 0.0
	super._step()


# from objects/obj_clown/Step_2.gml
func _step_end() -> void:
	if inmario == 1.0:
		if GM.instance_exists(A.obj_mario):
			v_duck_small = (GM.instance_find(A.obj_mario, 0).y + 12.0)
			if GM.keyboard_check(G.abajo) and (not GM.keyboard_check(G.arriba)) and G.apariencia == 2.0:
				if GM.instance_find(A.obj_mario, 0).get("holding") == 2.0:
					var _spr: Variant = Scr.scr_marioduckhold(self)  # PORT: 原版 obj_mario.sprite_index = scr_marioduckhold()，脚本在 clown 上下文里调用一次，再赋给全部 obj_mario
					for inst in GM.with_list(A.obj_mario):
						inst.sprite_index = _spr
					if GM.instance_exists(A.obj_helmet):
						if G.powerup == 0.0:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 2.0)
						else:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 5.0)
				else:
					var _spr: Variant = Scr.scr_marioduck(self)  # PORT: 同上
					for inst in GM.with_list(A.obj_mario):
						inst.sprite_index = _spr
					if GM.instance_exists(A.obj_helmet):
						if G.powerup == 0.0:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = v_duck_small
						else:
							for inst in GM.with_list(A.obj_helmet):
								inst.y = (v_duck_small - 1.0)
	if rot == 1.0:
		if up == 0.0:
			if rotacion > (rot_angle - 16.0):
				rotacion -= 2.0
			else:
				up = 1.0
		if up == 1.0:
			if rotacion < (rot_angle + 16.0):
				rotacion += 2.0
			else:
				up = 2.0
		elif up == 2.0:
			if rotacion > rot_angle:
				rotacion -= 2.0
			else:
				up = 0.0
				rot = 0.0
	else:
		rotacion = rot_angle
	super._step_end()


# from objects/obj_clown/Alarm_0.gml
func _alarm_0() -> void:
	if sprite_index != s_clown_evil and sprite_index != s_clown_bounce and sprite_index != s_clown_evil_bounce and sprite_index != s_clown_damage:
		if sprite_index == s_clown:
			sprite_index = s_clown_eyes
			alarm[0] = 10.0
		else:
			sprite_index = s_clown
			alarm[0] = (120.0 + GM.random(GM.gm_round(120.0)))
	else:
		alarm[0] = 30.0


# from objects/obj_clown/Alarm_1.gml
func _alarm_1() -> void:
	inmario = 0.0


# from objects/obj_clown/Alarm_2.gml
func _alarm_2() -> void:
	enablecontrol = 1.0
	GM.audio_stop_sound(Scr.scr_snd_clown_damage(self))
	if inenemy == 1.0:
		sprite_index = s_clown_evil
	else:
		sprite_index = s_clown
		alarm[0] = 30.0


# from objects/obj_clown/Alarm_3.gml
func _alarm_3() -> void:
	if inenemy == 2.0:
		inenemy = 0.0
	else:
		alarm[3] = -1.0


# from objects/obj_clown/Alarm_4.gml
func _alarm_4() -> void:
	sprite_index = s_clown


# from objects/obj_clown/Collision_obj_boomboom.gml
func _collision_obj_boomboom(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
		if inmario == 1.0:
			GM.audio_stop_sound(A.snd_stomp)
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
			if (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				hspeed = 1.5
			elif (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				hspeed = -1.5


# from objects/obj_clown/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
		GM.audio_stop_sound(A.snd_stomp)
		GM.audio_play_sound(A.snd_stomp, 0.0, false)
		if rot == 0.0:
			rot = 1.0
		hspeed = GM.lengthdir_x(3.0, GM.point_direction(other.x, other.y, x, y))


# from objects/obj_clown/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	pass  # 原文件为空


# from objects/obj_clown/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	pass  # 原文件为空


# from objects/obj_clown/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other
	if inenemy == 1.0:
		GM.audio_stop_sound(A.snd_stomp)
		GM.audio_play_sound(A.snd_stomp, 0.0, false)
		enablecontrol = 0.0
		if sprite_index != s_clown_damage:
			alarm[2] = 30.0
		other.hspeed = GM.lengthdir_x(1.0, GM.point_direction(x, y, other.x, other.y))
	elif (inmario == 0.0 and (not GM.instance_exists(A.obj_kuribo_drybones))) or (inmario == 0.0 and GM.instance_exists(A.obj_kuribo_drybones) and GM.instance_find(A.obj_kuribo_drybones, 0).get("gran_golpe") == 0.0):
		if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed > 0.0 and o.state == 2.0 and G.powerup != -82.0:
			o.inclown = 1.0
			inmario = 1.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(A.snd_add_wings, 0.0, false)
				GM.audio_play_sound(A.snd_NSMBU_clown_fly, 1.0, true)
			else:
				GM.audio_play_sound(A.snd_clown_in, 0.0, false)
			alarm[0] = 30.0
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
				inst.dash_atack = 0.0
				inst.dash_cont = 0.0
				inst.arrow = 0.0
				inst.arrow_ready = 0.0
				inst.event_user(15)
			GM.other = _o


# from objects/obj_clown/Collision_obj_pinchos.gml
func _collision_obj_pinchos(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
		GM.audio_stop_sound(Scr.scr_snd_clown_damage(self))
		GM.audio_play_sound(Scr.scr_snd_clown_damage(self), 0.0, false)
		enablecontrol = 0.0
		alarm[2] = 180.0
		alarm[0] = -1.0
		sprite_index = s_clown_damage
		if (other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			hspeed = 1.0
			vspeed = -1.0
		elif (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = -1.0
			vspeed = -1.0
		elif (other.bbox_bottom + (bbox_top / 2.0)) < (bbox_bottom + (bbox_top / 2.0)):
			hspeed = 1.0
			vspeed = -1.0
		elif (other.bbox_bottom + (bbox_top / 2.0)) > (bbox_bottom + (bbox_top / 2.0)):
			hspeed = -1.0
			vspeed = 1.0


# from objects/obj_clown/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	pass  # 原文件为空


# from objects/obj_clown/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = s_clown
	imdead.image_speed = 0.0
	imdead.image_index = 0.0
	imdead.direct = direct
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_clown/Other_13.gml
func _user_3() -> void:
	var col_one_left
	var col_one_right
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.set("rot", 1.0)
				inst.event_user(0)
			GM.other = _o
		hspeed = (-hspeed)
		enablecontrol = 0.0
		if sprite_index != s_clown_damage:
			alarm[2] = 15.0
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


# from objects/obj_clown/Other_14.gml
func _user_4() -> void:
	var semisolid
	var physolid
	var col_one_top
	var col_one_bottom
	var col_bbox
	if vspeed >= 0.0:
		semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) == null) and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_physicssolid, true, false) == null) and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_bullebill_base, true, false) == null) and (collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) == null):
				vspeed = -0.5
				if G.apariencia == 3.0:
					GM.audio_stop_sound(A.spr_NSMBU_clown_bounce)
					GM.audio_play_sound(A.spr_NSMBU_clown_bounce, 0.0, false)
			else:
				vspeed = 0.0
			col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.set("rot", 1.0)
					inst.event_user(0)
				GM.other = _o
	else:
		gravity = 0.02
		if vspeed > 0.5:
			vspeed = 0.5
	if vspeed < 0.0:
		if inmario == 0.0:
			if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
					y += 1.0
				col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
				if col_one_bottom != null:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_one_bottom):
						inst.set("rot", 1.0)
						inst.event_user(0)
					GM.other = _o
				vspeed = 0.0
		else:
			if G.powerup == 0.0:
				col_bbox = 10.0
			else:
				col_bbox = 16.0
			if collision_rectangle(bbox_left, (bbox_top - col_bbox), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - col_bbox), bbox_right, bbox_top, A.obj_hurtsolid2, true, false) != null or collision_rectangle(bbox_left, (bbox_top - col_bbox), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - col_bbox), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - col_bbox), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
					y += 1.0
				col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
				if col_one_bottom != null:
					var _o: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_one_bottom):
						inst.set("rot", 1.0)
						inst.event_user(0)
					GM.other = _o
				vspeed = 0.0
	if bbox_top > (GM.room_height + 46.0) or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 32.0) and (G.bg_level == "castle" or (G.bg_level == "forest" and G.modo_noche == 1.0) or (G.bg_level == "mountain" and G.modo_noche == 1.0))):
		instance_destroy()
	_user_14()


# from objects/obj_clown/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, x, y, (x_scale * direct), y_scale, rotacion, GM.c_white, 1.0)
