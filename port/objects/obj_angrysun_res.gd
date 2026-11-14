extends "res://objects/obj_parent_resource.gd"

var s_music_editor = null
var img_ground: float = 0.0
var img_pendiente1: float = 0.0
var img_block: float = 0.0
var img_rock: float = 0.0
var img_pinchos: float = 0.0
var img_cloud: float = 0.0
var img_hidden_block: float = 0.0
var img_1up: float = 0.0
var img_billbanzai: float = 0.0
var img_bobomb: float = 0.0
var img_buzzy: float = 0.0
var img_muncher: float = 0.0
var img_chomp: float = 0.0
var img_bullet: float = 0.0
var img_cannon: float = 0.0
var img_angrysun: float = 0.0
var img_buzzy_shell: float = 0.0
var img_cloud_block = null
var img_donut = null


# from objects/obj_angrysun_res/Create_0.gml
func _create() -> void:
	super._create()
	super._create()
	exception = 1.0
	grid_selected = A.spr_grid_selected_32x32_2
	s_music_editor = 109.0
	img_ground = 72.0
	img_pendiente1 = 195.0
	img_block = 64.0
	img_rock = 17.0
	img_pinchos = 106.0
	img_cloud = 103.0
	img_hidden_block = 11.0
	img_1up = 0.0
	img_billbanzai = 2.0
	img_bobomb = 25.0
	img_buzzy = 35.0
	img_muncher = 100.0
	img_chomp = 141.0
	img_bullet = 5.0
	img_cannon = 155.0
	img_angrysun = 131.0
	img_buzzy_shell = 87.0


# from objects/obj_angrysun_res/Step_2.gml
func _step_end() -> void:
	match float(G.apariencia):
		0.0:
			if G.modo_noche == 1.0:
				sprite_index = A.spr_SMB_happymoon
			else:
				sprite_index = A.spr_SMB_angrysun
		1.0:
			if G.modo_noche == 1.0:
				sprite_index = A.spr_SMB3_happymoon
			else:
				sprite_index = A.spr_SMB3_angrysun
		2.0:
			if G.modo_noche == 1.0:
				sprite_index = A.spr_happymoon
			else:
				sprite_index = A.spr_angrysun
		3.0:
			if G.modo_noche == 1.0:
				sprite_index = A.spr_NSMBU_happymoon
			else:
				sprite_index = A.spr_NSMBU_angrysun_idle


# from objects/obj_angrysun_res/Other_10.gml
func _user_0() -> void:
	var _with_target2 = GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)
	var _other1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target2):
		inst.sprite_index = A.spr_windows_2
		inst.id_object = self
		inst.index_object1 = 131.0
		inst.index_object2 = 99.0
		if G.modo_noche == 0.0:
			inst.selected_1 = 1.0
			inst.selected_2 = 0.0
		else:
			inst.selected_1 = 0.0
			inst.selected_2 = 1.0
		inst.number = 2.1
	GM.other = _other1


