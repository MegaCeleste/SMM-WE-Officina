# from objects/obj_persistent/（第 2 批移植，已逐事件核对）
# 唯一的 persistent object。设置文件改用 ConfigFile；Discord/NekoPresence
#（Other_60、Other_70、np_* 调用）和 Android 分支不移植。
# 触屏虚拟按键（Other_12–15）照翻，兼容层的 virtual_key_* 现在是空实现。
extends GMObject

var airship: float = 0.0
var port_y: float = 0.0
var prev_hspeeds: float = 0.0
var mode: float = 0.0
var done: float = 0.0
var ready_v: float = 0.0  # 原名 ready（和 Node.ready 撞名）
var s: float = 2.0
var vk_movimientos: float = 0.0
var vk_saltos: float = 0.0
var modo_android: float = 0.0
var sleep_tm: float = 0.0
var opacidad: float = 0.0
var back: float = -1.0  ## 截图 sprite 编号，-1 表示没有
var message: String = ""
var directorio_temp: String = ""
var leftstick: Array = []
var gp_stick: Array = []
var fullscreen: float = 0.0
var shock_enabled: float = 0.0
var var_time_var: float = 0.0
var pronto = null
var filter: float = 1.0
var mobile_keys: Array = []
var uni_time = null  # init_shockwave 里赋值
var uni_mouse_pos = null  # init_shockwave 里赋值
var var_mouse_pos_x = null  # init_shockwave 里赋值
var var_mouse_pos_y = null  # init_shockwave 里赋值
var uni_resolution = null  # init_shockwave 里赋值
var var_resolution_x = null  # init_shockwave 里赋值
var var_resolution_y = null  # init_shockwave 里赋值
var uni_shock_amplitude = null  # init_shockwave 里赋值
var var_shock_amplitude = null  # init_shockwave 里赋值
var uni_shock_refraction = null  # init_shockwave 里赋值
var var_shock_refraction = null  # init_shockwave 里赋值
var uni_shock_width = null  # init_shockwave 里赋值
var var_shock_width = null  # init_shockwave 里赋值
var cronometro = null
var cronometro_play = null
var cronometro_restart = null

const SETTINGS_PATH: String = "user://settings.cfg"
const SETTINGS_NUMBERS: Array[String] = [
	"vsync", "lanzar_agarrar", "saltar", "saltar_spin", "pause", "jugador",
	"arriba", "abajo", "izquierda", "derecha", "idioma", "w_scale",
	"audiomaster", "sm4j_style", "effect_star", "hd", "controller",
]


