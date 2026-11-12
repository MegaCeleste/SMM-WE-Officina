extends "res://objects/obj_enemyparent.gd"

var xmin: float = 0.0
var happy: float = 0.0
var edible: float = 0.0
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var movement = null


# from objects/obj_angrysun/Create_0.gml
func _create() -> void:
	xmin = 0.0
	if G.modo_noche == 1.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_happymoon
			1.0:
				sprite_index = A.spr_SMB3_happymoon
			2.0:
				sprite_index = A.spr_happymoon
			3.0:
				sprite_index = A.spr_NSMBU_happymoon
	elif G.modo_noche == 0.0:
		match G.apariencia:
			0.0:
				sprite_index = A.spr_SMB_angrysun
			1.0:
				sprite_index = A.spr_SMB3_angrysun
			2.0:
				sprite_index = A.spr_angrysun
			3.0:
				sprite_index = A.spr_NSMBU_angrysun_idle
	if G.modo_noche == 1.0:
		happy = 1.0
		hardness = 100.0
		stomp = -1.0
		edible = 2.0
		if G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.1
	else:
		happy = 0.0
		hardness = 99.0
		stomp = 2.0
		edible = 2.0
		if G.apariencia == 2.0:
			image_speed = 0.15
		elif G.apariencia == 3.0:
			image_speed = 0.5
		else:
			image_speed = 0.1
	ready_v = 0.0
	movement = null
	wings = 0.0
	innave = 0.0
	dead_h = 0.0
	modo_lava = 0.0
	direct = 1.0
	swimming = 0.0
	apilar = 0.0


# from objects/obj_angrysun/Destroy_0.gml
func _destroy() -> void:
	if movement != null:
		for inst in GM.with_list(movement):
			inst.instance_destroy()


# from objects/obj_angrysun/Step_0.gml
func _step() -> void:
	if ready_v == 0.0:
		speed = 4.0
		move_towards_point((GM.camera_get_view_x(GM.view_get_camera(0)) + 64.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0), speed)
		if x > (GM.camera_get_view_x(GM.view_get_camera(0)) + 56.0) and x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 72.0) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0) and y < (GM.camera_get_view_y(GM.view_get_camera(0)) + 56.0):
			speed = 0.0
			ready_v = 1.0
	elif ready_v == 1.0:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 64.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0)
		if GM.instance_exists(A.obj_mario):
			if G.apariencia == 2.0 and G.modo_noche == 0.0:
				sprite_index = A.spr_angrysun_atack
			ready_v = 2.0
			alarm[0] = 1.0
			movement = GM.instance_create(x, y, A.obj_angrysun_movement)
	elif GM.instance_exists(movement):
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + movement.x)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + movement.y)
	else:
		x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 64.0)
		y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0)


# from objects/obj_angrysun/Alarm_0.gml
func _alarm_0() -> void:
	if happy == 1.0:
		for inst in GM.with_list(GM.instance_create(((x - 3.0) + GM.random(GM.gm_round(22.0))), ((y - 3.0) + GM.random(GM.gm_round(22.0))), A.obj_smoke)):
			inst.sprite_index = A.spr_boltspark
			inst.image_speed = 0.1
	alarm[0] = 4.0


# from objects/obj_angrysun/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	var a
	var b
	if happy == 1.0 and ready_v == 2.0:
		GM.audio_play_sound(A.snd_scatter, 0.0, false)
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_enemyparent):
			if inst.object_index != A.obj_grinder:
				a = 0.0
				for _rep in range(8):
					for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
						inst2.sprite_index = A.spr_boltspark
						inst2.image_speed = 0.1
						inst2.motion_set(a, 0.5)
					a += 45.0
				b = 22.5
				for _rep in range(8):
					for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
						inst2.sprite_index = A.spr_boltspark
						inst2.image_speed = 0.1
						inst2.motion_set(b, 1.0)
					b += 45.0
				if GM.variable_instance_exists(inst, "key") and inst.key == 1.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), (inst.y - 8.0), A.obj_key_appear)):
						inst2.vspeed = -4.0
				inst.instance_destroy()
				# with (instance_create(...)) event_user(0)：块内 other 是外层 with 的 inst
				GM.other = inst
				for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), inst.y, A.obj_score)):
					inst2.event_user(0)
				GM.other = self
		# NOTE: obj_bossparent 是 obj_enemyparent 的子类，上面的 with 已经包含 boss，这里原版重复处理一遍（原样照搬）；obj_bossparent 目前是空壳
		for inst in GM.with_list(A.obj_bossparent):
			a = 0.0
			for _rep in range(8):
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_boltspark
					inst2.image_speed = 0.1
					inst2.motion_set(a, 0.5)
				a += 45.0
			b = 22.5
			for _rep in range(8):
				for inst2 in GM.with_list(GM.instance_create(((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0) - 8.0), ((GM.gm_round((inst.bbox_top + inst.bbox_bottom)) / 2.0) - 8.0), A.obj_smoke)):
					inst2.sprite_index = A.spr_boltspark
					inst2.image_speed = 0.1
					inst2.motion_set(b, 1.0)
				b += 45.0
			if GM.variable_instance_exists(inst, "key") and inst.key == 1.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x - 8.0), (inst.y - 8.0), A.obj_key_appear)):
					inst2.vspeed = -4.0
			inst.instance_destroy()
			GM.other = inst
			for inst2 in GM.with_list(GM.instance_create((GM.gm_round((inst.bbox_left + inst.bbox_right)) / 2.0), inst.y, A.obj_score)):
				inst2.event_user(0)
			GM.other = self
		GM.other = _o
		instance_destroy()
		GM.other = self
		for inst in GM.with_list(GM.instance_create((GM.gm_round((bbox_left + bbox_right)) / 2.0), y, A.obj_score)):
			inst.event_user(3)
		GM.other = _o
	else:
		super._collision_obj_mario(other)


# from objects/obj_angrysun/Other_10.gml
func _user_0() -> void:
	imdead = GM.instance_create(x, y, A.obj_enemy_dead)
	imdead.direct = direct
	imdead.direct_y = -1.0
	imdead.sprite_index = sprite_index
	if dead_h == 0.0:
		if GM.other.hspeed == 0.0 and direct == 1.0:
			imdead.hspeed = 1.0
		elif GM.other.hspeed == 0.0 and direct == -1.0:
			imdead.hspeed = -1.0
	instance_destroy()


# from objects/obj_angrysun/Other_15.gml
func _user_5() -> void:
	return


# from objects/obj_angrysun/Other_24.gml
func _user_14() -> void:
	return


# from objects/obj_angrysun/Draw_0.gml
func _gm_draw() -> void:
	if ready_v == 0.0:
		draw_self()
	elif ready_v == 1.0:
		GM.draw_sprite_ext(sprite_index, -1.0, (GM.gm_round(GM.camera_get_view_x(GM.view_get_camera(0))) + 64.0), (GM.gm_round(GM.camera_get_view_y(GM.view_get_camera(0))) + 48.0), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
	elif GM.instance_exists(A.obj_angrysun_movement):
		GM.draw_sprite_ext(sprite_index, -1.0, (GM.gm_round(GM.camera_get_view_x(GM.view_get_camera(0))) + GM.instance_find(A.obj_angrysun_movement, 0).x), (GM.gm_round(GM.camera_get_view_y(GM.view_get_camera(0))) + GM.instance_find(A.obj_angrysun_movement, 0).y), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
	else:
		draw_self()