# from objects/obj_angrysun_res/Other_11.gml
func _user_1() -> void:
	var _with_target4 = GM.instance_create((x - 8.0), (y - 8.0), A.obj_smoke)
	var _other3: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target4):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	GM.other = _other3
	GM.audio_play_sound(A.snd_change_night_day, 0.0, false)
	if G.modo_noche == 0.0:
		G.modo_noche = 1.0
	else:
		G.modo_noche = 0.0
	Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 6.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 0.0)
	Scr.__background_set(self, (int(7) << int(0)), 3.0, 0x000001)
	match G.bg_level:
		"ground":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_overworld_0)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_overworld_1)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_overworld_2)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_overworld_3)
				Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_overworld_4)
				Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_overworld_5)
				Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_overworld_6)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
				Scr.__background_set(self, (int(7) << int(0)), 3.0, GM.c_black)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_ground(self))
			for _obj_write5 in GM.with_list(A.obj_levelmanager):
				_obj_write5.levelmusic = Scr.scr_snd_ground(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
		"underground":
			_user_0()
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underground(self))
			for _obj_write6 in GM.with_list(A.obj_levelmanager):
				_obj_write6.levelmusic = Scr.scr_snd_underground(self)
			s_music_editor = Scr.scr_snd_editor_underground(self)
		"castle":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_castle_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_castle_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_castle_3)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_castle(self))
			for _obj_write7 in GM.with_list(A.obj_levelmanager):
				_obj_write7.levelmusic = Scr.scr_snd_castle(self)
			s_music_editor = Scr.scr_snd_editor_castle(self)
		"underwater":
			_user_0()
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underwater(self))
			for _obj_write8 in GM.with_list(A.obj_levelmanager):
				_obj_write8.levelmusic = Scr.scr_snd_underwater(self)
			s_music_editor = Scr.scr_snd_editor_underwater(self)
		"ghost":
			_user_0()
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_ghost_house_1)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_ghost_house_2)
					Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_ghost_house(self))
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_ghost_house(self))
			for _obj_write9 in GM.with_list(A.obj_levelmanager):
				_obj_write9.levelmusic = Scr.scr_snd_ghost_house(self)
			s_music_editor = Scr.scr_snd_editor_ghost(self)
		"airship":
			_user_0()
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_airship_0)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_airship_1)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_airship_2)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_airship_3)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_airship_4)
					Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_airship_5)
					Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_airship_6)
					Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_airship_night_0)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_airship_night_1)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_airship_night_2)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_airship_night_3)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_airship_night_4)
					Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_airship_night_5)
					Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_airship_night_6)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_airship(self))
			for _obj_write10 in GM.with_list(A.obj_levelmanager):
				_obj_write10.levelmusic = Scr.scr_snd_airship(self)
			s_music_editor = Scr.scr_snd_editor_airship(self)
		"forest":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_forest_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_forest_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_forest_3)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_forest_4)
				Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_forest_5)
				Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_forest_6)
				Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_forest_7)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_forest(self))
			for _obj_write11 in GM.with_list(A.obj_levelmanager):
				_obj_write11.levelmusic = Scr.scr_snd_forest(self)
			s_music_editor = Scr.scr_snd_editor_forest(self)
		"sky":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_sky_0)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_sky_1)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_sky_2)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_sky_3)
				Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_sky_4)
				Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_sky_5)
				Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_sky_6)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_sky(self))
			for _obj_write12 in GM.with_list(A.obj_levelmanager):
				_obj_write12.levelmusic = Scr.scr_snd_sky(self)
			s_music_editor = Scr.scr_snd_editor_sky(self)
		"desert":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_desert_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_desert_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_desert_3)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_desert_4)
				Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_desert_5)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_desert(self))
			for _obj_write13 in GM.with_list(A.obj_levelmanager):
				_obj_write13.levelmusic = Scr.scr_snd_desert(self)
			s_music_editor = Scr.scr_snd_editor_desert(self)
		"snow":
			_user_0()
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_snow_0)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_snow_1)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_snow_2)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_snow_3)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_snow_4)
					Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_snow_5)
					Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_snow_night_1)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_snow_night_2)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_snow_night_3)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_snow_night_4)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_snow_night_5)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_snow(self))
			for _obj_write14 in GM.with_list(A.obj_levelmanager):
				_obj_write14.levelmusic = Scr.scr_snd_snow(self)
			s_music_editor = Scr.scr_snd_editor_snow(self)
		"fall":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_autumn_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_autumn_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_autumn_3)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_autumn_4)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_fall(self))
			for _obj_write15 in GM.with_list(A.obj_levelmanager):
				_obj_write15.levelmusic = Scr.scr_snd_autumn(self)
			s_music_editor = Scr.scr_snd_editor_forest(self)
		"beach":
			_user_0()
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_beach_0)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_beach_1)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_beach_2)
				Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_beach_3)
				Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_beach_4)
				Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_beach_5)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_beach(self))
			for _obj_write16 in GM.with_list(A.obj_levelmanager):
				_obj_write16.levelmusic = Scr.scr_snd_beach(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
		"mountain":
			_user_0()
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_mountain_0)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_mountain_1)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_mountain_2)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_mountain_3)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_mountain_4)
					Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_volcano_0)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_volcano_1)
					Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_volcano_2)
					Scr.__background_set(self, Scr.e__BG.Index, 3.0, A.bg_NSMBU_volcano_3)
					Scr.__background_set(self, Scr.e__BG.Index, 4.0, A.bg_NSMBU_volcano_4)
					Scr.__background_set(self, Scr.e__BG.Index, 5.0, A.bg_NSMBU_volcano_5)
					Scr.__background_set(self, Scr.e__BG.Index, 7.0, A.bg_NSMBU_volcano_6)
					Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 1.0)
					Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_mountain(self))
			for _obj_write17 in GM.with_list(A.obj_levelmanager):
				_obj_write17.levelmusic = Scr.scr_snd_mountain(self)
			s_music_editor = Scr.scr_snd_editor_mountain(self)
	for _obj_write18 in GM.with_list(A.obj_levelmanager):
		_obj_write18.levelmusic_original = GM.instance_find(A.obj_levelmanager, 0).levelmusic
	Scr.scr_create_bg_anim(self)
	GM.audio_stop_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
	GM.audio_play_sound(s_music_editor, 99.0, true)
	for _obj_write19 in GM.with_list(A.obj_creator_jugar_editar):
		_obj_write19.music_editor = s_music_editor
	_user_3()
	_user_4()


