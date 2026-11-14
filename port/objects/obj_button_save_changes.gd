extends GMObject

# Assigned by scr_toast in the caller instance, as in GML.
var texto = null
var ancho = null
var xx = null
var yy = null
var toast = null

var effect_hover: float = 0.0
var anim: float = 0.0
var press: float = 0.0


# from objects/obj_button_save_changes/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	if GM.veq(G.save_changes, 0.0):
		image_index = 0.0
	else:
		image_index = 1.0
	effect_hover = 0.0
	anim = 0.0
	press = 1.0


# from objects/obj_button_save_changes/Alarm_0.gml
func _alarm_0() -> void:
	if GM.instance_exists(A.obj_parent_resource):
		if GM.instance_exists(A.obj_arrow_lock) and GM.instance_find(A.obj_arrow_lock, 0).visible == true:
			var _with_target2 = A.obj_load_image
			var _other1: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target2):
				inst.instance_destroy()
			GM.other = _other1
			G.instance_deactivate = 1.0
			Scr.scr_toast(self, 1.0, Scr.scr_language(self, 91.0))
		else:
			_user_0()
	else:
		G.instance_deactivate = 1.0
		var _with_target4 = A.obj_load_image
		var _other3: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target4):
			inst.instance_destroy()
		GM.other = _other3
		Scr.scr_toast(self, 1.0, Scr.scr_language(self, 92.0))


