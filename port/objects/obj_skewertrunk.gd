# from objects/obj_skewertrunk（第 6b 批移植，已核对）
extends "res://objects/obj_deactivation.gd"


var skewer_down: int = 0  ## sprite 编号
var skewer_up: int = 0  ## sprite 编号
var skewer_left: int = 0  ## sprite 编号
var skewer_right: int = 0  ## sprite 编号
var parent_y: float = 0.0  # scr_edit_to_play 写入（direct_t 为 2/4 时存的是 x 坐标）
var ready_v: float = 0.0  # PORT: 原名 ready，和 Node.ready 撞名
var direct_t: float = 0.0  # scr_edit_to_play 写入
var rotacion: float = 0.0  # scr_edit_to_play 写入
var vuelta: float = 0.0
var groundpount_cont: float = 0.0
var player = null


# from objects/obj_skewertrunk/Create_0.gml
func _create() -> void:
	var dark  # 局部变量提升（GML 的 var 是函数作用域）
	if G.apariencia == 3.0:
		sprite_index = A.spr_NSMBU_skewertrunk
		skewer_down = A.spr_NSMBU_skewer_down
		skewer_up = A.spr_NSMBU_skewer_up
		skewer_left = A.spr_NSMBU_skewer_left
		skewer_right = A.spr_NSMBU_skewer_right
	else:
		sprite_index = A.spr_skewertrunk
		skewer_down = A.spr_skewer_down
		skewer_up = A.spr_skewer_up
		skewer_left = A.spr_skewer_left
		skewer_right = A.spr_skewer_right
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		dark = 1.0
	else:
		dark = 0.0
	match G.apariencia:
		0.0:
			if dark == 1.0:
				image_index = 1.0
			else:
				image_index = 0.0
		1.0:
			if dark == 1.0:
				image_index = 3.0
			else:
				image_index = 2.0
		2.0:
			image_index = 4.0
	image_speed = 0.0
	parent_y = (y - 32.0)
	ready_v = 0.0
	direct_t = 1.0
	rotacion = 0.0
	vuelta = 1.0
	groundpount_cont = 0.0
	alarm[0] = 60.0


# from objects/obj_skewertrunk/Destroy_0.gml
func _destroy() -> void:
	GM.audio_stop_sound(A.snd_skewer1)
	GM.audio_stop_sound(A.snd_skewer2)
	GM.audio_stop_sound(A.snd_skewer3)
	GM.audio_stop_sound(A.snd_skewer4)
	GM.audio_stop_sound(A.snd_skewer5)


# from objects/obj_skewertrunk/Step_0.gml
func _step() -> void:
	match ready_v:
		1.0:
			match direct_t:
				1.0:
					if y <= (ystart - 32.0):
						vspeed = 0.0
						y = (ystart - 32.0)
						alarm[1] = 60.0
						ready_v = 2.0
				2.0:
					if x <= (xstart - 32.0):
						hspeed = 0.0
						x = (xstart - 32.0)
						alarm[1] = 60.0
						ready_v = 2.0
				3.0:
					if y >= (ystart + 32.0):
						vspeed = 0.0
						y = (ystart + 32.0)
						alarm[1] = 60.0
						ready_v = 2.0
				4.0:
					if x >= (xstart + 32.0):
						hspeed = 0.0
						x = (xstart + 32.0)
						alarm[1] = 60.0
						ready_v = 2.0
		3.0:
			event_user(int(direct_t))
		5.0:
			match direct_t:
				1.0:
					if y <= ystart:
						vspeed = 0.0
						y = ystart
						alarm[0] = 120.0
						ready_v = 0.0
						_user_6()
				2.0:
					if x <= xstart:
						hspeed = 0.0
						x = xstart
						alarm[0] = 120.0
						ready_v = 0.0
						_user_6()
				3.0:
					if y >= ystart:
						vspeed = 0.0
						y = ystart
						alarm[0] = 120.0
						ready_v = 0.0
						_user_6()
				4.0:
					if x >= xstart:
						hspeed = 0.0
						x = xstart
						alarm[0] = 120.0
						ready_v = 0.0
						_user_6()


