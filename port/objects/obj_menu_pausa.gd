extends GMObject

var rain: int = 0
var music = null
var back: int = -1
var textcnd: Array = []


# from objects/obj_menu_pausa/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	rain = A.obj_lighting
	if GM.instance_exists(A.obj_rainmaker):
		for inst in GM.with_list(A.obj_rainmaker):
			self.rain = inst.object_index
			inst.instance_destroy()
	var manager = GM.instance_find(A.obj_levelmanager, 0)
	var persistent = GM.instance_find(A.obj_persistent, 0)
	music = manager.levelmusic
	var sx: float = persistent.s
	back = int(Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, (G.gw * sx), (G.gh * sx), false, false))
	GM.instance_deactivate_all(true, self)
	#
	# audio_bus_main.effects[0] = undefined;
	# /*
	GM.instance_activate_object(A.obj_persistent)
	if GM.audio_is_playing(music):
		GM.audio_pause_sound(music)
	if GM.audio_is_playing(Scr.scr_snd_starman(self)):
		GM.audio_pause_sound(Scr.scr_snd_starman(self))
	if GM.audio_is_playing(Scr.scr_music_link(self)):
		GM.audio_pause_sound(Scr.scr_music_link(self))
	if GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
		GM.audio_pause_sound(Scr.scr_snd_switchsong(self))
	if GM.audio_is_playing(Scr.scr_snd_dead(self)):
		GM.audio_pause_sound(Scr.scr_snd_dead(self))
	if GM.audio_is_playing(Scr.scr_snd_dead(self)):
		GM.audio_pause_sound(Scr.scr_snd_dead(self))
	if GM.audio_is_playing(Scr.scr_snd_hurryup(self)):
		GM.audio_pause_sound(Scr.scr_snd_hurryup(self))
	if GM.audio_is_playing(A.bgm_sm1clear):
		GM.audio_pause_sound(A.bgm_sm1clear)
	if GM.audio_is_playing(A.snd_n64):
		GM.audio_pause_sound(A.snd_n64)
	if GM.audio_is_playing(A.snd_SMB_clear_superball):
		GM.audio_pause_sound(A.snd_SMB_clear_superball)
	if GM.audio_is_playing(A.snd_SMB3_course_clear):
		GM.audio_pause_sound(A.snd_SMB3_course_clear)
	if GM.audio_is_playing(A.bgm_smwclear):
		GM.audio_pause_sound(A.bgm_smwclear)
	if GM.audio_is_playing(A.snd_SMB_course_clear_castle):
		GM.audio_pause_sound(A.snd_SMB_course_clear_castle)
	if GM.audio_is_playing(A.snd_SMB3_course_clear_castle):
		GM.audio_pause_sound(A.snd_SMB3_course_clear_castle)
	if GM.audio_is_playing(A.bgm_smwclear_castle):
		GM.audio_pause_sound(A.bgm_smwclear_castle)
	if GM.audio_is_playing(Scr.scr_snd_skid(self)):
		GM.audio_pause_sound(Scr.scr_snd_skid(self))
	if GM.audio_is_playing(A.snd_pmeter):
		GM.audio_pause_sound(A.snd_pmeter)
	if GM.audio_is_playing(A.snd_boomboom_ruleta):
		GM.audio_pause_sound(A.snd_boomboom_ruleta)
	GM.audio_stop_sound(Scr.scr_snd_bowserjr_shell(self))
	GM.audio_stop_sound(A.snd_skewer1)
	GM.audio_stop_sound(A.snd_skewer2)
	GM.audio_stop_sound(A.snd_skewer3)
	GM.audio_stop_sound(A.snd_skewer4)
	GM.audio_stop_sound(A.snd_skewer5)
	GM.audio_stop_sound(A.snd_NSMBU_desllizarse_walljump)
	GM.audio_stop_sound(A.snd_NSMBU_helice_planear)
	GM.audio_stop_sound(A.snd_NSMBU_squirrel_plan)
	GM.audio_stop_sound(A.snd_NSMBU_vine_up)
	GM.audio_play_sound(A.snd_pausa, 0.0, false)
	if G.postnivel == 0.0:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 255.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 81.0), A.obj_pausa_button)
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 255.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 107.0), A.obj_pausa_button)):
			inst.type = 1.0
			inst.text = Scr.scr_language(inst, 150.0)
			inst.sprite_index = A.spr_bt_parent
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 255.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 133.0), A.obj_pausa_button)):
			inst.type = 2.0
			inst.text = Scr.scr_language(inst, 161.0)
			inst.sprite_index = A.spr_bt_parent
	else:
		GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 255.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 94.0), A.obj_pausa_button)
		for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 255.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 120.0), A.obj_pausa_button)):
			inst.type = 2.0
			inst.text = Scr.scr_language(inst, 161.0)
			inst.sprite_index = A.spr_bt_parent
	for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 352.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 183.0), A.obj_settings_button)):
		inst.image_index = 2.0
		inst.x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 352.0)
		inst.y = (GM.camera_get_view_y(GM.view_get_camera(0)) + 183.0)
		inst.depth = -17.0
	# obj_skip_control is referenced by the source but absent from the project resources.
	if GM.instance_exists(A.obj_persistent):
		if persistent.modo_android == 0.0:
			GM.instance_create((x + 100.0), (y + 100.0), A.obj_cursor)
		else:
			for inst in GM.with_list(GM.instance_create((x + 100.0), (y + 100.0), A.obj_cursor)):
				inst.visible = false
	GM.aset(textcnd, 0, Scr.scr_language(self, 46.0))
	GM.aset(textcnd, 1, Scr.scr_language(self, 47.0))
	GM.aset(textcnd, 2, Scr.scr_language(self, 48.0))
	GM.aset(textcnd, 3, Scr.scr_language(self, 49.0))