# from objects/obj_button_save_changes/Other_10.gml
func _user_0() -> void:
	var day  # 局部变量提升（GML 的 var 是函数作用域）
	var hour  # 局部变量提升（GML 的 var 是函数作用域）
	var minute  # 局部变量提升（GML 的 var 是函数作用域）
	var month  # 局部变量提升（GML 的 var 是函数作用域）
	var year  # 局部变量提升（GML 的 var 是函数作用域）
	if GM.os_type != GM.os_android:
		if not GM.directory_exists(G.directorio):
			GM.directory_create(G.directorio)
	var _root_list2 = []
	var _map2 = {}
	_root_list2.append(_map2)
	pass
	if GM.current_day < 10.0:
		day = ("0" + GM.string(GM.current_day))
	else:
		day = GM.string(GM.current_day)
	if GM.current_month < 10.0:
		month = ("0" + GM.string(GM.current_month))
	else:
		month = GM.string(GM.current_month)
	if GM.current_year < 10.0:
		year = ("0" + GM.string(GM.current_year))
	else:
		year = GM.string(GM.current_year)
	var date = ((((day + "/") + month) + "/") + year)
	if GM.current_hour < 10.0:
		hour = ("0" + GM.string(GM.current_hour))
	else:
		hour = GM.string(GM.current_hour)
	if GM.current_minute < 10.0:
		minute = ("0" + GM.string(GM.current_minute))
	else:
		minute = GM.string(GM.current_minute)
	var time = ((hour + ":") + minute)
	_map2["user"] = G.my1
	_map2["etiqueta1"] = G.etiqueta1_temp
	_map2["etiqueta2"] = G.etiqueta2_temp
	_map2["apariencia"] = G.apariencia
	_map2["entorno"] = G.bg_level
	_map2["cronometro"] = GM.instance_find(A.obj_levelmanager, 0).leveltime
	_map2["autoavance"] = G.autoavance
	_map2["modo_noche"] = G.modo_noche
	_map2["ground2"] = GM.instance_find(A.obj_ground2, 0).y
	_map2["ground3_x"] = GM.instance_find(A.obj_ground3, 0).x
	_map2["ground3_y"] = GM.instance_find(A.obj_ground3, 0).y
	_map2["size"] = GM.room_width
	_map2["water_level"] = GM.instance_find(A.obj_card_bout, 0).pos_y
	_map2["water_level_limit"] = GM.instance_find(A.obj_card_bout, 0).pos_y_limit
	_map2["water_level_speed"] = G.water_speed
	_map2["date"] = date
	_map2["time"] = time
	_map2["condiciones"] = G.condiciones
	_map2["condiciones_type"] = G.condiciones_type
	_map2["condiciones_object"] = G.condiciones_object
	_map2["condiciones_count"] = G.condiciones_count
	_map2["ds_s"] = G.sounds_level
	_map2["meteorites"] = G.meteoritos
	_map2["description"] = G.desc
	var _root_list3 = []
	if GM.instance_exists(A.obj_ground):
		var _with_target6 = A.obj_ground
		var _other5: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target6):
			var _map3 = {}
			_root_list3.append(_map3)
			pass
			_map3["x_pos"] = inst.x
			_map3["y_pos"] = inst.y
			_map3["index"] = inst.image_index
		GM.other = _other5
	var _root_list6 = []
	if GM.instance_exists(A.obj_decoracion_parent):
		var _with_target8 = A.obj_decoracion_parent
		var _other7: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target8):
			var _map6 = {}
			_root_list6.append(_map6)
			pass
			_map6["object"] = GM.object_get_name(inst.object_index)
			_map6["x_pos"] = inst.x
			_map6["y_pos"] = inst.y
			_map6["sprite"] = GM.sprite_get_name(inst.sprite_index)
			_map6["index"] = inst.image_index
		GM.other = _other7
	var _root_list = []
	var _with_target10 = A.obj_parent_resource
	var _other9: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target10):
		if inst.object_index != A.obj_tuberia_res and inst.object_index != A.obj_cannon_res and inst.object_index != A.obj_cannon_red_res and inst.object_index != A.obj_semisolid_platform1 and inst.object_index != A.obj_mushroom_platform_res and inst.object_index != A.obj_vine_res and inst.object_index != A.obj_pokey_res and inst.object_index != A.obj_bullebill_base_red_res and inst.object_index != A.obj_bullebill_base_res and inst.object_index != A.obj_platform_res and inst.object_index != A.obj_platform_blue_res and inst.object_index != A.obj_puente_res and inst.object_index != A.obj_door_res and inst.object_index != A.obj_door_exit_res and inst.object_index != A.obj_door_switch_res and inst.object_index != A.obj_door_switch_exit_res and inst.object_index != A.obj_door_lock_res and inst.object_index != A.obj_door_lock_exit_res and inst.object_index != A.obj_firebar_res and inst.object_index != A.obj_ground:
			var _map = {}
			_root_list.append(_map)
			pass
			_map["object"] = GM.object_get_name(inst.object_index)
			_map["x_pos"] = inst.x
			_map["y_pos"] = inst.y
			_map["sprout"] = inst.sprout
			_map["progresivo"] = inst.progresivo
			_map["wings"] = inst.wings
			_map["rotacion"] = inst.rotacion
			_map["direct_t"] = inst.direct_t
			_map["paracaidas"] = inst.paracaidas
			_map["key"] = inst.key
			_map["inup"] = inst.inup
			_map["modo_water"] = inst.modo_water
			_map["s_scaley"] = inst.s_scaley
	GM.other = _other9
	var _root_list4 = []
	var _with_target12 = A.obj_parent_resource
	var _other11: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target12):
		if inst.object_index == A.obj_tuberia_res and inst.warp != 2.0:
			var _map4 = {}
			_root_list4.append(_map4)
			pass
			_map4["x_pos"] = inst.x
			_map4["y_pos"] = inst.y
			_map4["size"] = inst.size
			_map4["rotacion"] = inst.rotacion
			_map4["direct_t"] = inst.direct_t
			_map4["scalex"] = inst.s_scalex
			_map4["color"] = inst.color
			_map4["mask"] = inst.plant
			_map4["xscale"] = inst.image_xscale
			_map4["yscale"] = inst.image_yscale
			_map4["warp"] = inst.warp
			_map4["t_x_pos"] = inst.t_x_pos
			_map4["t_y_pos"] = inst.t_y_pos
			_map4["t_size"] = inst.t_size
			_map4["t_rotacion"] = inst.t_rotacion
			_map4["t_direct_t"] = inst.t_direct_t
			_map4["t_s_scalex"] = inst.t_s_scalex
			_map4["t_color"] = inst.t_color
			_map4["t_xscale"] = inst.t_xscale
			_map4["t_yscale"] = inst.t_yscale
	GM.other = _other11
	var _root_list5 = []
	var _with_target14 = A.obj_parent_resource
	var _other13: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target14):
		if inst.object_index == A.obj_cannon_res or inst.object_index == A.obj_cannon_red_res:
			var _map5 = {}
			_root_list5.append(_map5)
			pass
			_map5["object"] = GM.object_get_name(inst.object_index)
			_map5["x_pos"] = inst.x
			_map5["y_pos"] = inst.y
			_map5["direct"] = inst.direct
			_map5["down"] = inst.d
			_map5["up"] = inst.u
			_map5["left"] = inst.l
			_map5["right"] = inst.r
	GM.other = _other13
	var _root_list7 = []
	var _with_target16 = A.obj_parent_resource
	var _other15: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target16):
		if inst.object_index == A.obj_semisolid_platform1 or inst.object_index == A.obj_mushroom_platform_res or inst.object_index == A.obj_vine_res or inst.object_index == A.obj_platform_res or inst.object_index == A.obj_platform_blue_res or inst.object_index == A.obj_puente_res or inst.object_index == A.obj_pokey_res or inst.object_index == A.obj_bullebill_base_red_res or inst.object_index == A.obj_bullebill_base_res or inst.object_index == A.obj_firebar_res:
			var _map7 = {}
			_root_list7.append(_map7)
			pass
			_map7["object"] = GM.object_get_name(inst.object_index)
			_map7["x_pos"] = inst.x
			_map7["y_pos"] = inst.y
			_map7["sprite"] = GM.sprite_get_name(inst.sprite_index)
			_map7["color"] = inst.color
			_map7["depth"] = inst.depth
			_map7["width"] = inst.size_x
			_map7["height"] = inst.size_y
			_map7["direct_t"] = inst.direct_t
			_map7["wings"] = inst.wings
	GM.other = _other15
	var _root_list8 = []
	var _with_target18 = A.obj_parent_resource
	var _other17: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target18):
		if inst.object_index == A.obj_door_res or inst.object_index == A.obj_door_switch_res or inst.object_index == A.obj_door_lock_res:
			var _map8 = {}
			_root_list8.append(_map8)
			pass
			_map8["object"] = GM.object_get_name(inst.object_index)
			_map8["x_pos"] = inst.x
			_map8["y_pos"] = inst.y
			_map8["door_x"] = inst.door_x
			_map8["door_y"] = inst.door_y
	GM.other = _other17
	var _wrapper = {}
	_wrapper["AJUSTES"] = _root_list2
	_wrapper["SUELO"] = _root_list3
	_wrapper["DECORACION"] = _root_list6
	_wrapper["NIVEL"] = _root_list
	_wrapper["TUBERIAS"] = _root_list4
	_wrapper["CANNON"] = _root_list5
	_wrapper["PLATAFORMAS"] = _root_list7
	_wrapper["PUERTAS"] = _root_list8
	var _root_list_sub1 = []
	var sub1 = {}
	sub1["AJUSTES"] = _root_list_sub1
	var mundo = {}
	mundo["MAIN"] = _wrapper
	mundo["SUB1"] = sub1
	var _string = GM.json_encode(mundo)
	_string = GM.string_replace_all(_string, ".000000", "")
	var _string_code = GM.base64_encode(_string)
	var _hash = Scr.sha1_string_utf8_hmac(self, G.drez, _string_code)
	_string_code += _hash
	Scr.SaveStringToFile(self, (G.directorio + G.save_changes), _string_code)
	G.last_level = G.save_changes
	G.levelguardabot = G.last_level
	pass
	var _with_target20 = A.obj_load_image
	var _other19: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target20):
		inst.instance_destroy()
	GM.other = _other19
	Scr.scr_toast(self, 0.0, Scr.scr_language(self, 95.0))
	G.instance_deactivate = 1.0
	for _obj_write21 in GM.with_list(A.obj_editormanager):
		_obj_write21.expand_open = 0.0
	if GM.instance_exists(A.obj_panel_save_load):
		var _with_target23 = A.obj_panel_save_load
		var _other22: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target23):
			inst.event_user(0)
		GM.other = _other22
	if GM.instance_exists(A.obj_robot):
		var _with_target25 = A.obj_robot
		var _other24: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target25):
			inst.active = 0.0
			inst.canpress = 0.0
		GM.other = _other24


