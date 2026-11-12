# from objects/obj_pswitch（第 5 批移植，已核对）
# PORT: mytop 在“没有”时存 A.obj_lighting（int，原版用 obj_lighting 当占位），有时存实例。
# GDScript 里 Object 和 int 用 ==/!= 比较会报运行时错误，所以占位判断统一写 is_same()。
extends "res://objects/obj_holdparent.gd"

var sprite_wings: float = 0.0
var press: float = 0.0
var mytop = null
var wings: float = 0.0
var wings_anim: float = 0.0
var mario2 = null


# from objects/obj_pswitch/Create_0.gml
func _create() -> void:
	super._create()
	match G.apariencia:
		0.0:
			sprite_index = A.spr_SMB_pswitch
			image_speed = 0.15
			sprite_wings = A.spr_SMB_wings_16x16
		1.0:
			sprite_index = A.spr_SMB3_pswitch
			image_speed = 0.15
			sprite_wings = A.spr_SMB3_wings2
		2.0:
			sprite_index = A.spr_pswitch
			image_speed = 0.15
			sprite_wings = A.spr_wings_items
		3.0:
			sprite_index = A.spr_NSMBU_pswitch
			image_speed = 0.3
			sprite_wings = A.spr_NSMBU_wings_items
	inup = 0.0
	press = 0.0
	mytop = GM.instance_create(x, y, A.obj_solidtop)
	wings = 0.0
	wings_anim = 0.0
	alarm[10] = 4.0


# from objects/obj_pswitch/Destroy_0.gml
func _destroy() -> void:
	super._destroy()
	if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()