# from objects/obj_skewertrunk/Step_2.gml
func _step_end() -> void:
	match direct_t:
		1.0:
			player = collision_rectangle((bbox_left + 3.0), parent_y, (bbox_right - 3.0), bbox_bottom, A.obj_mario, true, false)
			if player != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(player):
					inst.event_user(0)
				GM.other = _o
		2.0:
			player = collision_rectangle(parent_y, (bbox_top + 5.0), bbox_right, (bbox_bottom - 5.0), A.obj_mario, false, true)
			if player != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(player):
					inst.event_user(0)
				GM.other = _o
		3.0:
			player = collision_rectangle((bbox_left + 3.0), bbox_top, (bbox_right - 3.0), parent_y, A.obj_mario, true, false)
			if player != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(player):
					inst.event_user(0)
				GM.other = _o
		4.0:
			player = collision_rectangle(bbox_left, (bbox_top + 5.0), parent_y, (bbox_bottom - 5.0), A.obj_mario, false, false)
			if player != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(player):
					inst.event_user(0)
				GM.other = _o
	_user_0()


# from objects/obj_skewertrunk/Alarm_0.gml
func _alarm_0() -> void:
	match direct_t:
		1.0:
			vspeed = -1.0
		2.0:
			hspeed = -1.0
		3.0:
			vspeed = 1.0
		4.0:
			hspeed = 1.0
	if G.apariencia == 3.0:
		vuelta = 1.0
		image_speed = 0.5
		GM.audio_stop_sound(A.snd_skewer1)
		GM.audio_play_sound(A.snd_skewer1, 0.0, false)
	ready_v = 1.0


# from objects/obj_skewertrunk/Alarm_1.gml
func _alarm_1() -> void:
	ready_v = 3.0
	if G.apariencia == 3.0:
		vuelta = 2.0
		image_speed = 0.6
		GM.audio_stop_sound(A.snd_skewer2)
		GM.audio_play_sound(A.snd_skewer2, 1.0, true)


# from objects/obj_skewertrunk/Alarm_2.gml
func _alarm_2() -> void:
	match direct_t:
		1.0:
			vspeed = -1.0
		2.0:
			hspeed = -1.0
		3.0:
			vspeed = 1.0
		4.0:
			hspeed = 1.0
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_skewer2)
		GM.audio_stop_sound(A.snd_skewer4)
		GM.audio_play_sound(A.snd_skewer4, 1.0, true)
	ready_v = 5.0


# from objects/obj_skewertrunk/Collision_obj_thwomp_b.gml
func _collision_obj_thwomp_b(other: GMObject) -> void:
	# ORIG-BUG: 原版 with obj_thwomp_b（不是 with other），碰到一个就让场上全部 obj_thwomp_b 执行 event_user(0)（死亡），照搬
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_thwomp_b):
		inst.event_user(0)
	GM.other = _o


# from objects/obj_skewertrunk/Other_7.gml
func _animation_end() -> void:
	vuelta -= 1.0
	if vuelta == 0.0:
		image_speed = 0.0
		image_index = 0.0


# from objects/obj_skewertrunk/Other_10.gml
func _user_0() -> void:
	var block  # 局部变量提升（GML 的 var 是函数作用域）
	var rock  # 局部变量提升（GML 的 var 是函数作用域）
	if groundpount_cont > 0.0:
		groundpount_cont -= 1.0
		match direct_t:
			1.0:
				rock = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_rockparent, false, false)
				block = collision_rectangle(bbox_left, (bbox_bottom + 2.0), bbox_right, ((bbox_bottom + vspeed) + 2.0), A.obj_blockparent, false, false)
			2.0:
				rock = collision_rectangle((bbox_right + 2.0), bbox_top, ((bbox_right + hspeed) + 2.0), bbox_bottom, A.obj_rockparent, false, false)
				block = collision_rectangle((bbox_right + 2.0), bbox_top, ((bbox_right + hspeed) + 2.0), bbox_bottom, A.obj_blockparent, false, false)
			3.0:
				rock = collision_rectangle(bbox_left, ((bbox_bottom + vspeed) - 2.0), bbox_right, (bbox_top - 2.0), A.obj_rockparent, false, false)
				block = collision_rectangle(bbox_left, ((bbox_bottom + vspeed) - 2.0), bbox_right, (bbox_top - 2.0), A.obj_blockparent, false, false)
			4.0:
				rock = collision_rectangle(((bbox_left + hspeed) - 2.0), bbox_top, bbox_left, bbox_bottom, A.obj_rockparent, false, false)
				block = collision_rectangle(((bbox_left + hspeed) - 2.0), bbox_top, bbox_left, bbox_bottom, A.obj_blockparent, false, false)
		if rock != null:
			for inst in GM.with_list(rock):
				inst.alarm[0] = 1.0
		if block != null:
			if block.object_index == A.obj_noteblock or block.object_index == A.obj_musicblock or block.object_index == A.obj_noteblock_s or block.object_index == A.obj_onoffblock:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(block):
					inst.event_user(3)
				GM.other = _o
			else:
				for inst in GM.with_list(block):
					inst.alarm[2] = 1.0


