# 第 4 批移植，已核对。
extends GMObject

var yview: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var canmove: float = 0.0
var pos_center: float = 0.0
var holding: float = 0.0
var helmet: float = 0.0
var myitem = null
var offset: float = 0.0
var destruir: float = 0.0
var salir: float = 0.0
var direct: float = 0.0
var w_posx: float = 0.0
var w_posy: float = 0.0
var w_direct: float = 0.0
var devs: float = 0.0
var blend_star = null
var flashAlpha: float = 0.0
var cp: float = 0.0
var cp_cont: float = 0.0
var color: Array = []
var my_y: float = 0.0


# from objects/obj_player_warp/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	yview = (y + 32.0)
	ready_v = 0.0
	canmove = 1.0
	pos_center = x
	holding = 0.0
	helmet = 0.0
	myitem = GM.noone
	offset = 0.0
	destruir = 0.0
	salir = 0.0
	direct = 1.0
	w_posx = 0.0
	w_posy = 0.0
	w_direct = 0.0
	devs = 0.0
	blend_star = GM.c_white
	flashAlpha = 1.0
	cp = 0.0
	cp_cont = 0.0
	GM.aset(color, 0, GM.make_colour_rgb(255.0, 255.0, 72.0))
	GM.aset(color, 1, GM.make_colour_rgb(254.0, 138.0, 139.0))
	GM.aset(color, 2, GM.make_colour_rgb(102.0, 245.0, 157.0))
	if G.powerup == 0.0:
		my_y = 15.0
	else:
		my_y = 12.0


# from objects/obj_player_warp/Destroy_0.gml
func _destroy() -> void:
	pass


# from objects/obj_player_warp/Step_0.gml
func _step() -> void:
	var altura: float = 0.0
	var mario2: int = 0
	if destruir == 1.0:
		if G.powerup == 0.0:
			altura = 17.0
		else:
			altura = 27.0
		if (vspeed > 0.0 and y > (ystart + 32.0) and direction == 270.0) or (vspeed < 0.0 and y < (ystart - altura) and direction == 90.0) or (hspeed < 0.0 and x < (xstart - 24.0) and direction == 180.0) or (hspeed > 0.0 and x > (xstart + 24.0) and direction == 0.0):
			instance_destroy()
		if (direction == 90.0 or direction == 270.0) and x != pos_center:
			x += ((pos_center - x) * 0.4)
	if salir == 1.0:
		if (vspeed > 0.0 and y > (ystart + 20.0) and direction == 270.0) or (vspeed > 0.0 and direction == 270.0 and collision_rectangle((x - 8.0), (y + 32.0), (x + 8.0), (y + 34.0), A.obj_solidtop, false, false) != null and y > (ystart + 16.0)) or (vspeed < 0.0 and y < (ystart - 32.0) and direction == 90.0) or (hspeed < 0.0 and x < (xstart - 24.0) and direction == 180.0) or (hspeed > 0.0 and x > (xstart + 24.0) and direction == 0.0):
			if G.apariencia == 3.0:
				mario2 = A.obj_marioU
			else:
				mario2 = A.obj_mario
			for inst in GM.with_list(GM.instance_create(x, y, mario2)):
				if self.direction == 180.0:
					inst.direct = -1.0
				if G.powerup != 0.0 and (self.direction == 90.0 or self.direction == 270.0) and inst.collision_rectangle((self.x - 8.0), self.y, (self.x + 8.0), (self.y + 8.0), A.obj_solid, false, false) != null:
					if inst.holding == 2.0 and G.apariencia == 2.0:
						inst.isduckhold = 1.0
					inst.isduck = 1.0
				inst.holding = self.holding
				inst.helmet = self.helmet
				G.warp_item = -4.0
				inst.walljump = 2.0
				if G.apariencia == 3.0:
					inst.alarm[11] = 10.0
			instance_destroy()
	if canmove == 1.0:
		if direction == 90.0 or direction == 270.0:
			speed = 1.0
		else:
			speed = 0.6
	if hspeed > 0.0:
		direct = 1.0
	elif hspeed < 0.0:
		direct = -1.0


# from objects/obj_player_warp/Step_2.gml
func _step_end() -> void:
	var sprite
	if G.apariencia == 3.0:
		if direction == 90.0 or direction == 270.0:
			if holding == 0.0:
				sprite_index = Scr.scr_NSMBU_ground_idle(self)
			else:
				sprite_index = Scr.scr_NSMBU_hold_ground(self)
			image_speed = 0.0
			image_index = 6.0
		else:
			if destruir == 1.0 and image_index >= 15.0:
				image_speed = 0.0
			else:
				image_speed = 0.5
			sprite_index = Scr.scr_NSMBU_walkpipes(self)
	else:
		if direction == 90.0 or direction == 270.0:
			sprite = Scr.scr_marioidle(self)
		else:
			sprite = Scr.scr_mariowalk(self)
		if holding == 0.0:
			sprite_index = sprite
		else:
			sprite_index = Scr.scr_mariohold(self)
		if vspeed != 0.0:
			image_speed = 0.0
			image_index = 0.0
		else:
			image_speed = 0.15