# from objects/obj_pswitch/Step_0.gml
func _step() -> void:
	var col_estalactita
	var col_mario_left
	var col_mario_right
	var i_levelmanager = GM.instance_find(A.obj_levelmanager, 0)
	var i_mario = GM.instance_find(A.obj_mario, 0)
	var i_lava_water = GM.instance_find(A.obj_lava_water, 0)
	if y < -20.0 and vspeed < 0.0:
		y = -20.0
	if GM.instance_exists(A.obj_levelmanager) and i_levelmanager.editor == 0.0 and held == 0.0 and inup == 1.0:
		if not place_meeting(x, (y - 16.0), A.obj_solid):
			inup = 0.0
	mario2 = collision_rectangle(bbox_left, (bbox_top - 1.0), bbox_right, bbox_top, A.obj_mario, true, false)
	if mario2 != null and held == 0.0 and inup == 0.0 and inmune == 0.0 and mario2.bbox_bottom < ((bbox_top - vspeed) + 5.0) and mario2.vspeed >= 0.0:
		_user_7()
	col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6.0), bbox_right, bbox_top, A.obj_icicle, true, false)
	if col_estalactita != null and col_estalactita.vspeed > 0.0 and held == 0.0 and inup == 0.0:
		_user_7()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(col_estalactita):
			inst.event_user(0)
		GM.other = _o
	if held == 0.0:
		col_mario_left = collision_rectangle((bbox_left - 6.0), (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_mario, false, false)
		col_mario_right = collision_rectangle(bbox_right, (bbox_top + 4.0), (bbox_right + 6.0), (bbox_bottom - 4.0), A.obj_mario, false, false)
		if GM.instance_exists(A.obj_mario) and ((col_mario_left != null and i_mario.direct == 1.0) or (col_mario_right != null and i_mario.direct == -1.0)) and Scr.scr_canhold(self) > 0.5 and inmune == 0.0 and inup == 0.0:
			if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
				for inst in GM.with_list(mytop):
					inst.instance_destroy()
				mytop = A.obj_lighting
			for inst in GM.with_list(A.obj_mario):
				inst.holding = 2.0
			if wings == 1.0:
				for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
					inst.direct = -1.0
				for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
					inst.sprite_index = A.spr_wings_dead2
					inst.direct = -1.0
				wings = 0.0
			if G.apariencia == 2.0 and i_mario.isduck == 1.0:
				for inst in GM.with_list(A.obj_mario):
					inst.isduckhold = 1.0
			if G.apariencia == 3.0:
				GM.audio_play_sound(GM.choose(A.snd_NSMBU_hold1, A.snd_NSMBU_hold2), 0.0, false)
				for inst in GM.with_list(GM.other):  # UNSURE: Step 事件里的 other.id，原版意图疑为 obj_mario；按字面取 GM.other（U14，同 obj_holdparent/Step_0）
					# PORT: 此处 GM.other 是本实例（obj_pswitch），它没有声明 triple_jump/triple_count，直接赋值会报错，改用 set()（不存在时静默无效）
					inst.triple_jump = 0.0
					inst.triple_count = 0.0
			held = 1.0
			depth = -7.0
			gravity = 0.0
			speed = 0.0
		if G.bg_level == "underwater" or (G.bg_level == "sky" and G.modo_noche == 1.0) or (G.bg_level == "airship" and G.modo_noche == 1.0) or (GM.instance_exists(A.obj_lava_water) and y > (i_lava_water.y + 16.0) and ((G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach")):
			swimming = 1.0
		else:
			swimming = 0.0
		if GM.instance_exists(A.obj_mario):
			if inwall == 0.0:
				_user_3()
				_user_4()
				if gravity == 0.0:
					if swimming == 0.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.145)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.145:
							hspeed = 0.0
					elif swimming == 1.0:
						hspeed = (maxf(0.0, (absf(hspeed) - 0.245)) * GM.gm_sign(hspeed))
						if absf(hspeed) < 0.244:
							hspeed = 0.0
			else:
				gravity /= 2.0
				if vspeed > 1.0:
					vspeed = 1.0
				hspeed = 0.0
				while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x -= 1.0
				while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
					x += 1.0
				if collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_right, (bbox_bottom - 1.0), A.obj_solid, false, false) == null:
					inwall = 0.0
		elif GM.instance_exists(A.obj_deadmario):
			vspeed = 0.0
			gravity = 0.0
		else:
			_user_3()
			_user_4()
		if GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= (i_lava_water.y - 12.0) and G.bg_level == "castle" and modo_lava == 0.0:
			if G.apariencia != 0.0:
				GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_lava)
			modo_lava = 1.0
		elif GM.instance_exists(A.obj_lava_water) and (bbox_bottom - 8.0) >= i_lava_water.y and G.bg_level == "forest" and G.modo_noche == 1.0 and modo_lava == 0.0:
			if G.apariencia != 0.0:
				GM.instance_create((x + 8.0), (i_lava_water.y - 26.0), A.obj_splash_posion)
			modo_lava = 1.0
		elif y > GM.room_height and held == 0.0:
			instance_destroy()
		if GM.instance_exists(A.obj_lava_water) and (y + 8.0) <= (i_lava_water.y - 12.0) and i_lava_water.vspeed > 0.0 and (modo_lava == 1.0 or swimming == 1.0):
			y = (i_lava_water.y - 20.0)
		if not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop) and GM.instance_exists(A.obj_mario):
			mytop.x = x
			mytop.y = ((y + 1.0) + vspeed)
	elif not is_same(mytop, A.obj_lighting) and GM.instance_exists(mytop):
		for inst in GM.with_list(mytop):
			inst.instance_destroy()
		mytop = A.obj_lighting
	if wings == 1.0:
		if not GM.instance_exists(A.obj_deadmario):
			if G.apariencia == 3.0:
				wings_anim += 0.5
			else:
				wings_anim += 0.12
		hspeed = -0.6
	if wings == 1.0:
		if y > (ystart + 16.0):
			if vspeed < -0.5:
				vspeed = -0.5
			else:
				vspeed -= 0.085
		elif y < (ystart - 16.0):
			if vspeed > 0.5:
				vspeed = 0.5
			else:
				vspeed += 0.085


# from objects/obj_pswitch/Alarm_1.gml
func _alarm_1() -> void:
	instance_destroy()


# from objects/obj_pswitch/Alarm_3.gml
func _alarm_3() -> void:
	inmune = 0.0
	if is_same(mytop, A.obj_lighting):
		mytop = GM.instance_create(x, y, A.obj_solidtop)


# from objects/obj_pswitch/Alarm_10.gml
func _alarm_10() -> void:
	if wings == 1.0:
		vspeed = -0.5
		depth = -7.0


