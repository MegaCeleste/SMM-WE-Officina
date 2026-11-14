extends GMObject

var sprite_selected: float = 0.0
var image_selected = null
var type: float = 0.0
var posicion: float = 0.0
var anim: float = 0.0
var can_anim: float = 0.0
var scale_up: float = 0.0
var scale_down: float = 0.0
var pos_left: float = 0.0
var left: float = 0.0
var right: float = 0.0
var ready_v: float = 0.0


# from objects/obj_panel_circle/Create_0.gml
func _create() -> void:
	match G.apariencia:
		0.0:
			sprite_selected = A.spr_cards_SMB
		1.0:
			sprite_selected = A.spr_cards_SMB3
		2.0:
			sprite_selected = A.spr_cards_SMW
		3.0:
			sprite_selected = A.spr_cards_NSMBU
	image_selected = 0.0
	image_speed = 0.0
	image_index = 0.0
	type = 0.0
	posicion = 0.0
	anim = 1.0
	can_anim = 0.0
	scale_up = 0.6
	scale_down = 1.0
	pos_left = 0.0
	left = 0.0
	right = 0.0
	ready_v = 0.0
	match float(GM.instance_find(A.obj_panel_expand, 0).value):
		1.0:
			image_index = 0.0
		2.0:
			image_index = 0.0
		3.0:
			image_index = 1.0
		4.0:
			image_index = 2.0
		5.0:
			image_index = 2.0
		6.0:
			image_index = 2.0
		7.0:
			image_index = 2.0
		_:
			image_index = 3.0


# from objects/obj_panel_circle/Destroy_0.gml
func _destroy() -> void:
	if GM.instance_exists(A.obj_card_circle):
		for inst in GM.with_list(A.obj_card_circle):
			inst.instance_destroy()


# from objects/obj_panel_circle/Step_2.gml
func _step_end() -> void:
	if can_anim == 1.0:
		if anim < 1.0:
			anim += 0.07
		else:
			event_user(int(GM.instance_find(A.obj_editormanager, 0).panel_circle))
			ready_v = 1.0
			anim = 1.0
			can_anim = 0.0
		image_xscale = anim
		image_yscale = anim
	if left == 1.0:
		image_xscale = scale_down
		image_yscale = scale_down
		if scale_down > 0.6:
			scale_down -= 0.05
	if right == 1.0:
		image_xscale = scale_up
		image_yscale = scale_up
		if scale_down < 1.0:
			scale_down += 0.05


# from objects/obj_panel_circle/Other_10.gml
func _user_0() -> void:
	type = 0.0
	sprite_index = A.spr_panel_circle
	image_index = 0.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 0.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 0.0
	posicion = 0.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_ground
		inst.mask_index = A.spr_circle_mask_1
		inst.value = 0.0
		self.image_selected = GM.instance_find(A.obj_panel_expand, 0).img_ground
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_slopes
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_pendiente1
		inst.mask_index = A.spr_circle_mask_2
		inst.value = 1.0
		inst.disabled = 1.0
		self.image_selected = GM.instance_find(A.obj_panel_expand, 0).img_pendiente1
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_pipebase_res
		inst.image_index = 221.0
		inst.mask_index = A.spr_circle_mask_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_tuberia_res
		match G.tuberia:
			0.0:
				inst.image_index = 134.0
			1.0:
				inst.image_index = 135.0
			2.0:
				inst.image_index = 136.0
			_:
				inst.image_index = 137.0
		inst.mask_index = A.spr_circle_mask_4
		inst.value = 3.0
		if GM.instance_number(A.obj_tuberia_res) > 10:
			inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_card_circle)):
		inst.obj = A.obj_pinchos_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_pinchos
		inst.mask_index = A.spr_circle_mask_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_mushroom_platform_res
		if G.mushroom_platform == 0.0:
			inst.image_index = 90.0
		elif G.mushroom_platform == 1.0:
			inst.image_index = 91.0
		elif G.mushroom_platform == 2.0:
			inst.image_index = 92.0
		inst.mask_index = A.spr_circle_mask_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 131.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_semisolid_platform1
		if G.semisolid_platform == 0.0:
			inst.image_index = 50.0
		elif G.semisolid_platform == 1.0:
			inst.image_index = 51.0
		elif G.semisolid_platform == 2.0:
			inst.image_index = 52.0
		inst.mask_index = A.spr_circle_mask_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_puente_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_puente
		inst.mask_index = A.spr_circle_mask_8
		inst.value = 7.0