# from objects/obj_skewertrunk/Other_11.gml
func _user_1() -> void:
	var brick  # 局部变量提升（GML 的 var 是函数作用域）
	if vspeed >= 0.0 and y >= ystart:
		var semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_physicssolid, false, false)
		brick = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_flipblock, false, false)
		if (semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0) and semisolid.object_index != A.obj_flipblock) or (semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0) and semisolid.object_index != A.obj_flipblock and brick != null):
			y = (semisolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
		if physolid != null and bbox_bottom < (physolid.yprevious + 5.0):
			y = (physolid.bbox_top - (GM.sprite_get_bbox_bottom(sprite_index) - GM.sprite_get_yoffset(sprite_index)))
	var solidtop = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false)
	brick = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_flipblock, false, false)
	if y >= ystart and ((solidtop != null and solidtop.object_index != A.obj_flipblock) or (solidtop != null and solidtop.object_index != A.obj_flipblock and brick != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null)) or (collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_physicssolid, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_physicssolid, false, false) == null))):
		gravity = 0.0
		if vspeed > 0.0:
			vspeed = 0.0
			_user_5()
			if G.apariencia == 3.0:
				for inst in GM.with_list(GM.instance_create(x, bbox_bottom, A.obj_smoke)):
					inst.sprite_index = A.spr_NSMBU_smoke_thwomp
					inst.depth = -3.0
			else:
				GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
				GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
			var col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
			if col_one_top != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_top):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			alarm[2] = 60.0
			ready_v = 4.0
	elif y > (GM.room_height + 16.0) and y >= ystart:
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		vspeed = 0.0
		alarm[2] = 60.0
		ready_v = 4.0
	elif y >= (ystart + 128.0):
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		vspeed = 0.0
		y = (ystart + 128.0)
		alarm[2] = 60.0
		ready_v = 4.0
	elif vspeed > 5.0:
		vspeed = 5.0
	else:
		vspeed += 0.5