# from objects/obj_angrysun_res/Other_13.gml
func _user_3() -> void:
	# /@description Create lava or delete it
	if G.bg_level == "mountain" and G.modo_noche == 1.0:
		if GM.instance_exists(A.obj_lava_water):
			var _with_target21 = A.obj_lava_water
			var _other20: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target21):
				inst.instance_destroy()
			GM.other = _other20
		var _with_target23 = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)
		var _other22: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target23):
			match float(G.apariencia):
				0.0:
					inst.sprite_index = A.spr_SMB_lava
				1.0:
					inst.sprite_index = A.spr_SMB3_lava
				2.0:
					inst.sprite_index = A.spr_lava
				3.0:
					inst.sprite_index = A.spr_NSMBU_lava
		GM.other = _other22
	elif G.bg_level != "castle" and G.bg_level != "beach" and G.bg_level != "forest":
		if GM.instance_exists(A.obj_lava_water):
			var _with_target25 = A.obj_lava_water
			var _other24: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target25):
				inst.instance_destroy()
			GM.other = _other24


# from objects/obj_angrysun_res/Other_14.gml
func _user_4() -> void:
	if G.bg_level == "snow" and G.modo_noche == 1.0:
		img_ground = 85.0
		img_pendiente1 = 208.0
		img_block = 68.0
		img_rock = 22.0
		img_pinchos = 109.0
		img_cloud = 177.0
	elif G.bg_level == "snow":
		img_ground = 84.0
		img_pendiente1 = 207.0
		img_block = 67.0
		img_rock = 21.0
		img_pinchos = 108.0
		img_cloud = 176.0
	elif G.bg_level == "desert":
		img_ground = 83.0
		img_pendiente1 = 206.0
	elif G.bg_level == "sky":
		img_ground = 82.0
		img_pendiente1 = 205.0
	elif G.bg_level == "beach":
		img_ground = 226.0
		img_pendiente1 = 195.0
	elif G.bg_level == "fall":
		img_ground = 227.0
		img_pendiente1 = 195.0
	elif G.bg_level == "forest":
		img_ground = 81.0
		img_pendiente1 = 204.0
		img_hidden_block = 10.0
	elif G.bg_level == "airship" and G.modo_noche == 1.0:
		img_ground = 80.0
		img_pendiente1 = 203.0
		if G.apariencia == 0.0:
			img_rock = 19.0
	elif G.bg_level == "airship":
		img_ground = 79.0
		img_pendiente1 = 202.0
		if G.apariencia == 0.0:
			img_rock = 19.0
	elif G.bg_level == "ghost":
		img_ground = 78.0
		img_pendiente1 = 201.0
		img_block = 65.0
		img_rock = 18.0
		img_hidden_block = 12.0
	elif G.bg_level == "underwater" and G.modo_noche == 1.0:
		img_ground = 77.0
		img_pendiente1 = 200.0
		img_rock = 20.0
		img_pinchos = 107.0
		img_cloud = 104.0
		img_hidden_block = 8.0
	elif G.bg_level == "underwater":
		img_ground = 76.0
		img_pendiente1 = 199.0
		img_rock = 20.0
		img_pinchos = 107.0
		img_pinchos = 107.0
		img_hidden_block = 8.0
	elif G.bg_level == "castle" and G.modo_noche == 1.0:
		img_ground = 75.0
		img_pendiente1 = 198.0
		img_block = 66.0
		img_rock = 19.0
		img_cloud = 175.0
		img_hidden_block = 12.0
	elif G.bg_level == "castle":
		img_ground = 74.0
		img_pendiente1 = 197.0
		img_block = 66.0
		img_rock = 19.0
		img_cloud = 175.0
		img_hidden_block = 12.0
	elif G.bg_level == "mountain" and G.modo_noche == 1.0:
		img_ground = 229.0
		img_pendiente1 = 198.0
	elif G.bg_level == "mountain":
		img_ground = 228.0
		img_pendiente1 = 195.0
	elif G.bg_level == "underground":
		img_ground = 73.0
		img_pendiente1 = 196.0
		img_block = 65.0
		img_rock = 18.0
		img_hidden_block = 12.0
	elif G.bg_level == "ground":
		img_ground = 72.0
		img_pendiente1 = 195.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		img_billbanzai = 3.0
		img_bobomb = 26.0
		img_buzzy = 36.0
		img_muncher = 101.0
		img_chomp = 142.0
		img_bullet = 6.0
		img_cannon = 156.0
		img_buzzy_shell = 88.0
	if G.bg_level == "ghost" or G.bg_level == "underground" or (G.modo_noche == 1.0 and G.bg_level != "snow" and G.bg_level != "castle"):
		img_cloud_block = 174.0
		img_donut = 178.0
	if G.modo_noche == 1.0 and G.bg_level != "underwater":
		img_hidden_block = 12.0
	if G.modo_noche == 1.0 and G.bg_level == "ground":
		img_1up = 123.0
	if G.modo_noche == 1.0:
		img_angrysun = 99.0
	else:
		img_angrysun = 131.0
	var _with_target27 = A.obj_card_item
	var _other26: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(_with_target27):
		if inst.obj == A.obj_ground:
			inst.obj_draw = self.img_ground
		elif inst.obj == A.obj_block_res:
			inst.obj_draw = self.img_block
		elif inst.obj == A.obj_rock_res:
			inst.obj_draw = self.img_rock
		elif inst.obj == A.obj_pinchos_res:
			inst.obj_draw = self.img_pinchos
		elif inst.obj == A.obj_billbanzai_res:
			inst.obj_draw = self.img_billbanzai
		elif inst.obj == A.obj_bobomb_res:
			inst.obj_draw = self.img_bobomb
		elif inst.obj == A.obj_buzzybeetle_res:
			inst.obj_draw = self.img_buzzy
		elif inst.obj == A.obj_muncher_res:
			inst.obj_draw = self.img_muncher
		elif inst.obj == A.obj_chomp_res:
			inst.obj_draw = self.img_chomp
		elif inst.obj == A.obj_block_hidden_res:
			inst.obj_draw = self.img_hidden_block
		elif inst.obj == A.obj_nube_res:
			inst.obj_draw = self.img_cloud
		elif inst.obj == A.obj_1up_res:
			inst.obj_draw = self.img_1up
		elif inst.obj == A.obj_bullebill_base_res:
			inst.obj_draw = self.img_bullet
		elif inst.obj == A.obj_cannon_res:
			inst.obj_draw = self.img_cannon
		elif inst.obj == A.obj_angrysun_res:
			inst.obj_draw = self.img_angrysun
		elif inst.obj == A.obj_buzzy_shell_res:
			inst.obj_draw = self.img_buzzy_shell
	GM.other = _other26
