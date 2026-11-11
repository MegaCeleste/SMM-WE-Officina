# from scripts/scr_edit_to_play/scr_edit_to_play.gml
# 第 3 批移植。整个脚本 1:1；match 的 subject 一律用 float() 包起来（实例变量里的数值可能是 int，GDScript 的 match 区分 int/float）。
extends RefCounted



# from scripts/scr_edit_to_play/scr_edit_to_play.gml
static func scr_edit_to_play(me: GMObject):
	var h  # 局部变量提升（GML 的 var 是函数作用域）
	var posx_1  # 局部变量提升（GML 的 var 是函数作用域）
	var posy_1  # 局部变量提升（GML 的 var 是函数作用域）
	var py  # 局部变量提升（GML 的 var 是函数作用域）
	var scalex  # 局部变量提升（GML 的 var 是函数作用域）
	var scaley  # 局部变量提升（GML 的 var 是函数作用域）
	var truckx  # 局部变量提升（GML 的 var 是函数作用域）
	var trucky  # 局部变量提升（GML 的 var 是函数作用域）
	var plant
	if GM.instance_exists(A.obj_ground):
		for inst in GM.with_list(A.obj_ground):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_slopes):
		for inst in GM.with_list(A.obj_slopes):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_decoracion_1):
		for inst in GM.with_list(A.obj_decoracion_1):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_skewer_res):
		for inst in GM.with_list(A.obj_skewer_res):
			inst.visible = false
			match float(inst.direct_t):
				1.0:
					posx_1 = (inst.x - 32.0)
					posy_1 = (inst.y - 32.0)
					truckx = inst.x
					trucky = (inst.y + 16.0)
					py = (inst.y - 16.0)
				2.0:
					posx_1 = (inst.x - 32.0)
					posy_1 = (inst.y - 32.0)
					truckx = (inst.x + 16.0)
					trucky = inst.y
					py = (inst.x - 16.0)
				3.0:
					posx_1 = (inst.x - 32.0)
					posy_1 = (inst.y + 16.0)
					truckx = inst.x
					trucky = (inst.y - 16.0)
					py = (inst.y + 15.0)
				4.0:
					posx_1 = (inst.x + 16.0)
					posy_1 = (inst.y - 32.0)
					truckx = (inst.x - 16.0)
					trucky = inst.y
					py = (inst.x + 15.0)
			if inst.direct_t == 1.0 or inst.direct_t == 3.0:
				scalex = 4.0
				scaley = 1.0
			else:
				scalex = 1.0
				scaley = 4.0
			inst.pos_x = ((16.0 * scalex) / 2.0)
			inst.pos_y = ((16.0 * scaley) / 2.0)
			inst.skewer = GM.instance_create(posx_1, posy_1, A.obj_skewer)
			inst.skewer.image_xscale = scalex
			inst.skewer.image_yscale = scaley
			inst.skewer.rotacion = inst.rotacion
			inst.skewer.direct_t = inst.direct_t
			inst.skewer.posx = inst.pos_x
			inst.skewer.posy = inst.pos_y
			inst.skewertrunk = GM.instance_create(truckx, trucky, A.obj_skewertrunk)
			inst.skewertrunk.direct_t = inst.direct_t
			inst.skewertrunk.rotacion = inst.rotacion
			inst.skewertrunk.parent_y = py
			match float(inst.direct_t):
				2.0:
					inst.skewertrunk.mask_index = A.spr_mask_skewer_left
				3.0:
					inst.skewertrunk.mask_index = A.spr_mask_skewer_up
				4.0:
					inst.skewertrunk.mask_index = A.spr_mask_skewer_right
	if GM.instance_exists(A.obj_decoracion_2):
		for inst in GM.with_list(A.obj_decoracion_2):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_decoracion_3):
		for inst in GM.with_list(A.obj_decoracion_3):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_claw_res):
		for inst in GM.with_list(A.obj_claw_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), (inst.y + 34.0), A.obj_claw)
	if GM.instance_exists(A.obj_decoracion_4):
		for inst in GM.with_list(A.obj_decoracion_4):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_semisolid_platform1):
		for inst in GM.with_list(A.obj_semisolid_platform1):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_mushroom_platform_res):
		for inst in GM.with_list(A.obj_mushroom_platform_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_puente_res):
		for inst in GM.with_list(A.obj_puente_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_rails_res):
		for inst in GM.with_list(A.obj_rails_res):
			inst.visible = false
			if inst.sprout != 0.0:
				Scr.scr_sprite_make_object_rieles(inst, inst.drawX, inst.y, inst.sprout)
			inst.event_user(3)
	if GM.instance_exists(A.obj_platform_res):
		for inst in GM.with_list(A.obj_platform_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_platform_blue_res):
		for inst in GM.with_list(A.obj_platform_blue_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_vine_res):
		for inst in GM.with_list(A.obj_vine_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_pokey_res):
		for inst in GM.with_list(A.obj_pokey_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_bullebill_base_res):
		for inst in GM.with_list(A.obj_bullebill_base_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_bullebill_base_red_res):
		for inst in GM.with_list(A.obj_bullebill_base_red_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_parent_sounds):
		for inst in GM.with_list(A.obj_parent_sounds):
			inst.visible = false
			inst.event_user(3)
	if G.apariencia == 0.0:
		if GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "castle") and (not GM.instance_exists(A.obj_axe_smw)):
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 4.0), (GM.instance_find(A.obj_ground3, 0).y - 176.0), A.obj_flagpole)
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 80.0), (GM.instance_find(A.obj_ground3, 0).y - 48.0), A.obj_SMB_castle)
	elif G.apariencia == 1.0:
		if GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "castle") and (not GM.instance_exists(A.obj_axe_smw)):
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif (G.bg_level != "castle") and (not GM.instance_exists(A.obj_goalcard)):
				GM.instance_create(GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 64.0), A.obj_goalcard)
	elif G.apariencia == 2.0:
		if GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "castle") and (not GM.instance_exists(A.obj_axe_smw)):
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create(GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 137.0), A.obj_goalgate)
	elif G.apariencia == 3.0:
		if GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "castle") and (not GM.instance_exists(A.obj_axe_smw)):
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 8.0), (GM.instance_find(A.obj_ground3, 0).y - 170.0), A.obj_flagpole)
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 80.0), (GM.instance_find(A.obj_ground3, 0).y - 48.0), A.obj_SMB_castle)
	elif G.apariencia == 4.0:
		if GM.instance_exists(A.obj_ground3):
			if (G.bg_level == "castle") and (not GM.instance_exists(A.obj_axe_smw)):
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 64.0), (GM.instance_find(A.obj_ground3, 0).y - 32.0), A.obj_crystalorb)
	if GM.instance_exists(A.obj_tuberia_res):
		for inst in GM.with_list(A.obj_tuberia_res):
			inst.visible = false
			if inst.warp < 2.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_tuberia)):
					inst2.sprite = inst.sprite
					inst2.part = inst.part
					inst2.size = inst.size
					inst2.direct = inst.s_scalex
					inst2.direct_t = inst.direct_t
					inst2.rotacion = inst.rotacion
					inst2.index = inst.color
					inst2.image_xscale = inst.image_xscale
					inst2.image_yscale = inst.image_yscale
					inst2.warp = inst.warp
					inst2.w_x_pos = inst.t_x_pos
					inst2.w_y_pos = inst.t_y_pos
					inst2.w_direct = inst.t_direct_t
					inst2.w_size = inst.t_size
					inst2.w_rotacion = inst.t_rotacion
					inst2.w_s_scalex = inst.t_s_scalex
					inst2.w_color = inst.t_color
					inst2.w_xscale = inst.t_xscale
					inst2.w_yscale = inst.t_yscale
					match float(inst.t_direct_t):
						0.0:
							inst2.w_posx = (inst.t_x_pos + 16.0)
							inst2.w_posy = inst.t_y_pos
						1.0:
							inst2.w_posx = (inst.t_x_pos + (16.0 + (inst.t_size * 16.0)))
							inst2.w_posy = inst.t_y_pos
						2.0:
							inst2.w_posx = (inst.t_x_pos + 16.0)
							inst2.w_posy = (inst.t_y_pos + (16.0 + (inst.t_size * 16.0)))
						3.0:
							inst2.w_posx = (inst.t_x_pos + 16.0)
							inst2.w_posy = inst.t_y_pos
					match float(inst.direct_t):
						0.0:
							inst2.m_posx = (inst2.x + 16.0)
							inst2.m_posy = inst2.y
						1.0:
							inst2.m_posx = (inst2.x + (16.0 + (inst.size * 16.0)))
							inst2.m_posy = inst2.y
						2.0:
							inst2.m_posx = (inst2.x + 16.0)
							inst2.m_posy = (inst2.y + (16.0 + (inst.size * 16.0)))
						3.0:
							inst2.m_posx = (inst2.x + 16.0)
							inst2.m_posy = inst2.y
					if inst.plant == 1.0:
						match float(inst.direct_t):
							0.0:
								plant = GM.instance_create((inst2.x + 16.0), (inst2.y + 16.0), A.obj_piranhaplant)
							1.0:
								plant = GM.instance_create((inst2.x + (16.0 + (inst.size * 16.0))), (inst2.y + 16.0), A.obj_piranhaplant)
							2.0:
								plant = GM.instance_create((inst2.x + 16.0), (inst2.y + (16.0 + (inst.size * 16.0))), A.obj_piranhaplant)
							3.0:
								plant = GM.instance_create((inst2.x + 16.0), (inst2.y + 16.0), A.obj_piranhaplant)
						plant.direct_t = inst.direct_t
						plant.rotacion = inst.rotacion
					if inst2.warp == 1.0:
						inst2.alarm[0] = 1.0
	if GM.instance_exists(A.obj_pipebase_res):
		for inst in GM.with_list(A.obj_pipebase_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_pipebase)
	if GM.instance_exists(A.obj_cannon_res):
		for inst in GM.with_list(A.obj_cannon_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_cannon)):
				match float(inst.direct):
					0.0:
						inst2.direct = 0.0
					1.0:
						inst2.direct = 45.0
					2.0:
						inst2.direct = 90.0
					3.0:
						inst2.direct = 135.0
					4.0:
						inst2.direct = 180.0
					5.0:
						inst2.direct = 225.0
					6.0:
						inst2.direct = 270.0
					7.0:
						inst2.direct = 315.0
				inst2.d = inst.d
				inst2.u = inst.u
				inst2.l = inst.l
				inst2.r = inst.r
	if GM.instance_exists(A.obj_cannon_red_res):
		for inst in GM.with_list(A.obj_cannon_red_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_cannon_red)):
				match float(inst.direct):
					0.0:
						inst2.direct = 0.0
					1.0:
						inst2.direct = 45.0
					2.0:
						inst2.direct = 90.0
					3.0:
						inst2.direct = 135.0
					4.0:
						inst2.direct = 180.0
					5.0:
						inst2.direct = 225.0
					6.0:
						inst2.direct = 270.0
					7.0:
						inst2.direct = 315.0
				inst2.d = inst.d
				inst2.u = inst.u
				inst2.l = inst.l
				inst2.r = inst.r
	if GM.instance_exists(A.obj_soplete_res):
		for inst in GM.with_list(A.obj_soplete_res):
			inst.visible = false
			if inst.sprout == 0.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_soplete)):
					inst2.direct_t = inst.direct_t
					inst2.rotacion = inst.rotacion
			else:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_soplete_invert)):
					inst2.direct_t = inst.direct_t
					inst2.rotacion = inst.rotacion
	if GM.instance_exists(A.obj_angrysun_res):
		for inst in GM.with_list(A.obj_angrysun_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_angrysun)
	if GM.instance_exists(A.obj_door_res):
		for inst in GM.with_list(A.obj_door_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_door)):
				inst2.posx = inst.door_x
				inst2.posy = inst.door_y
	if GM.instance_exists(A.obj_door_switch_res):
		for inst in GM.with_list(A.obj_door_switch_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_door_switch)):
				inst2.posx = inst.door_x
				inst2.posy = inst.door_y
	if GM.instance_exists(A.obj_door_lock_res):
		for inst in GM.with_list(A.obj_door_lock_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_door_lock)):
				inst2.posx = inst.door_x
				inst2.posy = inst.door_y
	if GM.instance_exists(A.obj_pink_coin_res):
		for inst in GM.with_list(A.obj_pink_coin_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_pink_coin)
	if GM.instance_exists(A.obj_bouncycloud_res):
		for inst in GM.with_list(A.obj_bouncycloud_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_bouncycloud)
	if GM.instance_exists(A.obj_rocangrejo_res):
		for inst in GM.with_list(A.obj_rocangrejo_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_rocangrejo)
	if GM.instance_exists(A.obj_shell_drybones_res):
		for inst in GM.with_list(A.obj_shell_drybones_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_shell_drybones)
	if GM.instance_exists(A.obj_mechakoopa_res):
		for inst in GM.with_list(A.obj_mechakoopa_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_mechakoopa)
	if GM.instance_exists(A.obj_bonybeetle_res):
		for inst in GM.with_list(A.obj_bonybeetle_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_bonybeetle)
	if GM.instance_exists(A.obj_bonybeetle_b_res):
		for inst in GM.with_list(A.obj_bonybeetle_b_res):
			inst.visible = false
			GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_bonybeetle_b)
	if GM.instance_exists(A.obj_lava_lift_res):
		for inst in GM.with_list(A.obj_lava_lift_res):
			inst.visible = false
			GM.instance_create((inst.x + 16.0), inst.y, A.obj_lava_lift)
	if GM.instance_exists(A.obj_fast_lava_lift_res):
		for inst in GM.with_list(A.obj_fast_lava_lift_res):
			inst.visible = false
			GM.instance_create((inst.x + 16.0), inst.y, A.obj_fast_lava_lift)
	if GM.instance_exists(A.obj_rock_res):
		for inst in GM.with_list(A.obj_rock_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block_rock)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_ice_res):
		for inst in GM.with_list(A.obj_ice_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_block_ice)
	if GM.instance_exists(A.obj_block_hidden_res):
		for inst in GM.with_list(A.obj_block_hidden_res):
			inst.visible = false
			if inst.sprout == 0.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block_hidden)):
					inst2.wings = inst.wings
					inst2.progresivo = inst.progresivo
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block_hidden)):
					inst2.sprout = inst.sprout
					inst2.wings = inst.wings
					inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_pinchos_res):
		for inst in GM.with_list(A.obj_pinchos_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_pinchos)
	if GM.instance_exists(A.obj_firebar_res):
		for inst in GM.with_list(A.obj_firebar_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_firebar)):
				inst2.fireballs = inst.size_x
				inst2.direct_t = inst.direct_t
				inst2.direction = inst.color
	if GM.instance_exists(A.obj_icicle_res):
		for inst in GM.with_list(A.obj_icicle_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_icicle)
	if GM.instance_exists(A.obj_icicle2_res):
		for inst in GM.with_list(A.obj_icicle2_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_icicle2)
	if GM.instance_exists(A.obj_mini_icicle_res):
		for inst in GM.with_list(A.obj_mini_icicle_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_mini_icicle)
	if GM.instance_exists(A.obj_mini_icicle2_res):
		for inst in GM.with_list(A.obj_mini_icicle2_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_mini_icicle2)
	if GM.instance_exists(A.obj_onoffblock_res):
		for inst in GM.with_list(A.obj_onoffblock_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_onoffblock)
	if GM.instance_exists(A.obj_onoffplatform_res):
		for inst in GM.with_list(A.obj_onoffplatform_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_onoffplatform)
	if GM.instance_exists(A.obj_onoffplatform_blue_res):
		for inst in GM.with_list(A.obj_onoffplatform_blue_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_onoffplatform_blue)
	if GM.instance_exists(A.obj_pblock_res):
		for inst in GM.with_list(A.obj_pblock_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_anti_pblock)
	if GM.instance_exists(A.obj_ninji_res):
		for inst in GM.with_list(A.obj_ninji_res):
			inst.visible = false
			if G.apariencia != 3.0:
				GM.instance_create(inst.x, inst.y, A.obj_ninji)
			else:
				GM.instance_create(inst.x + 5.0, inst.y + 7.0, A.obj_NSMBU_ninji)
	if GM.instance_exists(A.obj_cooligan_res):
		for inst in GM.with_list(A.obj_cooligan_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_cooligan)
	if GM.instance_exists(A.obj_pblock2_res):
		for inst in GM.with_list(A.obj_pblock2_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_pblock)
	if GM.instance_exists(A.obj_oneway_res):
		for inst in GM.with_list(A.obj_oneway_res):
			inst.visible = false
			match float(inst.direct_t):
				1.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_onewaygate_right)):
						inst2.rotacion = inst.rotacion
						inst2.rot_angle = inst.rotacion
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_onewaygate_top)):
						inst2.rotacion = inst.rotacion
						inst2.rot_angle = inst.rotacion
				3.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_onewaygate_left)):
						inst2.rotacion = inst.rotacion
						inst2.rot_angle = inst.rotacion
				4.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_onewaygate_bottom)):
						inst2.rotacion = inst.rotacion
						inst2.rot_angle = inst.rotacion
	if GM.instance_exists(A.obj_checkpoint_res):
		for inst in GM.with_list(A.obj_checkpoint_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_checkpoint)):
				inst2.rotacion = inst.rotacion
				inst2.sprout = inst.sprout
	if GM.instance_exists(A.obj_arrow_res):
		for inst in GM.with_list(A.obj_arrow_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_arrow)):
				inst2.rotacion = inst.rotacion
	if GM.instance_exists(A.obj_coin_res):
		for inst in GM.with_list(A.obj_coin_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_coin)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_icecoin_res):
		for inst in GM.with_list(A.obj_icecoin_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_icecoin)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_coin10_res):
		for inst in GM.with_list(A.obj_coin10_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_coin10)
	if GM.instance_exists(A.obj_coin30_res):
		for inst in GM.with_list(A.obj_coin30_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_coin30)
	if GM.instance_exists(A.obj_coin50_res):
		for inst in GM.with_list(A.obj_coin50_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_coin50)
	if GM.instance_exists(A.obj_donut_res):
		for inst in GM.with_list(A.obj_donut_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_donut)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_torbellino_res):
		for inst in GM.with_list(A.obj_torbellino_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_torbellino)
	if (G.bg_level == "mountain") and (G.modo_noche == 1.0) and (G.meteoritos == 1.0) and (not GM.instance_exists(A.obj_meteorites_maker)):
		GM.instance_create(GM.instance_find(A.obj_persistent, 0).x + 5.0, GM.instance_find(A.obj_persistent, 0).y - 5.0, A.obj_meteorites_maker)
	#
	# 	if (global.bg_level == "underground") and (global.apariencia > 1) and (!instance_exists(obj_audio_control))
	# 		instance_create(obj_persistent.x + 10, obj_persistent.y - 10, obj_audio_control)
	# 	/*
	if GM.instance_exists(A.obj_foo_res):
		for inst in GM.with_list(A.obj_foo_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_foo)
	if GM.instance_exists(A.obj_goomba_res):
		for inst in GM.with_list(A.obj_goomba_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_goomba_b_res):
		for inst in GM.with_list(A.obj_goomba_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba_b)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_goombrat_b_res):
		for inst in GM.with_list(A.obj_goombrat_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba2_b)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_goombrat_res):
		for inst in GM.with_list(A.obj_goombrat_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_galoomba2)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_waddlewing_res):
		for inst in GM.with_list(A.obj_waddlewing_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_waddlewing)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_koopa_res):
		for inst in GM.with_list(A.obj_koopa_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_koopa)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_koopa_b_res):
		for inst in GM.with_list(A.obj_koopa_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_koopa_b)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_koopa_red_res):
		for inst in GM.with_list(A.obj_koopa_red_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_koopa_red)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_koopa_red_b_res):
		for inst in GM.with_list(A.obj_koopa_red_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_koopa_red_b)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.key = inst.key
	if GM.instance_exists(A.obj_drybones_res):
		for inst in GM.with_list(A.obj_drybones_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_drybones)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_buzzybeetle_res):
		for inst in GM.with_list(A.obj_buzzybeetle_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_buzzybeetle)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.inup = inst.inup
	if GM.instance_exists(A.obj_buzzybeetle_b_res):
		for inst in GM.with_list(A.obj_buzzybeetle_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_buzzybeetle_b)):
				inst2.wings = inst.wings
				inst2.inup = inst.inup
				if inst2.inup == 0.0:
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_buzzy_shell_res):
		for inst in GM.with_list(A.obj_buzzy_shell_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_shell_empty)
	if GM.instance_exists(A.obj_boomboom_res):
		for inst in GM.with_list(A.obj_boomboom_res):
			inst.visible = false
			if G.apariencia == 3.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_NSMBU_boomboom)):
					inst2.key = inst.key
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_boomboom)):
					inst2.key = inst.key
	if GM.instance_exists(A.obj_boomboom_b_res):
		for inst in GM.with_list(A.obj_boomboom_b_res):
			inst.visible = false
			if G.apariencia == 3.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_NSMBU_boomboom_b)):
					inst2.key = inst.key
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_boomboom_b)):
					inst2.key = inst.key
	if GM.instance_exists(A.obj_bowser_res):
		for inst in GM.with_list(A.obj_bowser_res):
			inst.visible = false
			match G.apariencia:
				0.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_SMB_bowser)):
						inst2.key = inst.key
				1.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_SMB3_bowser)):
						inst2.key = inst.key
				2.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_SMW_bowser)):
						inst2.key = inst.key
				3.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_NSMBU_bowser)):
						inst2.key = inst.key
	if GM.instance_exists(A.obj_bowserjr_res):
		for inst in GM.with_list(A.obj_bowserjr_res):
			inst.visible = false
			if G.apariencia == 3.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_NSMBU_bowserjr)):
					inst2.key = inst.key
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
			else:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_bowserjr)):
					inst2.key = inst.key
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_spiny_res):
		for inst in GM.with_list(A.obj_spiny_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_spiny)):
				inst2.wings = inst.wings
				inst2.inup = inst.inup
				if inst.wings == 1.0:
					if G.apariencia == 3.0:
						inst2.image_index = 1.0
					else:
						inst2.sprite_index = A.spr_spiny_wings
						inst2.image_index = G.apariencia
					inst2.image_speed = 0.0
	if GM.instance_exists(A.obj_spiny_shell_res):
		for inst in GM.with_list(A.obj_spiny_shell_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_spiny_empty)
	if GM.instance_exists(A.obj_lakitu_res):
		for inst in GM.with_list(A.obj_lakitu_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 16.0), A.obj_lakitu)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.sprout = inst.sprout
	if GM.instance_exists(A.obj_cheepcheep_res):
		for inst in GM.with_list(A.obj_cheepcheep_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_cheepcheep)):
				inst2.modo_water = inst.modo_water
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_cheepcheep2_res):
		for inst in GM.with_list(A.obj_cheepcheep2_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_cheepcheep2)):
				inst2.modo_water = inst.modo_water
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_blooper_res):
		for inst in GM.with_list(A.obj_blooper_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_blooper)
	if GM.instance_exists(A.obj_floruga_res):
		for inst in GM.with_list(A.obj_floruga_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_floruga)
	if GM.instance_exists(A.obj_floruga_angry_res):
		for inst in GM.with_list(A.obj_floruga_angry_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_floruga)):
				inst2.state = 2.0
				inst2.closeness = 8.0
				inst2.alarm[0] = 4.0
	if GM.instance_exists(A.obj_hammerbro_res):
		for inst in GM.with_list(A.obj_hammerbro_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_hammerbro)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_icebro_res):
		for inst in GM.with_list(A.obj_icebro_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_icebro)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_boomerangbro_res):
		for inst in GM.with_list(A.obj_boomerangbro_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_boomerangbro)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_firebro_res):
		for inst in GM.with_list(A.obj_firebro_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_firebro)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_sledgebro_res):
		for inst in GM.with_list(A.obj_sledgebro_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_sledgebro)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_charginchuck_res):
		for inst in GM.with_list(A.obj_charginchuck_res):
			inst.visible = false
			if G.apariencia == 3.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_NSMBU_charginchuck)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_charginchuck)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_magikoopa_res):
		for inst in GM.with_list(A.obj_magikoopa_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_magikoopa)
	if GM.instance_exists(A.obj_monty_res):
		for inst in GM.with_list(A.obj_monty_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_monty_chase)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_rocky_res):
		for inst in GM.with_list(A.obj_rocky_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_rocky)
	if GM.instance_exists(A.obj_chomp_res):
		for inst in GM.with_list(A.obj_chomp_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_chain_chomp_free)
	if GM.instance_exists(A.obj_chomp_b_res):
		for inst in GM.with_list(A.obj_chomp_b_res):
			inst.visible = false
			GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_chain_chomp_free_b)
	if GM.instance_exists(A.obj_boo_res):
		for inst in GM.with_list(A.obj_boo_res):
			inst.visible = false
			if inst.inup == 0.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_boo)):
					inst2.wings = inst.wings
			else:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_boo)):
					if G.apariencia == 3.0:
						inst2.sprite_index = A.spr_NSMBU_boo_stretch
					else:
						inst2.sprite_index = A.spr_boo_stretch
						inst2.image_index = G.apariencia
					inst2.inup = inst.inup
	if GM.instance_exists(A.obj_egg_res):
		for inst in GM.with_list(A.obj_egg_res):
			inst.visible = false
			if G.apariencia < 2.0:
				h = 8.0
			else:
				h = 0.0
			if G.apariencia < 3.0:
				if inst.wings == 0.0:
					for inst2 in GM.with_list(GM.instance_create((inst.x + h), inst.y, A.obj_egg)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
				else:
					for inst2 in GM.with_list(GM.instance_create((inst.x + h), inst.y, A.obj_egg_blue)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_egg_red_res):
		for inst in GM.with_list(A.obj_egg_red_res):
			inst.visible = false
			if G.apariencia == 2.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_egg_red)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
			elif G.apariencia != 3.0:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_egg_red)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_pplant_res):
		for inst in GM.with_list(A.obj_pplant_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_jumppiranha)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.inup = inst.inup
	if GM.instance_exists(A.obj_big_pplant_res):
		for inst in GM.with_list(A.obj_big_pplant_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 27.0), inst.y + 24.0, A.obj_big_pplant)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.inup = inst.inup
	if GM.instance_exists(A.obj_big_pplant_b_res):
		for inst in GM.with_list(A.obj_big_pplant_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 54.0), inst.y, A.obj_big_pplant_b)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.inup = inst.inup
	if GM.instance_exists(A.obj_plant_fire_res):
		for inst in GM.with_list(A.obj_plant_fire_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_plant_fire)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_spike_res):
		for inst in GM.with_list(A.obj_spike_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_spike)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_spike_ball_res):
		for inst in GM.with_list(A.obj_spike_ball_res):
			inst.visible = false
			if G.bg_level == "snow":
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_snow_ball)):
					inst2.paracaidas = inst.paracaidas
			else:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_spike_ball)):
					inst2.spike_alone = 1.0
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_spike_ball_b_res):
		for inst in GM.with_list(A.obj_spike_ball_b_res):
			inst.visible = false
			if G.bg_level == "snow":
				for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_snow_ball_b)):
					inst2.paracaidas = inst.paracaidas
			else:
				for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_spike_ball_b)):
					inst2.spike_alone = 1.0
					inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_muncher_res):
		for inst in GM.with_list(A.obj_muncher_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), inst.y, A.obj_muncher)
	if GM.instance_exists(A.obj_muncher_b_res):
		for inst in GM.with_list(A.obj_muncher_b_res):
			inst.visible = false
			GM.instance_create(inst.x, (inst.y - 16.0), A.obj_muncher_b)
	if GM.instance_exists(A.obj_thwomp_res):
		for inst in GM.with_list(A.obj_thwomp_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 16.0), (inst.y + 16.0), A.obj_thwomp)):
				inst2.direct_t = inst.direct_t
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_thwomp_b_res):
		for inst in GM.with_list(A.obj_thwomp_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x), (inst.y), A.obj_thwomp_b)):
				inst2.direct_t = inst.direct_t
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_grrrol_res):
		for inst in GM.with_list(A.obj_grrrol_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create_depth((inst.x + 24.0), (inst.y + 24.0), -2.0, A.obj_grrrol)):
				inst2.direct_t = inst.direct_t
	if GM.instance_exists(A.obj_grrrol_new_res):
		for inst in GM.with_list(A.obj_grrrol_new_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create_depth((inst.x + 20.0), (inst.y + 18.0), -2.0, A.obj_grrrol_new)):
				inst2.direct_t = inst.direct_t
	if GM.instance_exists(A.obj_grrrol_b_res):
		for inst in GM.with_list(A.obj_grrrol_b_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create_depth((inst.x + 32.5), (inst.y + 32.5), -2.0, A.obj_grrrol_b)):
				inst2.direct_t = inst.direct_t
	if GM.instance_exists(A.obj_podoboo_res):
		for inst in GM.with_list(A.obj_podoboo_res):
			inst.visible = false
			GM.instance_create((inst.x + 8.0), (inst.y + 8.0), A.obj_podoboo)
	if GM.instance_exists(A.obj_podoboo_b_res):
		for inst in GM.with_list(A.obj_podoboo_b_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_podoboo_b)
	if GM.instance_exists(A.obj_clown_res):
		for inst in GM.with_list(A.obj_clown_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_clown)
	if GM.instance_exists(A.obj_clown_fire_res):
		for inst in GM.with_list(A.obj_clown_fire_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_clown_fire)
	if GM.instance_exists(A.obj_cinta_res):
		for inst in GM.with_list(A.obj_cinta_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_cinta_on_res):
		for inst in GM.with_list(A.obj_cinta_on_res):
			inst.visible = false
			inst.event_user(3)
	if GM.instance_exists(A.obj_billbanzai_res):
		for inst in GM.with_list(A.obj_billbanzai_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_banzaibill)):
				inst2.direct = inst.s_scaley
				inst2.rotacion = inst.rotacion
				inst2.direct_t = inst.direct_t
	if GM.instance_exists(A.obj_billbanzai_red_res):
		for inst in GM.with_list(A.obj_billbanzai_red_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_billbanzai_red)):
				match float(inst.rotacion):
					0.0:
						inst2.direction = 180.0
					180.0:
						inst2.direction = 0.0
					90.0:
						inst2.direction = 270.0
					270.0:
						inst2.direction = 90.0
				inst2.rotacion = inst.rotacion
				inst2.direct_t = inst.direct_t
				if inst2.direct_t < 3.0:
					inst2.sprite_index = A.spr_billbanzai_red_i
	if GM.instance_exists(A.obj_bobomb_res):
		for inst in GM.with_list(A.obj_bobomb_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_bobomb)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_bobomb_ready_res):
		for inst in GM.with_list(A.obj_bobomb_ready_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create((inst.x + 8.0), inst.y, A.obj_bobomb_ready)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_1up_res):
		for inst in GM.with_list(A.obj_1up_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_1up)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_star_res):
		for inst in GM.with_list(A.obj_star_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_star)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_mushroom_res):
		for inst in GM.with_list(A.obj_mushroom_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_mushroom)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_SMB2_mushroom_res):
		for inst in GM.with_list(A.obj_SMB2_mushroom_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_SMB2_mushroom)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_link_res):
		for inst in GM.with_list(A.obj_link_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_link)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
	if GM.instance_exists(A.obj_hen_mushroom_res):
		for inst in GM.with_list(A.obj_hen_mushroom_res):
			inst.visible = false
			match G.apariencia:
				0.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_hen_mushroom)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				1.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_hammersuit)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_pballon)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				3.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_penguin_suit)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_fireflower_res):
		for inst in GM.with_list(A.obj_fireflower_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_fireflower)):
				inst2.wings = inst.wings
				inst2.paracaidas = inst.paracaidas
				inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_superflower_res):
		for inst in GM.with_list(A.obj_superflower_res):
			inst.visible = false
			if G.apariencia != 0.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_fireflower)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
					inst2.progresivo = inst.progresivo
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_superflower)):
					inst2.wings = inst.wings
					inst2.paracaidas = inst.paracaidas
					inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_frogsuit_res):
		for inst in GM.with_list(A.obj_frogsuit_res):
			inst.visible = false
			match G.apariencia:
				0.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_link)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				1.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_frogsuit)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				2.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_pballon)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				3.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_superarcon)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_cap_res):
		for inst in GM.with_list(A.obj_cap_res):
			inst.visible = false
			match G.apariencia:
				0.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_megamushroom)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				3.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_propellershroom)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
				_:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_cap)):
						inst2.wings = inst.wings
						inst2.paracaidas = inst.paracaidas
						inst2.progresivo = inst.progresivo
	if GM.instance_exists(A.obj_spring_res):
		for inst in GM.with_list(A.obj_spring_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_spring)
	if GM.instance_exists(A.obj_spring_land_res):
		for inst in GM.with_list(A.obj_spring_land_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_spring_land)
	if GM.instance_exists(A.obj_grinder_res):
		for inst in GM.with_list(A.obj_grinder_res):
			inst.visible = false
			GM.instance_create((inst.x + 24.0), (inst.y + 24.0), A.obj_grinder)
	if GM.instance_exists(A.obj_bumper_res):
		for inst in GM.with_list(A.obj_bumper_res):
			inst.visible = false
			GM.instance_create((inst.x + 24.0), (inst.y + 24.0), A.obj_bumper)
	if GM.instance_exists(A.obj_pswitch_res):
		for inst in GM.with_list(A.obj_pswitch_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_pswitch)):
				inst2.inup = inst.inup
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_pow_res):
		for inst in GM.with_list(A.obj_pow_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_block_pow_hold)
	if GM.instance_exists(A.obj_key_res):
		for inst in GM.with_list(A.obj_key_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_key)
	if GM.instance_exists(A.obj_nube_res):
		for inst in GM.with_list(A.obj_nube_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_nube)
	if GM.instance_exists(A.obj_qblock_res):
		for inst in GM.with_list(A.obj_qblock_res):
			inst.visible = false
			match float(inst.sprout):
				0.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block)):
						inst2.wings = inst.wings
				-1.0:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block_multicoin)):
						inst2.wings = inst.wings
				_:
					for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block)):
						inst2.sprout = inst.sprout
						inst2.progresivo = inst.progresivo
						inst2.wings = inst.wings
	if GM.instance_exists(A.obj_noteblock_res):
		for inst in GM.with_list(A.obj_noteblock_res):
			inst.visible = false
			if inst.sprout == 0.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_noteblock)):
					inst2.wings = inst.wings
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_noteblock)):
					inst2.sprout = inst.sprout
					inst2.wings = inst.wings
	if GM.instance_exists(A.obj_musicblock_res):
		for inst in GM.with_list(A.obj_musicblock_res):
			inst.visible = false
			for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_musicblock)):
				inst2.wings = inst.wings
	if GM.instance_exists(A.obj_noteblock_s_res):
		for inst in GM.with_list(A.obj_noteblock_s_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_noteblock_s)
	if GM.instance_exists(A.obj_block_gold_res):
		for inst in GM.with_list(A.obj_block_gold_res):
			inst.visible = false
			GM.instance_create(inst.x, inst.y, A.obj_block_gold)
	if GM.instance_exists(A.obj_block_res):
		for inst in GM.with_list(A.obj_block_res):
			inst.visible = false
			if inst.sprout == 0.0:
				GM.instance_create(inst.x, inst.y, A.obj_flipblock)
			elif inst.sprout == -1.0:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block_multicoin)):
					match G.apariencia:
						0.0:
							inst2.sprite_index = A.spr_SMB_qblock
							inst2.image_speed = 0.0
							match G.bg_level:
								"snow":
									if G.modo_noche == 1.0:
										inst2.image_index = 4.0
									else:
										inst2.image_index = 3.0
								"castle":
									inst2.image_index = 2.0
								"ghost":
									inst2.image_index = 1.0
								"underground":
									inst2.image_index = 1.0
								_:
									inst2.image_index = 0.0
						1.0:
							# switch global.bg_level：原版 case "mountain" 的 else 分支没有 break，会落入 default；两条路径结果相同，已合并
							match G.bg_level:
								"castle":
									inst2.sprite_index = A.spr_SMB3_qblock_dark
								"ghost":
									inst2.sprite_index = A.spr_SMB3_qblock_night
								"underground":
									inst2.sprite_index = A.spr_SMB3_qblock_night
								"mountain":
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_SMB3_qblock_dark
									else:
										inst2.sprite_index = A.spr_SMB3_qblock
								_:
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_SMB3_qblock_night
									else:
										inst2.sprite_index = A.spr_SMB3_qblock
							inst2.image_speed = 0.15
						2.0:
							inst2.image_speed = 0.0
							inst2.sprite_index = A.spr_flipblock
						3.0:
							# switch global.bg_level（case/default 内的 break 都只是跳出 switch）
							match G.bg_level:
								"castle":
									inst2.sprite_index = A.spr_NSMBU_block_dark
								"ghost":
									inst2.sprite_index = A.spr_NSMBU_block_night
								"underground":
									inst2.sprite_index = A.spr_NSMBU_block_night
								"mountain":
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_NSMBU_block_dark
									else:
										inst2.sprite_index = A.spr_NSMBU_block
								_:
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_NSMBU_block_night
									else:
										inst2.sprite_index = A.spr_NSMBU_block
							inst2.image_speed = 0.2
					inst2.wings = inst.wings
			else:
				for inst2 in GM.with_list(GM.instance_create(inst.x, inst.y, A.obj_block)):
					match G.apariencia:
						0.0:
							inst2.sprite_index = A.spr_SMB_qblock
							inst2.image_speed = 0.0
							match G.bg_level:
								"snow":
									if G.modo_noche == 1.0:
										inst2.image_index = 4.0
									else:
										inst2.image_index = 3.0
								"castle":
									inst2.image_index = 2.0
								"ghost":
									inst2.image_index = 1.0
								"underground":
									inst2.image_index = 1.0
								_:
									inst2.image_index = 0.0
						1.0:
							# switch global.bg_level：原版 case "mountain" 的 else 分支没有 break，会落入 default；两条路径结果相同，已合并
							match G.bg_level:
								"castle":
									inst2.sprite_index = A.spr_SMB3_qblock_dark
								"ghost":
									inst2.sprite_index = A.spr_SMB3_qblock_night
								"underground":
									inst2.sprite_index = A.spr_SMB3_qblock_night
								"mountain":
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_SMB3_qblock_dark
									else:
										inst2.sprite_index = A.spr_SMB3_qblock
								_:
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_SMB3_qblock_night
									else:
										inst2.sprite_index = A.spr_SMB3_qblock
							inst2.image_speed = 0.15
						2.0:
							inst2.image_speed = 0.0
							inst2.sprite_index = A.spr_flipblock
						3.0:
							# switch global.bg_level（case/default 内的 break 都只是跳出 switch）
							match G.bg_level:
								"castle":
									inst2.sprite_index = A.spr_NSMBU_block_dark
								"ghost":
									inst2.sprite_index = A.spr_NSMBU_block_night
								"underground":
									inst2.sprite_index = A.spr_NSMBU_block_night
								"mountain":
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_NSMBU_block_dark
									else:
										inst2.sprite_index = A.spr_NSMBU_block
								_:
									if G.modo_noche == 1.0:
										inst2.sprite_index = A.spr_NSMBU_block_night
									else:
										inst2.sprite_index = A.spr_NSMBU_block
							inst2.image_speed = 0.2
					inst2.sprout = inst.sprout
					inst2.progresivo = inst.progresivo
					inst2.wings = inst.wings
	G.instance_deactivate = 1.0

