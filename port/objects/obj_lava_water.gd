extends GMObject

var direct: float = 0.0
var anim_lava: float = 0.0
var mytopid = null
var pos_y: float = 0.0  # PORT: obj_load_guardabot 会给它写 pos_y_limit
var pos_y_limit: float = 0.0
var img_sprite: float = 0.0
var up_down: float = 0.0
var not_move: float = 0.0
var bajar: float = 0.0
var b_bajar: float = 0.0
var num_tile_ancho_d: float = 0.0
var num_tile_alto_d: float = 0.0
var num_ancho_d: float = 0.0
var num_alto_d: float = 0.0
var i: float = 0.0
var j: float = 0.0
var num_tile_ancho: float = 0.0
var num_ancho: float = 0.0


# from objects/obj_lava_water/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	x = GM.camera_get_view_x(GM.view_get_camera(0))
	direct = 1.0
	anim_lava = 0.0
	image_xscale = 24.0
	if GM.instance_exists(A.obj_card_bout):
		y = GM.instance_find(A.obj_card_bout, 0).get("pos_y")  # obj_card_bout 是空壳，自定义变量用 get
	mytopid = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), y, A.obj_lava_water_drybones)
	mytopid.image_xscale = 24.0
	pos_y = y
	pos_y_limit = y
	img_sprite = A.spr_lava_down
	up_down = 0.0
	not_move = 0.0
	bajar = 0.0
	b_bajar = 0.0


# from objects/obj_lava_water/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(mytopid):
		inst.instance_destroy()
	if GM.audio_is_playing(A.snd_NSMBU_lava):
		GM.audio_stop_sound(A.snd_NSMBU_lava)


# from objects/obj_lava_water/Step_1.gml
func _step_begin() -> void:
	#
	# if (global.apariencia == 3 and global.bg_level == "castle" and obj_levelmanager.editor == 0 )
	# {
	# 	if !audio_is_playing(snd_NSMBU_lava)
	# 		audio_play_sound(snd_NSMBU_lava, 0, true)
	# }
	# else{
	# if audio_is_playing(snd_NSMBU_lava)
	# 	audio_stop_sound(snd_NSMBU_lava)
	# }
	#
	pass


