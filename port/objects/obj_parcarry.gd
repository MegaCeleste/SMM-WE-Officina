# from objects/obj_parcarry（第 5 批移植，已核对）
# ORIG-BUG: Create 第一句就是 instance_destroy()，之后的代码照常执行，但实例已销毁（照搬）
extends "res://objects/obj_physicsparent.gd"

var held = null
var snowball = null
var enemy = null
var hold = null
var cloud: float = 0.0
var obj = null  # object 编号：Create 里是 25（GMS 运行时编号），obj_puller 写入 object_index（int）
var sprite = null  # sprite 编号：Create 里是 3579（GMS 运行时编号），obj_puller 写入 sprite_index（int）
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var inmune: float = 0.0
var altura: float = 0.0
var bill: float = 0.0
var cont: float = 0.0
var mybullet = null
var imdead = null


# from objects/obj_parcarry/Create_0.gml
func _create() -> void:
	instance_destroy()  # ORIG-BUG: 见文件头；Destroy 事件此时立即执行，held/cloud 尚未赋值（UNSURE: 原版读未赋值变量会报错，这里 held 是 null，比较结果为 false）
	if G.bg_level == "snow":
		sprite_index = A.spr_SMB_spike_ball
		image_index = 2.0
	elif (G.bg_level == "castle") or ((G.bg_level == "underground") or ((G.bg_level == "ghost") or (G.modo_noche == 1.0))):
		# UNSURE: spr_SMB2_veggies_night 在原工程里没有这个资源（a.gd 无此常量），原版会当成未赋值的实例变量读取（报错）。用 asset_get_index 取，取不到得 -1
		sprite_index = GM.asset_get_index("spr_SMB2_veggies_night")
		image_index = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
	else:
		image_index = GM.choose(0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
	image_speed = 0.0
	held = 1.0
	snowball = 0.0
	enemy = 0.0
	hold = 0.0
	cloud = 0.0
	obj = 25.0  # UNSURE: 25 是 GMS 运行时的 object 编号（原版 __objectNames[25] = obj_fallow_view），和 A. 的编号不同；照抄数值
	sprite = 3579.0  # UNSURE: 3579 是 GMS 运行时的 sprite 编号，和 A. 的编号不同；照抄数值
	swimming = 0.0
	ready_v = 0.0
	inmune = 1.0
	direct = 1.0
	altura = (sprite_width / 2.0)
	bill = 0.0
	cont = 0.0
	alarm[10] = 1.0


# from objects/obj_parcarry/Destroy_0.gml
func _destroy() -> void:
	if (held == 1.0) or (cloud == 1.0):
		var i_mario = GM.instance_find(A.obj_mario, 0)
		if GM.instance_exists(A.obj_mario) and (i_mario.holding == 1.0):
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 0.0


# from objects/obj_parcarry/Step_0.gml
func _step() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if held > 0.5:
		if (not GM.keyboard_check(G.lanzar_agarrar)) and ready_v == 1.0 and cloud == 0.0:
			if GM.instance_exists(A.obj_mario):
				GM.audio_play_sound(A.snd_SMB2_throw, 0.0, false)
				ystart = y
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 0.0
					inst.event_user(7)
					inst.isduckhold = 0.0
				GM.other = _o
				vspeed = 0.1
				gravity = 0.2
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					hspeed = ((1.0 + absf((i_mario.hspeed - 0.3))) * GM.gm_sign(i_mario.direct))
				else:
					hspeed = ((3.0 + absf((i_mario.hspeed - 0.3))) * GM.gm_sign(i_mario.direct))
				held = 0.0
				GM.keyboard_key_release(G.lanzar_agarrar)
				inmune = 1.0
				alarm[0] = 2.0
	else:
		if hold == 0.0:
			if enemy == 1.0 and (obj == A.obj_banzaibill or obj == A.obj_bulletbill or obj == A.obj_bulletbull_red):
				if swimming == 1.0:
					image_angle -= (6.0 * GM.gm_sign(hspeed))
				else:
					image_angle -= (13.0 * GM.gm_sign(hspeed))
			elif swimming == 1.0:
				image_angle -= (3.0 * GM.gm_sign(hspeed))
			else:
				image_angle -= (6.0 * GM.gm_sign(hspeed))
		if enemy == 1.0 and inmune == 0.0:
			if obj == A.obj_bulletbill:
				bill = 1.0
				if swimming == 1.0:
					gravity = 0.1
					if vspeed > 0.4:
						vspeed = 0.4
				else:
					gravity = 0.2
					if vspeed > 4.0:
						vspeed = 4.0
				if y > (ystart + 24.0):
					for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_bulletbill)):
						inst.direct = self.direct
						inst.hspeed = inst.direct
					instance_destroy()
			elif obj == A.obj_bulletbull_red:
				bill = 1.0
				if swimming == 1.0:
					gravity = 0.1
					if vspeed > 0.4:
						vspeed = 0.4
				else:
					gravity = 0.2
					if vspeed > 4.0:
						vspeed = 4.0
				if y > (ystart + 24.0):
					mybullet = GM.instance_create(x, (y - 8.0), A.obj_bulletbull_red)
					for inst in GM.with_list(mybullet):
						inst.direct = self.direct
						inst.hspeed = inst.direct
						if inst.direct < 0.0:
							inst.image_index = 1.0
						else:
							inst.image_index = 0.0
					instance_destroy()
			elif obj == A.obj_cannonball:
				bill = 1.0
				if swimming == 1.0:
					gravity = 0.1
					if vspeed > 0.4:
						vspeed = 0.4
				else:
					gravity = 0.2
					if vspeed > 4.0:
						vspeed = 4.0
				if y > (ystart + 24.0):
					mybullet = GM.instance_create(x, y, A.obj_cannonball)
					for inst in GM.with_list(mybullet):
						inst.hspeed = self.direct
					instance_destroy()
			elif obj == A.obj_cannonball_red:
				bill = 1.0
				if swimming == 1.0:
					gravity = 0.1
					if vspeed > 0.4:
						vspeed = 0.4
				else:
					gravity = 0.2
					if vspeed > 4.0:
						vspeed = 4.0
				if y > (ystart + 24.0):
					mybullet = GM.instance_create(x, y, A.obj_cannonball_red)
					for inst in GM.with_list(mybullet):
						inst.hspeed = (2.0 * self.direct)
					instance_destroy()
			elif obj == A.obj_banzaibill:
				bill = 1.0
				if swimming == 1.0:
					gravity = 0.1
					if vspeed > 0.4:
						vspeed = 0.4
				else:
					gravity = 0.2
					if vspeed > 4.0:
						vspeed = 4.0
				if y > (ystart + 74.0):
					for inst in GM.with_list(GM.instance_create(x, y, A.obj_banzaibill)):
						if self.direct == 1.0:
							inst.direct = -1.0
							inst.rotacion = 180.0
							inst.direct_t = 3.0
						else:
							inst.direct = 1.0
							inst.rotacion = 0.0
							inst.direct_t = 1.0
					instance_destroy()
			else:
				_user_3()
				_user_4()
				if cont == 0.0 and gravity == 0.0:
					cont = 1.0
				if cont > 0.0:
					if cont > 8.0:
						_user_5()
					else:
						cont += 0.6
		elif swimming == 1.0:
			gravity = 0.1
			if vspeed > 0.4:
				vspeed = 0.4
		else:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0


