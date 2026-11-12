# from objects/obj_physicssolid（第 6c 批移植，已核对）
extends "res://objects/obj_physicsparent.gd"



# from objects/obj_physicssolid/Collision_obj_bossparent.gml
func _collision_obj_bossparent(other: GMObject) -> void:
	if other.visible == true:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			GM.audio_stop_sound(Scr.scr_snd_kick(self))
			GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(other):
				inst.event_user(0)
			GM.other = _o


# from objects/obj_physicssolid/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.hardness != 6.0 and other.visible == true and other.object_index != A.obj_grinder and other.object_index != A.obj_banzaibill and other.object_index != A.obj_podoboo and other.object_index != A.obj_angrysun and other.object_index != A.obj_cheepcheep and other.object_index != A.obj_thwomp and other.object_index != A.obj_boo and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			if other.object_index == A.obj_bobomb or other.object_index == A.obj_bobomb_ready:
				for inst in GM.with_list(other):
					GM.instance_create(inst.x, inst.y, A.obj_explosion)
					inst.instance_destroy()
			else:
				GM.audio_stop_sound(Scr.scr_snd_kick(self))
				GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(other):
					inst.event_user(0)
				GM.other = _o


# from objects/obj_physicssolid/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
		other.y += vspeed
	if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
		GM.audio_stop_sound(Scr.scr_snd_kick(self))
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_physicssolid/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and other.state > 1.0:
		other.y += vspeed
	if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (other.state < 2.0 or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
		GM.instance_create(other.x, other.y, A.obj_deadmario)
		for inst in GM.with_list(other):
			inst.instance_destroy()


# from objects/obj_physicssolid/Collision_obj_powerupparent.gml
func _collision_obj_powerupparent(other: GMObject) -> void:
	if other.object_index != A.obj_cap and other.object_index != A.obj_propellershroom:
		if (bbox_bottom - vspeed) < (other.bbox_top + 2.0) and vspeed > 0.0 and vspeed != 0.0:
			other.y += vspeed
		if (bbox_bottom - vspeed) < (other.bbox_top + 1.0) and vspeed > 0.0 and (collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_solidtop, false, false) != null or collision_rectangle((other.bbox_left + 4.0), (other.bbox_bottom + vspeed), (other.bbox_right - 4.0), (other.bbox_bottom + vspeed), A.obj_physicssolid, false, false) != null):
			GM.instance_create(other.x, other.y, A.obj_smoke)
			for inst in GM.with_list(other):
				inst.instance_destroy()