# from objects/obj_persistent/Create_0.gml
func _create() -> void:
	GM.gml_release_mode(true)
	Scr.init_shockwave(self)
	GM.audio_master_gain(0.25)
	var gamepad: bool
	GM.randomise()
	G.audiomaster = 0.25
	airship = 0.0
	port_y = 0.0
	prev_hspeeds = 0.0
	G.level_g = 0.0
	G.init_DSM = 0.0
	G.vsync = 1.0
	G.DSM_2 = 0.0
	G.hardness = ""
	G.mondi = 7.0
	G.pp = 0.0
	G.level_group = 0.0
	G.levelguardabot = ""
	G.nm_play = 0.0
	G.level_id = ""
	G.level_name = ""
	G.intentos = ""
	G.number_like = 0.0
	G.level_like = 3.0
	G.style_course = 0.0
	G.map_consult = -4.0
	G.type_consult = -4.0
	G.id_CR = 0.0
	G.liked_CR = 0.0
	G.complete_CR = 0.0
	G.pages_nm = 1.0
	G.tabvalue = 2.0
	G.ms_check = 0.0
	G.nrecord = 0.0
	G.record = 0.0
	G.warp_item = -4.0
	G.warp_x = 0.0
	G.warp_y = 0.0
	G.hd = 1.0
	G.meteoritos = 0.0
	G.shadows = 0.0
	G.user_gb = ""
	G.jump = 0.0
	G.etiq_nm = ""
	mode = 0.0
	done = 0.0
	ready_v = 0.0
	s = 2.0
	G.sounds_level = 0.0
	G.powerup_editor = 0.0
	G.star_flash = 0.0
	G.scroll_perc = 0.0
	G.sonidos = 1.0
	G.completed_levels = 0.0
	G.lives = 0.0
	G.my1 = 0.0
	G.my2 = 0.0
	G.my3 = -1.0
	G.my4 = -1.0
	G.my5 = 0.0
	G.my6 = -1.0
	G.my7 = -1.0
	G.desc = ""
	G.ss = 0.0
	G.name_user = ""
	G.name_users = ""
	G.last_level = ""
	G.key_h = "clave765409"
	G.played_levels = []  # ds_list_create()
	G.condiciones = 0.0
	G.condiciones_clear = 0.0
	G.condiciones_type = 0.0
	G.condiciones_object = 0.0
	G.condiciones_count = 0.0
	G.controller = 1.0
	vk_movimientos = 0.0
	vk_saltos = 0.0
	if GM.os_type == GM.os_android:
		modo_android = 1.0
		sleep_tm = 4.0
	else:
		modo_android = 0.0
		sleep_tm = 10.0
	G.save_changes = 0.0
	G.controles_tactiles = 1.0
	G.sm4j_style = 0.0
	G.effect_star = 1.0
	G.idioma = 0.0
	G.modo_noche = 0.0
	G.entorno = "ground"
	G.apariencia = 2.0
	G.dsm = 0.0
	G.difficultyd = -1.0
	G.difficulty = 0.0
	if G.apariencia == 0.0:
		G.fade = 0.3
	elif G.apariencia == 1.0:
		G.fade = 0.5
	else:
		G.fade = 0.25
	opacidad = 0.5
	G.key_br = 0.0
	back = -1.0
	message = ""
	port_y = 0.0
	G.showfps = 0.0
	Scr.scr_init_globals(self)
	G.gw = 384.0
	G.gh = 216.0
	G.font_google_legacy = GM.font_add("font_as.ttf", 12.0, 0.0, 0.0, 32.0, 128.0)
	G.font_google = GM.font_add("fontcjk.ttf", 12.0, 0.0, 0.0, 32.0, 128.0)
	G.levelmusic = A.snd_gameover
	G.drez = "2559F35097-2021"
	G.ctor = "2024 | OpenWE"  # 
	G.ver = "V1.0.0"
	G.descver = "OpenWE | Build ver. 1.0.0 - 11012024"
	G.wdigits_SMB = GM.font_add_sprite_ext(A.spr_SMB_numbers, "0123456789", 0.0, 0.0)
	G.wdigits_SMB3 = GM.font_add_sprite_ext(A.spr_SMB3_numbers, "0123456789", 0.0, 0.0)
	G.wdigits = GM.font_add_sprite_ext(A.spr_numbers, "0123456789", 0.0, 0.0)
	G.wdigits_NSMBU = GM.font_add_sprite_ext(A.spr_NSMBU_numbers, "0123456789", 0.0, 0.0)
	G.wdigits_NSMBU_points = GM.font_add_sprite_ext(A.spr_NSMBU_numbers_points, "0123456789", 0.0, 0.0)
	G.big_digits = GM.font_add_sprite_ext(A.spr_numbers_big, "0123456789", 0.0, 0.0)
	G.time_digits = GM.font_add_sprite_ext(A.spr_numbers_time, "0123456789", 0.0, 0.0)
	G.time_digits_white = GM.font_add_sprite_ext(A.spr_numbers_time_white, "0123456789", 0.0, 0.0)
	G.numbers_lives = GM.font_add_sprite_ext(A.spr_numbers_lives, "0123456789", 0.0, 0.0)
	directorio_temp = ""
	if GM.os_type == GM.os_android:
		# Android 分支不移植（port-plan §0）
		# GML: global.directorio_temp = getDire1("SMM_WE")
		# GML: global.directorio = (global.directorio_temp + "/")
		# GML: global.directorio_temporal = (working_directory + "/temp/")
		pass
	else:
		G.directorio_temp = (GM.working_directory + "Niveles\\")
		G.directorio = (GM.working_directory + "Niveles\\")
		G.directorio_temporal = (GM.working_directory + "temp\\")
	gamepad = GM.gamepad_is_connected(0)
	GM.aset(leftstick, 0, 0.0)
	GM.aset(leftstick, 1, 0.0)
	GM.aset(leftstick, 2, 0.0)
	GM.aset(leftstick, 3, 0.0)
	GM.aset(G.data, 0, "")
	GM.aset(G.data, 1, "")
	GM.aset(G.data, 2, "")
	GM.aset(G.data, 3, "")
	G.subpixels = true
	var _gp: int = 0
	while _gp < 5:
		# GML 的 gp_stick[_gp][k] = 0 会自动建出二维数组
		if _gp >= gp_stick.size() or not (gp_stick[_gp] is Array):
			GM.aset(gp_stick, _gp, [])
		GM.aset(gp_stick[_gp], 0, 0.0)
		GM.aset(gp_stick[_gp], 1, 0.0)
		GM.aset(gp_stick[_gp], 2, 0.0)
		GM.aset(gp_stick[_gp], 3, 0.0)
		_gp += 1
	GM.math_set_epsilon(0.00001)
	GM.application_surface_draw_enable(false)