# from objects/obj_menu_pausa/Destroy_0.gml
func _destroy() -> void:
	for inst in GM.with_list(A.obj_pausa_button):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_settings_button):
		inst.instance_destroy()
	#
	# if instance_exists(obj_audio_control)
	# with (obj_audio_control)
	# 	audio_bus_main.effects[0] = _ef_reverb;
	# /*


# from objects/obj_menu_pausa/Other_10.gml
func _user_0() -> void:
	if rain != A.obj_lighting:
		GM.instance_create(0.0, 0.0, rain)
	GM.instance_activate_all()
	if GM.sprite_exists(back):
		GM.sprite_delete(back)
	if GM.instance_exists(A.obj_cursor):
		for inst in GM.with_list(A.obj_cursor):
			inst.instance_destroy()
	if not GM.instance_exists(A.obj_deadmario):
		if GM.audio_is_paused(music):
			GM.audio_resume_sound(music)
	if GM.audio_is_paused(Scr.scr_snd_starman(self)):
		GM.audio_resume_sound(Scr.scr_snd_starman(self))
	if GM.audio_is_paused(Scr.scr_snd_switchsong(self)):
		GM.audio_resume_sound(Scr.scr_snd_switchsong(self))
	if GM.audio_is_paused(Scr.scr_snd_dead(self)):
		GM.audio_resume_sound(Scr.scr_snd_dead(self))
	if GM.audio_is_paused(Scr.scr_music_link(self)):
		GM.audio_resume_sound(Scr.scr_music_link(self))
	if GM.audio_is_paused(Scr.scr_snd_hurryup(self)):
		GM.audio_resume_sound(Scr.scr_snd_hurryup(self))
	if GM.audio_is_paused(A.bgm_sm1clear):
		GM.audio_resume_sound(A.bgm_sm1clear)
	if GM.audio_is_paused(A.snd_SMB_clear_superball):
		GM.audio_resume_sound(A.snd_SMB_clear_superball)
	if GM.audio_is_paused(A.snd_SMB3_course_clear):
		GM.audio_resume_sound(A.snd_SMB3_course_clear)
	if GM.audio_is_paused(A.bgm_smwclear):
		GM.audio_resume_sound(A.bgm_smwclear)
	if GM.audio_is_paused(A.snd_SMB_course_clear_castle):
		GM.audio_resume_sound(A.snd_SMB_course_clear_castle)
	if GM.audio_is_paused(A.snd_SMB3_course_clear_castle):
		GM.audio_resume_sound(A.snd_SMB3_course_clear_castle)
	if GM.audio_is_paused(A.bgm_smwclear_castle):
		GM.audio_resume_sound(A.bgm_smwclear_castle)
	if GM.audio_is_paused(Scr.scr_snd_skid(self)):
		GM.audio_resume_sound(Scr.scr_snd_skid(self))
	if GM.audio_is_paused(A.snd_pmeter):
		GM.audio_resume_sound(A.snd_pmeter)
	if GM.audio_is_paused(A.snd_boomboom_ruleta):
		GM.audio_resume_sound(A.snd_boomboom_ruleta)
	# Android touch controls are outside the port's scope.
	instance_destroy()