# from objects/obj_parcarry/Step_2.gml
func _step_end() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if held > 0.5:
		if GM.instance_exists(A.obj_mario):
			if ready_v == 0.0:
				if cloud == 0.0:
					if ((G.powerup == 0.0) and (y <= ((i_mario.y - altura) + 20.0))) or ((G.powerup != 0.0) and (y <= ((i_mario.y - altura) + 16.0))):
						y = i_mario.y
						ready_v = 1.0
					else:
						y -= 2.0
					x = i_mario.x
					direct = i_mario.direct
				else:
					if y <= (ystart - 16.0):
						y = (ystart - 16.0)
					else:
						y -= 2.0
					x = xstart
			else:
				if (G.bg_level == "underwater") or (((G.bg_level == "castle") and (G.modo_noche == 1.0)) or (GM.instance_exists(A.obj_lava_water) and ((y >= (i_lava_water.y + 16.0)) and ((G.bg_level == "forest") and (G.modo_noche == 0.0))))):
					for inst in GM.with_list(A.obj_mario):
						inst.vspeed = -1.0
					if GM.keyboard_check(G.abajo) and (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bumper, true, false) == null):
						for inst in GM.with_list(A.obj_mario):
							inst.vspeed = 0.5
						if vspeed > 0.5:
							vspeed = 0.5
				for inst in GM.with_list(A.obj_mario):
					inst.holding = 1.0
				visible = true
				direct = i_mario.direct
				x = i_mario.x
				if G.jugador == 1.0:
					if i_mario.isduck == 1.0:
						if G.powerup == 0.0:
							y = ((i_mario.y - altura) + 18.0)
						else:
							y = ((i_mario.y - altura) + 14.0)
					elif G.powerup == 0.0:
						y = ((i_mario.y - altura) + 14.0)
					else:
						y = ((i_mario.y - altura) + 6.0)
				elif i_mario.isduck == 1.0:
					if G.powerup == 0.0:
						y = ((i_mario.y - altura) + 20.0)
					else:
						y = ((i_mario.y - altura) + 16.0)
				elif G.powerup == 0.0:
					y = ((i_mario.y - altura) + 16.0)
				else:
					y = ((i_mario.y - altura) + 8.0)