# from objects/obj_skewertrunk/Other_12.gml
func _user_2() -> void:
	var brick  # 局部变量提升（GML 的 var 是函数作用域）
	if hspeed >= 0.0 and x > xstart:
		var ssolid = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_solid, false, false)
		var solidphy = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_physicssolid, false, false)
		var bullet = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_bullebill_base, false, false)
		var oneway = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_onewaygate_left, false, false)
		brick = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + hspeed), bbox_bottom, A.obj_flipblock, false, false)
		if (ssolid != null and bbox_right < (ssolid.xprevious + 5.0) and ssolid.object_index != A.obj_flipblock) or (ssolid != null and bbox_right < (ssolid.xprevious + 5.0) and ssolid.object_index != A.obj_flipblock and brick != null):
			x = (ssolid.bbox_left - 16.0)
		if solidphy != null and bbox_right < (solidphy.xprevious + 5.0):
			x = (solidphy.bbox_left - 16.0)
		if bullet != null and bbox_right < (bullet.xprevious + 5.0):
			x = (bullet.bbox_left - 16.0)
		if oneway != null and bbox_right < (oneway.xprevious + 5.0):
			x = (oneway.bbox_left - 16.0)
	var solidtop = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_solid, false, false)
	brick = collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_flipblock, false, false)
	if x > xstart and ((solidtop != null and solidtop.object_index != A.obj_flipblock) or (solidtop != null and solidtop.object_index != A.obj_flipblock and brick != null) or collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_right + 1.0), bbox_top, (bbox_right + 1.0), bbox_bottom, A.obj_onewaygate_left, false, false) != null):
		hspeed = 0.0
		_user_5()
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x + 16.0), y, A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_thwomp
				inst.depth = -3.0
				inst.image_angle = 90.0
		else:
			GM.instance_create((bbox_right - 8.0), (bbox_top + 8.0), A.obj_smoke)
			GM.instance_create((bbox_right - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
		var col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
		if col_one_left != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_left):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		alarm[2] = 60.0
		ready_v = 4.0
	elif (x < (GM.camera_get_view_x(GM.view_get_camera(0))) + 16.0) and x <= xstart:
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		hspeed = 0.0
		alarm[2] = 60.0
		ready_v = 4.0
	elif x >= (xstart + 128.0):
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		hspeed = 0.0
		x = (xstart + 128.0)
		alarm[2] = 60.0
		ready_v = 4.0
	elif hspeed > 5.0:
		hspeed = 5.0
	else:
		hspeed += 0.5


# from objects/obj_skewertrunk/Other_13.gml
func _user_3() -> void:
	var brick  # 局部变量提升（GML 的 var 是函数作用域）
	if vspeed <= 0.0 and y <= ystart:
		var semisolid = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top - 1.0), A.obj_solidtop, false, false)
		var physolid = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top - 1.0), A.obj_physicssolid, false, false)
		var bullet = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top - 1.0), A.obj_bullebill_base, false, false)
		var oneway = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top - 1.0), A.obj_onewaygate_bottom, false, false)
		brick = collision_rectangle(bbox_left, (bbox_top + vspeed), bbox_right, (bbox_top - 1.0), A.obj_flipblock, false, false)
		if (semisolid != null and bbox_top > (semisolid.yprevious - 5.0) and semisolid.object_index != A.obj_flipblock) or (semisolid != null and bbox_top > (semisolid.yprevious - 5.0) and semisolid.object_index != A.obj_flipblock and brick != null):
			y = (semisolid.bbox_bottom + 16.0)
		if physolid != null and bbox_top > (physolid.yprevious - 5.0):
			y = (physolid.bbox_bottom + 16.0)
		if bullet != null and bbox_top > (bullet.yprevious - 5.0):
			y = (bullet.bbox_bottom + 16.0)
		if oneway != null and bbox_top > (oneway.yprevious - 5.0):
			y = (oneway.bbox_bottom + 16.0)
	var solidtop = collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, false, false)
	brick = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_flipblock, false, false)
	if y <= ystart and ((solidtop != null and solidtop.object_index != A.obj_flipblock) or (solidtop != null and solidtop.object_index != A.obj_flipblock and brick != null) or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_top + 1.0), A.obj_physicssolid, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_top + 1.0), A.obj_bullebill_base, false, false) != null or collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, (bbox_top + 1.0), A.obj_onewaygate_bottom, false, false) != null):
		gravity = 0.0
		if vspeed < 0.0:
			vspeed = 0.0
			_user_5()
			if G.apariencia == 3.0:
				for inst in GM.with_list(GM.instance_create(x, bbox_top, A.obj_smoke)):
					inst.sprite_index = A.spr_NSMBU_smoke_thwomp
					inst.depth = -3.0
			else:
				GM.instance_create((bbox_left - 8.0), (bbox_top - 8.0), A.obj_smoke)
				GM.instance_create((bbox_right - 8.0), (bbox_top - 8.0), A.obj_smoke)
			var col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
			if col_one_bottom != null:
				var _o: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_bottom):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o
			alarm[2] = 60.0
			ready_v = 4.0
	elif y < -16.0 and y <= ystart:
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		vspeed = 0.0
		alarm[2] = 60.0
		ready_v = 4.0
	elif y <= (ystart - 128.0):
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		vspeed = 0.0
		y = (ystart - 128.0)
		alarm[2] = 60.0
		ready_v = 4.0
	elif vspeed < -5.0:
		vspeed = -5.0
	else:
		vspeed -= 0.5