# from objects/obj_menu_pausa/Other_11.gml
func _user_1() -> void:
	if G.lives > 1.0 or G.dsm == 0.0:
		GM.instance_activate_all()
		GM.instance_activate_object(A.obj_mario)
		if GM.sprite_exists(back):
			GM.sprite_delete(back)
		if GM.instance_exists(A.obj_cursor):
			for inst in GM.with_list(A.obj_cursor):
				inst.instance_destroy()
		G.checkpoint = -4.0
		G.checkpointroom = -4.0
		G.checkpoint_x = 0.0
		G.checkpoint_y = 0.0
		G.pinkcoins_count = 0.0
		G.pink_coins = 0.0
		G.pink_coin1_x = 0.0
		G.pink_coin1_y = 0.0
		G.pink_coin2_x = 0.0
		G.pink_coin2_y = 0.0
		G.pink_coin3_x = 0.0
		G.pink_coin3_y = 0.0
		G.pink_coin4_x = 0.0
		G.pink_coin4_y = 0.0
		G.pink_coin5_x = 0.0
		G.pink_coin5_y = 0.0
		G.pink_coin6_x = 0.0
		G.pink_coin6_y = 0.0
		G.pink_coin7_x = 0.0
		G.pink_coin7_y = 0.0
		G.pink_coin8_x = 0.0
		G.pink_coin8_y = 0.0
		G.pink_coin9_x = 0.0
		G.pink_coin9_y = 0.0
		G.pink_coin10_x = 0.0
		G.pink_coin10_y = 0.0
		for inst in GM.with_list(A.obj_levelmanager):
			inst.switchon = 0.0
		for inst in GM.with_list(A.obj_persistent):
			inst.alarm[6] = -1.0
		G.ms_check = 0.0
		if GM.audio_is_paused(music):
			GM.audio_stop_sound(music)
		if GM.audio_is_paused(Scr.scr_snd_starman(self)):
			GM.audio_stop_sound(Scr.scr_snd_starman(self))
		if GM.audio_is_paused(Scr.scr_snd_switchsong(self)):
			GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		if GM.audio_is_paused(Scr.scr_music_link(self)):
			GM.audio_resume_sound(Scr.scr_music_link(self))
		if GM.audio_is_paused(Scr.scr_snd_dead(self)):
			GM.audio_stop_sound(Scr.scr_snd_dead(self))
		if GM.audio_is_paused(Scr.scr_snd_hurryup(self)):
			GM.audio_stop_sound(Scr.scr_snd_hurryup(self))
		if GM.audio_is_paused(A.bgm_sm1clear):
			GM.audio_stop_sound(A.bgm_sm1clear)
		if GM.audio_is_paused(A.snd_SMB_clear_superball):
			GM.audio_stop_sound(A.snd_SMB_clear_superball)
		if GM.audio_is_paused(A.snd_SMB3_course_clear):
			GM.audio_stop_sound(A.snd_SMB3_course_clear)
		if GM.audio_is_paused(A.bgm_smwclear):
			GM.audio_stop_sound(A.bgm_smwclear)
		if GM.audio_is_paused(A.snd_SMB_course_clear_castle):
			GM.audio_stop_sound(A.snd_SMB_course_clear_castle)
		if GM.audio_is_paused(A.snd_SMB3_course_clear_castle):
			GM.audio_stop_sound(A.snd_SMB3_course_clear_castle)
		if GM.audio_is_paused(A.bgm_smwclear_castle):
			GM.audio_stop_sound(A.bgm_smwclear_castle)
		if GM.audio_is_paused(Scr.scr_snd_skid(self)):
			GM.audio_stop_sound(Scr.scr_snd_skid(self))
		if GM.audio_is_paused(A.snd_pmeter):
			GM.audio_stop_sound(A.snd_pmeter)
		if GM.audio_is_paused(A.snd_boomboom_ruleta):
			GM.audio_stop_sound(A.snd_boomboom_ruleta)
		if G.dsm == 1.0:
			G.coins = 0.0
		Scr.scr_restart(self)
		instance_destroy()


# from objects/obj_menu_pausa/Other_12.gml
func _user_2() -> void:
	if G.lives > 0.0 or G.dsm == 0.0:
		G.keys = 0.0
		G.ms_check = 0.0
		Scr.scr_init_globals(self)
		GM.audio_stop_sound(Scr.scr_snd_clown_damage(self))
		GM.audio_stop_sound(music)
		GM.audio_stop_sound(Scr.scr_snd_starman(self))
		GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		GM.audio_stop_sound(Scr.scr_snd_dead(self))
		GM.audio_stop_sound(Scr.scr_snd_hurryup(self))
		GM.audio_stop_sound(A.bgm_sm1clear)
		GM.audio_stop_sound(A.snd_SMB_clear_superball)
		GM.audio_stop_sound(A.snd_SMB3_course_clear)
		GM.audio_stop_sound(A.bgm_smwclear)
		GM.audio_stop_sound(A.snd_SMB_course_clear_castle)
		GM.audio_stop_sound(A.snd_SMB3_course_clear_castle)
		GM.audio_stop_sound(A.bgm_smwclear_castle)
		GM.audio_stop_sound(Scr.scr_snd_skid(self))
		GM.audio_stop_sound(A.snd_pmeter)
		GM.audio_stop_sound(A.snd_boomboom_ruleta)
		if (G.nm_play != 0.0) and (G.dsm == 0.0):
			pass
		else:
			GM.room_goto(A.rm_guardabot)