# from objects/obj_parcarry/Alarm_0.gml
func _alarm_0() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if enemy == 1.0:
		if obj == A.obj_snow_ball_held:
			for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_snow_ball_held)):
				inst.alarm[0] = 5.0
				inst.fisica = 1.0
				inst.hspeed = self.hspeed
				inst.vspeed = self.vspeed
			instance_destroy()
		elif obj == A.obj_koopa or obj == A.obj_shell_held:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_shell_held)):
				inst.vspeed = 0.1
				inst.sprite_index = self.sprite_index
				if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and inst.y > (i_lava_water.y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
					inst.prevhspeed = (2.5 * GM.gm_sign(i_mario.direct))
					inst.hspeed = (2.5 * GM.gm_sign(i_mario.direct))
				else:
					inst.prevhspeed = ((2.6 + absf(i_mario.hspeed)) * GM.gm_sign(i_mario.direct))
					inst.hspeed = ((2.6 + absf(i_mario.hspeed)) * GM.gm_sign(i_mario.direct))
				inst.inmune = 1.0
				inst.alarm[2] = 15.0
			instance_destroy()
		inmune = 0.0
	elif hold == 1.0:
		if obj == A.obj_block_pow_hold:
			for inst in GM.with_list(GM.instance_create((x - 8.0), (y - 8.0), A.obj_block_pow_hold)):
				inst.hspeed = self.hspeed
				inst.vspeed = self.vspeed
				inst.explode = 1.0
				inst.inmune = 1.0
				inst.alarm[1] = 15.0
			instance_destroy()
	elif snowball == 1.0:
		for inst in GM.with_list(GM.instance_create(x, (y - 8.0), A.obj_snow_ball_held)):
			inst.alarm[0] = 5.0
			inst.fisica = 1.0
			inst.hspeed = self.hspeed
			inst.vspeed = self.vspeed
		instance_destroy()
	else:
		inmune = 0.0


# from objects/obj_parcarry/Alarm_10.gml
func _alarm_10() -> void:
	if enemy == 1.0:
		if obj == A.obj_snow_ball_held:
			sprite_index = A.spr_SMB_spike_ball
			image_index = 2.0
		elif obj == A.obj_banzaibill:
			sprite_index = A.spr_SMB_banzaibill
		elif obj == A.obj_galoomba:
			sprite_index = A.spr_SMB_goomba_deads
		elif obj == A.obj_galoomba_b:
			sprite_index = A.spr_SMB_goomba_b_deads
		elif obj == A.obj_galoomba2:
			sprite_index = A.spr_SMB_goomba2_deads
		elif obj == A.obj_bobomb:
			sprite_index = A.spr_SMB_bobomb_deads
		elif obj == A.obj_bulletbill:
			sprite_index = A.spr_SMB_bulletbill_deads
		elif obj == A.obj_bulletbull_red:
			sprite_index = A.spr_SMB_bulletbill_red
		elif obj == A.obj_koopa:
			sprite_index = A.spr_SMB_koopa_deads
		elif obj == A.obj_koopa_b:
			sprite_index = A.spr_SMB_koopa_b_deads
		elif obj == A.obj_koopa_red:
			sprite_index = A.spr_SMB_koopa_red_deads
		elif obj == A.obj_koopa_red_b:
			sprite_index = A.spr_SMB_koopa_red_b_deads
		elif obj == A.obj_piranhaplant:
			sprite_index = A.spr_SMB_pplant_deads
		elif obj == A.obj_buzzybeetle:
			sprite_index = A.spr_SMB_buzzybeetle_deads
		elif obj == A.obj_rocangrejo:
			sprite_index = A.spr_rocangrejo_deads_1
		else:
			sprite_index = int(sprite)  # PORT: sprite 可能是 float（Create 里的 3579.0），sprite_index 是 int
		if obj != A.obj_snow_ball_held and obj != A.obj_bulletbull_red:
			if G.bg_level == "castle" or G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		altura = (sprite_width / 2.0)
	elif hold == 1.0:
		if obj == A.obj_block_pow_hold:
			sprite_index = A.spr_SMB_pow
		else:
			sprite_index = int(sprite)  # PORT: 同上
		if G.bg_level == "castle" or G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
			image_index = 1.0
		else:
			image_index = 0.0
		altura = (sprite_width / 2.0)
	elif cloud == 1.0:
		sprite_index = A.spr_SMB_nube
		image_speed = 0.4
		image_index = 0.0
		visible = true


# from objects/obj_parcarry/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	if (ready_v == 1.0) and ((inmune == 0.0) and (bill == 0.0)):
		if (held == 0.0) and ((o.hardness < 99.0) and ((other.sprite_index != A.spr_beachkoopa) and (other.sprite_index != A.spr_beachkoopa_red))):
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o
			_user_0()
	elif (ready_v == 1.0) and ((inmune == 1.0) and (bill == 0.0)):
		if (held == 1.0) and (o.hardness < 99.0):
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o2: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o2
			_user_0()


# from objects/obj_parcarry/Other_7.gml
func _animation_end() -> void:
	if cloud == 1.0:
		instance_destroy()


# from objects/obj_parcarry/Other_10.gml
func _user_0() -> void:
	if held == 1.0:
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0
			inst.isduckhold = 0.0
	if (G.bg_level == "snow") and (snowball == 1.0):
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			# UNSURE: spr_SMB2_snow_ball_effect 在原工程里没有这个资源（a.gd 无此常量），原版会当成 obj_smoke 未赋值的实例变量读取（报错）。用 asset_get_index 取，取不到得 -1
			inst.sprite_index = GM.asset_get_index("spr_SMB2_snow_ball_effect")
			inst.image_speed = 0.25
	else:
		imdead = GM.instance_create(x, y, A.obj_enemy_dead)
		imdead.sprite_index = sprite_index
		imdead.image_index = image_index
		imdead.girar = 1.0
		imdead.direct = direct
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
	instance_destroy()


# from objects/obj_parcarry/Other_15.gml
func _user_5() -> void:
	if obj == A.obj_galoomba:
		GM.instance_create(x, (y - 8.0), A.obj_galoomba)
	elif obj == A.obj_galoomba2:
		GM.instance_create(x, (y - 8.0), A.obj_galoomba2)
	elif obj == A.obj_galoomba2:  # ORIG-BUG: 和上一个分支条件重复（死代码），照搬
		GM.instance_create(x, (y - 8.0), A.obj_galoomba2)
	elif (obj == A.obj_bobomb) or (obj == A.obj_bobomb_ready):
		GM.instance_create((x - 8.0), (y - 8.0), A.obj_explosion)
	else:
		GM.instance_create(x, (y - 8.0), int(obj))  # PORT: obj 可能是 float（Create 里的 25.0），instance_create 要 int
	instance_destroy()


# from objects/obj_parcarry/Draw_0.gml
func _gm_draw() -> void:
	if enemy == 1.0 and obj != A.obj_bulletbill and obj != A.obj_bulletbull_red and obj != A.obj_banzaibill:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), direct, -1.0, image_angle, GM.c_white, 1.0)
	elif enemy == 1.0 and obj == A.obj_banzaibill:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), (-direct), 1.0, image_angle, GM.c_white, 1.0)
	elif hold == 1.0:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), 1.0, 1.0, image_angle, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), direct, 1.0, image_angle, GM.c_white, 1.0)