# from objects/obj_skewertrunk/Other_14.gml
func _user_4() -> void:
	var brick  # 局部变量提升（GML 的 var 是函数作用域）
	if hspeed <= 0.0 and x < xstart:
		var ssolid = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_solid, false, false)
		var solidphy = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_physicssolid, false, false)
		var bullet = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_bullebill_base, false, false)
		var oneway = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_onewaygate_right, false, false)
		brick = collision_rectangle((bbox_left + hspeed), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_flipblock, false, false)
		if (ssolid != null and bbox_left > (ssolid.xprevious - 5.0) and ssolid.object_index != A.obj_flipblock) or (ssolid != null and bbox_left > (ssolid.xprevious - 5.0) and ssolid.object_index != A.obj_flipblock and brick != null):
			x = (ssolid.bbox_right + 16.0)
		if solidphy != null and bbox_left > (solidphy.xprevious - 5.0):
			x = (solidphy.bbox_right + 16.0)
		if bullet != null and bbox_left > (bullet.xprevious - 5.0):
			x = (bullet.bbox_right + 16.0)
		if oneway != null and bbox_left > (oneway.xprevious - 5.0):
			x = (oneway.bbox_right + 16.0)
	var solidtop = collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_solid, false, false)
	brick = collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_flipblock, false, false)
	if x < xstart and ((solidtop != null and solidtop.object_index != A.obj_flipblock) or (solidtop != null and solidtop.object_index != A.obj_flipblock and brick != null) or collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_physicssolid, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_bullebill_base, false, false) != null or collision_rectangle((bbox_left - 1.0), bbox_top, (bbox_left - 1.0), bbox_bottom, A.obj_onewaygate_left, false, false) != null):
		hspeed = 0.0
		_user_5()
		if G.apariencia == 3.0:
			for inst in GM.with_list(GM.instance_create((x - 16.0), y, A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_smoke_thwomp
				inst.depth = -3.0
				inst.image_angle = 90.0
		else:
			GM.instance_create((bbox_left - 8.0), (bbox_top + 8.0), A.obj_smoke)
			GM.instance_create((bbox_left - 8.0), (bbox_bottom - 8.0), A.obj_smoke)
		var col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
		if col_one_right != null:
			var _o: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(col_one_right):
				inst.rot = 1.0
				inst.event_user(0)
			GM.other = _o
		alarm[2] = 60.0
		ready_v = 4.0
	elif x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 16.0) and x <= xstart:
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		hspeed = 0.0
		alarm[2] = 60.0
		ready_v = 4.0
	elif x <= (xstart - 128.0) or (x < (GM.camera_get_view_x(GM.view_get_camera(0)) - 16.0) and x <= xstart):
		if G.apariencia == 3.0:
			GM.audio_stop_sound(A.snd_skewer2)
			GM.audio_stop_sound(A.snd_skewer3)
			GM.audio_play_sound(A.snd_skewer3, 0.0, false)
		hspeed = 0.0
		x = (xstart - 128.0)
		alarm[2] = 60.0
		ready_v = 4.0
	elif hspeed < -5.0:
		hspeed = -5.0
	else:
		hspeed -= 0.5


# from objects/obj_skewertrunk/Other_15.gml
func _user_5() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_skewer2)
		GM.audio_stop_sound(A.snd_skewer3)
		GM.audio_play_sound(A.snd_skewer3, 0.0, false)
	else:
		GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
		GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
	Scr.init_shake(self, 1.0)
	groundpount_cont = 4.0


# from objects/obj_skewertrunk/Other_16.gml
func _user_6() -> void:
	if G.apariencia == 3.0:
		GM.audio_stop_sound(A.snd_skewer4)
		GM.audio_stop_sound(A.snd_skewer5)
		GM.audio_play_sound(A.snd_skewer5, 0.0, false)


# from objects/obj_skewertrunk/Draw_0.gml
func _gm_draw() -> void:
	match direct_t:
		1.0:
			Scr.draw_sprite_tiled_area_ext(self, skewer_down, image_index, (GM.gm_round(x) - 32.0), GM.gm_round(y), (x - 32.0), parent_y, (x + 32.0), y, GM.c_white, 1.0)
			GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
		2.0:
			Scr.draw_sprite_tiled_area_ext(self, skewer_right, image_index, GM.gm_round(x), (GM.gm_round(y) - 32.0), parent_y, (y - 32.0), x, (y + 32.0), GM.c_white, 1.0)
			GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
		3.0:
			Scr.draw_sprite_tiled_area_ext(self, skewer_up, image_index, (GM.gm_round(x) - 32.0), GM.gm_round(y), (x - 32.0), y, (x + 32.0), parent_y, GM.c_white, 1.0)
			GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
		4.0:
			Scr.draw_sprite_tiled_area_ext(self, skewer_left, image_index, GM.gm_round(x), (GM.gm_round(y) - 32.0), x, (y - 32.0), parent_y, (y + 32.0), GM.c_white, 1.0)
			GM.draw_sprite_ext(sprite_index, image_index, x, y, 1.0, 1.0, rotacion, GM.c_white, 1.0)