# from objects/obj_panel_circle/Other_11.gml
func _user_1() -> void:
	type = 0.0
	sprite_index = A.spr_panel_circle
	image_index = 0.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 0.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 1.0
	posicion = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_block_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_block
		inst.mask_index = A.spr_circle_mask_1
		inst.value = 0.0
		self.image_selected = GM.instance_find(A.obj_panel_expand, 0).img_block
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_qblock_res
		inst.image_index = 93.0
		inst.mask_index = A.spr_circle_mask_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_rock_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_rock
		inst.mask_index = A.spr_circle_mask_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_block_hidden_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_hidden_block
		inst.mask_index = A.spr_circle_mask_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_card_circle)):
		inst.obj = A.obj_donut_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_donut
		inst.mask_index = A.spr_circle_mask_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		match G.noteblock:
			0.0:
				inst.obj = A.obj_noteblock_res
				inst.image_index = 102.0
			1.0:
				inst.obj = A.obj_musicblock_res
				inst.image_index = 140.0
			2.0:
				inst.obj = A.obj_noteblock_s_res
				inst.image_index = 216.0
		inst.mask_index = A.spr_circle_mask_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 131.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_nube_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_cloud_block
		inst.mask_index = A.spr_circle_mask_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_ice_res
		inst.image_index = 16.0
		inst.mask_index = A.spr_circle_mask_8
		inst.value = 7.0


# from objects/obj_panel_circle/Other_12.gml
func _user_2() -> void:
	type = 1.0
	sprite_index = A.spr_panel_circle
	image_index = 1.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 1.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 2.0
	posicion = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 53.0), A.obj_card_circle)):
		if G.icecoin == 1.0:
			inst.obj = A.obj_icecoin_res
			inst.image_index = 150.0
		else:
			inst.obj = A.obj_coin_res
			inst.image_index = 46.0
		inst.mask_index = A.spr_circle_mask10_1
		inst.value = 0.0
		self.image_selected = inst.image_index
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 209.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 63.0), A.obj_card_circle)):
		match G.coin10:
			0.0:
				inst.obj = A.obj_coin10_res
				inst.image_index = 47.0
			1.0:
				inst.obj = A.obj_coin30_res
				inst.image_index = 48.0
			2.0:
				inst.obj = A.obj_coin50_res
				inst.image_index = 49.0
		inst.mask_index = A.spr_circle_mask10_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 229.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 91.0), A.obj_card_circle)):
		inst.obj = A.obj_pink_coin_res
		inst.image_index = 148.0
		inst.mask_index = A.spr_circle_mask10_3
		inst.value = 2.0
		if GM.instance_number(A.obj_pink_coin_res) > 4:
			inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 229.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 123.0), A.obj_card_circle)):
		inst.obj = A.obj_mushroom_res
		inst.image_index = 96.0
		inst.mask_index = A.spr_circle_mask10_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 209.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_card_circle)):
		inst.obj = A.obj_fireflower_res
		inst.image_index = 61.0
		inst.mask_index = A.spr_circle_mask10_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 161.0), A.obj_card_circle)):
		inst.obj = A.obj_cap_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_cap
		inst.mask_index = A.spr_circle_mask10_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 153.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), A.obj_card_circle)):
		if G.hen_mushroom == 1.0:
			inst.obj = A.obj_hen_mushroom_res
			inst.image_index = 31.0
		else:
			inst.obj = A.obj_frogsuit_res
			inst.image_index = 184.0
		inst.mask_index = A.spr_circle_mask10_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 133.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 123.0), A.obj_card_circle)):
		inst.obj = A.obj_star_res
		inst.image_index = 130.0
		inst.mask_index = A.spr_circle_mask10_8
		inst.value = 7.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 133.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 91.0), A.obj_card_circle)):
		inst.obj = A.obj_1up_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_1up
		inst.mask_index = A.spr_circle_mask10_9
		inst.value = 8.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 153.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 63.0), A.obj_card_circle)):
		if G.yoshi_egg == 0.0:
			inst.obj = A.obj_egg_res
			inst.image_index = 59.0
		else:
			inst.obj = A.obj_egg_red_res
			inst.image_index = 60.0
		inst.mask_index = A.spr_circle_mask10_10
		inst.value = 9.0


