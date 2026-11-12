extends "res://objects/obj_physicsparent.gd"

var held = null
var inup: float = 0.0
var big: float = 0.0
var modo_lava: float = 0.0
var inwall: float = 0.0
var shake: float = 0.0
var inmune: float = 0.0
var spin_x = null
var kickme: float = 0.0
var ready_v = null  # 原名 ready（和 Node.ready 撞名）；仅子类（obj_spring 等）赋值
var ready2 = null  # 仅子类赋值
var walk = null  # 仅子类赋值
var fisica = null  # 第 4 批补：由别的 object 写入
var explode = null  # 第 4 批补：由别的 object 写入


# from objects/obj_holdparent/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	held = 0.0
	inup = 0.0
	bouncy = 0.0
	direct = 1.0
	big = 0.0
	modo_lava = 0.0
	swimming = 0.0
	inwall = 0.0
	shake = 0.0
	inmune = 0.0
	spin_x = 0.0
	direct = 1.0
	kickme = 0.0


# from objects/obj_holdparent/Destroy_0.gml
func _destroy() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
			inst.isduckhold = 0.0
		for inst in GM.with_list(A.obj_player_warp):
			inst.set("holding", 0.0)
		for inst in GM.with_list(A.obj_doormario):
			inst.set("holding", 0.0)
		for inst in GM.with_list(A.obj_doormario_exit):
			inst.set("holding", 0.0)


# from objects/obj_holdparent/Step_0.gml
func _step() -> void:
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if y < -20.0 and vspeed < 0.0:
		y = -20.0
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	else:
		swimming = 0.0
	if held == 0.0:
		var col_mario_left = collision_rectangle((bbox_left - 6.0), (bbox_top + 8.0), bbox_left, (bbox_bottom - 4.0), A.obj_mario, false, false)
		var col_mario_right = collision_rectangle(bbox_right, (bbox_top + 8.0), (bbox_right + 6.0), (bbox_bottom - 4.0), A.obj_mario, false, false)
		if GM.instance_exists(A.obj_mario) and ((col_mario_left != null and i_mario.direct == 1.0) or (col_mario_right != null and i_mario.direct == -1.0)) and object_index != A.obj_shell and object_index != A.obj_shell_empty and object_index != A.obj_spiny_empty and i_mario.bbox_bottom > (bbox_top + 5.0) and i_mario.bbox_top < (bbox_bottom - 4.0) and Scr.scr_canhold(self) > 0.5 and sprite_height <= 30.0 and (object_index != A.obj_spring or (object_index == A.obj_spring and ready_v == 0.0 and ready2 == 0.0)) and inmune == 0.0:
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
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solidphy, false, false) != null) and vspeed < 0.0:
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
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
					x += 1.0
				if (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null) and (collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null):
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
		elif (y > GM.room_height and held == 0.0) or (modo_lava == 1.0 and GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (i_lava_water.y + 16.0)):
			instance_destroy()
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 5.0) < (i_lava_water.y - 12.0) and G.bg_level == "castle" and modo_lava == 1.0:
			modo_lava = 0.0
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) <= (i_lava_water.y - 12.0) and i_lava_water.vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (i_lava_water.y - 20.0)


