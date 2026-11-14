extends GMObject

var ready_v: float = 0.0  # 原名 ready，与 Node.ready 冲突
var sprite: int = 0
var dark: float = 0.0
var anim: Array = []
var cont: int = 0
var scale: float = 0.0
var dis: float = 0.0


# from objects/obj_title_controller/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	ready_v = 0.0
	sprite = 0.0
	dark = 0.0
	for i: int in range(12):
		GM.aset(anim, i, 0.0)
	cont = 0
	scale = 1.0
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 108.0), A.obj_curtainin)):
		inst.fallow = 1.0


# from objects/obj_title_controller/Step_2.gml
func _step_end() -> void:
	if (G.bg_level == "forest" and (G.apariencia == 3.0 or G.apariencia == 0.0)) or G.bg_level == "castle" or G.bg_level == "underground" or G.bg_level == "ghost" or G.modo_noche == 1.0:
		sprite = A.spr_letters_white
		dark = 1.0
	else:
		sprite = A.spr_letters
		dark = 0.0
	if ready_v == 1.0:
		if GM.instance_exists(A.obj_mario):
			for inst in GM.with_list(A.obj_mario):
				inst.disablecontrols = 1.0
		anim[cont] += 35.0
		if anim[cont] > 196.0:
			if cont == 11:
				alarm[1] = 10.0
				ready_v = 2.0
			cont += 1


# from objects/obj_title_controller/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 3.0


# from objects/obj_title_controller/Alarm_1.gml
func _alarm_1() -> void:
	GM.room_goto(A.rm_editor)


# from objects/obj_title_controller/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_letters_super, dark, (GM.camera_get_view_x(GM.view_get_camera(0)) + 96.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 36.0) + anim[11]))
	GM.draw_sprite(sprite, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 96.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[10]))
	GM.draw_sprite(sprite, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 119.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[9]))
	GM.draw_sprite(sprite, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 138.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[8]))
	GM.draw_sprite(sprite, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 157.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[7]))
	GM.draw_sprite(sprite, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 165.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[6]))
	GM.draw_sprite(sprite, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 195.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[5]))
	GM.draw_sprite(sprite, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 218.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[4]))
	GM.draw_sprite(sprite, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 237.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[3]))
	GM.draw_sprite(sprite, 6.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 256.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[2]))
	GM.draw_sprite(sprite, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 273.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 57.0) + anim[1]))
	GM.draw_sprite(A.spr_we, dark, (GM.camera_get_view_x(GM.view_get_camera(0)) + 214.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + 90.0) + anim[0]))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_set_halign(GM.fa_left)
	dis = GM.gm_round(((98.0 - GM.string_width(GM.string_hash_to_newline(G.my1))) / 2.0))
	GM.draw_sprite(A.spr_bg_panel, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 13.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 201.0))
	GM.draw_text(((GM.camera_get_view_x(GM.view_get_camera(0)) + 13.0) + dis), (GM.camera_get_view_y(GM.view_get_camera(0)) + 199.0), GM.string_hash_to_newline(G.my1))
	GM.draw_set_halign(GM.fa_center)
	GM.draw_sprite(A.spr_bg_panel, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 143.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 201.0))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 199.0), GM.string_hash_to_newline(G.ctor))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_sprite(A.spr_bg_panel, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 333.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 201.0))
	GM.draw_set_font(G.font_google_legacy)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 340.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 199.0), GM.string_hash_to_newline(G.ver))
	GM.draw_set_font(G.font_google)