# from objects/obj_panel_circle/Other_13.gml
func _user_3() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle_7
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 3.0
	posicion = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		if G.goomba == 0.0:
			inst.obj = A.obj_goomba_res
			inst.image_index = 69.0
		else:
			inst.obj = A.obj_goombrat_res
			inst.image_index = 70.0
			self.image_selected = 70.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = inst.image_index
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.koopa == 0.0:
			inst.obj = A.obj_koopa_res
			inst.image_index = 94.0
		else:
			inst.obj = A.obj_koopa_red_res
			inst.image_index = 95.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		if G.buzzy == 0.0:
			inst.obj = A.obj_buzzybeetle_res
			inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_buzzy
		else:
			inst.obj = A.obj_buzzybeetle_b_res
			inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_buzzy_shell
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 125.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		if G.spiny == 0.0:
			inst.obj = A.obj_spiny_res
			inst.image_index = 127.0
		else:
			inst.obj = A.obj_spiny_shell_res
			inst.image_index = 89.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_blooper_res
		inst.image_index = 23.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.cheepcheep == 0.0:
			inst.obj = A.obj_cheepcheep_res
			inst.image_index = 38.0
		else:
			inst.obj = A.obj_cheepcheep2_res
			inst.image_index = 39.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0


# from objects/obj_panel_circle/Other_14.gml
func _user_4() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 4.0
	posicion = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		if G.plant == 0.0:
			inst.obj = A.obj_pplant_res
			inst.image_index = 116.0
		else:
			inst.obj = A.obj_plant_fire_res
			inst.image_index = 110.0
		inst.mask_index = A.spr_circle_mask_1
		inst.value = 0.0
		self.image_selected = inst.image_index
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_muncher_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_muncher
		inst.mask_index = A.spr_circle_mask_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_thwomp_res
		inst.image_index = 132.0
		inst.mask_index = A.spr_circle_mask_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_monty_res
		inst.image_index = 97.0
		inst.mask_index = A.spr_circle_mask_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_card_circle)):
		inst.obj = A.obj_rocky_res
		inst.image_index = 98.0
		inst.mask_index = A.spr_circle_mask_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		if G.hammerbro == 0.0:
			match G.brothers:
				0.0:
					inst.obj = A.obj_hammerbro_res
					inst.image_index = 86.0
				1.0:
					inst.obj = A.obj_firebro_res
					inst.image_index = 222.0
				2.0:
					inst.obj = A.obj_icebro_res
					inst.image_index = 223.0
				_:
					inst.obj = A.obj_boomerangbro_res
					inst.image_index = 224.0
		else:
			inst.obj = A.obj_sledgebro_res
			inst.image_index = 124.0
		inst.mask_index = A.spr_circle_mask_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 131.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_chomp_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_chomp
		inst.mask_index = A.spr_circle_mask_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_spike_res
		inst.image_index = 151.0
		inst.mask_index = A.spr_circle_mask_8
		inst.value = 7.0


# from objects/obj_panel_circle/Other_15.gml
func _user_5() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 5.0
	posicion = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		if G.floruga == 0.0:
			inst.obj = A.obj_floruga_res
			inst.image_index = 158.0
		else:
			inst.obj = A.obj_floruga_angry_res
			inst.image_index = 159.0
		inst.mask_index = A.spr_circle_mask_1
		inst.value = 0.0
		self.image_selected = inst.image_index
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_boo_res
		inst.image_index = 28.0
		inst.mask_index = A.spr_circle_mask_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_podoboo_res
		inst.image_index = 114.0
		inst.mask_index = A.spr_circle_mask_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		if G.bobomb == 0.0:
			inst.obj = A.obj_bobomb_res
			inst.image_index = 25.0
		else:
			inst.obj = A.obj_bobomb_ready_res
			inst.image_index = 27.0
		inst.mask_index = A.spr_circle_mask_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_card_circle)):
		inst.obj = A.obj_drybones_res
		inst.image_index = 56.0
		inst.mask_index = A.spr_circle_mask_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 58.0
		inst.mask_index = A.spr_circle_mask_6
		inst.disabled = 1.0
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 131.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_magikoopa_res
		inst.image_index = 145.0
		inst.mask_index = A.spr_circle_mask_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_pokey_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_pokey
		inst.mask_index = A.spr_circle_mask_8
		inst.value = 7.0