# from objects/obj_persistent/Step_0.gml
func _step() -> void:
	if G.pp == 0.0:
		if G.controller == 1.0:
			var gp_count: int = 0
			while gp_count < 5:
				if GM.gamepad_is_connected(gp_count):
					if gp_stick[gp_count][0] == 0.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislv) <= -0.5:
						gp_stick[gp_count][0] = 1.0
						GM.keyboard_key_press(G.arriba)
					elif gp_stick[gp_count][0] == 1.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislv) > -0.5:
						gp_stick[gp_count][0] = 0.0
						GM.keyboard_key_release(G.arriba)
					if gp_stick[gp_count][1] == 0.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislv) >= 0.5:
						gp_stick[gp_count][1] = 1.0
						GM.keyboard_key_press(G.abajo)
					elif gp_stick[gp_count][1] == 1.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislv) < 0.5:
						gp_stick[gp_count][1] = 0.0
						GM.keyboard_key_release(G.abajo)
					if gp_stick[gp_count][2] == 0.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislh) <= -0.5:
						gp_stick[gp_count][2] = 1.0
						GM.keyboard_key_press(G.izquierda)
					elif gp_stick[gp_count][2] == 1.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislh) > -0.5:
						gp_stick[gp_count][2] = 0.0
						GM.keyboard_key_release(G.izquierda)
					if gp_stick[gp_count][3] == 0.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislh) >= 0.5:
						gp_stick[gp_count][3] = 1.0
						GM.keyboard_key_press(G.derecha)
					elif gp_stick[gp_count][3] == 1.0 and GM.gamepad_axis_value(gp_count, GM.gp_axislh) < 0.5:
						gp_stick[gp_count][3] = 0.0
						GM.keyboard_key_release(G.derecha)
					if GM.gamepad_button_check(gp_count, GM.gp_padu):
						GM.keyboard_key_press(G.arriba)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_padu):
						GM.keyboard_key_release(G.arriba)
					if GM.gamepad_button_check(gp_count, GM.gp_padd):
						GM.keyboard_key_press(G.abajo)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_padd):
						GM.keyboard_key_release(G.abajo)
					if GM.gamepad_button_check(gp_count, GM.gp_padl):
						GM.keyboard_key_press(G.izquierda)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_padl):
						GM.keyboard_key_release(G.izquierda)
					if GM.gamepad_button_check(gp_count, GM.gp_shoulderl):
						GM.keyboard_key_press(G.saltar_spin)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_shoulderl):
						GM.keyboard_key_release(G.saltar_spin)
					if GM.gamepad_button_check(gp_count, GM.gp_shoulderlb):
						GM.keyboard_key_press(G.saltar_spin)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_shoulderlb):
						GM.keyboard_key_release(G.saltar_spin)
					if GM.gamepad_button_check(gp_count, GM.gp_padr):
						GM.keyboard_key_press(G.derecha)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_padr):
						GM.keyboard_key_release(G.derecha)
					if GM.gamepad_button_check(gp_count, GM.gp_shoulderr):
						GM.keyboard_key_press(G.saltar_spin)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_shoulderr):
						GM.keyboard_key_release(G.saltar_spin)
					if GM.gamepad_button_check(gp_count, GM.gp_shoulderrb):
						GM.keyboard_key_press(G.saltar_spin)
					elif GM.gamepad_button_check_released(gp_count, GM.gp_shoulderrb):
						GM.keyboard_key_release(G.saltar_spin)
					if gp_count == 4:
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face1):
							GM.keyboard_key_press(G.lanzar_agarrar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face1):
							GM.keyboard_key_release(G.lanzar_agarrar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face4):
							GM.keyboard_key_press(G.lanzar_agarrar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face4):
							GM.keyboard_key_release(G.lanzar_agarrar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_select):
							GM.keyboard_key_press(GM.vk_space)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_select):
							GM.keyboard_key_release(GM.vk_space)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face2):
							GM.keyboard_key_press(G.saltar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face2):
							GM.keyboard_key_release(G.saltar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_start):
							GM.keyboard_key_press(GM.vk_return)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_start):
							GM.keyboard_key_release(GM.vk_return)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face3):
							GM.keyboard_key_press(G.saltar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face3):
							GM.keyboard_key_release(G.saltar)
					else:
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face3):
							GM.keyboard_key_press(G.lanzar_agarrar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face3):
							GM.keyboard_key_release(G.lanzar_agarrar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face4):
							GM.keyboard_key_press(G.lanzar_agarrar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face4):
							GM.keyboard_key_release(G.lanzar_agarrar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_select):
							GM.keyboard_key_press(GM.vk_space)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_select):
							GM.keyboard_key_release(GM.vk_space)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face2):
							GM.keyboard_key_press(G.saltar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face2):
							GM.keyboard_key_release(G.saltar)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_start):
							GM.keyboard_key_press(GM.vk_return)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_start):
							GM.keyboard_key_release(GM.vk_return)
						if GM.gamepad_button_check_pressed(gp_count, GM.gp_face1):
							GM.keyboard_key_press(G.saltar)
						elif GM.gamepad_button_check_released(gp_count, GM.gp_face1):
							GM.keyboard_key_release(G.saltar)
				gp_count += 1


