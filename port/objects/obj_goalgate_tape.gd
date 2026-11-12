# from objects/obj_goalgate_tape（第 7 批移植，已核对）
extends GMObject

var bonus: float = 0.0
var myscore = null
var bonus_a: float = 0.0  # PORT: 原版只在 Other_10 里赋值（没有 variable_instance_exists 查询），声明成 float
var bonus_b: float = 0.0


# from objects/obj_goalgate_tape/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	vspeed = 1.0
	bonus = 0.0


# from objects/obj_goalgate_tape/Step_0.gml
func _step() -> void:
	x = (GM.instance_find(A.obj_goalgate, 0).x + 8.0)
	if vspeed > 0.0 and y >= (GM.instance_find(A.obj_goalgate, 0).y + 121.0):
		vspeed = -1.0
	elif vspeed < 0.0 and y <= (GM.instance_find(A.obj_goalgate, 0).y + 8.0):
		vspeed = 1.0
	if G.condiciones == 0.0 or (G.condiciones == 1.0 and G.condiciones_clear == 1.0):
		sprite_index = A.spr_goal
	else:
		sprite_index = A.spr_goal_disabled


# from objects/obj_goalgate_tape/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	bonus = 1.0


# from objects/obj_goalgate_tape/Other_10.gml
func _user_0() -> void:
	var mario_y: float
	if not GM.audio_is_playing(A.bgm_smwclear):
		GM.audio_play_sound(A.bgm_smwclear, 0.0, false)
	for inst in GM.with_list(A.obj_goalgate):
		inst.alarm[1] = 560.0
	if GM.room != A.rm_editor:
		var _p = GM.instance_find(A.obj_persistent, 0)  # obj_persistent.modo_android（第一个实例）
		if _p.modo_android == 1.0 and G.controles_tactiles == 1.0:
			var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(A.obj_persistent):
				inst.event_user(4)
				inst.event_user(5)
			GM.other = _o
	if GM.instance_exists(A.obj_mario):
		if bonus == 1.0:
			myscore = GM.instance_create((x - 8.0), y, A.obj_score)
			for inst in GM.with_list(myscore):
				inst.visible = false
			mario_y = (GM.instance_find(A.obj_mario, 0).y + 16.0)
			if mario_y < (ystart + 5.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(7)
				GM.other = _o
				bonus_a = 2.0
				bonus_b = 5.0
			elif mario_y < (ystart + 41.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(11)
				GM.other = _o
				bonus_a = 4.0
				bonus_b = 0.0
			elif mario_y < (ystart + 65.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(11)
				GM.other = _o
				bonus_a = 4.0
				bonus_b = 0.0
			elif mario_y < (ystart + 89.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(10)
				GM.other = _o
				bonus_a = 2.0
				bonus_b = 5.0
			# ORIG-BUG: 前一个分支已是 mario_y < ystart + 89，这里写成 ystart - 113（大概想写 + 113），永远不成立。照搬
			elif mario_y < (ystart - 113.0):
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(9)
				GM.other = _o
				bonus_a = 1.0
				bonus_b = 0.0
			else:
				var _o: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(myscore):
					inst.event_user(8)
				GM.other = _o
				bonus_a = -1.0
				bonus_b = 5.0
			for inst in GM.with_list(A.obj_goalgate_front):
				inst.bonus = 1.0
				inst.bonus_a = self.bonus_a
				inst.bonus_b = self.bonus_b
				inst.alarm[0] = 210.0
				inst.alarm[1] = 1.0
		for inst in GM.with_list(A.obj_mario):
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_player_goal_smw)):
				inst2.vspeed = inst.vspeed
				inst2.direct = inst.direct
				inst2.swim = inst.isswim
				if GM.instance_exists(A.obj_helmet_spiny):
					inst2.helmet = 2.0
				elif GM.instance_exists(A.obj_helmet):
					inst2.helmet = 1.0
				inst2.sprite_index = inst.sprite_index
			inst.instance_destroy()
	for inst in GM.with_list(GM.instance_create((x + 16.0), (y - 16.0), A.obj_smoke)):
		inst.sprite_index = A.spr_smokethwomp
	instance_destroy()


# from objects/obj_goalgate_tape/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		if GM.instance_exists(A.obj_ground3):
			GM.draw_sprite_ext(sprite_index, -1.0, (GM.instance_find(A.obj_goalgate, 0).x + 8.0), (GM.instance_find(A.obj_goalgate, 0).y + 9.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, -1.0, (GM.instance_find(A.obj_goalgate, 0).x + 8.0), (y + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
