# from objects/obj_block_pow_active（第 5 批移植，已核对）
extends GMObject


# from objects/obj_block_pow_active/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pow_explode
			GM.audio_stop_sound(A.snd_SMB3_pow)
			GM.audio_play_sound(A.snd_SMB3_pow, 0.0, false)
		1.0:
			sprite_index = A.spr_SMB3_pow_explode
			GM.audio_stop_sound(A.snd_SMB3_pow)
			GM.audio_play_sound(A.snd_SMB3_pow, 0.0, false)
		2.0:
			sprite_index = A.spr_pow_explode
			GM.audio_stop_sound(A.snd_pow)
			GM.audio_play_sound(A.snd_pow, 0.0, false)
		3.0:
			sprite_index = A.spr_NSMBU_pow_explode
			GM.audio_stop_sound(A.snd_NSMBU_pow)
			GM.audio_play_sound(A.snd_NSMBU_pow, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_spinthump)):
				inst.sprite_index = A.spr_NSMBU_effect_pow
				inst.image_speed = 0.6
				inst.depth = -6.0
	image_speed = 0.6
	if G.effect_star == 1.0:
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.var_mouse_pos_x = (((self.x + 88.0) * 2.0) - (GM.camera_get_view_x(GM.view_get_camera(0)) * 2.0))
			inst.var_mouse_pos_y = (((self.y + 88.0) * 2.0) - (GM.camera_get_view_y(GM.view_get_camera(0)) * 2.0))
			inst.event_user(6)
		GM.other = _o
	alarm[0] = 1.0


# from objects/obj_block_pow_active/Alarm_0.gml
func _alarm_0() -> void:
	var coin
	var _o: GMObject = GM.other
	GM.other = self  # with 块里调用 event_user，其中的 other 是本实例（第 17 条）
	if GM.instance_exists(A.obj_shell):
		for inst in GM.with_list(A.obj_shell):
			if inst.vspeed == 0.0 and inst.nomatar == 0.0 and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
	if GM.instance_exists(A.obj_enemyparent):
		for inst in GM.with_list(A.obj_enemyparent):
			if (inst.object_index == A.obj_buzzybeetle or inst.object_index == A.obj_buzzybeetle_b or inst.object_index == A.obj_spiny) and inst.inup == 1.0 and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.event_user(9)
			elif inst.vspeed == 0.0 and inst.hardness < 99.0 and inst.object_index != A.obj_grinder and inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom + 1.0), inst.bbox_right, (inst.bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom - 4.0), inst.bbox_right, (inst.bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
			elif inst.object_index == A.obj_boo and inst.inup > 0.0 and inst.visible == true and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
	if GM.instance_exists(A.obj_muncher):
		for inst in GM.with_list(A.obj_muncher):
			if inst.vspeed == 0.0 and inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom + 1.0), inst.bbox_right, (inst.bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom - 4.0), inst.bbox_right, (inst.bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
	if GM.instance_exists(A.obj_galoomba_hold):
		for inst in GM.with_list(A.obj_galoomba_hold):
			if inst.vspeed == 0.0 and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
	if GM.instance_exists(A.obj_bossparent):
		for inst in GM.with_list(A.obj_bossparent):
			if inst.vspeed == 0.0 and inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom + 1.0), inst.bbox_right, (inst.bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (inst.collision_rectangle(inst.bbox_left, (inst.bbox_bottom - 4.0), inst.bbox_right, (inst.bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) and inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				inst.dead_h = 1.0
				inst.event_user(0)
	GM.other = _o
	if GM.instance_exists(A.obj_coin):
		for inst in GM.with_list(A.obj_coin):
			if inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0):
				coin = GM.instance_create(inst.x, inst.y, A.obj_coin_pow)
				coin.sprite_index = inst.sprite_index
				coin.image_speed = inst.image_speed
				coin.hspeed = GM.random_range(-1.0, 1.0)
				inst.instance_destroy()
	if GM.instance_exists(A.obj_coin10):
		for inst in GM.with_list(A.obj_coin10):
			if inst.x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 404.0) and inst.x > (GM.camera_get_view_x(GM.view_get_camera(0)) - 20.0) and inst.y > (GM.camera_get_view_y(GM.view_get_camera(0)) - 20.0) and inst.y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 236.0) and inst.active == 0.0:
				coin = GM.instance_create(inst.x, inst.y, A.obj_coin_pow)
				coin.sprite_index = inst.sprite_index
				coin.image_speed = inst.image_speed
				coin.hspeed = GM.random_range(-1.0, 1.0)
				match inst.object_index:
					A.obj_coin50:
						coin.type = 50.0
					A.obj_coin30:
						coin.type = 30.0
				inst.instance_destroy()


# from objects/obj_block_pow_active/Other_7.gml
func _animation_end() -> void:
	instance_destroy()