# from objects/obj_persistent/Alarm_0.gml
func _alarm_0() -> void:
	# / @description Stop fading to black
	# Set mode to fade from black
	mode = 0.0
	# Begin fading from black
	if not GM.instance_exists(A.obj_mariostart):
		done = 0.0
		GM.instance_activate_all()
	# Delete the screenshot
	if GM.sprite_exists(back):
		GM.sprite_delete(back)


# from objects/obj_persistent/Alarm_1.gml
func _alarm_1() -> void:
	GM.instance_deactivate_all(true, self)
	GM.instance_activate_object(A.obj_mariostart)


# from objects/obj_persistent/Alarm_2.gml
func _alarm_2() -> void:
	# / @description Center the window
	GM.window_center()


# from objects/obj_persistent/Alarm_3.gml
func _alarm_3() -> void:
	message = ""


# from objects/obj_persistent/Alarm_4.gml
func _alarm_4() -> void:
	if ready_v == 0.0:
		ready_v = 1.0
		GM.room_goto(A.rm_intro)
	else:
		for inst in GM.with_list(A.obj_intro_controller):
			inst.instance_destroy()
		GM.audio_play_sound(A.snd_add_paracaidas, 0.0, false)
		Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_lg)
		#
		#    with (instance_create(4, 11, obj_btn_idioma))
		#        value = 0
		#    with (instance_create(35, 11, obj_btn_idioma))
		#        value = 1
		#    with (instance_create(66, 11, obj_btn_idioma))
		#        value = 2
		# 	/*
		GM.instance_create(0.0, 0.0, A.obj_login_control)
		GM.instance_create(149.0, 138.0, A.obj_btn_invitado)
		GM.instance_create(123.0, 138.0, A.obj_btn_iniciar)
		GM.instance_create(286.0, 185.0, A.obj_btn_social)
		for inst in GM.with_list(GM.instance_create(308.0, 185.0, A.obj_btn_social)):
			inst.image_index = 1.0
			inst.link = inst.url_dc
		for inst in GM.with_list(GM.instance_create(330.0, 185.0, A.obj_btn_social)):
			inst.image_index = 2.0
			inst.link = inst.url_yt
		for inst in GM.with_list(GM.instance_create(352.0, 185.0, A.obj_btn_social)):
			inst.image_index = 3.0
			inst.link = inst.url_tw
		GM.instance_create(0.0, 0.0, A.obj_cursor)
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 189.0), A.obj_version)


# from objects/obj_persistent/Alarm_5.gml
func _alarm_5() -> void:
	# / @description Because GM: Studio is buggy, delay applying settings
	# Apply fullscreen
	GM.window_set_fullscreen(fullscreen)
	# Set window size and resize surface
	_user_1()


# from objects/obj_persistent/Alarm_6.gml
func _alarm_6() -> void:
	GM.audio_play_sound(Scr.scr_snd_switchalert(self), 0.0, false)


# from objects/obj_persistent/Alarm_7.gml
func _alarm_7() -> void:
	shock_enabled = 0.0
	var_time_var = 0.0


# from objects/obj_persistent/Alarm_8.gml
func _alarm_8() -> void:
	if GM.instance_exists(A.obj_editormanager):
		for inst in GM.with_list(A.obj_editormanager):
			inst.expand_open = 0.0


# from objects/obj_persistent/Alarm_9.gml
func _alarm_9() -> void:
	# / @description Check if Discord's running
	ready_v = 1.0  # GML: ready = true
	G.discord_initialized = false


# from objects/obj_persistent/Alarm_10.gml
func _alarm_10() -> void:
	if G.apariencia == 0.0:
		G.fade = 0.3
	elif G.apariencia == 1.0:
		G.fade = 0.5
	else:
		G.fade = 0.25


# from objects/obj_persistent/Alarm_11.gml
func _alarm_11() -> void:
	# Set VSync
	if G.vsync == 0.0:
		if GM.display_get_timing_method() != GM.tm_sleep:
			GM.display_set_timing_method(GM.tm_sleep)
			if GM.display_get_sleep_margin() != sleep_tm:
				GM.display_set_sleep_margin(sleep_tm)
	else:
		GM.display_set_timing_method(GM.tm_countvsyncs)