# from objects/obj_pswitch/Collision_obj_bullebill_base.gml
func _collision_obj_bullebill_base(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and inup == 0.0 and other.vspeed >= 0.0 and held == 0.0:
		_user_7()


# from objects/obj_pswitch/Collision_obj_clown.gml
func _collision_obj_clown(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and other.vspeed >= 0.0 and inup == 0.0 and held == 0.0:
		_user_7()


# from objects/obj_pswitch/Collision_obj_enemyparent.gml
func _collision_obj_enemyparent(other: GMObject) -> void:
	if wings == 0.0:
		if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and inup == 0.0 and other.vspeed >= 0.0 and other.object_index != A.obj_grinder and other.object_index != A.obj_boo and other.object_index != A.obj_podoboo and other.object_index != A.obj_magikoopa and other.object_index != A.obj_banzaibill and other.object_index != A.obj_bulletbill and other.object_index != A.obj_cannonball and other.object_index != A.obj_cannonball_red and held == 0.0:
			_user_7()


# from objects/obj_pswitch/Collision_obj_enemyparent_held.gml
func _collision_obj_enemyparent_held(other: GMObject) -> void:
	if inup == 1.0 and other.vspeed < 0.0 and other.held == 0.0:
		_user_6()
		for inst in GM.with_list(other):
			inst.vspeed = 0.0


# from objects/obj_pswitch/Collision_obj_icicle.gml
func _collision_obj_icicle(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and inup == 0.0 and other.vspeed >= 0.0 and held == 0.0:
		_user_7()
		var _o: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o


# from objects/obj_pswitch/Collision_obj_link_arrow.gml
func _collision_obj_link_arrow(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and inup == 0.0 and other.vspeed >= 0.0 and held == 0.0:
		_user_7()
		var _o2: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o2


# from objects/obj_pswitch/Collision_obj_mario.gml
func _collision_obj_mario(other: GMObject) -> void:
	if inup == 0.0:
		super._collision_obj_mario(other)


# from objects/obj_pswitch/Collision_obj_physicssolid.gml
func _collision_obj_physicssolid(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and inup == 0.0 and other.vspeed >= 0.0 and held == 0.0:
		_user_7()


# from objects/obj_pswitch/Collision_obj_superball.gml
func _collision_obj_superball(other: GMObject) -> void:
	if other.bbox_bottom < ((bbox_top - vspeed) + 5.0) and held == 0.0:
		_user_7()
		var _o3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(other):
			inst.event_user(0)
		GM.other = _o3


# from objects/obj_pswitch/Other_11.gml
func _user_1() -> void:
	pass


# from objects/obj_pswitch/Other_13.gml
func _user_3() -> void:
	if wings == 0.0:
		var solidphy_right
		var solidphy_left
		var col_one_left
		var col_one_right
		solidphy_right = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solidphy, false, false)
		solidphy_left = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solidphy, false, false)
		if (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, false, false) != null) or (hspeed > 0.0 and solidphy_right != null and ((not is_same(mytop, A.obj_lighting) and solidphy_right != mytop) or is_same(mytop, A.obj_lighting))) or (hspeed < 0.0 and solidphy_left != null and ((not is_same(mytop, A.obj_lighting) and solidphy_left != mytop) or is_same(mytop, A.obj_lighting))) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_helmet, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_helmet, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, false, false) != null) or (hspeed > 0.0 and collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false) != null) or (hspeed < 0.0 and collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false) != null):
			col_one_left = collision_rectangle(bbox_right, (bbox_top + 1.0), (bbox_right + 1.0), (bbox_bottom - 4.0), A.obj_onewaygate_left, false, false)
			col_one_right = collision_rectangle((bbox_left - 1.0), (bbox_top + 1.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, false, false)
			if hspeed > 0.0 and col_one_left != null:
				var _o4: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_left):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o4
			if hspeed < 0.0 and col_one_right != null:
				var _o5: GMObject = GM.other
				GM.other = self
				for inst in GM.with_list(col_one_right):
					inst.rot = 1.0
					inst.event_user(0)
				GM.other = _o5
			hspeed = 0.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_solid, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_hurtsolid2, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_hurtsolid2, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_bullebill_base, true, false) != null:
				x += 1.0
			while collision_rectangle(bbox_right, (bbox_top + 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_onewaygate_left, true, false) != null:
				x -= 1.0
			while collision_rectangle(bbox_left, (bbox_top + 4.0), bbox_left, (bbox_bottom - 4.0), A.obj_onewaygate_right, true, false) != null:
				x += 1.0


# from objects/obj_pswitch/Other_14.gml
func _user_4() -> void:
	var semisolid
	var col_one_top
	var solidphy
	var col_one_bottom
	var block
	if inup == 0.0 and wings == 0.0:
		if vspeed >= 0.0:
			semisolid = collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + vspeed), A.obj_solidtop, false, false)
			if semisolid != null and bbox_bottom < (semisolid.yprevious + 5.0):
				y = (semisolid.bbox_top - (sprite_height - GM.sprite_get_yoffset(sprite_index)))
			if vspeed > 4.0:
				vspeed = 4.0
		if collision_rectangle(bbox_left, (bbox_bottom - 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_solidtop, false, false) != null and (collision_rectangle(bbox_left, (bbox_bottom - 4.0), bbox_right, (bbox_bottom - 4.0), A.obj_solidtop, false, false) == null):
			gravity = 0.0
			if vspeed > 0.0:
				if bouncy == 1.0:
					if vspeed > 0.5:
						vspeed = ((-vspeed) / 2.0)
					else:
						vspeed = 0.0
						bouncy = 0.0
				else:
					vspeed = 0.0
				col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1.0), bbox_right, (bbox_bottom + 1.0), A.obj_onewaygate_top, false, false)
				if col_one_top != null:
					var _o6: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_one_top):
						inst.rot = 1.0
						inst.event_user(0)
					GM.other = _o6
		elif modo_lava == 1.0:
			hspeed = 0.0
			gravity = 0.02
			if vspeed > 0.03:
				vspeed = 0.03
		elif swimming <= 0.5:
			gravity = 0.2
			if vspeed > 4.0:
				vspeed = 4.0
		elif swimming == 1.0:
			gravity = 0.02
			if vspeed > 1.0:
				vspeed = 1.0
		if vspeed < 0.0:
			solidphy = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solidphy, true, false)
			if collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_solid, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_hurtsolid2, true, false) != null or (solidphy != null and not is_same(mytop, A.obj_lighting) and solidphy != mytop) or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_bullebill_base, true, false) != null or collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top, A.obj_onewaygate_bottom, true, false) != null:
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solid, true, false) != null and (not place_meeting(x, y, A.obj_solid)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_hurtsolid2, true, false) != null and (not place_meeting(x, y, A.obj_hurtsolid2)):
					y += 1.0
				while collision_rectangle(bbox_left, (bbox_top + 1.0), bbox_right, (bbox_top + 1.0), A.obj_solidphy, true, false) != null and (not place_meeting(x, y, A.obj_solidphy)):
					y += 1.0
				col_one_bottom = collision_rectangle((bbox_left + 1.0), ((bbox_top + vspeed) - 1.0), (bbox_right - 1.0), (bbox_top - 1.0), A.obj_onewaygate_bottom, true, false)
				if col_one_bottom != null:
					var _o7: GMObject = GM.other
					GM.other = self
					for inst in GM.with_list(col_one_bottom):
						inst.rot = 1.0
						inst.event_user(0)
					GM.other = _o7
				block = collision_rectangle(bbox_left, (bbox_top - 2.0), bbox_right, (bbox_top - 1.0), A.obj_blockparent, false, false)
				if block != null and (GM.object_get_parent(object_index) == A.obj_holdparent or GM.object_get_parent(object_index) == A.obj_enemyparent_held):
					if block.ready_v == 0.0:
						var _o8: GMObject = GM.other
						GM.other = self
						for inst in GM.with_list(block):
							inst.event_user(2)
						GM.other = _o8
				vspeed = 0.0
	elif inup == 1.0:
		gravity = 0.0
		vspeed = 0.0


