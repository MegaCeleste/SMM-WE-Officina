extends "res://objects/obj_holdparent.gd"

var hardness: float = 0.0


# from objects/obj_enemyparent_held/Create_0.gml
func _create() -> void:
	super._create()
	hardness = 0.0
	direct = 1.0
	inmune = 1.0
	if object_index == A.obj_shell or object_index == A.obj_shell_empty or object_index == A.obj_spiny_empty or object_index == A.obj_shell_drybones:
		alarm[6] = 15.0
	else:
		alarm[3] = 15.0


# from objects/obj_enemyparent_held/Step_0.gml
func _step() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var col_mario_left
	var col_mario_right
	if y < -20.0 and vspeed < 0.0:
		y = -20.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if held == 0.0:
		col_mario_left = collision_rectangle((bbox_left - 6.0), (bbox_top + 8.0), bbox_left, (bbox_bottom - 4.0), A.obj_mario, false, false)
		col_mario_right = collision_rectangle(bbox_right, (bbox_top + 8.0), (bbox_right + 6.0), (bbox_bottom - 4.0), A.obj_mario, false, false)
		if GM.instance_exists(A.obj_mario) and (not GM.instance_exists(A.obj_invincibility)) and ((col_mario_left != null and i_mario.direct == 1.0) or (col_mario_right != null and i_mario.direct == -1.0)) and object_index != A.obj_shell and object_index != A.obj_shell_empty and object_index != A.obj_spiny_empty and i_mario.bbox_bottom > (bbox_top + 5.0) and i_mario.bbox_top < (bbox_bottom - 4.0) and Scr.scr_canhold(self) > 0.5 and (sprite_height <= 30.0 or object_index == A.obj_mechakoopa_held) and (object_index != A.obj_spring or (object_index == A.obj_spring and ready_v == 0.0 and ready2 == 0.0)) and inmune == 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 2.0
			if G.apariencia == 2.0 and i_mario.isduck == 1.0:
				for inst in GM.with_list(A.obj_mario):
					inst.isduckhold = 1.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(GM.choose(A.snd_NSMBU_hold1, A.snd_NSMBU_hold2), 0.0, false)
				for inst in GM.with_list(GM.other):  # UNSURE: Step 事件里的 other.id，原版意图疑为 obj_mario；按字面取 GM.other
					inst.triple_jump = 0.0
					inst.triple_count = 0.0
			held = 1.0
			depth = -7.0
			gravity = 0.0
			speed = 0.0
		if collision_rectangle(bbox_left, (bbox_top - 8.0), bbox_right, (bbox_top + 7.0), A.obj_mario, false, false) != null and image_speed != 0.0 and inmune == 0.0 and vspeed != 0.0 and hspeed == 0.0 and object_index != A.obj_bobomb_hold and object_index != A.obj_galoomba_hold and object_index != A.obj_galoomba_hold2:
			hspeed = (maxf(0.0, (absf(hspeed) - 0.075)) * GM.gm_sign(hspeed))
			if absf(hspeed) < 0.075:
				hspeed = 0.0
			for inst in GM.with_list(A.obj_mario):
				inst.x += hspeed
			if object_index == A.obj_spring:
				for inst in GM.with_list(A.obj_mario):
					inst.y = ((y + (image_index * 4.0)) - 32.0)
			else:
				for inst in GM.with_list(A.obj_mario):
					inst.y = ceilf((bbox_top - (31.0 - vspeed)))
		if GM.instance_exists(A.obj_mario):
			if inwall == 0.0:
				super._step()
				if gravity == 0.0:
					if swimming == 0.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.085)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.085:
							hspeed = 0.0
					elif swimming == 1.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.085)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.085:
							hspeed = 0.0
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) and vspeed < 0.0:
					hspeed = 0.0
					inwall = 1.0
			else:
				if object_index == A.obj_galoomba_hold or object_index == A.obj_bobomb_hold:
					direct = (-direct)
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x += 1.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
					x += 1.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
					x += 1.0
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_hurtsolid2, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidphy, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null):
					inwall = 0.0
		elif GM.instance_exists(A.obj_deadmario):
			vspeed = 0.0
			gravity = 0.0
		else:
			super._step()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "castle" and object_index != A.obj_bobomb_hold and modo_lava == 0.0:
			if G.apariencia != 0.0:
				if object_index == A.obj_shell:
					GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_lava)
				else:
					GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_lava)
			modo_lava = 1.0
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y - 12.0) and G.bg_level == "forest" and G.modo_noche == 1.0 and object_index != A.obj_bobomb_hold and modo_lava == 0.0:
			if G.apariencia != 0.0:
				if object_index == A.obj_shell:
					GM.instance_create(x, (i_lava_water.y - 26.0), A.obj_splash_posion)
				else:
					GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_posion)
			modo_lava = 1.0
		elif y > GM.room_height and object_index != A.obj_cap_mario and object_index != A.obj_helmet and object_index != A.obj_helmet_spiny and held == 0.0:
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) <= (i_lava_water.y - 12.0) and i_lava_water.vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (i_lava_water.y - 20.0)