# from objects/obj_persistent/Other_2.gml
func _game_start() -> void:
	if GM.os_type != GM.os_android:
		# #macro DISCORD_APP_ID "699637175360421948"（全局宏，引用处写 Scr.DISCORD_APP_ID）
		pronto = false
		alarm[9] = GM.room_speed * 5.0
		#
		# if (!np_initdiscord(DISCORD_APP_ID, true, np_steam_app_id_empty))
		# {
		# 	show_error("NekoPresence init fail.", true);
		# }
		# /*
	if GM.os_type == GM.os_android:
		sleep_tm = 4.0
	else:
		sleep_tm = 10.0
	fullscreen = 0.0
	filter = 1.0
	G.vsync = 1.0
	G.jugador = 0.0
	G.derecha = 68.0
	G.izquierda = 65.0
	G.arriba = 87.0
	G.abajo = 83.0
	G.saltar = 38.0
	G.saltar_spin = 40.0
	G.lanzar_agarrar = 37.0
	G.pause = 32.0
	G.w_scale = 1.0
	_load_settings()
	alarm[5] = 1.0
	GM.audio_play_sound(A.snd_coin, 0.0, false)
	alarm[4] = 260.0
	alarm[11] = 1.0
	if GM.os_type == GM.os_android:
		# Android 分支不移植（port-plan §0）
		# GML: if (os_check_permission("android.permission.WRITE_EXTERNAL_STORAGE") == os_permission_denied)
		# GML:     os_request_permission("android.permission.WRITE_EXTERNAL_STORAGE");
		pass


# from objects/obj_persistent/Other_3.gml
func _game_end() -> void:
	if GM.os_type != GM.os_android:
		# GML: np_update();（Discord / NekoPresence 不移植）
		GM.game_end()
	GM.keyboard_key_release(GM.vk_control)
	GM.keyboard_key_release(G.lanzar_agarrar)
	_user_7()


# from objects/obj_persistent/Other_4.gml
func _room_start() -> void:
	GM.view_set_visible(0, true)
	GM.view_enabled = true
	GM.view_set_wport(0, (G.gw * 2.0))
	GM.view_set_hport(0, (G.gh * 2.0))
	GM.camera_set_view_size(GM.view_get_camera(0), G.gh, GM.camera_get_view_height(GM.view_get_camera(0)))
	GM.camera_set_view_size(GM.view_get_camera(0), G.gw, GM.camera_get_view_width(GM.view_get_camera(0)))
	GM.camera_set_view_border(GM.view_get_camera(0), (G.gh / 2.0), GM.camera_get_view_border_y(GM.view_get_camera(0)))
	GM.camera_set_view_border(GM.view_get_camera(0), (G.gw / 2.0), GM.camera_get_view_border_x(GM.view_get_camera(0)))
	if GM.room != A.rm_guardabot and GM.room != A.rm_guardabot_play and GM.room != A.rm_title:
		G.etiqueta1_temp = -1.0
		G.etiqueta2_temp = -1.0
	if GM.room != A.rm_guardabot_play and GM.room != A.rm_title:
		G.condiciones = 0.0
		G.condiciones_clear = 0.0
		G.condiciones_type = 0.0
		G.condiciones_object = 0.0
		G.condiciones_count = 0.0
	if GM.room != A.rm_guardabot_play:
		G.map_consult = -4.0
		G.type_consult = -4.0
		G.pages_nm = 1.0
		G.tabvalue = 0.0
	if GM.room == A.rm_logo:
		alarm[4] = 240.0
	if GM.room != A.rm_guardabot_play:
		G.level_g = 0.0
		G.nm_play = 0.0
		G.level_id = ""
	if GM.room == A.rm_editor or GM.room == A.rm_title or GM.room == A.rm_guardabot or GM.room == A.rm_course_world or GM.room == A.rm_credito:
		G.dsm = 0.0
	#
	# if (room == rm_title)
	# 	{
	# 		np_update();
	#        np_setpresence("Menú Principal", (("¡Jugando SMM:WE " + global.ver) + "!"), "menu", "small_logo")
	# 	}
	#    else if (room == rm_editor)
	#    {
	# 		np_update();
	#        var texto = choose(("Construyendo una aventura - " + global.my1), ("Contruyendo un nivel - " + global.my1), ("Creando un nivel - " + global.my1), ("Creando una aventura - " + global.my1))
	#        np_setpresence("Editor de Niveles", texto, "makinglevel", "small_logo")
	#
	#    }
	#    else if (room == rm_guardabot)
	# 	{
	# 		np_update();
	#        np_setpresence("Guardabot", "Revisando niveles", "guardabot_menu", "small_guardabot")
	# 	}
	#
	# 	{
	# 		np_update();
	#        np_setpresence("Niveles Mundiales", "Revisando niveles", "surfingstages", "small_globe")
	# 	}
	#    else if (room == rm_guardabot_play)
	#    {
	# 		np_update();
	#        if (global.nm_play != 0)
	#        {
	#            switch global.style_course
	#            {
	#                case 0:
	#                    var style = "start_smb1"
	#                    break
	#                case 1:
	#                    style = "start_smb3"
	#                    break
	#                case 2:
	#                    style = "start_smw"
	#                    break
	#                case 3:
	#                    style = "start_nsmbu"
	#                    break
	#            }
	#
	#            np_setpresence("Niveles Mundiales", ("Jugando " + global.level_name), style, "small_globe")
	#        }
	#        else
	#        {
	#            var ntext = string_copy(global.levelguardabot, 1, (string_length(global.levelguardabot) - 4))
	#            np_setpresence("Guardabot", ("Jugando " + ntext), "guardabot_level", "small_guardabot")
	#        }
	#    }
	#
	if mode == 1.0:
		_user_0()