# from objects/obj_panel_circle/Other_16.gml
func _user_6() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle_7
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 6.0
	posicion = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_bowser_res
		inst.image_index = 32.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 32.0
		if GM.instance_number(A.obj_bowser_res) > 3:
			inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_bowserjr_res
		inst.image_index = 33.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_boomboom_res
		inst.image_index = 30.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_mechakoopa_res
		inst.image_index = 185.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_angrysun_res
		if G.modo_noche == 1.0:
			inst.image_index = 99.0
		else:
			inst.image_index = 131.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
		if GM.instance_number(A.obj_angrysun_res) > 0:
			inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_lakitu_res
		inst.image_index = 161.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.clown == 0.0:
			inst.obj = A.obj_clown_res
			inst.image_index = 44.0
		else:
			inst.obj = A.obj_clown_fire_res
			inst.image_index = 45.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0


# from objects/obj_panel_circle/Other_17.gml
func _user_7() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle_7
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 7.0
	posicion = 7.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_bonybeetle_res
		inst.image_index = 220.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 220.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_charginchuck_res
		inst.image_index = 212.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_rocangrejo_res
		inst.image_index = 219.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_grrrol_new_res
		inst.image_index = 217.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_waddlewing_res
		inst.image_index = 233.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_cooligan_res
		inst.image_index = 231.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0


# from objects/obj_panel_circle/Other_18.gml
func _user_8() -> void:
	type = 2.0
	sprite_index = A.spr_panel_circle_7
	image_index = 2.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 2.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 8.0
	posicion = 8.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 188.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		inst.disabled = 1.0
		self.image_selected = 188.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 189.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 194.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 190.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 193.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 192.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 191.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0
		inst.disabled = 1.0


# from objects/obj_panel_circle/Other_19.gml
func _user_9() -> void:
	type = 3.0
	sprite_index = A.spr_panel_circle_7
	image_index = 3.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 3.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 9.0
	posicion = 9.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_soplete_res
		if G.soplete == 0.0:
			inst.image_index = 166.0
		else:
			inst.image_index = 43.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 166.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.bulletbill_base == 0.0:
			inst.obj = A.obj_bullebill_base_res
			inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_bullet
		else:
			inst.obj = A.obj_bullebill_base_red_res
			inst.image_index = 7.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		if G.billbanzai == 0.0:
			inst.obj = A.obj_billbanzai_res
			inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_billbanzai
		else:
			inst.obj = A.obj_billbanzai_red_res
			inst.image_index = 4.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		if G.cannon == 0.0:
			inst.obj = A.obj_cannon_res
			inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_cannon
		else:
			inst.obj = A.obj_cannon_red_res
			inst.image_index = 157.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		match G.estalactita:
			0.0:
				inst.obj = A.obj_mini_icicle_res
				inst.image_index = 213.0
			1.0:
				inst.obj = A.obj_mini_icicle2_res
				inst.image_index = 214.0
			2.0:
				inst.obj = A.obj_icicle_res
				inst.image_index = 138.0
			3.0:
				inst.obj = A.obj_icicle2_res
				inst.image_index = 139.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		if G.foo == 0.0:
			inst.obj = A.obj_torbellino_res
			inst.image_index = 133.0
		else:
			inst.obj = A.obj_foo_res
			inst.image_index = 215.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_checkpoint_res
		inst.image_index = 37.0
		inst.mask_index = A.spr_circle_mask7_7
		if GM.instance_number(A.obj_checkpoint_res) > 0:
			inst.disabled = 1.0
		inst.value = 6.0


# from objects/obj_panel_circle/Other_20.gml
func _user_10() -> void:
	type = 3.0
	sprite_index = A.spr_panel_circle
	image_index = 3.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 3.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 10.0
	posicion = 10.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_key_res
		inst.image_index = 146.0
		inst.mask_index = A.spr_circle_mask_1
		inst.value = 0.0
		self.image_selected = 146.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		match G.door:
			0.0:
				inst.obj = A.obj_door_res
				inst.image_index = 54.0
				if GM.instance_number(A.obj_door_res) > 3:
					inst.disabled = 1.0
			1.0:
				inst.obj = A.obj_door_switch_res
				inst.image_index = 55.0
				if GM.instance_number(A.obj_door_switch_res) > 3:
					inst.disabled = 1.0
			2.0:
				inst.obj = A.obj_door_lock_res
				inst.image_index = 147.0
				if GM.instance_number(A.obj_door_lock_res) > 3:
					inst.disabled = 1.0
		inst.mask_index = A.spr_circle_mask_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 231.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		if G.pblock == 0.0:
			inst.obj = A.obj_pblock_res
			inst.image_index = 154.0
		else:
			inst.obj = A.obj_pblock2_res
			inst.image_index = 182.0
		inst.mask_index = A.spr_circle_mask_3
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 217.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		inst.obj = A.obj_pswitch_res
		inst.image_index = 117.0
		inst.mask_index = A.spr_circle_mask_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 156.0), A.obj_card_circle)):
		inst.obj = A.obj_pow_res
		inst.image_index = 115.0
		inst.mask_index = A.spr_circle_mask_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 142.0), A.obj_card_circle)):
		if G.spring == 0.0:
			inst.obj = A.obj_spring_res
			inst.image_index = 128.0
		else:
			inst.obj = A.obj_spring_land_res
			inst.image_index = 129.0
		inst.mask_index = A.spr_circle_mask_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 131.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_card_circle)):
		inst.obj = A.obj_vine_res
		inst.image_index = 149.0
		inst.mask_index = A.spr_circle_mask_7
		inst.value = 6.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 145.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 72.0), A.obj_card_circle)):
		inst.obj = A.obj_arrow_res
		inst.image_index = 1.0
		inst.mask_index = A.spr_circle_mask_8
		inst.value = 7.0