# from objects/obj_enemyparent_held/Step_2.gml
func _step_end() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_player_warp = GM.instance_find(A.obj_player_warp, 0)
	var i_doormario = GM.instance_find(A.obj_doormario, 0)
	var i_doormario_exit = GM.instance_find(A.obj_doormario_exit, 0)
	if held == 1.0:
		swimming = 0.0
		vspeed = 0.0
		if GM.instance_exists(A.obj_mario):
			if i_mario.helice_fly == 4.0 or i_mario.stuntime > 0.0 or (G.powerup == -82.0 and (not GM.instance_exists(A.obj_mario_transform2))):
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
				y -= 1.0
				held = 0.0
				depth = 0.0
				shake = 0.0
				alarm[0] = -1.0
				if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_physicssolid, false, false) != null:
					inwall = 1.0
					hspeed = 0.0
				if i_mario.hspeed == 0.0:
					hspeed = (1.0 * i_mario.direct)
				else:
					hspeed = (i_mario.hspeed / 2.0)
				inmune = 1.0
				alarm[6] = 15.0
				for inst in GM.with_list(A.obj_mario):
					inst.isduckhold = 0.0
				return
			if i_mario.holding == 2.0 and (i_mario.stompstyle == 1.0 or (i_mario.helice_fly > 0.0 and i_mario.helice_fly < 4.0)):
				if alarm[0] == -1.0:
					alarm[0] = 1.0
				x = (i_mario.x + spin_x)
			elif i_mario.airspin == 1.0 and i_mario.holding == 2.0:
				if alarm[0] == -1.0:
					alarm[0] = 1.0
				x = (i_mario.x + spin_x)
			else:
				if G.apariencia == 3.0:
					depth = -10.0
					x = (i_mario.x + (8.0 * i_mario.direct))
				elif i_mario.turning == 1.0:
					depth = -10.0
					x = i_mario.x
				else:
					depth = -7.0
					x = (i_mario.x + (11.0 * i_mario.direct))
				shake = 0.0
				alarm[0] = -1.0
				if GM.keyboard_check(G.abajo) and i_mario.state < 2.0 and object_index == A.obj_shell_drybones:
					_user_1()
					for inst in GM.with_list(A.obj_mario):
						inst.isduckhold = 0.0
				elif GM.keyboard_check(G.abajo) and i_mario.state < 2.0 and i_mario.helmet == 0.0 and G.apariencia != 3.0 and object_index == A.obj_shell_empty:
					GM.audio_stop_sound(A.snd_helmet_add)
					GM.audio_play_sound(A.snd_helmet_add, 0.0, false)
					for inst in GM.with_list(A.obj_mario):
						inst.helmet = 1.0
					GM.instance_create(i_mario.x, (i_mario.y + 15.0), A.obj_helmet)
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 0.0
					for inst in GM.with_list(A.obj_mario):
						inst.isduckhold = 0.0
					instance_destroy()
				elif GM.keyboard_check(G.abajo) and i_mario.state < 2.0 and i_mario.helmet == 0.0 and G.apariencia != 3.0 and object_index == A.obj_spiny_empty:
					GM.audio_stop_sound(A.snd_helmet_spiny_add)
					GM.audio_play_sound(A.snd_helmet_spiny_add, 0.0, false)
					for inst in GM.with_list(A.obj_mario):
						inst.helmet = 1.0
					GM.instance_create(i_mario.x, (i_mario.y + 15.0), A.obj_helmet_spiny)
					for inst in GM.with_list(GM.instance_create((i_mario.x - 4.0), (i_mario.y + 14.0), A.obj_smoke)):
						inst.sprite_index = A.spr_sparkles_helmet
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 0.0
					for inst in GM.with_list(A.obj_mario):
						inst.isduckhold = 0.0
					instance_destroy()
				elif GM.keyboard_check(G.abajo) and i_mario.vspeed == 0.0 and G.apariencia == 2.0:
					y = (i_mario.y + 16.0)
			if (i_mario.y + 4.0) < (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0):
				y = (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0)
			elif G.powerup == 0.0:
				if G.apariencia == 3.0:
					y = (i_mario.y + 12.0)
				else:
					y = (i_mario.y + 15.0)
			elif G.apariencia == 3.0:
				y = (i_mario.y + 4.0)
			else:
				y = (i_mario.y + 12.0)
			if GM.keyboard_check(G.lanzar_agarrar):
				if GM.keyboard_check(G.abajo) and i_mario.state < 2.0 and i_mario.stompstyle == 0.0 and G.apariencia != 3.0 and (object_index == A.obj_spiny_empty or object_index == A.obj_shell_empty):
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 0.0
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 2.0
				if i_mario.stompstyle == 0.0:
					direct = i_mario.direct
				else:
					direct = 1.0
			elif i_mario.disablecontrols == 0.0 and G.key_br == 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
				y -= 1.0
				held = 0.0
				depth = 0.0
				shake = 0.0
				alarm[0] = -1.0
				_user_2()
			visible = true
		elif GM.instance_exists(A.obj_player_warp):
			for inst in GM.with_list(A.obj_player_warp):
				inst.set("myitem", sprite_index)
			G.warp_item = sprite_index
			if G.apariencia == 3.0:
				x = (i_player_warp.x + (8.0 * i_player_warp.get("direct")))
			else:
				x = (i_player_warp.x + (11.0 * i_player_warp.get("direct")))
			if G.powerup == 0.0:
				if G.apariencia == 3.0:
					y = (i_player_warp.y + 12.0)
				else:
					y = (i_player_warp.y + 15.0)
			elif G.apariencia == 3.0:
				y = (i_player_warp.y + 4.0)
			else:
				y = (i_player_warp.y + 12.0)
			for inst in GM.with_list(A.obj_player_warp):
				inst.set("holding", 2.0)
			visible = false
		elif GM.instance_exists(A.obj_doormario):
			for inst in GM.with_list(A.obj_doormario):
				inst.set("myitem", sprite_index)
			if G.apariencia == 3.0:
				x = (i_doormario.x + (8.0 * i_doormario.get("direct")))
			else:
				x = (i_doormario.x + (11.0 * i_doormario.get("direct")))
			if G.powerup == 0.0:
				if G.apariencia == 3.0:
					y = (i_doormario.y + 12.0)
				else:
					y = (i_doormario.y + 15.0)
			elif G.apariencia == 3.0:
				y = (i_doormario.y + 4.0)
			else:
				y = (i_doormario.y + 12.0)
			for inst in GM.with_list(A.obj_doormario):
				inst.set("holding", 2.0)
			visible = false
		elif GM.instance_exists(A.obj_doormario_exit):
			for inst in GM.with_list(A.obj_doormario_exit):
				inst.set("myitem", sprite_index)
			if G.apariencia == 3.0:
				x = (i_doormario_exit.x + (8.0 * i_doormario_exit.get("direct")))
			else:
				x = (i_doormario_exit.x + (11.0 * i_doormario_exit.get("direct")))
			if G.powerup == 0.0:
				if G.apariencia == 3.0:
					y = (i_doormario_exit.y + 12.0)
				else:
					y = (i_doormario_exit.y + 15.0)
			elif G.apariencia == 3.0:
				y = (i_doormario_exit.y + 4.0)
			else:
				y = (i_doormario_exit.y + 12.0)
			for inst in GM.with_list(A.obj_doormario_exit):
				inst.set("holding", 2.0)
			visible = false
		elif G.warp_item == -4.0:
			held = 0.0
	else:
		_user_14()


