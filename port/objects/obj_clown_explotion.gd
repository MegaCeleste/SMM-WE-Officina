# 第 7 批移植，已核对。
extends "res://objects/obj_smoke.gd"


# from objects/obj_clown_explotion/Create_0.gml
func _create() -> void:
	# PORT: 原版没有 event_inherited()，obj_smoke 的 Create 不执行（scale 保持 null，obj_smoke 的 Draw 不读它）
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_clown_explotion
		image_speed = 0.5
	else:
		image_speed = 0.2
	direct = 1.0


# from objects/obj_clown_explotion/Collision_obj_block_ice.gml
func _collision_obj_block_ice(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.alarm[0] = 1.0
	event_user(0)  # ORIG-BUG: 本 object 和父类 obj_smoke 都没有 User Event 0，原版这里是空操作，照搬


# from objects/obj_clown_explotion/Collision_obj_block_rock.gml
func _collision_obj_block_rock(other: GMObject) -> void:
	for inst in GM.with_list(other):
		inst.alarm[0] = 1.0
	event_user(0)  # ORIG-BUG: 本 object 和父类 obj_smoke 都没有 User Event 0，原版这里是空操作，照搬


# from objects/obj_clown_explotion/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.object_index != A.obj_onoffblock and other.object_index != A.obj_noteblock and other.object_index != A.obj_musicblock and other.object_index != A.obj_noteblock_s:
		for inst in GM.with_list(other):
			inst.alarm[2] = 1.0
	event_user(0)  # ORIG-BUG: 同上，空操作


# from objects/obj_clown_explotion/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if other.hardness == 0.0:
		GM.audio_play_sound(Scr.scr_snd_kick(self), 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(GM.instance_create(other.x, other.y, A.obj_score)):
			inst.event_user(0)
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o
