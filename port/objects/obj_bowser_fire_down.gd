extends GMObject

var destruir: float = 0.0
var swimming: float = 0.0


# from objects/obj_bowser_fire_down/Create_0.gml
func _create() -> void:
	image_speed = 0.15
	destruir = 0.0
	swimming = 0.0


# from objects/obj_bowser_fire_down/Step_0.gml
func _step() -> void:
	_user_4()
	if GM.instance_exists(A.obj_mario_transform2):
		depth = -5.0
	else:
		depth = -7.0


# from objects/obj_bowser_fire_down/Alarm_0.gml
func _alarm_0() -> void:
	_user_0()


# from objects/obj_bowser_fire_down/Collision_obj_blockparent.gml
func _collision_obj_blockparent(other: GMObject) -> void:
	if other.vspeed < 0.0:
		_user_0()


# from objects/obj_bowser_fire_down/Collision_obj_helmet.gml
func _collision_obj_helmet(other: GMObject) -> void:
	_user_0()


# from objects/obj_bowser_fire_down/Collision_obj_invincibility.gml
func _collision_obj_invincibility(other: GMObject) -> void:
	_user_0()


# from objects/obj_bowser_fire_down/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if not GM.instance_exists(A.obj_invincibility):
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_bowser_fire_down/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_smokespin
	instance_destroy()


# from objects/obj_bowser_fire_down/Other_14.gml
func _user_4() -> void:
	var solidtop
	var solidpow
	var solidthwomp
	var solidmuncher
	var solidpinchos
	if vspeed >= 0.0:
		solidtop = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		solidpow = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_block_pow_hold, false, false)
		solidthwomp = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_thwomp, false, false)
		solidmuncher = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_muncher, false, false)
		solidpinchos = collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + vspeed), A.obj_pinchos, false, false)
		if solidtop != null and bbox_bottom < (solidtop.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0):
			y = (solidtop.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidmuncher != null and bbox_bottom < (solidmuncher.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0):
			y = (solidmuncher.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidpinchos != null and bbox_bottom < (solidpinchos.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0):
			y = (solidpinchos.y + floorf(((y - bbox_bottom) - 0.9)))
		if solidthwomp != null and bbox_bottom < (solidthwomp.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0):
			y = (solidthwomp.y + floorf(((y - bbox_bottom) - 16.0)))
		if solidpow != null and bbox_bottom < (solidpow.yprevious + 5.0) and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0 and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0):
			y = (solidpow.y + floorf(((y - bbox_bottom) - 0.9)))
		if vspeed > 4.0:
			vspeed = 4.0
	if collision_rectangle(bbox_left, bbox_bottom, bbox_right, (bbox_bottom + 4.0), A.obj_slopeparent, true, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_slopeparent, true, false) == null) and vspeed == 0.0:
		y += 4.0
	if collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 8.0), bbox_right, (bbox_bottom - 8.0), A.obj_slopeparent, true, false) == null):
		while collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, bbox_bottom, A.obj_slopeparent, true, false) != null:
			y -= 1.0
	if (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_block_pow_hold, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_block_pow_hold, false, false) == null) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_thwomp, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_thwomp, false, false) == null) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_muncher, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_muncher, false, false) == null) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0)) or (collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_pinchos, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_pinchos, false, false) == null) and y > (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0)) or collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_slopeparent, true, false) != null:
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
		if destruir == 0.0:
			alarm[0] = 180.0
			destruir = 1.0
	elif y >= (GM.room_height - 24.0) and float(GM.layer_background_get_sprite(Scr.scr_bg_underwater(self))) > 0.5 and GM.instance_find(A.obj_levelmanager, 0).editor == 0.0:
		_user_0()
	elif swimming <= 0.5:  # GML: !swimming
		gravity = 0.1
		if vspeed > 1.4:
			vspeed = 1.4
	elif swimming == 1.0:
		gravity = 0.1
		if vspeed > 0.4:
			vspeed = 0.4
	if (vspeed < 0.0 and collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_solid, true, false) != null) or (vspeed < 0.0 and collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false) != null):
		vspeed = 0.0
	if (bbox_top - 16.0) > GM.room_height:
		instance_destroy()


# from objects/obj_bowser_fire_down/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, image_index, GM.gm_round(x), y, 1.0, 1.0, 0.0, GM.c_white, 1.0)
