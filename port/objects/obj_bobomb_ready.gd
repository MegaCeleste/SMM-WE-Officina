extends "res://objects/obj_bobomb.gd"

var sonido_antibomb: int = 0  # 原版只在 apariencia == 3 时赋值，其余外观下不会读


# from objects/obj_bobomb_ready/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bobomb_ready
		1.0:
			sprite_index = A.spr_SMB3_bobomb_ready
		2.0:
			sprite_index = A.spr_bobomb_ready
		3.0:
			sprite_index = A.spr_NSMBU_bobomb_ready
	if G.apariencia == 3.0:
		if Scr.outside_view(self) <= 0.5:
			sonido_antibomb = GM.audio_play_sound(A.snd_NSMBU_bobomb_charge, 0.0, false)
		else:
			sonido_antibomb = -4
		image_speed = 1.0
		alarm[0] = 1.0
	else:
		image_speed = 0.2
	alarm[1] = 300.0
	time_blow = 0.0
	s_bobomb = A.spr_bobomb_ready
	startTime = GM.current_time


# from objects/obj_bobomb_ready/Destroy_0.gml
func _destroy() -> void:
	super._destroy()
	if G.apariencia == 3.0:
		GM.audio_stop_sound(sonido_antibomb)


# from objects/obj_bobomb_ready/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create((x - (5.0 * direct)), (y - 5.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_bobomb
		inst.depth = (self.depth + 1.0)
		inst.image_speed = 0.6
	alarm[0] = 12.0


# from objects/obj_bobomb_ready/Alarm_1.gml
func _alarm_1() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(sonido_antibomb)
	GM.instance_create((x - 8.0), y, A.obj_explosion)
	instance_destroy()


# from objects/obj_bobomb_ready/Alarm_10.gml
func _alarm_10() -> void:
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		if wings == 1.0:
			hspeed = (0.3 * direct)
		else:
			hspeed = (0.5 * direct)
	elif wings == 1.0:
		hspeed = (0.5 * direct)
	else:
		hspeed = (0.7 * direct)
	if wings == 1.0 or paracaidas == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_bobomb_ready_wings
			1.0:
				sprite_index = A.spr_SMB3_bobomb_ready_wings
			2.0:
				sprite_index = A.spr_bobomb_ready_wings
			3.0:
				sprite_index = A.spr_NSMBU_bobomb_hold


# from objects/obj_bobomb_ready/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_bobomb_ready_deads
	imdead.image_index = G.apariencia
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0:
			if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = 1.0
			elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
				imdead.hspeed = -1.0
		elif GM.other.hspeed > 0.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed < 0.0:
			imdead.hspeed = -1.0
	else:
		imdead.hspeed = 0.0
		for inst in GM.with_list(GM.instance_create(imdead.x, (imdead.y - 5.0), A.obj_smoke)):
			inst.sprite_index = A.spr_spinthump
	instance_destroy()


# from objects/obj_bobomb_ready/Other_11.gml
func _user_1() -> void:
	time_blow = alarm[1]
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_bobomb_hold)):
		inst.direct = self.direct
		inst.alarm[1] = self.time_blow
	instance_destroy()