# from objects/obj_enemyparent_held/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0 and bbox_bottom < (other.yprevious + 5.0) and kickme == 1.0 and inmune == 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		y -= 1.0
		_user_7()
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(((GM.gm_round((bbox_left + bbox_right)) / 2.0) - 8.0), y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		inmune = 1.0
		if object_index == A.obj_shell or object_index == A.obj_shell_empty or object_index == A.obj_spiny_empty or object_index == A.obj_shell_drybones:
			alarm[6] = 15.0
		else:
			alarm[3] = 15.0


# from objects/obj_enemyparent_held/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	if hspeed != 0.0 and held == 0.0 and vspeed < 0.0 and o.hardness < 99.0 and i_levelmanager.get("editor") == 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		_user_0()
	elif (hspeed != 0.0 or held == 1.0) and o.hardness < 99.0 and i_levelmanager.get("editor") == 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		_user_0()


# from objects/obj_enemyparent_held/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	if hspeed != 0.0 and held == 0.0 and vspeed <= 0.0 and o.hardness < 99.0 and other.sprite_index != A.spr_beachkoopa and other.sprite_index != A.spr_beachkoopa_red:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	elif vspeed < 0.0 and held == 0.0 and o.hardness < 99.0 and other.sprite_index != A.spr_beachkoopa and other.sprite_index != A.spr_beachkoopa_red:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2
	elif held == 1.0 and o.hardness < 99.0 and bbox_bottom > (other.bbox_top + 4.0):
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o3
		_user_0()


# from objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml
# Q7（port-plan §9）：yy 里这个碰撞事件缺 collisionObjectId，按“与自身同类（含后代）碰撞”处理
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	if hardness < 99.0:
		if o.held == 1.0:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			_user_0()
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
				inst.event_user(4)
			GM.other = _o
			for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o2
		elif held == 0.0 and o.held == 0.0 and hspeed != 0.0:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o3: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
				inst.event_user(4)
			GM.other = _o3
			for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
			var _o4: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o4


# from objects/obj_enemyparent_held/Collision_obj_explosion.gml
func _collision_obj_explosion(other: GMObject) -> void:
	if hardness < 99.0:
		_user_0()
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump


# from objects/obj_enemyparent_held/Collision_obj_fireball.gml
func _collision_obj_fireball(other: GMObject) -> void:
	if hardness < 99.0 and object_index != A.obj_bobomb_hold:
		_user_0()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
	else:
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_enemyparent_held/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	if hardness < 99.0:
		_user_0()
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump


# from objects/obj_enemyparent_held/Collision_obj_shell_held.gml
func _collision_obj_shell_held(other: GMObject) -> void:
	if held == 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		_user_0()
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), ((GM.gm_round((bbox_top + bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	else:
		_user_0()


# from objects/obj_enemyparent_held/Other_10.gml
func _user_0() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
			inst.isduckhold = 0.0
	for inst in GM.with_list(GM.instance_create(GM.gm_round(x), GM.gm_round((y + sprite_height)), A.obj_enemy_dead)):
		inst.sprite_index = self.sprite_index
		inst.image_index = self.image_index
	instance_destroy()


# from objects/obj_enemyparent_held/Other_17.gml
func _user_7() -> void:
	_user_0()
