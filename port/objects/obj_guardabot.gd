extends GMObject

var c_cont: float = 0.0
var active: float = 0.0
var can_anim: float = 0.0
var anim: float = 0.0
var pos_x: float = 0.0
var pos_y: float = 0.0
var list_post: float = 0.0
var cont_scroll: float = 0.0
var my_list: Array = []
var gb_head: int = 0
var gb_text_level = null
var fname = null
var cantidad: String = ""
var can_x: float = 0.0


# from objects/obj_guardabot/Create_0.gml
func _create() -> void:
	#
	# audio_bus_main.effects[0] = undefined;
	# /*
	G.powerup = 0.0
	G.mariostart = 0.0
	G.modojuego = 0.0
	G.level_g = 1.0
	c_cont = GM.make_colour_rgb(255.0, 215.0, 91.0)
	active = 1.0
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 361.0), GM.camera_get_view_y(GM.view_get_camera(0)) + 4.0, A.obj_menu_editor_ext)
	GM.instance_create(376.0, 58.0, A.obj_scrollbar2)
	can_anim = 1.0
	anim = 0.0
	GM.audio_play_sound(A.snd_guardabot, 99.0, true)
	pos_x = 38.0
	pos_y = 55.0
	list_post = 0.0
	cont_scroll = 1.0
	my_list = []
	if G.idioma == 1.0:
		gb_head = A.spr_guardabot_head_en
	elif G.idioma == 3.0:
		gb_head = A.spr_guardabot_head_it
	elif G.idioma == 4.0:
		gb_head = A.spr_guardabot_head_ch
	else:
		gb_head = A.spr_guardabot_head
	gb_text_level = Scr.scr_language(self, 172.0)
	var dir: DirAccess = DirAccess.open(GM._fix_path(G.directorio))
	if dir != null:
		dir.list_dir_begin()
		fname = dir.get_next()
		while fname != "":
			if not dir.current_is_dir() and fname.to_lower().ends_with(".swe"):
				my_list.append(fname)
			fname = dir.get_next()
		dir.list_dir_end()
	cantidad = GM.string(float(my_list.size()))
	# PORT: 原版截图显示 9/90 和 11/90 分别使用一位和两位数量的对齐。
	if my_list.size() > 9:
		can_x = 306.0
	else:
		can_x = 310.0
	_user_0()
	alarm[0] = 60.0


# from objects/obj_guardabot/Alarm_0.gml
func _alarm_0() -> void:
	if G.press_load == 1.0:
		if GM.instance_number(A.obj_gb_button) < 1:
			GM.room_goto(A.rm_editor)


# from objects/obj_guardabot/Other_4.gml
func _room_start() -> void:
	for inst in GM.with_list(A.obj_rainmaker):
		inst.instance_destroy()


# from objects/obj_guardabot/Other_5.gml
func _room_end() -> void:
	GM.audio_stop_sound(A.snd_guardabot)


# from objects/obj_guardabot/Other_10.gml
func _user_0() -> void:
	var cont
	var i
	var item
	if my_list.size() > 99:
		cont = 99
	else:
		cont = my_list.size()
	i = 0
	while i < cont:
		item = GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + pos_x), (GM.camera_get_view_y(GM.view_get_camera(0)) + pos_y), A.obj_gb_button)
		item.texto = my_list[i]
		if list_post == 2.0:
			pos_x = 38.0
			pos_y += 52.0
			list_post = 0.0
			cont_scroll += 1.0
		else:
			list_post += 1.0
			pos_x += 104.0
		i += 1


# from objects/obj_guardabot/Draw_0.gml
func _gm_draw() -> void:
	if can_anim == 1.0:
		anim += 0.3
	GM.draw_sprite(A.spr_gb_cover1, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 34.0), GM.camera_get_view_y(GM.view_get_camera(0)))
	GM.draw_sprite(A.spr_gb_cover2, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 34.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 206.0))
	GM.draw_sprite(gb_head, anim, (GM.camera_get_view_x(GM.view_get_camera(0)) + 94.0), GM.camera_get_view_y(GM.view_get_camera(0)))
	GM.draw_set_font(G.font_google)
	GM.draw_text_color((GM.camera_get_view_x(GM.view_get_camera(0)) + can_x), (GM.camera_get_view_y(GM.view_get_camera(0)) + 6.0), GM.string_hash_to_newline((cantidad + "/90")), c_cont, c_cont, c_cont, c_cont, 1.0)
	GM.draw_sprite(A.spr_guardabot_tabs, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 34.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 30.0))
	GM.draw_set_color(GM.c_white)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 176.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 32.0), GM.string_hash_to_newline(gb_text_level))
