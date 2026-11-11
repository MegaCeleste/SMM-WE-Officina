extends "res://objects/obj_parent_resource.gd"

var create_bgo: float = 0.0
var create_bgo2 = null
var no_clean: float = 0.0
var ready_v = null  # 原名 ready（和 Node.ready 撞名）
var vent1 = null  # 以下 6 个由 scr_auto_tile 赋值（脚本内实例变量）
var vent2 = null
var vent3 = null
var vent4 = null
var borde1 = null
var borde2 = null


# from objects/obj_ground/Create_0.gml
func _create() -> void:
	super._create()
	move_snap(16.0, 16.0)
	create_bgo = 0.0
	create_bgo2 = 0.0
	if GM.room == A.rm_guardabot_play or GM.room == A.rm_title:
		_user_0()
	else:
		sprite_index = A.spr_ground
	no_clean = 0.0


# from objects/obj_ground/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		_user_0()


# from objects/obj_ground/Alarm_0.gml
func _alarm_0() -> void:
	return


# from objects/obj_ground/Alarm_3.gml
func _alarm_3() -> void:
	image_xscale = 1.0
	image_yscale = 1.0


# from objects/obj_ground/Alarm_5.gml
func _alarm_5() -> void:
	if collision_point(x, (y - 8.0), A.obj_ground, false, true) != null or collision_point(x, (y - 8.0), A.obj_decoracion_1, false, true) != null or collision_point(x, (y - 8.0), A.obj_decoracion_2, false, true) != null or collision_point(x, (y - 8.0), A.obj_decoracion_3, false, true) != null or collision_point(x, (y - 8.0), A.obj_decoracion_4, false, true) != null or collision_point((x - 8.0), (y - 8.0), A.obj_decoracion_4, false, true) != null or collision_point((x + 24.0), (y - 8.0), A.obj_decoracion_4, false, true) != null:
		alarm[2] = -1.0
		return
	elif create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)) or create_bgo == GM.gm_round(GM.random(100.0)):
		GM.audio_stop_sound(A.snd_decoracion)
		GM.audio_play_sound(A.snd_decoracion, 0.0, false)
		if collision_point((x - 8.0), (y + 8.0), A.obj_ground, false, true) != null and collision_point((x + 24.0), (y + 8.0), A.obj_ground, false, true) != null and (collision_point((x - 8.0), (y - 8.0), A.obj_decoracion_1, false, true) == null) and (collision_point((x + 24.0), (y - 8.0), A.obj_decoracion_1, false, true) == null) and (collision_point((x - 8.0), (y - 8.0), A.obj_decoracion_2, false, true) == null) and (collision_point((x + 24.0), (y - 8.0), A.obj_decoracion_2, false, true) == null) and (collision_point((x - 8.0), (y - 8.0), A.obj_decoracion_3, false, true) == null) and (collision_point((x + 24.0), (y - 8.0), A.obj_decoracion_3, false, true) == null):
			create_bgo2 = GM.choose(0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0)
			if create_bgo2 == 0.0:
				GM.instance_create((x + 16.0), (y - 16.0), A.obj_decoracion_4)
			else:
				GM.instance_create(x, (y - 16.0), GM.choose(A.obj_decoracion_1, A.obj_decoracion_2, A.obj_decoracion_3, A.obj_decoracion_1, A.obj_decoracion_2, A.obj_decoracion_1, A.obj_decoracion_3, A.obj_decoracion_3))
		else:
			GM.instance_create(x, (y - 16.0), GM.choose(A.obj_decoracion_1, A.obj_decoracion_2, A.obj_decoracion_3, A.obj_decoracion_2, A.obj_decoracion_1, A.obj_decoracion_3))


# from objects/obj_ground/Alarm_6.gml
func _alarm_6() -> void:
	pos_cal = 0.0


# from objects/obj_ground/Collision_obj_tile_trigger.gml
func _collision_obj_tile_trigger(_other: GMObject) -> void:
	_user_5()


# from objects/obj_ground/Other_0.gml
func _outside_room() -> void:
	if GM.instance_exists(A.obj_levelmanager) and GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0 and drag == 0.0:
		_user_2()
		GM.instance_create(x, y, A.obj_tile_trigger)


# from objects/obj_ground/Other_10.gml
func _user_0() -> void:
	sprite_index = Scr.scr_tiles_ground(self)


# from objects/obj_ground/Other_12.gml
func _user_2() -> void:
	# itp：GML 里是实例或 obj_lighting（"没有"的哨兵）；按 §3.3 第 15 条，"没有"用 null 表示
	var itp = null
	if no_clean == 0.0:
		if instance_place(x, (y - 16.0), A.obj_decoracion_1) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_1)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_2) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_2)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_3) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_3)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_4) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_4)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_1) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_1)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_2) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_2)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_3) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_3)
		elif instance_place(x, (y - 16.0), A.obj_decoracion_4) != null:
			itp = instance_place(x, (y - 16.0), A.obj_decoracion_4)
		else:
			itp = null  # GML: itp = obj_lighting
		if itp != null:  # GML: itp != obj_lighting
			for inst in GM.with_list(itp):
				inst.instance_destroy()
		super._user_2()


