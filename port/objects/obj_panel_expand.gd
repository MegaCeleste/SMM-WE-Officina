extends GMObject

var value = null
var header: float = 0.0
var draw_circles_1: float = 0.0
var draw_circles_2: float = 0.0
var circle_1: float = 0.0
var circle_2: float = 0.0
var img_1up: float = 0.0
var img_pipes: float = 0.0
var img_mushroom_platform: float = 0.0
var img_semisolid_platform: float = 0.0
var img_puente: float = 0.0
var img_cloud_block: float = 0.0
var img_fireflower: float = 0.0
var img_cap: float = 0.0
var img_donut: float = 0.0
var img_hidden_block: float = 0.0
var img_buzzy: float = 0.0
var img_buzzy_shell: float = 0.0
var img_muncher: float = 0.0
var img_bobomb: float = 0.0
var img_billbanzai: float = 0.0
var img_chomp: float = 0.0
var img_bullet: float = 0.0
var img_cannon: float = 0.0
var img_mazo: float = 0.0
var img_pokey: float = 0.0
var img_ground: float = 0.0
var img_pendiente1: float = 0.0
var img_pinchos: float = 0.0
var img_block: float = 0.0
var img_rock: float = 0.0


# from objects/obj_panel_expand/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	value = 1.0
	header = 0.0
	draw_circles_1 = 0.0
	draw_circles_2 = 0.0
	circle_1 = 0.0
	circle_2 = 0.0
	img_1up = 0.0
	img_pipes = 134.0
	img_mushroom_platform = 90.0
	img_semisolid_platform = 50.0
	img_puente = 118.0
	img_cloud_block = 103.0
	img_fireflower = 61.0
	img_cap = 113.0
	img_donut = 53.0
	img_hidden_block = 11.0
	img_buzzy = 35.0
	img_buzzy_shell = 87.0
	img_muncher = 100.0
	img_bobomb = 25.0
	img_billbanzai = 2.0
	img_chomp = 141.0
	img_bullet = 5.0
	img_cannon = 155.0
	img_mazo = 164.0
	img_pokey = 152.0
	match G.bg_level:
		"snow":
			if G.modo_noche == 1.0:
				img_ground = 85.0
				img_pendiente1 = 208.0
				img_pinchos = 109.0
				img_block = 68.0
				img_rock = 22.0
				img_cloud_block = 177.0
				img_donut = 181.0
			else:
				img_ground = 84.0
				img_pendiente1 = 207.0
				img_pinchos = 108.0
				img_block = 67.0
				img_rock = 21.0
				img_cloud_block = 176.0
				img_donut = 180.0
			img_pokey = 153.0
		"desert":
			img_ground = 83.0
			img_pendiente1 = 206.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
		"sky":
			img_ground = 82.0
			img_pendiente1 = 205.0
			img_pinchos = 106.0
			img_block = 64.0
			if G.apariencia == 0.0:
				img_rock = 19.0
			else:
				img_rock = 21.0
		"forest":
			img_ground = 81.0
			img_pendiente1 = 204.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
			img_hidden_block = 10.0
		"airship":
			if G.modo_noche == 1.0:
				img_ground = 80.0
				img_pendiente1 = 203.0
			else:
				img_ground = 79.0
				img_pendiente1 = 202.0
			img_pinchos = 106.0
			img_block = 66.0
			if G.apariencia == 0.0:
				img_rock = 19.0
			else:
				img_rock = 21.0
		"ghost":
			img_ground = 78.0
			img_pendiente1 = 201.0
			img_pinchos = 106.0
			img_block = 65.0
			img_rock = 18.0
			img_hidden_block = 12.0
		"underwater":
			if G.modo_noche == 1.0:
				img_ground = 77.0
				img_pendiente1 = 200.0
			else:
				img_ground = 76.0
				img_pendiente1 = 199.0
			img_pinchos = 107.0
			img_block = 64.0
			img_rock = 20.0
			img_hidden_block = 8.0
			img_cloud_block = 104.0
		"castle":
			if G.modo_noche == 1.0:
				img_ground = 75.0
				img_pendiente1 = 198.0
			else:
				img_ground = 74.0
				img_pendiente1 = 197.0
			img_pinchos = 106.0
			img_block = 66.0
			img_rock = 19.0
			img_cloud_block = 175.0
			img_donut = 179.0
		"underground":
			img_ground = 73.0
			img_pendiente1 = 196.0
			img_pinchos = 106.0
			img_block = 65.0
			img_rock = 18.0
			img_hidden_block = 12.0
		"ground":
			img_ground = 72.0
			img_pendiente1 = 195.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
		"fall":
			img_ground = 227.0
			img_pendiente1 = 195.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
		"beach":
			img_ground = 226.0
			img_pendiente1 = 195.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
		"mountain":
			if G.modo_noche == 1.0:
				img_ground = 229.0
			else:
				img_ground = 228.0
			img_pendiente1 = 195.0
			img_pinchos = 106.0
			img_block = 64.0
			img_rock = 17.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		img_buzzy = 36.0
		img_buzzy_shell = 88.0
		img_muncher = 101.0
		img_billbanzai = 3.0
		img_chomp = 142.0
		img_bobomb = 26.0
		img_bullet = 6.0
		img_cannon = 156.0
		img_mazo = 165.0
	if G.bg_level == "ghost" or G.bg_level == "underground" or (G.modo_noche == 1.0 and G.bg_level != "snow" and G.bg_level != "castle"):
		img_cloud_block = 174.0
		img_donut = 178.0
	if G.modo_noche == 1.0 and G.bg_level != "underwater":
		img_hidden_block = 12.0
	if G.modo_noche == 1.0 and G.bg_level == "ground":
		img_1up = 123.0
	value = (GM.instance_find(A.obj_editormanager, 0).panel_circle + 1.0)
	if value == 1.0 or value == 2.0:
		header = 0.0
	elif value == 3.0:
		header = 1.0
	elif value == 4.0 or value == 5.0 or value == 6.0 or value == 7.0 or value == 8.0 or value == 9.0:
		header = 2.0
	else:
		header = 3.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 350.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 17.0), A.obj_button_close)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 133.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 13.0), A.obj_header)
	if not GM.instance_exists(A.obj_btn_header_1):
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 1.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 13.0), A.obj_btn_header_1)
	if not GM.instance_exists(A.obj_btn_header_2):
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 2.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 13.0), A.obj_btn_header_2)
	if not GM.instance_exists(A.obj_btn_header_3):
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 3.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 13.0), A.obj_btn_header_3)
	if not GM.instance_exists(A.obj_btn_header_4):
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + Scr.scr_header(self, 4.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 13.0), A.obj_btn_header_4)
	var _with_target2 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 51.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_next_before)
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.image_index = 0.0
	GM.other = _other1
	var _with_target4 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 304.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0), A.obj_next_before)
	var _other3: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target4):
		inst.image_index = 1.0
	GM.other = _other3
	var _with_target6 = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 125.0), A.obj_panel_circle)
	var _other5: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target6):
		inst.can_anim = 1.0
		inst.anim = 0.6
	GM.other = _other5
	# image_speed = 0
	# value = 1
	# header = 0
	# draw_circles_1 = 0
	# draw_circles_2 = 0
	# circle_1 = 0
	# circle_2 = 0
	# img_1up = 0
	# img_pipes = 134
	# img_mushroom_platform = 90
	# img_semisolid_platform = 50
	# img_puente = 118
	# img_cloud_block = 103
	# img_fireflower = 61
	# img_cap = 113
	# img_donut = 53
	# img_hidden_block = 11
	# img_buzzy = 35
	# img_buzzy_shell = 87
	# img_muncher = 100
	# img_bobomb = 25
	# img_billbanzai = 2
	# img_chomp = 141
	# img_bullet = 5
	# img_cannon = 155
	# img_mazo = 164
	# img_pokey = 152
	# switch global.bg_level
	# {
	#    case "snow":
	#        if (global.modo_noche == 1)
	#        {
	#            img_ground = 85
	#            img_pendiente1 = 208
	#            img_pinchos = 109
	#            img_block = 68
	#            img_rock = 22
	#            img_cloud_block = 177
	#            img_donut = 181
	#        }
	#        else
	#        {
	#            img_ground = 84
	#            img_pendiente1 = 207
	#            img_pinchos = 108
	#            img_block = 67
	#            img_rock = 21
	#            img_cloud_block = 176
	#            img_donut = 180
	#        }
	#        img_pokey = 153
	#        break
	#    case "desert":
	#        img_ground = 83
	#        img_pendiente1 = 206
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        break
	#    case "sky":
	#        img_ground = 82
	#        img_pendiente1 = 205
	#        img_pinchos = 106
	#        img_block = 64
	#        if (global.apariencia == 0)
	#            img_rock = 19
	#        else
	#            img_rock = 21
	#        break
	#    case "forest":
	#        img_ground = 81
	#        img_pendiente1 = 204
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        img_hidden_block = 10
	#        break
	#    case "airship":
	#        if (global.modo_noche == 1)
	#        {
	#            img_ground = 80
	#            img_pendiente1 = 203
	#        }
	#        else
	#        {
	#            img_ground = 79
	#            img_pendiente1 = 202
	#        }
	#        img_pinchos = 106
	#        img_block = 66
	#        if (global.apariencia == 0)
	#            img_rock = 19
	#        else
	#            img_rock = 21
	#        break
	#    case "ghost":
	#        img_ground = 78
	#        img_pendiente1 = 201
	#        img_pinchos = 106
	#        img_block = 65
	#        img_rock = 18
	#        img_hidden_block = 12
	#        break
	#    case "underwater":
	#        if (global.modo_noche == 1)
	#        {
	#            img_ground = 77
	#            img_pendiente1 = 200
	#        }
	#        else
	#        {
	#            img_ground = 76
	#            img_pendiente1 = 199
	#        }
	#        img_pinchos = 107
	#        img_block = 64
	#        img_rock = 20
	#        img_hidden_block = 8
	#        img_cloud_block = 104
	#        break
	#    case "castle":
	#        if (global.modo_noche == 1)
	#        {
	#            img_ground = 75
	#            img_pendiente1 = 198
	#        }
	#        else
	#        {
	#            img_ground = 74
	#            img_pendiente1 = 197
	#        }
	#        img_pinchos = 106
	#        img_block = 66
	#        img_rock = 19
	#        img_cloud_block = 175
	#        img_donut = 179
	#        break
	#    case "underground":
	#        img_ground = 73
	#        img_pendiente1 = 196
	#        img_pinchos = 106
	#        img_block = 65
	#        img_rock = 18
	#        img_hidden_block = 12
	#        break
	#    case "ground":
	#        img_ground = 72
	#        img_pendiente1 = 195
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        break
	#    case "fall":
	#        img_ground = 227
	#        img_pendiente1 = 195
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        break
	#    case "beach":
	#        img_ground = 226
	#        img_pendiente1 = 195
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        break
	# 	case "mountain":
	#        if (global.modo_noche == 1)
	#        {
	#            img_ground = 229
	#        }
	#        else
	#        {
	#            img_ground = 228
	#        }
	# 		img_pendiente1 = 195
	#        img_pinchos = 106
	#        img_block = 64
	#        img_rock = 17
	#        break
	# }
	# if (global.bg_level == "castle" || global.bg_level == "ghost" || global.bg_level == "underground" || global.modo_noche == 1)
	# {
	#    img_buzzy = 36
	#    img_buzzy_shell = 88
	#    img_muncher = 101
	#    img_billbanzai = 3
	#    img_chomp = 142
	#    img_bobomb = 26
	#    img_bullet = 6
	#    img_cannon = 156
	#    img_mazo = 165
	# }
	# if (global.bg_level == "ghost" || global.bg_level == "underground" || (global.modo_noche == 1 && global.bg_level != "snow" && global.bg_level != "castle"))
	# {
	#    img_cloud_block = 174
	#    img_donut = 178
	# }
	# if (global.modo_noche == 1 && global.bg_level != "underwater")
	#    img_hidden_block = 12
	# if (global.modo_noche == 1 && global.bg_level == "ground")
	#    img_1up = 123
	# value = (obj_editormanager.panel_circle + 1)
	# instance_create((camera_get_view_x(view_get_camera(0)) + 350), (camera_get_view_y(view_get_camera(0)) + 19), obj_button_close)
	# if (room == rm_editor)
	# {
	# instance_create((camera_get_view_x(view_get_camera(0)) + 133), (camera_get_view_y(view_get_camera(0)) + 13), obj_header)
	# }
	# with (instance_create((camera_get_view_x(view_get_camera(0)) + 51), (camera_get_view_y(view_get_camera(0)) + 111), obj_next_before))
	#    image_index = 0
	# with (instance_create((camera_get_view_x(view_get_camera(0)) + 304), (camera_get_view_y(view_get_camera(0)) + 111), obj_next_before))
	#    image_index = 1
	# with (instance_create((camera_get_view_x(view_get_camera(0)) + 192), (camera_get_view_y(view_get_camera(0)) + 125), obj_panel_circle))
	# {
	#    can_anim = 1
	#    anim = 0.6
	# }
	# if (value == 1 || value == 2)
	#    header = 0
	# else if (value == 3)
	#    header = 1
	# else if (value == 4 || value == 5 || value == 6 || value == 7 || value == 8)
	#    header = 2
	# else
	#    header = 3