# from objects/obj_player_warp/Alarm_0.gml
func _alarm_0() -> void:
	canmove = 1.0
	_user_0()


# from objects/obj_player_warp/Alarm_1.gml
func _alarm_1() -> void:
	var pipe = null
	if devs == 1.0:
		GM.instance_create(x, y, A.obj_deadmario)
		instance_destroy()
	else:
		_user_0()
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
			inst.devs = 1.0
			inst.canmove = 0.0
			inst.alarm[0] = 30.0
			inst.alarm[2] = 1.0
			inst.salir = 1.0
			inst.holding = self.holding
			inst.myitem = G.warp_item
		instance_destroy()
		for inst in GM.with_list(A.obj_levelmanager):
			inst.barrier = 1.0
			inst.alarm[6] = 2.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_player_warp/Alarm_2.gml
func _alarm_2() -> void:
	match direction:
		90.0:
			if collision_rectangle((x - 8.0), (y - 8.0), (x + 8.0), (y - 4.0), A.obj_solid, false, false) != null or collision_rectangle((x - 8.0), (y - 8.0), (x + 8.0), (y - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((x - 8.0), (y - 8.0), (x + 8.0), (y - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((x - 8.0), (y - 8.0), (x + 8.0), (y - 4.0), A.obj_onewaygate_bottom, false, false) != null:
				alarm[0] = -1.0
				alarm[1] = 120.0
		0.0:
			if collision_rectangle((x + 20.0), (y + 8.0), (x + 28.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((x + 20.0), (y + 8.0), (x + 28.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((x + 20.0), (y + 8.0), (x + 28.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((x + 18.0), (y + 8.0), (x + 28.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null:
				alarm[0] = -1.0
				alarm[1] = 120.0
		270.0:
			if collision_rectangle((x - 8.0), (y + 40.0), (x + 8.0), (y + 44.0), A.obj_solid, false, false) != null or collision_rectangle((x - 8.0), (y + 40.0), (x + 8.0), (y + 44.0), A.obj_physicssolid, false, false) != null or collision_rectangle((x - 8.0), (y + 40.0), (x + 8.0), (y + 44.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((x - 8.0), (y + 40.0), (x + 8.0), (y + 44.0), A.obj_onewaygate_top, false, false) != null:
				alarm[0] = -1.0
				alarm[1] = 120.0
		180.0:
			if collision_rectangle((x - 28.0), (y + 8.0), (x - 20.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null or collision_rectangle((x - 28.0), (y + 8.0), (x - 20.0), (bbox_bottom - 4.0), A.obj_physicssolid, false, false) != null or collision_rectangle((x - 28.0), (y + 8.0), (x - 20.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null or collision_rectangle((x - 28.0), (y + 8.0), (x - 18.0), (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null:
				alarm[0] = -1.0
				alarm[1] = 120.0


# from objects/obj_player_warp/Other_10.gml
func _user_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_pipes(self))
	GM.audio_play_sound(Scr.scr_snd_pipes(self), 0.0, false)


# from objects/obj_player_warp/Other_11.gml
func _user_1() -> void:
	# / @description Star effects
	if G.effect_star == 1.0:
		if G.apariencia == 3.0:
			if cp_cont == 0.0:
				flashAlpha -= 0.05
				if flashAlpha < 0.6:
					cp_cont = 1.0
					if cp < 1.0:
						cp += 1.0
					else:
						cp = 0.0
			else:
				flashAlpha += 0.05
				if flashAlpha > 0.8:
					cp_cont = 0.0
		else:
			# default 分支里的 break 只是跳出 switch，等价于 if/else
			if cp_cont == 0.0:
				flashAlpha -= 0.15
				if flashAlpha < 0.3:
					cp_cont = 1.0
					if cp < 2.0:
						cp += 1.0
					else:
						cp = 0.0
			else:
				flashAlpha += 0.15
				if flashAlpha > 0.9:
					cp_cont = 0.0
		blend_star = color[int(cp)]


# from objects/obj_player_warp/Draw_0.gml
func _gm_draw() -> void:
	var bota_roja
	var bota_verde
	var drybones_shell
	var iindex
	var pos
	match G.apariencia:
		0.0:
			if G.powerup == -77.0:
				drybones_shell = A.spr_SMB_kuribo_drybones_mega
				bota_roja = A.spr_SMB_kuriboshoe2_big
				bota_verde = A.spr_kuriboshoe_big
			else:
				drybones_shell = A.spr_SMB_kuribo_drybones
				bota_roja = A.spr_SMB_kuriboshoe2
				bota_verde = A.spr_SMB_kuriboshoe
		1.0:
			drybones_shell = A.spr_SMB3_kuribo_drybones
			bota_roja = A.spr_kuriboshoe2
			bota_verde = A.spr_kuriboshoe
		3.0:
			drybones_shell = A.spr_NSMBU_kuribo_drybones
			bota_roja = A.spr_kuriboshoe2
			bota_verde = A.spr_SMB_kuriboshoe
		_:
			drybones_shell = A.spr_kuribo_drybones
			bota_roja = A.spr_SMB_kuriboshoe2
			bota_verde = A.spr_SMB_kuriboshoe
	if G.yoshi > 0.0:
		if G.yoshi == 1.0:
			if GM.instance_exists(A.obj_yoshi_red):
				GM.draw_sprite_ext(A.spr_yoshi_red, image_index, GM.gm_round(x), (GM.gm_round(y) + 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			elif GM.instance_exists(A.obj_yoshi_blue):
				var i_yoshi_blue = GM.instance_find(A.obj_yoshi_blue, 0)
				if i_yoshi_blue.mouthholder != null:
					GM.draw_sprite_ext(A.spr_yoshi_fm_blue, image_index, GM.gm_round(x), (GM.gm_round(y) + 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(A.spr_yoshi_blue, image_index, GM.gm_round(x), (GM.gm_round(y) + 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			elif GM.instance_exists(A.obj_yoshi2):
				var i_yoshi2 = GM.instance_find(A.obj_yoshi2, 0)
				if i_yoshi2.mouthholder != null:
					GM.draw_sprite_ext(A.spr_yoshi_fm, image_index, GM.gm_round(x), (GM.gm_round(y) + 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(A.spr_yoshi, image_index, GM.gm_round(x), (GM.gm_round(y) + 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			GM.draw_sprite_ext(Scr.scr_marioride(self), image_index, GM.gm_round(x), (y - 7.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			if GM.instance_exists(A.obj_cap_mario):
				GM.draw_sprite_ext(A.spr_cap_stay_yoshi, 0.0, (x - (4.0 * direct)), (y - 9.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
		elif G.yoshi == 2.0:
			if GM.instance_exists(A.obj_kuribo_drybones):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_drybones(self), 0.0, GM.gm_round(x), (y - 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_drybones(self), 0.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(drybones_shell, 0.0, GM.gm_round(x), (y + 16.0), direct, 1.0, 0.0, GM.c_white, 1.0)
				if GM.instance_exists(A.obj_cap_mario):
					GM.draw_sprite_ext(A.spr_cap_stay_yoshi, 0.0, x, (y - 2.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
			elif GM.instance_exists(A.obj_kuriboshoe2):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y - 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(bota_roja, 0.0, GM.gm_round(x), (y + 17.0), direct, 1.0, 0.0, GM.c_white, 1.0)
			elif GM.instance_exists(A.obj_kuriboshoe):
				if G.powerup == -77.0:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), (y - 16.0), direct, 1.0, 0.0, GM.c_white, image_alpha)
				else:
					GM.draw_sprite_ext(Scr.scr_mario_shoe(self), 0.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
				GM.draw_sprite_ext(bota_verde, 0.0, GM.gm_round(x), (y + 16.0), direct, 1.0, 0.0, GM.c_white, 1.0)
	else:
		if G.powerup == 3.0:
			GM.draw_sprite_ext(A.spr_cap_stay_start, 0.0, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
		if holding == 2.0:
			if G.powerup == -85.0:
				if direction == 90.0 or direction == 270.0:
					pos = 1.0
				else:
					pos = 12.0
				GM.draw_sprite(myitem, 0.0, x, (y + pos))
			else:
				var posx: float = GM.sprite_get_xoffset(myitem)
				if direction == 90.0 or direction == 270.0:
					pos = 6.0
				else:
					pos = 11.0
				if myitem == A.spr_frozenblock_24x24 or myitem == A.spr_frozenblock_32x32 or myitem == A.spr_frozenblock_24x36 or myitem == A.spr_frozenblock_24x24 or myitem == A.spr_frozenblock_36x24 or myitem == A.spr_frozenblock_32x48:
					iindex = G.apariencia
				else:
					iindex = 0.0
				if posx < 4.0:
					GM.draw_sprite(myitem, iindex, ((x - 8.0) + (pos * direct)), (y + my_y))
				else:
					GM.draw_sprite(myitem, iindex, (x + (pos * direct)), (y + my_y))
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			var i_invincibility = GM.instance_find(A.obj_invincibility, 0)
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, i_invincibility.blend_star, i_invincibility.flashAlpha)
			GM.shader_reset()
