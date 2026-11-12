# from objects/obj_invincibility（第 5 批移植，已核对）
extends GMObject

var cp: float = 0.0
var cp_cont: float = 0.0
var flashAlpha: float = 0.0
var color: Array = []
var hitpoint: float = 0.0
var blend_star = null  # 只在 Step 里赋值；玩家侧读的是 obj_mario.blend_star，这个是 object 自己的


# from objects/obj_invincibility/Create_0.gml
func _create() -> void:
	cp = 0.0
	cp_cont = 0.0
	flashAlpha = 1.0
	if G.apariencia == 3.0:
		GM.aset(color, 0.0, GM.make_colour_rgb(255.0, 140.0, 199.0))
		GM.aset(color, 1.0, GM.make_colour_rgb(254.0, 252.0, 143.0))
		GM.aset(color, 2.0, GM.make_colour_rgb(102.0, 245.0, 157.0))
	else:
		GM.aset(color, 0.0, GM.make_colour_rgb(255.0, 255.0, 72.0))
		GM.aset(color, 1.0, GM.make_colour_rgb(254.0, 138.0, 139.0))
		GM.aset(color, 2.0, GM.make_colour_rgb(102.0, 245.0, 157.0))
	hitpoint = 0.0
	alarm[0] = 600.0
	alarm[3] = 5.0
	for inst in GM.with_list(A.obj_persistent):
		inst.alarm[6] = -1.0
		inst.alarm[6] = 420.0
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_sparkles
		image_speed = 0.3
	else:
		image_speed = 0.4
	if G.apariencia < 2.0:
		visible = false
	else:
		alarm[1] = 1.0
	alarm[2] = 4.0


# from objects/obj_invincibility/Step_0.gml
func _step() -> void:
	# /Invincibility logic
	var blend
	# PORT: 原文 default 分支里 if 的第一支末尾有 break，它是该 case 的最后一条语句的最后一支，
	# 等于直接结束 switch，所以翻成 match 时去掉（GDScript 的 match 里 break 会跳出外层循环）。
	match G.apariencia:
		3.0:
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
		_:
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
	# If Mario exists
	if GM.instance_exists(A.obj_mario):
		# Snap to position
		x = GM.instance_find(A.obj_mario, 0).x
		y = GM.instance_find(A.obj_mario, 0).y
		# Set depth
		depth = -6.0
		# Make sure Mario is fully invincible
		for inst in GM.with_list(A.obj_mario):
			inst.invincible = -1.0
	# Be invisible if neither exists
	else:
		visible = false
		return
	# Otherwise, be visible
	visible = true


# from objects/obj_invincibility/Alarm_0.gml
func _alarm_0() -> void:
	GM.audio_stop_sound(Scr.scr_snd_starman(self))
	for inst in GM.with_list(A.obj_levelmanager):
		inst.alarm[0] = 1.0
	# Give Mario temporary invincibility + disable flashing effects
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_mario):
		inst.isflashing = 0.0
		inst.invincible = 1.0
		inst.event_user(6)
	GM.other = _o
	# Destroy
	instance_destroy()


# from objects/obj_invincibility/Alarm_1.gml
func _alarm_1() -> void:
	if visible == true:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_sparkletrail)):
			inst.depth = -5.0
	alarm[1] = 10.0


# from objects/obj_invincibility/Alarm_2.gml
func _alarm_2() -> void:
	# /Handle Mario's invincibility flashing
	# Make Mario flash
	for inst in GM.with_list(A.obj_mario):
		if inst.isflashing == 0.0:
			inst.isflashing = 1.0
		else:
			inst.isflashing = 0.0
	# Keep flashing
	alarm[2] = 4.0


# from objects/obj_invincibility/Alarm_3.gml
func _alarm_3() -> void:
	var blend
	if cp < 2.0:
		cp += 1.0
	else:
		cp = 0.0
	blend = color[int(cp)]
	if GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).visible == true:
			for inst in GM.with_list(A.obj_mario):
				inst.blend_star = blend
		alarm[3] = 5.0
	else:
		return


# from objects/obj_invincibility/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_invincibility/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if G.apariencia > 1.0 and (other.object_index == A.obj_egg or other.object_index == A.obj_egg_red):
		return
	if other.object_index != A.obj_grinder and other.object_index != A.obj_crumblebones:
		Scr.scr_musicalscale(self, self, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.hitpoints = 0.0
			inst.event_user(0)
		GM.other = _o


# from objects/obj_invincibility/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	GM.audio_stop_sound(Scr.scr_snd_kick(self))
	GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_invincibility/Other_5.gml
func _room_end() -> void:
	pass  # 原文件为空