# from objects/obj_persistent/Other_5.gml
func _room_end() -> void:
	var sx: float = GM.instance_find(A.obj_persistent, 0).s
	G.save_changes = 0.0
	G.sounds_level = 0.0
	mode = 1.0
	back = Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, (G.gw * sx), (G.gh * sx), false, false)
	alarm[1] = 1.0


# from objects/obj_persistent/Other_10.gml
func _user_0() -> void:
	var sx: float
	if mode == 0.0:
		sx = GM.instance_find(A.obj_persistent, 0).s
		back = Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, (G.gw * 2.0), (G.gh * 2.0), false, false)
		GM.instance_deactivate_all(true, self)
	done = 0.0
	mode = 1.0
	alarm[0] = 30.0


# from objects/obj_persistent/Other_11.gml
func _user_1() -> void:
	s = (filter + 1.0)
	GM.display_reset(0.0, 0.0)
	# PORT: use the available native window pixels for world and GUI rendering.
	GM.window_set_game_size((G.gw * s), (G.gh * s))
	GM.display_set_gui_size((G.gw * s), (G.gh * s))
	GM.surface_resize(GM.application_surface, (G.gw * 2.0), (G.gh * 2.0))
	alarm[2] = 1.0


# from objects/obj_persistent/Other_12.gml
func _user_2() -> void:
	s = (filter + 1.0)
	if G.sm4j_style == 1.0:
		GM.aset(mobile_keys, 0, GM.virtual_key_add((32.0 * s), (80.0 * s), (32.0 * s), (64.0 * s), G.arriba))
		GM.aset(mobile_keys, 1, GM.virtual_key_add((32.0 * s), (178.0 * s), (32.0 * s), (64.0 * s), G.abajo))
		GM.aset(mobile_keys, 2, GM.virtual_key_add((-34.0 * s), (144.0 * s), (64.0 * s), (32.0 * s), G.izquierda))
		GM.aset(mobile_keys, 3, GM.virtual_key_add((66.0 * s), (144.0 * s), (64.0 * s), (32.0 * s), G.derecha))
	elif G.sm4j_style != 1.0:
		GM.aset(mobile_keys, 0, GM.virtual_key_add((34.0 * s), (102.0 * s), (32.0 * s), (48.0 * s), G.arriba))
		GM.aset(mobile_keys, 1, GM.virtual_key_add((34.0 * s), (158.0 * s), (32.0 * s), (48.0 * s), G.abajo))
		GM.aset(mobile_keys, 2, GM.virtual_key_add((-6.0 * s), (138.0 * s), (48.0 * s), (32.0 * s), G.izquierda))
		GM.aset(mobile_keys, 3, GM.virtual_key_add((59.0 * s), (138.0 * s), (48.0 * s), (32.0 * s), G.derecha))
	vk_movimientos = 1.0


# from objects/obj_persistent/Other_13.gml
func _user_3() -> void:
	s = (filter + 1.0)
	if G.sm4j_style == 1.0:
		#
		# 	instance_create_depth(camera_get_view_x(view_get_camera(0))+320,camera_get_view_y(view_get_camera(0))+158,0,obj_sm4j_jump)
		# 	/*
		GM.aset(mobile_keys, 4, GM.virtual_key_add((320.0 * s), (158.0 * s), (64.0 * s), (64.0 * s), G.saltar))
		GM.aset(mobile_keys, 5, GM.virtual_key_add((320.0 * s), (30.0 * s), (64.0 * s), (64.0 * s), G.saltar_spin))
		GM.aset(mobile_keys, 6, GM.virtual_key_add((256.0 * s), (158.0 * s), (64.0 * s), (64.0 * s), G.lanzar_agarrar))
		if GM.room != A.rm_editor:
			GM.aset(mobile_keys, 7, GM.virtual_key_add((336.0 * s), (0.0 * s), (32.0 * s), (32.0 * s), 13.0))
		GM.aset(mobile_keys, 8, GM.virtual_key_add((320.0 * s), (94.0 * s), (64.0 * s), (64.0 * s), 17.0))
	else:
		GM.aset(mobile_keys, 4, GM.virtual_key_add((300.0 * s), (158.0 * s), (32.0 * s), (32.0 * s), G.saltar))
		GM.aset(mobile_keys, 5, GM.virtual_key_add((340.0 * s), (176.0 * s), (32.0 * s), (32.0 * s), G.saltar_spin))
		GM.aset(mobile_keys, 6, GM.virtual_key_add((337.0 * s), (35.0 * s), (36.0 * s), (51.0 * s), G.lanzar_agarrar))
		if GM.room != A.rm_editor:
			GM.aset(mobile_keys, 7, GM.virtual_key_add((184.0 * s), (193.0 * s), (16.0 * s), (16.0 * s), 13.0))
		GM.aset(mobile_keys, 8, GM.virtual_key_add((318.0 * s), (118.0 * s), (32.0 * s), (32.0 * s), G.lanzar_agarrar))
	vk_saltos = 1.0


