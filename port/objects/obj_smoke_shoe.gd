# 第 4 批移植，已核对。
extends GMObject

var direct: float = 0.0


# from objects/obj_smoke_shoe/Create_0.gml
func _create() -> void:
	image_speed = 0.2
	direct = 1.0


# from objects/obj_smoke_shoe/Step_0.gml
func _step() -> void:
	hspeed = (maxf(0.0, (absf(hspeed) - 0.05)) * GM.gm_sign(hspeed))
	if hspeed < 0.05 and hspeed > -0.05:
		instance_destroy()


# from objects/obj_smoke_shoe/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	var o = other
	if o.hardness < 99.0:
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_smoke_shoe/Collision_obj_muncher.gml
func _collision_obj_muncher(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		GM.audio_stop_sound(Scr.scr_snd_kick(inst))
		GM.audio_play_sound(Scr.scr_snd_kick(inst), 0.0, false)
		inst.event_user(0)
	GM.other = _o


# from objects/obj_smoke_shoe/Collision_obj_shell.gml
func _collision_obj_shell(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		GM.audio_stop_sound(Scr.scr_snd_kick(inst))
		GM.audio_play_sound(Scr.scr_snd_kick(inst), 0.0, false)
		inst.event_user(0)
	GM.other = _o


# from objects/obj_smoke_shoe/Other_7.gml
func _animation_end() -> void:
	if sprite_index == A.spr_SMB3_smoke_shoe:
		sprite_index = A.spr_SMB3_smoke_shoe_end


# from objects/obj_smoke_shoe/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, direct, 1.0, 0.0, GM.c_white, 1.0)
