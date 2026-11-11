extends GMObject

var distancia: float = 0.0
var text_level: String = ""
var texto: String = ""
var c_color: int = 0


# from objects/obj_mariostart/Create_0.gml
func _create() -> void:
	if GM.room == A.rm_guardabot_play:
		GM.instance_activate_all()
	distancia = 0.0
	text_level = ""
	texto = ""
	c_color = GM.make_colour_rgb(89.0, 15.0, 16.0)
	alarm[0] = 30.0
	if G.postnivel == 0.0:
		alarm[1] = 200.0
	else:
		alarm[1] = 260.0


# from objects/obj_mariostart/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_mariostart_m):
		inst.instance_destroy()
	if GM.instance_exists(A.obj_levelmanager):
		for inst in GM.with_list(A.obj_levelmanager):
			inst.canpause = 1.0


# from objects/obj_mariostart/Alarm_0.gml
func _alarm_0() -> void:
	var pos: float  # 局部变量提升（GML 的 var 是函数作用域）
	var posyy: float
	visible = true
	if G.dsm == 0.0:
		pos = 192.0
	else:
		pos = 176.0
	if G.apariencia == 3.0:
		posyy = 124.0
	else:
		posyy = 100.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + pos), (GM.camera_get_view_y(GM.view_get_camera(0)) + posyy), A.obj_mariostart_m)


# from objects/obj_mariostart/Alarm_1.gml
func _alarm_1() -> void:
	GM.instance_activate_all()
	for inst in GM.with_list(A.obj_persistent):
		inst.done = 0.0
	# with (obj_levelmanager) event_user(5)：GM.other 设为外层 self（§3.3 第 17 条）
	var _o: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(5)
	GM.other = _o
	if GM.instance_find(A.obj_persistent, 0).modo_android == 1.0 and G.controles_tactiles == 1.0:
		if GM.room != A.rm_title and GM.room != A.rm_logo and GM.room != A.rm_gameover and GM.room != A.rm_guardabot and GM.room != A.rm_editor:
			GM.other = self
			for inst in GM.with_list(A.obj_persistent):
				inst.event_user(2)
				inst.event_user(3)
			GM.other = _o
	instance_destroy()


# from objects/obj_mariostart/Draw_0.gml
func _gm_draw() -> void:
	var vertext: String  # 局部变量提升（GML 的 var 是函数作用域）
	var author: String = G.author
	var level_id: String = G.level_id
	var tag1: String = G.tag1_pub
	var tag2: String = G.tag2_pub
	var level_name: String = G.level_name
	GM.draw_clear(GM.c_black)
	GM.draw_sprite_stretched(A.spr_mariostart, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 20.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 16.0), 344.0, 49.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	if G.nm_play != 0.0:
		distancia = GM.gm_round(((384.0 - GM.string_width(GM.string_hash_to_newline((level_name)))) / 2.0))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + distancia), (GM.camera_get_view_y(GM.view_get_camera(0)) + 28.0), GM.string_hash_to_newline((level_name)))
		GM.draw_sprite_ext(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 290.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 71.0), 1.5, 1.5, image_angle, image_blend, 0.5)
		GM.draw_sprite_ext(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 290.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 83.0), 1.5, 1.5, image_angle, image_blend, 0.5)
		GM.draw_sprite_ext(A.spr_user_icon, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 343.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0), 1.5, 1.5, image_angle, c_color, 1.0)
		GM.draw_text_ext_transformed_colour((GM.camera_get_view_x(GM.view_get_camera(0)) + 305.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 69.0), GM.string_hash_to_newline(tag1), 32.0, 128.0, 1.0, 1.0, image_angle, GM.c_white, GM.c_white, GM.c_white, GM.c_white, 0.5)
		GM.draw_text_ext_transformed_colour((GM.camera_get_view_x(GM.view_get_camera(0)) + 305.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 81.0), GM.string_hash_to_newline(tag2), 32.0, 128.0, 1.0, 1.0, image_angle, GM.c_white, GM.c_white, GM.c_white, GM.c_white, 0.5)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 342.0 - GM.string_width(author)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0), GM.string_hash_to_newline((author)))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0), GM.string_hash_to_newline((level_id)))
	elif G.levelguardabot != "":
		var ntext: String = GM.string_copy(G.levelguardabot, 1.0, (GM.string_length(G.levelguardabot) - 4.0))
		distancia = GM.gm_round(((384.0 - GM.string_width(GM.string_hash_to_newline((ntext)))) / 2.0))
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + distancia), (GM.camera_get_view_y(GM.view_get_camera(0)) + 28.0), GM.string_hash_to_newline((ntext)))
		GM.draw_sprite_ext(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 290.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 71.0), 1.5, 1.5, image_angle, image_blend, 0.5)
		GM.draw_sprite_ext(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 290.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 83.0), 1.5, 1.5, image_angle, image_blend, 0.5)
		GM.draw_sprite_ext(A.spr_user_icon, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 343.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 50.0), 1.5, 1.5, image_angle, c_color, 1.0)
		GM.draw_text_ext_transformed_colour((GM.camera_get_view_x(GM.view_get_camera(0)) + 305.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 69.0), GM.string_hash_to_newline(tag1), 32.0, 128.0, 1.0, 1.0, image_angle, GM.c_white, GM.c_white, GM.c_white, GM.c_white, 0.5)
		GM.draw_text_ext_transformed_colour((GM.camera_get_view_x(GM.view_get_camera(0)) + 305.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 81.0), GM.string_hash_to_newline(tag2), 32.0, 128.0, 1.0, 1.0, image_angle, GM.c_white, GM.c_white, GM.c_white, GM.c_white, 0.5)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 342.0 - GM.string_width(G.user_gb)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 48.0), GM.string_hash_to_newline((G.user_gb)))
	if G.postnivel != 0.0:
		if G.postnivel == 1.0:
			vertext = Scr.scr_language(self, 74.0)
		else:
			vertext = Scr.scr_language(self, 75.0)
		GM.draw_set_color(GM.c_white)
		GM.draw_set_halign(GM.fa_center)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0)), (GM.camera_get_view_y(GM.view_get_camera(0)) + 162.0), GM.string_hash_to_newline(vertext))
		GM.draw_set_halign(GM.fa_left)
