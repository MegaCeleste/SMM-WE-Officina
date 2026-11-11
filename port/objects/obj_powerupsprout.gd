extends GMObject

var bounce: float = 0.0
var downwards: float = 0.0
var s_sprout: float = 0.0
var type: float = 0.0
var wings: float = 0.0
var swimming: float = 0.0


# from objects/obj_powerupsprout/Create_0.gml
func _create() -> void:
	bounce = 0.0
	image_speed = 0.0
	downwards = 0.0
	s_sprout = -1.0
	type = 0.0
	wings = 0.0
	swimming = 0.0
	alarm[0] = 1.0


# from objects/obj_powerupsprout/Alarm_0.gml
func _alarm_0() -> void:
	match s_sprout:
		1.0:
			type = 0.0
		2.0:
			type = 0.0
		-50.0:
			type = 0.0
		-78.0:
			type = 0.0
		-85.0:
			type = 0.0
		-46.0:
			type = 0.0
		-44.0:
			type = 0.0
		-43.0:
			type = 0.0
		-29.0:
			type = 0.0
		-38.0:
			type = 0.0
		-18.0:
			type = 0.0
			if G.modo_noche == 1.0 and G.bg_level == "ground":
				image_index = G.apariencia
			else:
				image_index = 1.0
		-80.0:
			type = 0.0
		-77.0:
			type = 0.0
		-21.0:
			type = 0.0
		_:
			type = 1.0
	if sprite_index == A.spr_SMB_link:
		GM.audio_play_sound(A.snd_SMB_link_itemappear, 0.0, false)
	elif sprite_index == A.spr_SMB_superflower:
		GM.audio_play_sound(A.snd_SMB_sprout_superflower, 0.0, false)
	else:
		GM.audio_play_sound(Scr.scr_snd_sprout(self), 0.0, false)
	if type == 0.0:
		visible = true
		if downwards == 1.0:
			vspeed = 0.5
		else:
			vspeed = -0.5
		alarm[1] = 32.0
	else:
		alarm[2] = 1.0


# from objects/obj_powerupsprout/Alarm_1.gml
func _alarm_1() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	if place_meeting(x, y, A.obj_solid) or place_meeting(x, y, A.obj_physicssolid) or place_meeting(x, y, A.obj_bullebill_base):
		GM.instance_create((x + 8.0), (y + 8.0), A.obj_detroy_enemy)
		instance_destroy()
	else:
		for inst in GM.with_list(Scr.scr_constant_make_object(self, x, y, s_sprout)):
			if GM.variable_instance_exists(inst, "wings") and wings == 1.0:
				inst.wings = 1.0
			if GM.variable_instance_exists(inst, "direct"):
				inst.direct = 1.0
		instance_destroy()


# from objects/obj_powerupsprout/Alarm_2.gml
func _alarm_2() -> void:
	var posy  # 局部变量提升（GML 的 var 是函数作用域）
	var spd  # 局部变量提升（GML 的 var 是函数作用域）
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
		swimming = 1.0
	var posx = GM.sprite_get_xoffset(sprite_index)
	if s_sprout == -66.0:
		posx = 0.0
	elif posx != 0.0:
		posx = 8.0
	elif type == 0.0:
		posx = 0.0
	if s_sprout == -67.0 or s_sprout == -68.0 or (wings == 1.0 and (s_sprout == -34.0 or s_sprout == -33.0)):
		spd = (0.3 - (0.2 * swimming))
	else:
		spd = (2.0 - (1.0 * swimming))
	if downwards == 0.0:
		posy = (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index))
		if position_meeting((x + posx), (y - posy), A.obj_solid) or position_meeting((x + posx), (y - posy), A.obj_physicssolid) or position_meeting((x + posx), (y - posy), A.obj_bullebill_base):
			GM.instance_create((x + 8.0), (y - 8.0), A.obj_detroy_enemy)
			instance_destroy()
		else:
			if s_sprout == -28.0:
				GM.instance_create(x, ystart, A.obj_beanstalk)
			else:
				for inst in GM.with_list(Scr.scr_constant_make_object(self, (x + posx), (y - posy), s_sprout)):
					if GM.variable_instance_exists(self, "wings") and wings == 1.0:
						inst.wings = 1.0
					if GM.variable_instance_exists(inst, "direct"):
						inst.direct = 1.0
					inst.vspeed = (-spd)
			instance_destroy()
	else:
		posy = (GM.sprite_get_yoffset(sprite_index) - GM.sprite_get_bbox_top(sprite_index))
		if position_meeting((x + posx), ((y + 16.0) + posy), A.obj_solid) or position_meeting((x + posx), ((y + 16.0) + posy), A.obj_physicssolid) or position_meeting((x + posx), ((y + 16.0) + posy), A.obj_bullebill_base):
			GM.instance_create((x + 8.0), (y + 24.0), A.obj_detroy_enemy)
			instance_destroy()
		else:
			if s_sprout == -28.0:
				for inst in GM.with_list(GM.instance_create(x, ystart, A.obj_beanstalk)):
					inst.set("downwards", 1.0)
			else:
				for inst in GM.with_list(Scr.scr_constant_make_object(self, (x + posx), ((y + 16.0) + posy), s_sprout)):
					if GM.variable_instance_exists(self, "wings") and wings == 1.0:
						inst.wings = 1.0
					if GM.variable_instance_exists(inst, "direct"):
						inst.direct = 1.0
			instance_destroy()