# from objects/obj_lava_water/Step_0.gml
func _step() -> void:
	var check
	var check_solid
	var check_oneway
	var check_bullet
	var hurtsolid2
	var solidphy
	x = GM.camera_get_view_x(GM.view_get_camera(0))
	if GM.instance_exists(A.obj_water_move):
		y = (GM.instance_find(A.obj_water_move, 0).y + 12.0)
	if GM.instance_exists(A.obj_card_bout) and GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		pos_y = GM.instance_find(A.obj_card_bout, 0).get("pos_y")  # obj_card_bout 是空壳，自定义变量用 get
		pos_y_limit = GM.instance_find(A.obj_card_bout, 0).get("pos_y_limit")
	match G.bg_level:
		"castle":
			img_sprite = A.spr_lava_down
		"mountain":
			img_sprite = A.spr_lava_down
		"forest":
			if G.modo_noche == 1.0:
				img_sprite = A.spr_lava_purple_down
			else:
				img_sprite = A.spr_water_down
		"beach":
			img_sprite = A.spr_water_beach_down
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		depth = -13.0
	else:
		depth = -7.0
	_user_0()
	if GM.instance_exists(A.obj_levelmanager):
		if (GM.instance_find(A.obj_levelmanager, 0).editor == 1.0) and (((G.bg_level == "forest") and (G.modo_noche == 1.0)) or ((G.bg_level == "castle") or ((G.bg_level == "mountain") and (G.modo_noche == 1.0)))):
			image_speed = 0.0
			image_index = 0.0
			image_alpha = 0.4
			anim_lava = 0.0
			up_down = 0.0
			not_move = 0.0
			bajar = 0.0
			b_bajar = 0.0
		elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (G.bg_level == "forest" or G.bg_level == "beach"):
			image_speed = 0.0
			image_index = 0.0
			image_alpha = 1.0
			anim_lava = 0.0
			up_down = 0.0
			not_move = 0.0
			bajar = 0.0
			b_bajar = 0.0
		else:
			if not GM.instance_exists(A.obj_deadmario):
				if G.apariencia == 3.0:
					image_speed = 0.3
					anim_lava += 0.3
				else:
					image_speed = 0.1
			image_alpha = 1.0
	if GM.instance_exists(A.obj_deadmario):
		not_move = 1.0
	if GM.instance_exists(A.obj_player_goal_parent):
		bajar = 1.0
	if (not GM.veq(mytopid, A.obj_lighting)) and GM.instance_exists(mytopid) and GM.instance_exists(A.obj_mario):
		mytopid.x = GM.camera_get_view_x(GM.view_get_camera(0))
		mytopid.y = y
		if GM.instance_exists(A.obj_kuribo_drybones):
			check = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_bottom - 1.0), GM.instance_find(A.obj_mario, 0).bbox_right, (GM.instance_find(A.obj_mario, 0).bbox_bottom + 1.0), A.obj_solidtop, false, false)
			check_solid = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_top - 2.0), GM.instance_find(A.obj_mario, 0).bbox_right, GM.instance_find(A.obj_mario, 0).bbox_top, A.obj_solid, true, false)
			check_oneway = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_top - 2.0), GM.instance_find(A.obj_mario, 0).bbox_right, GM.instance_find(A.obj_mario, 0).bbox_top, A.obj_onewaygate_bottom, true, false)
			check_bullet = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_top - 2.0), GM.instance_find(A.obj_mario, 0).bbox_right, GM.instance_find(A.obj_mario, 0).bbox_top, A.obj_bullebill_base, true, false)
			hurtsolid2 = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_top - 2.0), GM.instance_find(A.obj_mario, 0).bbox_right, GM.instance_find(A.obj_mario, 0).bbox_top, A.obj_physicssolid, true, false)
			solidphy = collision_rectangle(GM.instance_find(A.obj_mario, 0).bbox_left, (GM.instance_find(A.obj_mario, 0).bbox_top - 2.0), GM.instance_find(A.obj_mario, 0).bbox_right, GM.instance_find(A.obj_mario, 0).bbox_top, A.obj_solidphy, true, false)
			if (check != null and vspeed > 0.0) or (check != null and vspeed < 0.0 and y > (GM.instance_find(A.obj_mario, 0).y + 32.0)) or ((check_solid != null or check_oneway != null or check_bullet != null or hurtsolid2 != null or solidphy != null) and vspeed < 0.0):
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 0.0
				return
			if collision_rectangle(bbox_left, (bbox_top - 8.0), bbox_right, (bbox_top + 7.0), A.obj_mario, false, false) != null and GM.instance_find(A.obj_mario, 0).y < (y - 28.0) and GM.instance_find(A.obj_mario, 0).state < 2.0:
				if GM.instance_exists(A.obj_clown):
					for inst in GM.with_list(A.obj_clown):
						inst.inmario = 0.0
				for inst in GM.with_list(A.obj_kuribo_drybones):
					inst.gran_golpe = 0.0
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 1.0
				if vspeed == 0.0:
					for inst in GM.with_list(A.obj_mario):
						inst.y = ceilf((bbox_top - 32.0))
				else:
					for inst in GM.with_list(A.obj_mario):
						inst.y = ceilf((bbox_top - (32.0 - vspeed)))
			else:
				for inst in GM.with_list(A.obj_mario):
					inst.inclown = 0.0


# from objects/obj_lava_water/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		if bajar == 1.0 and GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach":
				vspeed = 0.0
			elif y < (GM.instance_find(A.obj_ground3, 0).y + 12.0):
				vspeed = 1.0
			elif b_bajar == 0.0:
				vspeed = 0.0
				b_bajar = 1.0
		elif pos_y != pos_y_limit:
			if not_move == 1.0:
				vspeed = 0.0
				image_speed = 0.0
			elif pos_y_limit < (y - 12.0) and vspeed == 0.0 and up_down == 0.0:
				vspeed = (-G.water_speed)
				up_down = 1.0
			elif pos_y_limit >= (y - 12.0) and vspeed < 0.0 and up_down == 1.0:
				vspeed = 0.0
				alarm[0] = 120.0
				up_down = 2.0
			elif pos_y_limit >= (y - 12.0) and vspeed == 0.0 and up_down == 3.0:
				vspeed = G.water_speed
				up_down = 4.0
			elif y >= pos_y and vspeed > 0.0 and up_down == 4.0:
				vspeed = 0.0
				alarm[0] = 120.0
				up_down = 5.0
	elif GM.instance_find(A.obj_levelmanager, 0).editor == 1.0 and (not GM.instance_exists(A.obj_water_move)):
		y = (pos_y + 12.0)
		up_down = 0.0
		vspeed = 0.0


