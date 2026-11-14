extends GMObject

var c_etiquetas: float = 0.0
var user = null
var fecha = null
var hora = null
var entorno = null
var modo_noche = null
var entorno_image = null
var index_stamp: float = 0.0
var text_draw: Array = []
var text: Array = []


# from objects/obj_gb_level/Create_0.gml
func _create() -> void:
	var mundos
	var _wrapper
	var _list
	var _map
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 184.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 105.0), A.obj_bt_gb_play)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 184.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 82.0), A.obj_bt_gb_edit)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 297.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 138.0), A.obj_bt_gb_delete)
	GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 330.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 54.0), A.obj_bt_gb_close)
	GM.instance_create_depth((GM.camera_get_view_x(GM.view_get_camera(0)) + 184.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 151.0), -7.0, A.obj_bt_rename)
	c_etiquetas = GM.make_colour_rgb(110.0, 119.0, 126.0)
	user = 0.0
	fecha = 0.0
	hora = 0.0
	entorno = 0.0
	modo_noche = 0.0
	entorno_image = 0.0
	index_stamp = 0.0
	for i: int in range(14):
		GM.aset(text_draw, i, Scr.scr_language(self, float(52 + i)))
	GM.aset(text_draw, 14, "Link")
	GM.aset(text_draw, 15, "---")
	text = ["Tradicional", "Puzles", "Contrarreloj", "Autoavance", "Automatismos", "Corto pero intenso", "Competitivo", "Tematico", "Música", "Artístico", "Habilidad", "Disparos", "Contra jefes", "En solitario", "Link", "---"]
	if GM.file_exists((G.directorio + G.levelguardabot)):
		mundos = Scr.LoadJSONFromFile(self, (G.directorio + G.levelguardabot))
		if GM.veq(mundos, 0.0) or GM.veq(mundos, 0.0):
			Scr.scr_toast(self, 1.0, Scr.scr_language(self, 103.0))
			G.levelguardabot = ""
			G.apariencia = 2.0
			G.condiciones = 0.0
			G.condiciones_type = 0.0
			G.condiciones_object = 0.0
			G.condiciones_count = 0.0
			instance_destroy()
			return
		_wrapper = mundos.get("MAIN")
		_list = _wrapper.get("AJUSTES")
		_map = _list[0]
		G.apariencia = _map.get("apariencia")
		G.etiqueta1_temp = _map.get("etiqueta1")
		G.etiqueta2_temp = _map.get("etiqueta2")
		index_stamp = G.etiqueta1_temp
		if G.etiqueta1_temp == -1.0:
			G.etiqueta1_temp = 15.0
			index_stamp = G.etiqueta2_temp
		if G.etiqueta2_temp == -1.0:
			G.etiqueta2_temp = 15.0
		user = _map.get("user")
		fecha = _map.get("date")
		hora = _map.get("time")
		entorno = _map.get("entorno")
		modo_noche = _map.get("modo_noche")
		match entorno:
			"ground":
				entorno_image = 0.0
			"underground":
				entorno_image = 1.0
			"underwater":
				entorno_image = 2.0
			"desert":
				entorno_image = 3.0
			"snow":
				entorno_image = 4.0
			"sky":
				entorno_image = 5.0
			"forest":
				entorno_image = 6.0
			"ghost":
				entorno_image = 7.0
			"airship":
				entorno_image = 8.0
			"castle":
				entorno_image = 9.0
			"fall":
				entorno_image = 10.0
			"beach":
				entorno_image = 11.0
			"mountain":
				entorno_image = 12.0 + modo_noche
			_:
				entorno_image = 0.0
		G.condiciones = _map.get("condiciones")
		G.condiciones_type = _map.get("condiciones_type")
		G.condiciones_object = _map.get("condiciones_object")
		G.condiciones_count = _map.get("condiciones_count")
		if _map.has("description"):
			G.desc = _map.get("description")
		else:
			G.desc = Scr.scr_language(self, 190.0)
		G.user_gb = user
		G.tag1_pub = text[int(G.etiqueta1_temp)]
		G.tag2_pub = text[int(G.etiqueta2_temp)]


# from objects/obj_gb_level/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_bt_gb_play):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_bt_gb_edit):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_bt_gb_delete):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_bt_gb_close):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_bt_rename):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_gb_button):
		inst.alarm[0] = 15.0


# from objects/obj_gb_level/Draw_0.gml
func _gm_draw() -> void:
	var nn_text
	var c_level
	c_level = GM.make_color_rgb(29.0, 42.0, 67.0)
	draw_self()
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_level)
	nn_text = Scr.scr_add3points(self, G.levelguardabot, 270.0, 52.0)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 52.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 54.0), GM.string_hash_to_newline(nn_text))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 55.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 176.0), GM.string_hash_to_newline(G.desc))
	GM.draw_set_color(c_etiquetas)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 59.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 69.0), GM.string_hash_to_newline(user))
	#
	# draw_text((camera_get_view_x(view_get_camera(0)) + 195), (camera_get_view_y(view_get_camera(0)) + 159), string_hash_to_newline(text[global.etiqueta1_temp]));
	# /*
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 86.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 159.0), GM.string_hash_to_newline(text_draw[int(G.etiqueta2_temp)]))
	GM.draw_sprite_ext(A.spr_stamps_new, index_stamp, (GM.camera_get_view_x(GM.view_get_camera(0)) + 44.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 83.0), 0.5, 0.5, image_angle, image_blend, image_alpha)
	if G.condiciones == 0.0:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 53.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 160.0), GM.string_hash_to_newline(text[15]))
	else:
		GM.draw_sprite(A.spr_cond_hud, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 53.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 160.0))
	GM.draw_sprite(A.spr_carteles, G.apariencia, (GM.camera_get_view_x(GM.view_get_camera(0)) + 300.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 84.0))
	GM.draw_sprite(A.spr_cards_entorno, entorno_image, (GM.camera_get_view_x(GM.view_get_camera(0)) + 302.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 111.0))
	GM.draw_sprite(A.spr_day_night_icon, modo_noche, (GM.camera_get_view_x(GM.view_get_camera(0)) + 330.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 121.0))
	GM.draw_sprite(A.spr_date_time_bg, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 44.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 146.0))
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 47.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), GM.string_hash_to_newline(fecha))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 152.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), GM.string_hash_to_newline(hora))