# from objects/obj_persistent/Other_14.gml
func _user_4() -> void:
	GM.virtual_key_delete(mobile_keys[0])
	GM.virtual_key_delete(mobile_keys[1])
	GM.virtual_key_delete(mobile_keys[2])
	GM.virtual_key_delete(mobile_keys[3])
	GM.keyboard_key_release(G.arriba)
	GM.keyboard_key_release(G.abajo)
	GM.keyboard_key_release(G.izquierda)
	GM.keyboard_key_release(G.derecha)
	GM.keyboard_key_release(G.saltar)
	GM.keyboard_key_release(G.saltar_spin)
	GM.keyboard_key_release(G.lanzar_agarrar)
	# DESACTIVARCONTROL
	vk_movimientos = 0.0


# from objects/obj_persistent/Other_15.gml
func _user_5() -> void:
	#
	# with obj_sm4j_jump
	# 	instance_destroy()
	# /*
	GM.virtual_key_delete(mobile_keys[4])
	GM.virtual_key_delete(mobile_keys[5])
	GM.virtual_key_delete(mobile_keys[6])
	if GM.room != A.rm_editor:
		GM.virtual_key_delete(mobile_keys[7])
	GM.virtual_key_delete(mobile_keys[8])
	vk_saltos = 0.0


# from objects/obj_persistent/Other_16.gml
func _user_6() -> void:
	shock_enabled = 1.0
	var_time_var = 0.0
	alarm[7] = 60.0


# from objects/obj_persistent/Other_17.gml
func _user_7() -> void:
	var config: ConfigFile = ConfigFile.new()
	config.set_value("settings", "fullscreen", fullscreen)
	config.set_value("settings", "filter", filter)
	for key: String in SETTINGS_NUMBERS:
		config.set_value("settings", key, G.get(key))
	config.set_value("settings", "last_level", G.last_level)
	# ORIG-BUG: 原版写 name_user，读入 name_users。
	config.set_value("settings", "name_user", G.name_user)
	config.set_value("settings", "my1", GM.string(G.my1))
	var error: Error = config.save(SETTINGS_PATH)
	if error != OK:
		push_warning("无法保存设置：%s（错误 %d）" % [SETTINGS_PATH, error])


func _load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var error: Error = config.load(SETTINGS_PATH)
	if error != OK:
		if error != ERR_FILE_NOT_FOUND:
			push_warning("无法读取设置：%s（错误 %d）" % [SETTINGS_PATH, error])
		return
	var value: Variant = config.get_value("settings", "fullscreen", fullscreen)
	if value is int or value is float:
		fullscreen = float(value)
	value = config.get_value("settings", "filter", filter)
	if value is int or value is float:
		filter = float(value)
	for key: String in SETTINGS_NUMBERS:
		value = config.get_value("settings", key, G.get(key))
		if value is int or value is float:
			G.set(key, float(value))
	value = config.get_value("settings", "last_level", G.last_level)
	if value is String:
		G.last_level = value
	value = config.get_value("settings", "name_user", G.name_users)
	if value is String:
		G.name_users = value
	value = config.get_value("settings", "my1", G.my1)
	if value is String:
		G.my1 = value
	GM.audio_master_gain(G.audiomaster)


# Other_60（异步：头像下载）、Other_70（异步：NekoPresence 的 Discord 事件）不移植：
# 原版只用它们接 Discord（port-plan §0）。


