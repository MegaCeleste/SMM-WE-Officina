# from objects/obj_explosion（第 5 批移植，已核对）
extends GMObject

var big: float = 0.0
var active_block: float = 0.0
var hitpoint: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）


# from objects/obj_explosion/Create_0.gml
func _create() -> void:
	if G.apariencia == 0.0:
		sprite_index = A.spr_SMB3_explotion
		image_speed = 0.4
	elif G.apariencia == 1.0:
		sprite_index = A.spr_SMB3_explotion
		image_speed = 0.4
	elif G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_explotion
		image_speed = 0.5
	else:
		image_speed = 0.45
	if Scr.outside_view(self) <= 0.5:
		if G.powerup == -85.0:
			GM.audio_stop_sound(A.snd_SMB_link_explosion)
			GM.audio_play_sound(A.snd_SMB_link_explosion, 0.0, false)
		else:
			GM.audio_stop_sound(Scr.scr_snd_explode(self))
			GM.audio_play_sound(Scr.scr_snd_explode(self), 0.0, false)
	alarm[0] = 30.0
	big = 0.0
	active_block = 0.0
	hitpoint = 0.0
	ready_v = 0.0


# from objects/obj_explosion/Collision_obj_block_ice.gml
func _collision_obj_block_ice(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		for inst in GM.with_list(other):
			inst.alarm[0] = 1.0


# from objects/obj_explosion/Collision_obj_block_pow_hold.gml
func _collision_obj_block_pow_hold(other: GMObject) -> void:
	if other.held == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.explode = 1.0
			inst.event_user(6)
		GM.other = _o


# from objects/obj_explosion/Collision_obj_block_rock.gml
func _collision_obj_block_rock(other: GMObject) -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		for inst in GM.with_list(other):
			inst.alarm[0] = 1.0


# from objects/obj_explosion/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.object_index != A.obj_onoffblock and other.object_index != A.obj_noteblock and other.object_index != A.obj_musicblock:
		for inst in GM.with_list(other):
			inst.alarm[2] = 1.0


# from objects/obj_explosion/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		Scr.scr_musicalscale(self, self, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_explosion/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if other.sprite_index == A.spr_SMB_link_shield and ready_v == 0.0 and ((other.direct == 1.0 and (x + 8.0) > other.x) or (other.direct == -1.0 and (x + 8.0) < other.x)):
		GM.audio_play_sound(A.snd_SMB_link_guardbullet, 0.0, false)
		for inst in GM.with_list(other):
			inst.hspeed = (-((2.0 * inst.direct)))
		ready_v = 1.0
		return
	elif ready_v == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_explosion/Collision_obj_onoffblock.gml
func _collision_obj_onoffblock(other: GMObject) -> void:
	if other.ready_v == 0.0 and active_block == 0.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o
		active_block = 1.0


# from objects/obj_explosion/Other_7.gml
func _animation_end() -> void:
	instance_destroy()


# from objects/obj_explosion/Draw_0.gml
func _gm_draw() -> void:
	if big == 0.0:
		GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	else:
		GM.draw_sprite_ext(sprite_index, image_index, x, y, 2.0, 2.0, 0.0, GM.c_white, 1.0)

