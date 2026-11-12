# 第 4 批移植，已核对。
extends GMObject

var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var spd_temp: float = 0.0
var inc: float = 0.0


# from objects/obj_groundpount/Create_0.gml
func _create() -> void:
	ready_v = 1.0
	spd_temp = 0.0
	inc = 0.0


# from objects/obj_groundpount/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var i_mario = GM.instance_find(A.obj_mario, 0)
		x = i_mario.x
		y = ((i_mario.y + 18.0) + i_mario.vspeed)
		if i_mario.groundpount < 2.0 or i_mario.groundpount > 3.0:
			instance_destroy()
		for inst in GM.with_list(A.obj_mario):
			inst.state = 2.0
		if (collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom + 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_solidtop, false, false) != null or collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom + 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null) and (collision_rectangle(i_mario.bbox_left, (i_mario.bbox_bottom + 1.0), i_mario.bbox_right, (i_mario.bbox_bottom + 1.0), A.obj_blockparent, false, false) == null):
			instance_destroy()
		if i_mario.vspeed == 0.0:
			inc += 1.0
			if inc > 3.0:
				instance_destroy()
	else:
		instance_destroy()


# from objects/obj_groundpount/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(A.obj_mario):
		inst.vspeed = self.spd_temp
	inc = 0.0
	spd_temp = 2.7


# from objects/obj_groundpount/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if GM.instance_exists(A.obj_mario):
		# with (other.id) 块体里的 other 是本实例；块体内调用了 event_user
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			if inst.object_index != A.obj_noteblock and inst.object_index != A.obj_musicblock and inst.object_index != A.obj_noteblock_s and inst.ready_v == 0.0:
				if inst.object_index == A.obj_flipblock:
					if G.powerup == 0.0:
						inst.event_user(3)
						inst.expand = 1.0
						for inst2 in GM.with_list(A.obj_groundpount):
							inst2.instance_destroy()
					else:
						inst.alarm[2] = 1.0
						inst.spd_temp = (GM.instance_find(A.obj_mario, 0).vspeed + 0.5)
						for inst2 in GM.with_list(A.obj_mario):
							inst2.vspeed = 0.0
						for inst2 in GM.with_list(self):
							inst2.alarm[0] = 2.0
						if not GM.keyboard_check(G.abajo):
							for inst2 in GM.with_list(A.obj_groundpount):
								inst2.instance_destroy()
						else:
							GM.audio_stop_sound(A.snd_NSMBU_groundpount_stop)
							GM.audio_play_sound(A.snd_NSMBU_groundpount_stop, 0.0, false)
				elif inst.object_index == A.obj_block_multicoin:
					if not GM.keyboard_check(G.abajo):
						for inst2 in GM.with_list(A.obj_groundpount):
							inst2.instance_destroy()
					if G.powerup == 0.0:
						inst.event_user(3)
						inst.expand = 1.0
						if inst.cointime == 2.0:
							for inst2 in GM.with_list(A.obj_groundpount):
								inst2.instance_destroy()
					else:
						inst.expand = 1.0
						inst.event_user(3)
				else:
					inst.event_user(3)
					inst.expand = 1.0
					for inst2 in GM.with_list(A.obj_groundpount):
						inst2.instance_destroy()
			else:
				for inst2 in GM.with_list(A.obj_groundpount):
					inst2.instance_destroy()
		GM.other = _o
	else:
		for inst in GM.with_list(A.obj_groundpount):
			inst.instance_destroy()