# from objects/obj_holdparent/Step_2.gml
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
				alarm[3] = 15.0
				for inst in GM.with_list(A.obj_mario):
					inst.isduckhold = 0.0
				return
			if i_mario.holding == 2.0 and (i_mario.stompstyle == 1.0 or (i_mario.helice_fly > 0.0 and i_mario.helice_fly < 4.0)):
				if alarm[0] == -1.0:
					alarm[0] = 1.0
				x = ((i_mario.x - 8.0) + spin_x)
			elif i_mario.airspin == 1.0 and i_mario.holding == 2.0:
				if alarm[0] == -1.0:
					alarm[0] = 1.0
				x = ((i_mario.x - 8.0) + spin_x)
			else:
				if G.apariencia == 3.0:
					depth = -10.0
					x = ((i_mario.x - 8.0) + (10.0 * i_mario.direct))
				elif i_mario.turning == 1.0:
					depth = -10.0
					x = (i_mario.x - 8.0)
				else:
					depth = -7.0
					x = ((i_mario.x - 8.0) + (11.0 * i_mario.direct))
				shake = 0.0
				alarm[0] = -1.0
				if GM.keyboard_check(G.abajo) and i_mario.vspeed == 0.0 and i_mario.gravity == 0.0 and G.apariencia == 2.0:
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
				if GM.keyboard_check(G.abajo) and i_mario.state < 2.0 and i_mario.stompstyle == 0.0 and G.apariencia != 3.0 and i_mario.helmet == 0.0 and (object_index == A.obj_spiny_empty or object_index == A.obj_shell_empty):
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 0.0
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.holding = 2.0
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
				x = ((i_player_warp.x - 8.0) + (10.0 * i_player_warp.get("direct")))
			else:
				x = ((i_player_warp.x - 8.0) + (11.0 * i_player_warp.get("direct")))
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
				x = ((i_doormario.x - 8.0) + (10.0 * i_doormario.get("direct")))
			else:
				x = ((i_doormario.x - 8.0) + (11.0 * i_doormario.get("direct")))
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
				x = ((i_doormario_exit.x - 8.0) + (10.0 * i_doormario_exit.get("direct")))
			else:
				x = ((i_doormario_exit.x - 8.0) + (11.0 * i_doormario_exit.get("direct")))
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
		var lava_lift = collision_rectangle(bbox_left, (bbox_bottom - 3.0), bbox_right, ((bbox_bottom + 4.0) + vspeed), A.obj_platform_parent, false, false)
		if lava_lift != null and vspeed >= 0.0:
			var check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_solidtop, false, false)
			var phy_check = collision_rectangle(bbox_left, (bbox_bottom - 2.0), bbox_right, ((bbox_bottom + 2.0) + vspeed), A.obj_physicssolid, false, false)
			if (check != null and check != lava_lift) or phy_check != null:
				return
			y = (lava_lift.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
			var spd = lava_lift.hspeed
			if (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed > 0.0 and (collision_rectangle(((bbox_right + 1.0) + spd), bbox_top, ((bbox_right + 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_solid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) == null)) or (lava_lift.hspeed < 0.0 and (collision_rectangle(((bbox_left - 1.0) + spd), bbox_top, ((bbox_left - 1.0) + spd), (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) == null)):
				x += lava_lift.hspeed
			if collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_onewaygate_left, false, false) != null or collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 1.0), (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
				x -= 1.0
			elif collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_solid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_onewaygate_right, false, false) != null or collision_rectangle((bbox_left - 1.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 1.0), A.obj_bullebill_base, false, false) != null:
				x += 1.0


# from objects/obj_holdparent/Alarm_0.gml
func _alarm_0() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if i_mario.stompstyle == 1.0 or i_mario.helice_fly == 1.0 or i_mario.helice_fly == 3.0:
			if shake > 4.0:
				shake = 0.0
			match shake:
				0.0:
					spin_x = 10.0
					depth = -7.0
				1.0:
					spin_x = 2.0
					depth = -7.0
				2.0:
					spin_x = -10.0
					depth = -7.0
				3.0:
					spin_x = -2.0
					depth = -10.0
				4.0:
					spin_x = 2.0
					depth = -10.0
			if shake == 4.0:
				shake = 0.0
			else:
				shake += 1.0
			alarm[0] = 1.6
		elif i_mario.helice_fly == 2.0:
			match shake:
				0.0:
					spin_x = 10.0
					depth = -7.0
				1.0:
					spin_x = 8.0
					depth = -7.0
				2.0:
					spin_x = 6.0
					depth = -7.0
				3.0:
					spin_x = 4.0
					depth = -7.0
				4.0:
					spin_x = 2.0
					depth = -7.0
				5.0:
					spin_x = 0.0
					depth = -7.0
				6.0:
					spin_x = -2.0
					depth = -7.0
				7.0:
					spin_x = -4.0
					depth = -7.0
				8.0:
					spin_x = -6.0
					depth = -7.0
				9.0:
					spin_x = -8.0
					depth = -7.0
				10.0:
					spin_x = -10.0
					depth = -7.0
				11.0:
					spin_x = -8.0
					depth = -10.0
				12.0:
					spin_x = -6.0
					depth = -10.0
				13.0:
					spin_x = -4.0
					depth = -10.0
				14.0:
					spin_x = -2.0
					depth = -10.0
				15.0:
					spin_x = 0.0
					depth = -10.0
				16.0:
					spin_x = 2.0
					depth = -10.0
				17.0:
					spin_x = 4.0
					depth = -10.0
				18.0:
					spin_x = 6.0
					depth = -10.0
				19.0:
					spin_x = 8.0
					depth = -10.0
			if shake == 19.0:
				shake = 0.0
			else:
				shake += 1.0
			alarm[0] = 2.6
		elif i_mario.airspin == 1.0:
			if shake > 7.0:
				shake = 0.0
			match shake:
				0.0:
					spin_x = 10.0
					depth = -7.0
				1.0:
					spin_x = -2.0
					depth = -7.0
				2.0:
					spin_x = 0.0
					depth = -7.0
				3.0:
					spin_x = -10.0
					depth = -7.0
				4.0:
					spin_x = -2.0
					depth = -7.0
				5.0:
					spin_x = 0.0
					depth = -10.0
				6.0:
					spin_x = 2.0
					depth = -10.0
				7.0:
					spin_x = 10.0
					depth = -10.0
			if shake == 7.0:
				shake = 0.0
			else:
				shake += 1.0
			alarm[0] = 1.6
	else:
		shake = 0.0
		spin_x = 0.0


# from objects/obj_holdparent/Alarm_2.gml
func _alarm_2() -> void:
	kickme = 1.0


# from objects/obj_holdparent/Alarm_3.gml
func _alarm_3() -> void:
	inmune = 0.0


# from objects/obj_holdparent/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if held == 0.0 and other.vspeed < 0.0 and kickme == 1.0:
		if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "airship") or (G.modo_noche == 1.0 and G.bg_level == "sky"):
			vspeed = -1.8
		else:
			vspeed = -3.0
		y -= 1.0
		kickme = 0.0
		alarm[2] = 4.0
	elif held == 0.0 and other.vspeed < 0.0 and vspeed < 0.0:
		_user_1()


# from objects/obj_holdparent/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var alturabo  # 局部变量提升（GML 的 var 是函数作用域）
	if held == 0.0:
		if object_index == A.obj_bobomb_hold:
			alturabo = 12.0
		else:
			alturabo = 5.0
		if other.bbox_bottom < ((bbox_top - vspeed) + alturabo) and other.vspeed > 0.0:
			_user_1()
		elif Scr.scr_canhold(self) == 0.0 and inmune == 0.0 and (object_index == A.obj_bobomb_hold or object_index == A.obj_galoomba_hold or object_index == A.obj_galoomba_hold_b or object_index == A.obj_galoomba_hold2 or object_index == A.obj_galoomba_hold2_b or object_index == A.obj_mechakoopa_held or object_index == A.obj_link_bomb):
			if not GM.audio_is_playing(Scr.scr_snd_kick(self)):
				GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			if not GM.instance_exists(A.obj_spinthump):
				for inst in GM.with_list(GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)):
					inst.image_xscale = 0.5
					inst.image_yscale = 0.5
			if (other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				hspeed = (other.hspeed - (1.0 - swimming))
				direct = -1.0
			else:
				hspeed = (other.hspeed + (1.0 - swimming))
				direct = 1.0
			vspeed = (-0.5 + swimming)
			inmune = 1.0
			alarm[3] = 15.0


# from objects/obj_holdparent/Other_5.gml
func _room_end() -> void:
	pass


# from objects/obj_holdparent/Other_11.gml
func _user_1() -> void:
	pass


# from objects/obj_holdparent/Other_12.gml
func _user_2() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.keyboard_check(G.abajo):
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_muncher, false, false) != null:
			inwall = 1.0
			hspeed = 0.0
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_slopeparent, true, false) == null:
			if i_mario.hspeed == 0.0:
				hspeed = (0.7 * i_mario.direct)
			else:
				hspeed = (i_mario.hspeed / 2.0)
		else:
			vspeed = 0.1
		inmune = 1.0
		alarm[3] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	elif GM.keyboard_check(G.arriba) and G.apariencia == 2.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
		if i_mario.hspeed == 0.0:
			hspeed = 0.0
		else:
			hspeed = (i_mario.direct / 2.0)
		vspeed = (-((6.125 - (3.5 * swimming))))
		if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_muncher, false, false) != null:
			inwall = 1.0
		inmune = 1.0
		alarm[3] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	else:
		if G.apariencia == 3.0:
			GM.audio_play_sound(GM.choose(A.snd_NSMBU_throw1, A.snd_NSMBU_throw2, A.snd_NSMBU_throw1), 0.0, false)
		else:
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			for inst in GM.with_list(GM.instance_create((x + 8.0), (y - 2.0), A.obj_smoke)):
				inst.sprite_index = A.spr_spinthump
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_mario):
			inst.event_user(7)
		GM.other = _o2
		for inst in GM.with_list(A.obj_mario):
			inst.stompstyle = 0.0
		if i_mario.helice_fly != 0.0:
			for inst in GM.with_list(A.obj_mario):
				inst.helice_fly = 5.0
		y += 1.0
		bouncy = 1.0
		if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_solid, false, false) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_bullebill_base, false, false) == null) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, A.obj_physicssolid, false, false) == null):
			vspeed = (-((1.5 - swimming)))
			hspeed = (((2.0 - swimming) + absf(i_mario.hspeed)) * GM.gm_sign(i_mario.direct))
		else:
			inwall = 1.0
		inmune = 1.0
		alarm[3] = 15.0
		for inst in GM.with_list(A.obj_mario):
			inst.isduckhold = 0.0
	# Slope fix
	while collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null:
		y -= 1.0


