extends GMObject

var humo: float = 0.0


# from objects/obj_meteorites/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_meteorite_small
			humo = A.spr_smoke_pballoon
		1.0:
			sprite_index = A.spr_SMB3_meteorite_small
			humo = A.spr_smoke_pballoon
		2.0:
			sprite_index = A.spr_meteorite_small
			humo = A.spr_smoke_pballoon
		3.0:
			sprite_index = A.spr_NSMBU_meteorite_small
			humo = A.spr_NSMBU_smoke_meteorite
	alarm[0] = 15.0


# from objects/obj_meteorites/Step_0.gml
func _step() -> void:
	_user_0()
	_user_4()


# from objects/obj_meteorites/Alarm_0.gml
func _alarm_0() -> void:
	for inst in GM.with_list(GM.instance_create((x), (y - 8.0), A.obj_smoke)):
		inst.sprite_index = int(humo)
		inst.depth = 0.0
	alarm[0] = 20.0


# from objects/obj_meteorites/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and (G.yoshi > 0.0 or other.stompstyle == 1.0):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(1)
		GM.other = _o
		GM.audio_play_sound(Scr.scr_snd_stomp(self), 0.0, false)
		GM.instance_create(other.x, (other.y + 22.0), A.obj_spinthump)
	elif GM.instance_exists(A.obj_invincibility):
		_user_0()
	else:
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_meteorites/Other_10.gml
func _user_0() -> void:
	var block_col: bool = place_meeting(x, y, A.obj_blockparent)
	var rock_col: bool = place_meeting(x, y, A.obj_rockparent)
	var solid_col: bool = place_meeting(x, y, A.obj_solidtop)
	if block_col or rock_col or solid_col:
		_user_1()


# from objects/obj_meteorites/Other_11.gml
func _user_1() -> void:
	if G.apariencia == 0.0 or G.apariencia == 1.0:
		GM.audio_play_sound(A.snd_SMB3_break, 0.0, false)
	elif G.apariencia == 3.0:
		GM.audio_play_sound(A.snd_NSMBU_rocks_break, 0.0, false)
	else:
		GM.audio_play_sound(A.snd_break, 0.0, false)
	for inst in GM.with_list(GM.instance_create((x), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(45.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(60.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(120.0, 6.0)
	for inst in GM.with_list(GM.instance_create((x), (y + 8.0), A.obj_shard)):
		match G.apariencia:
			3.0:
				inst.sprite_index = A.spr_NSMBU_meteorite_shard_small
			_:
				inst.sprite_index = A.spr_volcanic_parts
				inst.image_index = G.apariencia
		inst.motion_set(135.0, 6.0)
	instance_destroy()


# from objects/obj_meteorites/Other_14.gml
func _user_4() -> void:
	if GM.instance_exists(A.obj_mario):
		gravity = 0.2
		if vspeed > 0.5:
			vspeed = 0.5
		image_angle -= GM.random_range(1.5, 3.0)
	else:
		vspeed = 0.0
