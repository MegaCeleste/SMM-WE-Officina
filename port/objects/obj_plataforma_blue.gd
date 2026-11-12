extends "res://objects/obj_platform_parent.gd"

var sprite: int = 0  ## sprite 编号
var sprite_wings: int = 0  ## sprite 编号
var index: float = 0.0
var size_x: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var wings: float = 0.0
var anim: float = 0.0
var timer: float = 0.0
var h: float = 0.0


# from objects/obj_plataforma_blue/Create_0.gml
func _create() -> void:
	sprite = A.spr_platform_blue
	match G.apariencia:
		0.0:
			sprite_wings = A.spr_SMB_wings
		1.0:
			sprite_wings = A.spr_SMB3_wings
		2.0:
			sprite_wings = A.spr_wings
		3.0:
			sprite_wings = A.spr_NSMBU_wings
	index = 0.0
	size_x = 4.0
	image_speed = 0.0
	ready_v = 0.0
	wings = 0.0
	anim = 0.0
	timer = 0.0
	alarm[0] = 1.0


# from objects/obj_plataforma_blue/Step_0.gml
func _step() -> void:
	if wings == 1.0:
		if not GM.instance_exists(A.obj_deadmario):
			if G.apariencia == 3.0:
				anim += 0.5
			else:
				anim += 0.15
		if ready_v == 0.0:
			y = (ystart + (sin((timer * 0.04375)) * 4.0))
			timer += 1.0
		elif vspeed > 1.0:
			vspeed = 1.0
	elif vspeed > 2.0:
		vspeed = 2.0
	if Scr.outside_view(self) > 0.5 and y > (GM.room_height + 64.0) and ready_v == 1.0:
		ready_v = 2.0
		vspeed = 0.0
		gravity = 0.0
		visible = false
		alarm[2] = 180.0
	if GM.instance_exists(A.obj_mario):
		var mario = GM.instance_find(A.obj_mario, 0)
		if collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top + 2.0), A.obj_mario, false, false) != null and mario.y < (y - 28.0) and mario.state < 2.0:
			if ready_v == 0.0:
				ready_v = 1.0
				alarm[1] = 15.0


# from objects/obj_plataforma_blue/Alarm_0.gml
func _alarm_0() -> void:
	if wings == 1.0:
		vspeed = 0.2


# from objects/obj_plataforma_blue/Alarm_1.gml
func _alarm_1() -> void:
	gravity = 0.06


# from objects/obj_plataforma_blue/Alarm_2.gml
func _alarm_2() -> void:
	for inst in GM.with_list(GM.instance_create(xstart, ystart, A.obj_plataforma_blue)):
		inst.sprite = self.sprite
		inst.size_x = self.size_x
		inst.image_xscale = self.size_x
		inst.wings = self.wings
	instance_destroy()


# from objects/obj_plataforma_blue/Draw_0.gml
func _gm_draw() -> void:
	if wings == 1.0:
		GM.draw_sprite_ext(sprite_wings, anim, (x - 8.0), (y - 20.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(sprite_wings, anim, ((x + (size_x * 16.0)) + 8.0), (y - 20.0), -1.0, 1.0, 0.0, GM.c_white, 1.0)
	h = 0.0
	while h < size_x:
		if h == 0.0:
			index = 0.0
		elif h == (size_x - 1.0):
			index = 2.0
		else:
			index = 1.0
		GM.draw_sprite(sprite, index, (x + (h * 16.0)), y)
		h += 1.0
