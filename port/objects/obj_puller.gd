# 第 4 批移植，已核对。
extends GMObject

var snowball: float = 0.0
var enemy = null
var held = null
var cloud: float = 0.0
var obj = null  # 创建时是 object 编号，obj_mario 之后会写成实例（nube.id 等）


# from objects/obj_puller/Create_0.gml
func _create() -> void:
	sprite_index = Scr.scr_mario_pull(self)
	image_speed = 0.15
	alarm[0] = 30.0
	alarm[1] = 20.0
	snowball = 0.0
	enemy = 0.0
	held = 0.0
	cloud = 0.0
	obj = A.obj_galoomba
	for inst in GM.with_list(A.obj_mario):
		inst.hspeed = 0.0
		inst.vspeed = 0.0
		inst.jumpnow = 0.0
		inst.holding = 1.0
		inst.disablecontrol = 1.0


# from objects/obj_puller/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_mario):
		inst.visible = true
		if inst.image_alpha != 1.0:
			inst.image_alpha = 1.0
		inst.disablecontrol = 0.0


# from objects/obj_puller/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		for inst in GM.with_list(A.obj_mario):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.jumpnow = 0.0
			inst.disablecontrol = 1.0
		for inst in GM.with_list(A.obj_mario):
			inst.visible = false
		var i_mario = GM.instance_find(A.obj_mario, 0)
		x = GM.gm_round(i_mario.x)
		y = GM.gm_round(i_mario.y)


# from objects/obj_puller/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(A.obj_mario):
		inst.visible = true
		inst.disablecontrol = 0.0
	instance_destroy()


# from objects/obj_puller/Alarm_1.gml
func _alarm_1() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario):
		if cloud == 1.0:
			if GM.instance_exists(obj):
				for inst in GM.with_list(GM.instance_create((i_mario.x - 8.0), (i_mario.y + 32.0), A.obj_parcarry)):
					inst.cloud = 1.0
					inst.visible = false
				for inst in GM.with_list(obj):
					inst.instance_destroy()
		elif held == 1.0:
			if GM.instance_exists(obj):
				for inst in GM.with_list(GM.instance_create(i_mario.x, (i_mario.y + 32.0), A.obj_parcarry)):
					inst.hold = self.held
					inst.obj = self.obj.object_index
					inst.sprite = self.obj.sprite_index
				for inst in GM.with_list(obj):
					inst.instance_destroy()
			else:
				_user_0()
		elif enemy == 1.0:
			if GM.instance_exists(obj):
				for inst in GM.with_list(GM.instance_create(i_mario.x, (i_mario.y + 32.0), A.obj_parcarry)):
					inst.enemy = self.enemy
					inst.obj = self.obj.object_index
					inst.sprite = self.obj.sprite_index
				for inst in GM.with_list(obj):
					inst.instance_destroy()
			else:
				_user_0()
		else:
			for inst in GM.with_list(GM.instance_create(i_mario.x, (i_mario.y + 32.0), A.obj_parcarry)):
				inst.snowball = self.snowball


# from objects/obj_puller/Other_10.gml
func _user_0() -> void:
	var i_mario = GM.instance_find(A.obj_mario, 0)
	if GM.instance_exists(A.obj_mario) and (i_mario.holding == 1.0):
		for inst in GM.with_list(A.obj_mario):
			inst.holding = 0.0


# from objects/obj_puller/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var i_mario = GM.instance_find(A.obj_mario, 0)
		GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), GM.gm_round(y), i_mario.direct, 1.0, 0.0, GM.c_white, i_mario.image_alpha)