# from objects/obj_menu_pausa/Draw_0.gml
func _gm_draw() -> void:
	var icon_pausa  # 局部变量提升（GML 的 var 是函数作用域）
	var level  # 局部变量提升（GML 的 var 是函数作用域）
	var texto  # 局部变量提升（GML 的 var 是函数作用域）
	var title
	var author
	var likes
	var intentos
	var tag1
	var tag2
	var record
	var cond_cont = G.condiciones_count
	if GM.sprite_exists(back):
		GM.gpu_set_blendenable(0.0)
		var sx = 0.5
		GM.draw_sprite_ext(back, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), sx, sx, 0.0, GM.c_white, 1.0)
		GM.gpu_set_blendenable(1.0)
	GM.draw_sprite_stretched(A.spr_expand_bg, 1.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), 239.0, 216.0)
	GM.draw_sprite_stretched(sprite_index, 0.0, x, y, 145.0, 216.0)
	GM.draw_sprite(A.spr_pausa_text, G.idioma, (GM.camera_get_view_x(GM.view_get_camera(0)) + 260.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 9.0))
	if G.nm_play != 0.0:
		icon_pausa = 1.0
	else:
		icon_pausa = 0.0
	GM.draw_sprite(A.spr_pausa_icons, icon_pausa, (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0))
	GM.draw_sprite(A.spr_pausa_icons, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 65.0))
	GM.draw_sprite(A.spr_pausaicons, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 88.0))
	GM.draw_sprite(A.spr_pausaicons, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 103.0))
	GM.draw_sprite(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 118.0))
	GM.draw_sprite(A.spr_pausaicons, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 133.0))
	GM.draw_sprite(A.spr_pausaicons, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 12.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 148.0))
	GM.draw_sprite(A.spr_user_icon, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 14.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 46.0))
	GM.draw_sprite_stretched(A.spr_pausa_line, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 22.0), 224.0, 1.0)
	GM.draw_sprite_stretched(A.spr_pausa_line, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 60.0), 224.0, 1.0)
	GM.draw_sprite_stretched(A.spr_pausa_line, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 7.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 80.0), 224.0, 1.0)
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(GM.c_white)
	if G.nm_play != 0.0:
		title = Scr.scr_language(self, 14.0)
		texto = G.level_name
		if GM.string_width(GM.string_hash_to_newline(texto)) > 205.0:
			var copy = GM.string_copy(texto, 0.0, 40.0)
			level = (copy + "...")
		else:
			level = texto
		author = G.author
		likes = G.number_like
		intentos = G.intentos
		tag1 = G.tag1_pub
		tag2 = G.tag2_pub
		record = G.record
	else:
		title = Scr.scr_language(self, 15.0)
		texto = G.levelguardabot
		level = Scr.scr_add3points(self, texto, 205.0, 40.0)
		author = G.user_gb
		likes = "--"
		intentos = "--"
		tag1 = G.tag1_pub
		tag2 = G.tag2_pub
		record = "--"
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 22.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 8.0), GM.string_hash_to_newline(title))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 16.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 26.0), GM.string_hash_to_newline(level))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 45.0), GM.string_hash_to_newline(author))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 85.0), GM.string_hash_to_newline(likes))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 100.0), GM.string_hash_to_newline(intentos))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 114.0), GM.string_hash_to_newline(tag1))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 129.0), GM.string_hash_to_newline(tag2))
	if record == "0":
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 145.0), GM.string_hash_to_newline("--"))
	else:
		GM.draw_text(((x - 195.0) - GM.gm_round((GM.string_width(GM.string_hash_to_newline((record))) / 2.0))), (y + 145.0), GM.string_hash_to_newline((record)))
	if cond_cont != 0.0:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 63.0), GM.string_hash_to_newline(textcnd[int(cond_cont)]))
	else:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 26.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 63.0), GM.string_hash_to_newline("--"))


# from objects/obj_menu_pausa/KeyPress_13.gml
func _keypress_13() -> void:
	if not GM.instance_exists(A.obj_settings_panel):
		_user_0()