# from objects/obj_persistent/Draw_0.gml
func _gm_draw() -> void:
	# / @description Draws the screenshot shown when fading to black
	if GM.sprite_exists(back):
		GM.gpu_set_blendenable(0.0)
		var sx = 0.5
		GM.draw_sprite_ext(back, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), sx, sx, 0.0, GM.c_white, 1.0)
		GM.gpu_set_blendenable(1.0)
	GM.draw_set_font(G.font_google)
	if vk_movimientos == 1.0:
		if G.sm4j_style == 1.0:
			if GM.keyboard_check(G.arriba):
				GM.draw_sprite_ext(A.spr_keyup_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 80.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_keyup_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 80.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.abajo):
				GM.draw_sprite_ext(A.spr_keydown_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 178.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_keydown_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 178.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.izquierda):
				GM.draw_sprite_ext(A.spr_keyleft_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) - 34.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_keyleft_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) - 34.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.derecha):
				GM.draw_sprite_ext(A.spr_keyright_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 66.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_keyright_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 66.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 144.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
		elif GM.keyboard_check(G.arriba) or GM.keyboard_check(G.abajo) or GM.keyboard_check(G.izquierda) or GM.keyboard_check(G.derecha):
			GM.draw_sprite_ext(A.spr_pad_3ds, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 118.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
		else:
			GM.draw_sprite_ext(A.spr_pad_3ds, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 118.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
	if vk_saltos == 1.0:
		if G.sm4j_style == 1.0:
			if GM.keyboard_check(G.saltar):
				GM.draw_sprite_ext(A.spr_key_a_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
				G.jump = 1.0
			else:
				GM.draw_sprite_ext(A.spr_key_a_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
				G.jump = 0.0
			if GM.keyboard_check(G.saltar_spin):
				GM.draw_sprite_ext(A.spr_key_al_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 30.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_key_al_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 30.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.lanzar_agarrar) or G.key_br == 1.0:
				GM.draw_sprite_ext(A.spr_keyu_b_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 256.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_keyu_b_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 256.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if G.key_br == 1.0:
				GM.draw_sprite_ext(A.spr_key_br_sm4j, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 94.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_key_br_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 320.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 94.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.room != A.rm_editor:
				GM.draw_sprite_ext(A.spr_key_p_sm4j, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 336.0), GM.camera_get_view_y(GM.view_get_camera(0)), 1.0, 1.0, 0.0, GM.c_white, 0.2)
		else:
			if GM.keyboard_check(G.saltar):
				GM.draw_sprite_ext(A.spr_nkey_a, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 300.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_nkey_a, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 300.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 158.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.saltar_spin):
				GM.draw_sprite_ext(A.spr_nkey_z, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 340.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 182.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_nkey_z, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 340.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 182.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.keyboard_check(G.lanzar_agarrar):
				GM.draw_sprite_ext(A.spr_nkey_b, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 337.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			else:
				GM.draw_sprite_ext(A.spr_nkey_b, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 337.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 51.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)
			if GM.room != A.rm_editor:
				GM.draw_sprite_ext(A.spr_nkey_pause, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 184.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 193.0), 1.0, 1.0, 0.0, GM.c_white, 0.2)


# from objects/obj_persistent/Draw_64.gml
func _gm_draw_gui() -> void:
	# / @description Deals with the application surface and fading
	GM.gpu_set_blendenable(0.0)
	if shock_enabled > 0.5:
		GM.shader_set(A.shd_shockwave)
		var_time_var += 0.03
	GM.shader_set_uniform_f(uni_time, var_time_var)
	GM.shader_set_uniform_f(uni_mouse_pos, var_mouse_pos_x, var_mouse_pos_y)
	GM.shader_set_uniform_f(uni_resolution, var_resolution_x, var_resolution_y)
	GM.shader_set_uniform_f(uni_shock_amplitude, var_shock_amplitude)
	GM.shader_set_uniform_f(uni_shock_refraction, var_shock_refraction)
	GM.shader_set_uniform_f(uni_shock_width, var_shock_width)
	GM.draw_surface_stretched(GM.application_surface, 0.0, port_y, (G.gw * (filter + 1.0)), (G.gh * (filter + 1.0)))
	GM.shader_reset()
	GM.gpu_set_blendenable(1.0)
	# GML 的 < 带 0.00001 容差（port-plan §3.3 第 6a 条、R15）：done 是逐帧累加的 1/30
	if done - 1.0 < -GM.EPSILON:
		done += (1.0 / 30.0)
		if mode == 0.0:
			GM.draw_set_alpha((1.0 - done))
		else:
			GM.draw_set_alpha(done)
		GM.draw_set_color(GM.c_black)
		GM.draw_rectangle(0.0, 0.0, 5000.0, 5000.0, false)
		GM.draw_set_alpha(1.0)
		GM.draw_set_color(GM.c_white)
	if G.showfps > 0.5 and GM.room != A.rm_logo and GM.room != A.rm_intro and GM.room != A.rm_credito:
		GM.draw_set_font(G.font_google)
		if GM.fps >= 60.0:
			GM.draw_text_colour(2.0, 2.0, GM.string_hash_to_newline((GM.string(GM.fps) + " FPS")), GM.c_lime, GM.c_lime, GM.c_lime, GM.c_lime, 1.0)
		elif GM.fps < 60.0:
			GM.draw_text_colour(2.0, 2.0, GM.string_hash_to_newline((GM.string(GM.fps) + " FPS")), GM.c_yellow, GM.c_yellow, GM.c_yellow, GM.c_yellow, 1.0)
		elif GM.fps < 30.0:
			GM.draw_text_colour(2.0, 2.0, GM.string_hash_to_newline((GM.string(GM.fps) + " FPS")), GM.c_red, GM.c_red, GM.c_red, GM.c_red, 1.0)
