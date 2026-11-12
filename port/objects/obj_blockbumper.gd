extends GMObject

var hitpoint: float = 0.0


# from objects/obj_blockbumper/Create_0.gml
func _create() -> void:
	alarm[0] = 2.0
	hitpoint = 0.0


# from objects/obj_blockbumper/Alarm_0.gml
func _alarm_0() -> void:
	instance_destroy()


# from objects/obj_blockbumper/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(other):
		if inst.ready_v == 0.0:
			if inst.object_index == A.obj_flipblock and G.apariencia != 2.0:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.alarm[2] = 1.0
			elif inst.object_index == A.obj_noteblock or inst.object_index == A.obj_musicblock or inst.object_index == A.obj_noteblock_s:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -1.5
				inst.event_user(0)
			else:
				GM.audio_play_sound(A.snd_bump, 0.0, false)
				inst.ready_v = 1.0
				inst.vspeed = -2.0
				inst.alarm[0] = 4.0
				inst.event_user(0)
	GM.other = _o


# from objects/obj_blockbumper/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0 and other.visible == true:
		Scr.scr_musicalscale(self, self, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(5)
		GM.other = _o