# from objects/obj_holdparent/Other_13.gml
func _user_3() -> void:
	if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if hspeed > 0.0 and col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		if hspeed < 0.0 and col_one_right != null:
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o2
		direct = (-direct)
		if GM.variable_instance_exists(self, "walk") and walk == 1.0:
			hspeed = (-hspeed)
		else:
			hspeed = 0.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_physicssolid, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
			x += 1.0
		while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
			x -= 1.0
		while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
			x += 1.0


# from objects/obj_holdparent/Other_14.gml
func _user_4() -> void:
	if vspeed >= 0.0:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if vspeed > 4.0:
			vspeed = 4.0
	if (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null)):
		gravity = 0.0
		if vspeed > 0.0:
			if bouncy == 1.0:
				if vspeed > 0.5:
					vspeed = ((-vspeed) / 2.0)
					hspeed = (maxf(0.0, (absf(hspeed) - 0.085)) * GM.gm_sign(hspeed))
				else:
					vspeed = 0.0
					bouncy = 0.0
			else:
				vspeed = 0.0
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
	elif modo_lava == 1.0:
		hspeed = 0.0
		gravity = 0.02
		if vspeed > 0.03:
			vspeed = 0.03
	elif not swimming:
		gravity = 0.15
		if vspeed > 4.0:
			vspeed = 4.0
	elif swimming == 1.0:
		gravity = 0.02
		if vspeed > 1.0:
			vspeed = 1.0
	if vspeed < 0.0:
		if collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_physicssolid, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_solidphy, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, (bbox_top - vspeed), bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, true, false) != null and (not place_meeting(x, y, A.obj_physicssolid)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
				y += 1.0
			while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, true, false) != null and (not place_meeting(x, y, A.obj_bullebill_base)):
				y += 1.0
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o2: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o2
			var block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
			if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
				if block.ready_v == 0.0:
					var _o3: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(block):
						inst.event_user(2)
					GM.other = _o3
			vspeed = 0.0


# from objects/obj_holdparent/Other_15.gml
func _user_5() -> void:
	vspeed = (-((3.0 - (1.5 * swimming))))
	if GM.other.hspeed == 0.0:
		if ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) < ((bbox_left + bbox_right) / 2.0):
			hspeed = 0.6
		elif ((GM.other.bbox_left + GM.other.bbox_right) / 2.0) > ((bbox_left + bbox_right) / 2.0):
			hspeed = -0.6
	elif GM.other.hspeed > 0.0:
		hspeed = 0.6
	elif GM.other.hspeed < 0.0:
		hspeed = -0.6


# from objects/obj_holdparent/Other_40.gml
func _outside_view_0() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
		for inst in GM.with_list(A.obj_doormario):
			inst.set("holding", 0.0)


# from objects/obj_holdparent/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