# from objects/obj_panel_circle/Other_21.gml
func _user_11() -> void:
	type = 3.0
	image_index = 3.0
	sprite_index = A.spr_panel_circle_7
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 3.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 11.0
	posicion = 11.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		if G.platform == 0.0:
			inst.obj = A.obj_platform_res
			inst.image_index = 111.0
		else:
			inst.obj = A.obj_platform_blue_res
			inst.image_index = 112.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 111.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.lava_lift == 0.0:
			inst.obj = A.obj_lava_lift_res
			inst.image_index = 168.0
		else:
			inst.obj = A.obj_fast_lava_lift_res
			inst.image_index = 169.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_ground2
		inst.image_index = 170.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.value = 2.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_grinder_res
		inst.image_index = 71.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_bumper_res
		inst.image_index = 34.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_skewer_res
		inst.image_index = GM.instance_find(A.obj_panel_expand, 0).img_mazo
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_claw_res
		inst.image_index = 163.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0


# from objects/obj_panel_circle/Other_22.gml
func _user_12() -> void:
	type = 3.0
	sprite_index = A.spr_panel_circle_7
	image_index = 3.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 3.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 12.0
	posicion = 12.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_onoffblock_res
		inst.image_index = 15.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 15.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		if G.onoff == 0.0:
			inst.obj = A.obj_onoffplatform_res
			inst.image_index = 13.0
		else:
			inst.obj = A.obj_onoffplatform_blue_res
			inst.image_index = 14.0
		inst.mask_index = A.spr_circle_mask7_2
		inst.value = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 233.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_ground
		inst.image_index = 171.0
		inst.mask_index = A.spr_circle_mask7_3
		inst.disabled = 1.0
		inst.value = 2.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 205.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_firebar_res
		inst.image_index = 167.0
		inst.mask_index = A.spr_circle_mask7_4
		inst.value = 3.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 156.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 150.0), A.obj_card_circle)):
		inst.obj = A.obj_oneway_res
		inst.image_index = 105.0
		inst.mask_index = A.spr_circle_mask7_5
		inst.value = 4.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 129.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_card_circle)):
		inst.obj = A.obj_cinta_res
		if G.cintas == 0.0:
			inst.image_index = 42.0
		else:
			inst.image_index = 40.0
		inst.mask_index = A.spr_circle_mask7_6
		inst.value = 5.0
		inst.disabled = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 144.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 74.0), A.obj_card_circle)):
		inst.obj = A.obj_rails_res
		inst.image_index = 173.0
		inst.mask_index = A.spr_circle_mask7_7
		inst.value = 6.0
		inst.disabled = 1.0


# from objects/obj_panel_circle/Other_23.gml
func _user_13() -> void:
	type = 3.0
	sprite_index = A.spr_panel_circle_7
	image_index = 3.0
	for inst in GM.with_list(A.obj_panel_expand):
		inst.header = 3.0
	for inst in GM.with_list(A.obj_header):
		inst.page = 13.0
	posicion = 13.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 58.0), A.obj_card_circle)):
		inst.obj = A.obj_bouncycloud_res
		inst.image_index = 218.0
		inst.mask_index = A.spr_circle_mask7_1
		inst.value = 0.0
		self.image_selected = 218.0


# from objects/obj_panel_circle/Draw_0.gml
func _gm_draw() -> void:
	draw_self()
	if ready_v == 1.0:
		GM.draw_sprite(sprite_selected, image_selected, (GM.camera_get_view_x(GM.view_get_camera(0)) + 181.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 107.0))
