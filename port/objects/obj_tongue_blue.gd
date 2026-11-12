# 第 7 批移植，已核对。
extends GMObject

var hunger: float = 0.0
var foodsprite = null  # sprite 编号（int）；noone 用 null（同 obj_yoshi2.mouthsprite 的写法）
var foodindex: float = 0.0
var foodoffset: float = 0.0
var direct_sprite = null  # PORT: 会被赋 other.direct（多数 object 的 direct 不带类型），不带类型
var powerup = null  # object 编号；noone 用 null（同 obj_yoshi2.powerup）
var berry = null  # 同 powerup
var ready_v: float = 0.0  # PORT: 原名 ready（和 Node.ready 撞名）
var t2: float = 0.0
var t3: float = 0.0
var t4: float = 0.0
var t5: float = 0.0
var tongue1x: float = 0.0  # PORT: 原版只在 Step_2 赋值，没人用 variable_instance_exists 查，声明成 float
var tongue2x: float = 0.0
var tongue3x: float = 0.0
var tongue4x: float = 0.0


# from objects/obj_tongue_blue/Create_0.gml
func _create() -> void:
	hunger = 0.0
	foodsprite = null
	foodindex = 0.0
	foodoffset = 0.0
	direct_sprite = 1.0
	powerup = null
	berry = null
	ready_v = 0.0
	t2 = 0.0
	t3 = 0.0
	t4 = 0.0
	t5 = 0.0


# from objects/obj_tongue_blue/Step_2.gml
func _step_end() -> void:
	var y2 = GM.instance_find(A.obj_yoshi_blue, 0)  # PORT: obj_yoshi_blue.xxx 读取 → 第一个实例（第 16 条），先取到不带类型的局部变量
	if GM.instance_exists(A.obj_mario) and GM.instance_exists(A.obj_yoshi_blue):
		if y2.sprite_index == A.spr_yoshi_lick:
			tongue1x = ((y2.x - 3.0) + (19.0 * y2.direct))
			tongue2x = ((t2 * y2.direct) + tongue1x)
			tongue3x = ((t3 * y2.direct) + tongue1x)
			tongue4x = ((t4 * y2.direct) + tongue1x)
		else:
			tongue1x = ((y2.x - 3.0) + (13.0 * y2.direct))
			tongue2x = ((t2 * y2.direct) + tongue1x)
			tongue3x = ((t3 * y2.direct) + tongue1x)
			tongue4x = ((t4 * y2.direct) + tongue1x)
		x = GM.gm_round(((t5 * y2.direct) + tongue1x))
		if y2.locked == 2.0:
			y = (y2.y + 4.0)
		else:
			y = (y2.y - 7.0)
		if ready_v == 0.0:
			if t2 != 8.0:
				t2 += 4.0
			if t3 != 16.0:
				t3 += 4.0
			if t4 != 24.0:
				t4 += 4.0
			if t5 != 32.0:
				t5 += 4.0
			elif ready_v != 1.0:
				ready_v = 1.0
				alarm[0] = 8.0
		elif ready_v == 2.0:
			if t2 != 0.0:
				t2 -= 4.0
			if t3 != 0.0:
				t3 -= 4.0
			if t4 != 0.0:
				t4 -= 4.0
			if t5 != 0.0:
				t5 -= 4.0
			else:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.alarm[1] = 5.0
				if hunger > 0.5:
					if powerup != null:
						GM.audio_play_sound(A.snd_yoshi_eat, 0.0, false)
						for inst in GM.with_list(A.obj_yoshi_blue):
							inst.powerup = powerup
						powerup = null
					elif berry != null:
						GM.audio_play_sound(A.snd_yoshi_eat, 0.0, false)
						for inst in GM.with_list(A.obj_yoshi_blue):
							inst.berry = berry
						berry = null
					elif y2.mouthholder == null:
						GM.audio_play_sound(A.snd_yoshi_eat, 0.0, false)
						GM.audio_play_sound(A.snd_coin, 0.0, false)
						G.coins += 1.0
				instance_destroy()
	else:
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.licking = 0.0
			inst.locked = 0.0
		instance_destroy()


# from objects/obj_tongue_blue/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 2.0


