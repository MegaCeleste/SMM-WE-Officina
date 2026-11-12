# from objects/obj_bobomb_hold（第 5 批移植，已核对）
extends "res://objects/obj_galoomba_hold.gd"

var sonido_antibomb: int = 0  # 原版只在 apariencia == 3 时赋值（audio_play_sound 的句柄），其余外观下不会读


# from objects/obj_bobomb_hold/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_bobomb_hold
		1.0:
			sprite_index = A.spr_SMB3_bobomb_hold
		2.0:
			sprite_index = A.spr_bobomb_hold
		3.0:
			sprite_index = A.spr_NSMBU_bobomb_hold
	if G.apariencia == 3.0:
		sonido_antibomb = GM.audio_play_sound(A.snd_NSMBU_bobomb_charge, 0.0, false)
		image_speed = 0.5
		alarm[4] = 1.0
	else:
		image_speed = 0.1
	hitpoint = 0.0
	direct = 1.0
	apilar = 0.0
	alarm[2] = 240.0
	alarm[1] = 300.0


# from objects/obj_bobomb_hold/Destroy_0.gml
func _destroy() -> void:
	super._destroy()
	if G.apariencia == 3.0:
		GM.audio_stop_sound(sonido_antibomb)


# from objects/obj_bobomb_hold/Step_0.gml
func _step() -> void:
	super._step()
	if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "castle":
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()
	elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) > (GM.instance_find(A.obj_lava_water, 0).y - 12.0) and G.bg_level == "mountain" and G.modo_noche == 1.0:
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()


# from objects/obj_bobomb_hold/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(A.obj_player_warp):
		if G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.1
		alarm[2] = 240.0
		alarm[1] = 300.0
	else:
		if G.apariencia == 3.0:
			GM.audio_stop_sound(sonido_antibomb)
		GM.instance_create((x - 8.0), y, A.obj_explosion)
		instance_destroy()


# from objects/obj_bobomb_hold/Alarm_2.gml
func _alarm_2() -> void:
	image_speed = 0.0
	if G.apariencia == 3.0:
		image_index = 13.0
	else:
		image_index = 0.0


# from objects/obj_bobomb_hold/Alarm_4.gml
func _alarm_4() -> void:
	for inst in GM.with_list(GM.instance_create((x - (6.0 * direct)), (y - 6.0), A.obj_smoke)):
		inst.sprite_index = A.spr_NSMBU_smoke_bobomb
		inst.depth = (self.depth + 1.0)
		inst.image_speed = 0.6
	alarm[4] = 15.0


# from objects/obj_bobomb_hold/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, (y + 8.0), A.obj_enemy_dead)
	imdead.girar = 1.0
	imdead.sprite_index = A.spr_bobomb_hold_deads
	imdead.image_index = G.apariencia
	if GM.other.hspeed == 0.0:
		if (GM.other.bbox_left + (bbox_right / 2.0)) < (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = 1.0
		elif (GM.other.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			imdead.hspeed = -1.0
	elif GM.other.hspeed > 0.0:
		imdead.hspeed = 1.0
	elif GM.other.hspeed < 0.0:
		imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_bobomb_hold/Other_11.gml
func _user_1() -> void:
	var o = GM.other  # PORT: 事件方法外的 other（第 17 条），取一次放局部，with 块内改 GM.other 不影响后面读 other
	if hitpoint == 1.0 and GM.instance_exists(A.obj_mario):
		if (GM.instance_find(A.obj_mario, 0).bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = -4.2
			direct = -1.0
		else:
			hspeed = 4.2
			direct = 1.0
		hitpoint = 0.0
		return
	if o.stompstyle == 1.0 or G.yoshi > 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(o):
			inst.event_user(1)
		GM.other = _o
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_stomp, 0.0, false)
		else:
			GM.audio_play_sound(A.snd_stomp, 0.0, false)
		for inst in GM.with_list(GM.instance_create(o.x, (o.y + 22.0), A.obj_spinthump)):
			inst.image_xscale = 0.8
			inst.image_yscale = 0.8
		if (o.bbox_left + (bbox_right / 2.0)) > (bbox_left + (bbox_right / 2.0)):
			hspeed = -4.2
			direct = -1.0
		else:
			hspeed = 4.2
			direct = 1.0