# from objects/obj_ground/Other_13.gml
func _user_3() -> void:
	var vobj: int
	var depht: float
	if image_index == 50.0:
		image_index = 9.0
	elif image_index == 51.0:
		image_index = 10.0
	elif image_index == 52.0:
		image_index = 39.0
	elif image_index == 53.0:
		image_index = 42.0
	elif image_index == 56.0:
		image_index = 8.0
	elif image_index == 57.0:
		image_index = 11.0
	elif image_index == 70.0:
		image_index = 33.0
	if image_index == 28.0 or image_index == 29.0 or image_index == 30.0 or image_index == 31.0 or image_index == 32.0 or image_index == 33.0 or image_index == 34.0 or image_index == 35.0 or image_index == 36.0 or image_index == 37.0 or image_index == 38.0 or image_index == 39.0 or image_index == 40.0 or image_index == 41.0 or image_index == 42.0 or image_index == 43.0 or image_index == 47.0 or image_index == 48.0 or image_index == 49.0:
		vobj = A.obj_modelbgo
		depht = 280.0
	else:
		vobj = A.obj_modelsolid
		depht = 5.0
	for inst in GM.with_list(GM.instance_create_depth(x, y, depht, vobj)):
		inst.image_speed = 0.0
		inst.sprite_index = self.sprite_index
		inst.image_index = self.image_index
		if inst.object_index == A.obj_modelbgo:
			inst.depth = 5.0


# from objects/obj_ground/Other_15.gml
func _user_5() -> void:
	image_index = Scr.scr_auto_tile(self)


# from objects/obj_ground/Other_18.gml
func _user_8() -> void:
	var itp = null  # GML 里 "没有" 是 obj_lighting，这里用 null（§3.3 第 15 条）
	create_bgo = GM.gm_round(GM.random(80.0))
	alarm[5] = 5.0
	if instance_place(x, y, A.obj_decoracion_1) != null:
		itp = instance_place(x, y, A.obj_decoracion_1)
	elif instance_place(x, y, A.obj_decoracion_2) != null:
		itp = instance_place(x, y, A.obj_decoracion_2)
	elif instance_place(x, y, A.obj_decoracion_3) != null:
		itp = instance_place(x, y, A.obj_decoracion_3)
	elif instance_place(x, y, A.obj_decoracion_4) != null:
		itp = instance_place(x, y, A.obj_decoracion_4)
	elif instance_place(x, y, A.obj_decoracion_1) != null:
		itp = instance_place(x, y, A.obj_decoracion_1)
	elif instance_place(x, y, A.obj_decoracion_2) != null:
		itp = instance_place(x, y, A.obj_decoracion_2)
	elif instance_place(x, y, A.obj_decoracion_3) != null:
		itp = instance_place(x, y, A.obj_decoracion_3)
	elif instance_place(x, y, A.obj_decoracion_4) != null:
		itp = instance_place(x, y, A.obj_decoracion_4)
	else:
		itp = null  # GML: itp = obj_lighting
	if itp != null:  # GML: itp != obj_lighting
		for inst in GM.with_list(itp):
			inst.instance_destroy()


# from objects/obj_ground/Mouse_0.gml
func _mouse_0() -> void:
	if G.play == 0.0 and Scr.scr_insideview(self) > 0.5 and G.resource_create == 0.0 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0:
		if G.editor_activity == 1.0:
			if G.cursor == 2.0:
				_user_2()
				GM.instance_create(x, y, A.obj_tile_trigger)


# from objects/obj_ground/Mouse_1.gml
func _mouse_1() -> void:
	if GM.instance_find(A.obj_editormanager, 0).get("expand_open") == 0.0 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0 and G.cursor == 2.0 and Scr.scr_insideview(self) > 0.5 and G.editor_activity == 1.0:
		_user_2()
		GM.instance_create(x, y, A.obj_tile_trigger)


# from objects/obj_ground/Mouse_4.gml
func _mouse_4() -> void:
	if G.resource_create == 0.0 and G.editor_activity == 1.0 and Scr.scr_insideview(self) > 0.5 and GM.instance_find(A.obj_levelmanager, 0).get("editor_sonidos") == 0.0:
		if G.cursor == 2.0:
			GM.instance_create(x, y, A.obj_tile_trigger)
			_user_2()


# from objects/obj_ground/Mouse_7.gml
func _mouse_7() -> void:
	pass