# from objects/obj_panel_expand/Destroy_0.gml
func _destroy() -> void:
	var _with_target8 = A.obj_button_close
	var _other7: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target8):
		inst.instance_destroy()
	GM.other = _other7
	var _with_target10 = A.obj_next_before
	var _other9: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target10):
		inst.instance_destroy()
	GM.other = _other9
	var _with_target12 = A.obj_header
	var _other11: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target12):
		inst.instance_destroy()
	GM.other = _other11
	var _with_target14 = A.obj_btn_header_1
	var _other13: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target14):
		inst.instance_destroy()
	GM.other = _other13
	var _with_target16 = A.obj_btn_header_2
	var _other15: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target16):
		inst.instance_destroy()
	GM.other = _other15
	var _with_target18 = A.obj_btn_header_3
	var _other17: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target18):
		inst.instance_destroy()
	GM.other = _other17
	var _with_target20 = A.obj_btn_header_4
	var _other19: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target20):
		inst.instance_destroy()
	GM.other = _other19
	for _obj_write21 in GM.with_list(A.obj_editormanager):
		_obj_write21.panel_circle = GM.instance_find(A.obj_panel_circle, 0).posicion
	var _with_target23 = A.obj_panel_circle
	var _other22: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target23):
		inst.instance_destroy()
	GM.other = _other22
	for _obj_write24 in GM.with_list(A.obj_expand):
		_obj_write24.active = 0.0


# from objects/obj_panel_expand/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite_ext(sprite_index, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), (GM.camera_get_view_width(GM.view_get_camera(0)) / 16.0), (GM.camera_get_view_height(GM.view_get_camera(0)) / 16.0), 0.0, GM.c_white, 1.0)
