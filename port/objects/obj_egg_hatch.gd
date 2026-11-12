# from objects/obj_egg_hatch（第 5 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"

var colour: float = 0.0
var color: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_egg_hatch/Create_0.gml
func _create() -> void:
	if G.apariencia != 2.0:
		instance_destroy()
		return
	GM.audio_stop_sound(A.snd_yoshi)
	GM.audio_play_sound(A.snd_yoshi, 0.0, false)
	colour = 0.0
	color = 0.0
	ready_v = 0.0
	direct = 1.0
	alarm[0] = 1.0


# from objects/obj_egg_hatch/Step_0.gml
func _step() -> void:
	super._step()


# from objects/obj_egg_hatch/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia == 3.0:
		image_speed = 0.7
	else:
		image_speed = 0.15
	ready_v = 1.0
	visible = true


# from objects/obj_egg_hatch/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var o = other  # 自定义变量经不带类型的局部变量访问
	var yosh  # 局部变量提升（GML 的 var 是函数作用域）；UNSURE: color 不是 0/1/2 时原版 yosh 未赋值（报错），这里是 null
	if o.state == 2.0 and o.holding == 0.0 and other.vspeed > 0.0 and other.visible == true and G.powerup != -82.0 and other.bbox_bottom < ((bbox_top - vspeed) + 5.0):
		for inst in GM.with_list(A.obj_mario):
			inst.x = (self.x - 1.0)
			inst.y = self.y
			inst.direct = self.direct
			inst.holding = 3.0
		if color == 0.0:
			yosh = A.obj_yoshi2
		elif color == 1.0:
			yosh = A.obj_yoshi_red
		elif color == 2.0:
			yosh = A.obj_yoshi_blue
		GM.instance_create((x - 1.0), (y + 16.0), yosh)
		GM.audio_stop_sound(A.snd_yoshi)
		GM.audio_play_sound(A.snd_yoshi, 0.0, false)
		instance_destroy()


# from objects/obj_egg_hatch/Other_7.gml
func _animation_end() -> void:
	if ready_v == 1.0:
		if G.apariencia == 3.0:
			if color == 0.0:
				return
		elif color == 0.0:
			for inst in GM.with_list(GM.instance_create((x - 1.0), (y + 16.0), A.obj_yoshi_abandon)):
				inst.vspeed = -1.5
		elif color == 1.0:
			for inst in GM.with_list(GM.instance_create((x - 1.0), (y + 16.0), A.obj_yoshi_abandon)):
				inst.color = 1.0
				inst.sprite_index = A.spr_yoshi_wait_red
				inst.vspeed = -1.5
		elif color == 2.0:
			for inst in GM.with_list(GM.instance_create((x - 1.0), (y + 16.0), A.obj_yoshi_abandon)):
				inst.color = 2.0
				inst.sprite_index = A.spr_yoshi_wait_blue
		instance_destroy()


# from objects/obj_egg_hatch/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, -1.0, GM.gm_round(x), (y + 1.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