# from objects/obj_button_save_changes/Draw_0.gml
func _gm_draw() -> void:
	var c_color
	var ypos
	if image_index == 0.0:
		c_color = GM.make_color_rgb(145.0, 145.0, 145.0)
	else:
		c_color = GM.make_color_rgb(199.0, 61.0, 71.0)
	if G.idioma == 1.0:
		ypos = 7.0
	else:
		ypos = 0.0
	draw_self()
	if effect_hover == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, x, y, anim, 2.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_color)
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_top)
	GM.draw_text(x + 15.0, y + 4.0 + ypos, GM.string_hash_to_newline(Scr.scr_language(self, 105.0)))
	GM.draw_set_halign(GM.fa_left)
	GM.draw_set_valign(GM.fa_left)


# from objects/obj_button_save_changes/Mouse_4.gml
func _mouse_4() -> void:
	if image_index == 1.0 and not GM.veq(G.save_changes, 0.0) and press == 1.0 and GM.instance_exists(A.obj_panel_save_load):
		GM.audio_play_sound(A.snd_select_guardabot, 0.0, false)
		if GM.instance_exists(A.obj_robot):
			var _with_target27 = A.obj_robot
			var _other26: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target27):
				inst.canpress = 1.0
			GM.other = _other26
		GM.file_delete(G.save_changes)
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 338.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 198.0), A.obj_load_image)
		G.instance_deactivate = 0.0
		press = 0.0
		alarm[0] = 12.0


# from objects/obj_button_save_changes/Mouse_10.gml
func _mouse_10() -> void:
	if image_index == 1.0:
		if effect_hover == 0.0:
			GM.audio_stop_sound(A.snd_panel_right_move)
			GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
		effect_hover = 1.0


# from objects/obj_button_save_changes/Mouse_11.gml
func _mouse_11() -> void:
	effect_hover = 0.0