# from objects/obj_lava_water/Alarm_0.gml
func _alarm_0() -> void:
	if up_down == 2.0:
		up_down = 3.0
	elif up_down == 5.0:
		up_down = 0.0


# from objects/obj_lava_water/Other_10.gml
func _user_0() -> void:
	match G.apariencia:
		0.0:
			match G.bg_level:
				"forest":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_lava_purple
					else:
						sprite_index = A.spr_SMB_water
				"castle":
					sprite_index = A.spr_SMB_lava
				"beach":
					sprite_index = A.spr_SMB_water_b
				"mountain":
					sprite_index = A.spr_SMB_lava
		1.0:
			match G.bg_level:
				"forest":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB3_lava_purple
					else:
						sprite_index = A.spr_SMB3_water
				"castle":
					sprite_index = A.spr_SMB3_lava
				"beach":
					sprite_index = A.spr_SMB3_water_b
				"mountain":
					sprite_index = A.spr_SMB3_lava
		2.0:
			match G.bg_level:
				"forest":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_lava_purple
					else:
						sprite_index = A.spr_water
				"castle":
					sprite_index = A.spr_lava
				"beach":
					sprite_index = A.spr_water_b
				"mountain":
					sprite_index = A.spr_lava
		3.0:
			match G.bg_level:
				"forest":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_NSMBU_pocion
					else:
						sprite_index = A.spr_NSMBU_water
				"castle":
					sprite_index = A.spr_NSMBU_lava
				"beach":
					sprite_index = A.spr_NSMBU_water
				"mountain":
					sprite_index = A.spr_NSMBU_lava
		4.0:
			match G.bg_level:
				"forest":
					# ORIG-BUG: spr_SMB2_lava_purple / spr_SMB2_water / spr_SMB2_lava 在工程里不存在（读未定义变量，GMS 里会直接报错）；apariencia==4 时这三处不赋值
					pass
				"castle":
					pass  # ORIG-BUG: spr_SMB2_lava 不存在，同上
				"beach":
					sprite_index = A.spr_SMB_water
				"mountain":
					if G.modo_noche == 1.0:
						sprite_index = A.spr_SMB_lava


# from objects/obj_lava_water/Draw_0.gml
func _gm_draw() -> void:
	var pos: float
	if GM.camera_get_view_y(GM.view_get_camera(0)) >= (y + 16.0):
		pos = GM.camera_get_view_y(GM.view_get_camera(0))
	else:
		pos = (y + 4.0)
	if G.apariencia == 3.0 and G.bg_level == "forest" and G.modo_noche == 1.0:
		num_tile_ancho_d = 21.0
		num_tile_alto_d = 48.0
		num_ancho_d = ceilf((GM.room_width / num_tile_ancho_d))
		num_alto_d = ceilf((240.0 / num_tile_alto_d))
		pos = (y + 18.0)
		i = 0.0
		while i < num_ancho_d:
			j = 0.0
			while j < num_alto_d:
				GM.draw_sprite_ext(A.spr_NSMBU_pocion_down, anim_lava, (i * num_tile_ancho_d), (pos + (j * num_tile_alto_d)), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
				j += 1.0
			i += 1.0
	else:
		GM.draw_sprite_ext(img_sprite, G.apariencia, GM.camera_get_view_x(GM.view_get_camera(0)), pos, ((GM.camera_get_view_width(GM.view_get_camera(0)) + 16.0) / 16.0), ((GM.camera_get_view_height(GM.view_get_camera(0)) + 16.0) / 16.0), 0.0, GM.c_white, image_alpha)
	if (G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach":
		if G.apariencia > 1.0:
			num_tile_ancho = 32.0
		else:
			num_tile_ancho = 16.0
	elif G.apariencia == 3.0:
		num_tile_ancho = 64.0
	else:
		num_tile_ancho = 16.0
	num_ancho = ceilf((GM.room_width / num_tile_ancho))
	if GM.instance_exists(A.obj_water_move):
		i = 0.0
		while i < num_ancho:
			GM.draw_sprite_ext(sprite_index, image_index, (i * num_tile_ancho), GM.instance_find(A.obj_water_move, 0).y, 1.0, 1.0, 0.0, GM.c_white, image_alpha)
			i += 1.0
	else:
		i = 0.0
		while i < num_ancho:
			GM.draw_sprite_ext(sprite_index, image_index, (i * num_tile_ancho), (y - 12.0), 1.0, 1.0, 0.0, GM.c_white, image_alpha)
			i += 1.0