# from objects/obj_pswitch/Other_16.gml
func _user_6() -> void:
	if press == 0.0:
		if G.apariencia == 3.0:
			GM.audio_play_sound(A.snd_NSMBU_switch, 0.0, false)
			for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
				inst.sprite_index = A.spr_NSMBU_ppress_anim
		else:
			GM.audio_play_sound(A.snd_warning, 0.0, false)
		sprite_index = A.spr_pswitch_press
		image_index = G.apariencia
		image_speed = 0.0
		var _o9: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_levelmanager):
			inst.pwarning = 0.0
			inst.alarm[10] = 600.0
			inst.event_user(1)
		GM.other = _o9
		press = 1.0
		alarm[1] = 10.0


# from objects/obj_pswitch/Other_17.gml
func _user_7() -> void:
	if G.apariencia == 3.0:
		for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
			inst.sprite_index = A.spr_NSMBU_ppress_anim
	GM.audio_play_sound(Scr.scr_snd_pwarning(self), 0.0, false)
	GM.instance_create(x, y, A.obj_pswitch_press)
	var _o10: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.pwarning = 0.0
		inst.alarm[10] = 600.0
		inst.event_user(1)
	GM.other = _o10
	instance_destroy()


# from objects/obj_pswitch/Draw_0.gml
func _gm_draw() -> void:
	if inup == 0.0:
		super._gm_draw()
	else:
		GM.draw_sprite_ext(sprite_index, image_index, (x + 16.0), (y + 16.0), 1.0, 1.0, 180.0, GM.c_white, 1.0)
	if wings == 1.0:
		if G.apariencia > 1.0:
			GM.draw_sprite(sprite_wings, wings_anim, x, y)
		else:
			GM.draw_sprite(sprite_wings, wings_anim, (x + 8.0), y)
