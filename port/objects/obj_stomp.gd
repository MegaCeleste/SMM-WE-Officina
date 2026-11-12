extends GMObject

var hitpoint: float = 0.0


# from objects/obj_stomp/Create_0.gml
func _create() -> void:
	for inst in GM.with_list(GM.instance_create((x - 16.0), y, A.obj_smoke)):
		inst.hspeed = -1.0
		inst.depth = -6.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.hspeed = 1.0
		inst.depth = -6.0
	GM.audio_stop_sound(Scr.scr_snd_bump(self))
	GM.audio_play_sound(Scr.scr_snd_bump(self), 0.0, false)
	image_speed = 0.5
	hitpoint = 0.0


# from objects/obj_stomp/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness < 99.0:
		Scr.scr_musicalscale(self, self, other, 1.0)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_stomp/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