# from objects/obj_tongue_blue/Collision_obj_bone.gml
func _collision_obj_bone(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = A.obj_bones_yoshi_one
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_bowser_fire.gml
func _collision_obj_bowser_fire(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = A.obj_yoshifire_one
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		foodindex = other.image_index
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_bowser_fire_down.gml
func _collision_obj_bowser_fire_down(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = A.obj_yoshifire_one
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_brohammer.gml
func _collision_obj_brohammer(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = A.obj_brohammer_yoshi
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_coin10.gml
func _collision_obj_coin10(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		foodsprite = other.sprite_index
		foodoffset = 8.0
		GM.audio_stop_sound(A.snd_coin10)
		GM.audio_play_sound(A.snd_coin10, 0.0, false)
		if other.object_index == A.obj_coin50:
			G.coins += 50.0
		elif other.object_index == A.obj_coin30:
			G.coins += 30.0
		else:
			G.coins += 10.0
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		GM.other = _o
		if G.apariencia != 0.0:
			GM.instance_create((other.x + 8.0), other.y, A.obj_sparkles_coin)
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	if hunger == 0.0 and ready_v == 0.0 and other.object_index != A.obj_thwomp and other.object_index != A.obj_grinder and other.object_index != A.obj_banzaibill and other.object_index != A.obj_bowserjr_shell and other.object_index != A.obj_grrrol:
		if o.edible == 2.0:
			ready_v = 1.0
			alarm[0] = 8.0
		else:
			hunger = 1.0
			ready_v = 1.0
			alarm[0] = 8.0
			# ORIG-BUG: 上面刚把 hunger 设成 1，这个 if (!hunger) 永远不成立，块内是死代码，照搬
			if hunger <= 0.5:  # GML: !hunger
				hunger = 1.0
				ready_v = 1.0
				alarm[0] = 8.0
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_yoshifire_one
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = other.sprite_index
				foodsprite = other.sprite_index
				foodindex = other.image_index
				foodoffset = 0.0
				for inst in GM.with_list(other):
					inst.instance_destroy()
			if (other.object_index == A.obj_cheepcheep or other.object_index == A.obj_cheepcheep2) and o.lava == 1.0 and G.bg_level == "castle":
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_yoshifire
			elif (other.object_index == A.obj_cheepcheep or other.object_index == A.obj_cheepcheep2) and o.lava == 1.0 and G.bg_level == "forest":
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_yoshifire_purple
			elif other.object_index == A.obj_drybones:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_bones_yoshi
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = other.sprite_index
			elif other.object_index == A.obj_shell_held:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_shell
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = other.sprite_index
			elif other.object_index == A.obj_koopa:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_shell
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = A.spr_shell
			elif other.object_index == A.obj_koopa_red:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_shell
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = A.spr_shell_red
			elif other.object_index == A.obj_spiny or other.object_index == A.obj_spiny_ball:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_shell
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = A.spr_spiny_dead
			elif other.object_index == A.obj_buzzybeetle:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_shell
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = A.spr_shell_buzzy
			elif other.object_index == A.obj_snow_ball_held:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_snow_ball
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = other.sprite_index
			elif other.object_index == A.obj_podoboo or other.object_index == A.obj_podoboo_b:
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthholder = A.obj_yoshifire
				for inst in GM.with_list(A.obj_yoshi_blue):
					inst.mouthsprite = other.sprite_index
			if other.object_index == A.obj_snow_ball_held:
				foodsprite = A.spr_snow_ball
			else:
				foodsprite = other.sprite_index
			direct_sprite = o.direct
			foodindex = other.image_index
			for inst in GM.with_list(other):
				self.foodoffset = (((inst.bbox_left + inst.bbox_right) / 2.0) - inst.x)
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_holdparent.gml
func _collision_obj_holdparent(other: GMObject) -> void:
	var o = other
	if other.object_index != A.obj_helmet and other.object_index != A.obj_helmet_spiny and other.object_index != A.obj_cap_mario:
		if other.object_index == A.obj_bobomb_hold or other.object_index == A.obj_galoomba_hold or other.object_index == A.obj_galoomba_hold2:
			if hunger == 0.0 and ready_v == 0.0:
				hunger = 1.0
				ready_v = 1.0
				alarm[0] = 8.0
				foodsprite = other.sprite_index
				direct_sprite = o.direct
				foodindex = other.image_index
				for inst in GM.with_list(other):
					self.foodoffset = (((inst.bbox_left + inst.bbox_right) / 2.0) - inst.x)
				for inst in GM.with_list(other):
					inst.instance_destroy()
		elif hunger <= 0.5:  # GML: !hunger
			hunger = 1.0
			ready_v = 1.0
			alarm[0] = 8.0
			for inst in GM.with_list(A.obj_yoshi_blue):
				inst.mouthholder = other.object_index
			for inst in GM.with_list(A.obj_yoshi_blue):
				inst.mouthsprite = other.sprite_index
			if other.object_index == A.obj_snow_ball:
				foodsprite = A.spr_snow_ball
			else:
				foodsprite = other.sprite_index
			foodoffset = 0.0
			for inst in GM.with_list(other):
				inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_plantfire.gml
func _collision_obj_plantfire(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = A.obj_yoshifire_one
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = other.object_index
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		if other.sprite_index == A.spr_rotten_b:
			foodindex = G.apariencia
		else:
			foodindex = other.image_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_pswitch.gml
func _collision_obj_pswitch(other: GMObject) -> void:
	if (hunger <= 0.5) and image_index == 0.0:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = other.object_index
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_spike_ball.gml
func _collision_obj_spike_ball(other: GMObject) -> void:
	if hunger == 0.0 and ready_v == 0.0:
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = other.object_index
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		direct_sprite = 1.0
		foodindex = other.image_index
		for inst in GM.with_list(other):
			self.foodoffset = (((inst.bbox_left + inst.bbox_right) / 2.0) - inst.x)
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Collision_obj_spring_land.gml
func _collision_obj_spring_land(other: GMObject) -> void:
	if hunger <= 0.5:  # GML: !hunger
		hunger = 1.0
		ready_v = 1.0
		alarm[0] = 8.0
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthholder = other.object_index
		for inst in GM.with_list(A.obj_yoshi_blue):
			inst.mouthsprite = other.sprite_index
		foodsprite = other.sprite_index
		foodoffset = 0.0
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_tongue_blue/Draw_0.gml
func _gm_draw() -> void:
	var y2 = GM.instance_find(A.obj_yoshi_blue, 0)  # PORT: 同 Step_2
	if hunger > 0.5:
		GM.draw_sprite_ext(foodsprite, foodindex, (((x + 3.0) + (3.0 * y2.direct)) - foodoffset), (y - 4.0), direct_sprite, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_tongue, 1.0, ((tongue1x + 3.0) - (3.0 * y2.direct)), y, y2.direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_tongue, 1.0, ((tongue2x + 3.0) - (3.0 * y2.direct)), y, y2.direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_tongue, 1.0, ((tongue3x + 3.0) - (3.0 * y2.direct)), y, y2.direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_tongue, 1.0, ((tongue4x + 3.0) - (3.0 * y2.direct)), y, y2.direct, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_tongue, 0.0, ((x + 3.0) - (3.0 * y2.direct)), y, y2.direct, 1.0, 0.0, GM.c_white, 1.0)
