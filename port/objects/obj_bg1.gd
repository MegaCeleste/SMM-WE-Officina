extends GMObject

var bg_s: String = ""
var active: float = 0.0
var bg_other: float = 0.0
var img_ground: float = 0.0
var img_pendiente1: float = 0.0
var img_block: float = 0.0
var img_rock: float = 0.0
var img_pinchos: float = 0.0
var img_donut: float = 0.0
var img_cloud: float = 0.0
var img_hidden_block: float = 0.0
var img_1up: float = 0.0
var img_billbanzai: float = 0.0
var img_bobomb: float = 0.0
var img_buzzy: float = 0.0
var img_buzzy_shell: float = 0.0
var img_muncher: float = 0.0
var img_chomp: float = 0.0
var img_bulletbill: float = 0.0
var img_cannon: float = 0.0
var img_pokey: float = 0.0
var s_music_editor = null
var x_pos: float = 0.0
var y_pos: float = 0.0
var subimage: float = 0.0
var anim: float = 0.0
var b_dec = null
var s_dec_hongo = null
var s_block_hidden = null
var s_puente = null
var img_cloud_block = null


# from objects/obj_bg1/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	bg_s = "ground"
	active = 0.0
	bg_other = 0.0
	img_ground = 72.0
	img_pendiente1 = 208.0
	img_block = 64.0
	img_rock = 17.0
	img_pinchos = 106.0
	img_donut = 53.0
	img_cloud = 103.0
	img_hidden_block = 11.0
	img_1up = 0.0
	img_billbanzai = 2.0
	img_bobomb = 25.0
	img_buzzy = 35.0
	img_buzzy_shell = 87.0
	img_muncher = 100.0
	img_chomp = 141.0
	img_bulletbill = 5.0
	img_cannon = 155.0
	img_pokey = 152.0
	s_music_editor = A.snd_editor_overworld
	x_pos = 0.0
	y_pos = 0.0
	subimage = 0.0
	anim = 0.0


# from objects/obj_bg1/Other_10.gml
func _user_0() -> void:
	Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 6.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 0.0)
	Scr.__background_set(self, (int(7) << int(0)), 3.0, 0x000001)
	match bg_s:
		"ground":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_ground(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
			b_dec = 39.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
		"underground":
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underground(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_underground(self)
			s_music_editor = Scr.scr_snd_editor_underground(self)
			b_dec = 42.0
			s_dec_hongo = 69.0
			s_block_hidden = 8.0
			s_puente = 96.0
		"castle":
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_castle_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_castle_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_castle_3)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_castle(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_castle(self)
			s_music_editor = Scr.scr_snd_editor_castle(self)
			b_dec = 35.0
			s_dec_hongo = 69.0
			s_block_hidden = 8.0
			s_puente = 96.0
		"underwater":
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underwater(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_underwater(self)
			s_music_editor = Scr.scr_snd_editor_underwater(self)
			b_dec = 43.0
			s_dec_hongo = 71.0
			s_block_hidden = 4.0
			s_puente = 96.0
		"ghost":
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_ghost_house_1)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_ghost_house_2)
					Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_ghost_house(self))
			else:
				Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_ghost_house(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_ghost_house(self)
			s_music_editor = Scr.scr_snd_editor_ghost(self)
			b_dec = 38.0
			s_dec_hongo = 69.0
			s_block_hidden = 8.0
			s_puente = 96.0
		"airship":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_airship(self)
			s_music_editor = Scr.scr_snd_editor_airship(self)
			b_dec = 34.0
			s_dec_hongo = 68.0
			s_block_hidden = 7.0
			s_puente = 96.0
		"forest":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_forest(self)
			s_music_editor = Scr.scr_snd_editor_forest(self)
			b_dec = 37.0
			s_dec_hongo = 69.0
			s_block_hidden = 6.0
			s_puente = 94.0
		"sky":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_sky(self)
			s_music_editor = Scr.scr_snd_editor_sky(self)
			b_dec = 40.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
		"desert":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_desert(self)
			s_music_editor = Scr.scr_snd_editor_desert(self)
			b_dec = 36.0
			s_dec_hongo = 69.0
			s_block_hidden = 5.0
			s_puente = 94.0
		"snow":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_snow(self)
			s_music_editor = Scr.scr_snd_editor_snow(self)
			b_dec = 41.0
			s_dec_hongo = 70.0
			s_block_hidden = 7.0
			s_puente = 95.0
		"fall":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_autumn(self)
			s_music_editor = Scr.scr_snd_editor_forest(self)
			b_dec = 39.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
		"beach":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_beach(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
			b_dec = 39.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
		"mountain":
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
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_mountain(self)
			s_music_editor = Scr.scr_snd_editor_mountain(self)
			b_dec = 40.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
	for inst in GM.with_list(A.obj_levelmanager):
		inst.levelmusic_original = GM.instance_find(A.obj_levelmanager, 0).levelmusic
	Scr.scr_create_bg_anim(self)


# from objects/obj_bg1/Other_11.gml
func _user_1() -> void:
	match G.bg_level:
		"snow":
			if G.modo_noche == 1.0:
				img_ground = 85.0
				img_pendiente1 = 208.0
				img_block = 68.0
				img_rock = 22.0
				img_pinchos = 109.0
				img_donut = 181.0
				img_cloud = 177.0
				img_pokey = 153.0
			else:
				img_ground = 84.0
				img_pendiente1 = 207.0
				img_block = 67.0
				img_rock = 21.0
				img_pinchos = 108.0
				img_donut = 180.0
				img_cloud = 176.0
				img_pokey = 153.0
		"desert":
			img_ground = 83.0
			img_pendiente1 = 206.0
		"sky":
			img_ground = 82.0
			img_pendiente1 = 205.0
		"beach":
			img_ground = 226.0
			img_pendiente1 = 195.0
		"fall":
			img_ground = 227.0
			img_pendiente1 = 195.0
		"forest":
			img_ground = 81.0
			img_pendiente1 = 204.0
			img_hidden_block = 10.0
		"airship":
			if G.modo_noche == 1.0:
				img_ground = 80.0
				img_pendiente1 = 203.0
			else:
				img_ground = 79.0
				img_pendiente1 = 202.0
			if G.apariencia == 0.0:
				img_rock = 19.0
		"ghost":
			img_ground = 78.0
			img_pendiente1 = 201.0
			img_block = 65.0
			img_rock = 18.0
			img_hidden_block = 12.0
		"underwater":
			if G.modo_noche == 1.0:
				img_ground = 77.0
				img_pendiente1 = 200.0
				img_rock = 20.0
				img_pinchos = 107.0
				img_cloud = 104.0
				img_hidden_block = 8.0
			else:
				img_ground = 76.0
				img_pendiente1 = 199.0
				img_rock = 20.0
				img_pinchos = 107.0
				img_cloud = 104.0
				img_hidden_block = 8.0
		"castle":
			if G.modo_noche == 1.0:
				img_ground = 75.0
				img_pendiente1 = 198.0
				img_block = 66.0
				img_rock = 19.0
				img_donut = 179.0
				img_cloud = 175.0
				img_hidden_block = 12.0
			else:
				img_ground = 74.0
				img_pendiente1 = 197.0
				img_block = 66.0
				img_rock = 19.0
				img_donut = 179.0
				img_cloud = 175.0
				img_hidden_block = 12.0
		"underground":
			img_ground = 73.0
			img_pendiente1 = 196.0
			img_block = 65.0
			img_rock = 18.0
			img_hidden_block = 12.0
		"mountain":
			if G.modo_noche == 1.0:
				img_ground = 229.0
				img_pendiente1 = 198.0
			else:
				img_ground = 228.0
				img_pendiente1 = 195.0
		_:
			img_ground = 72.0
			img_pendiente1 = 195.0
	if G.modo_noche == 1.0 and G.bg_level == "ground":
		img_1up = 123.0
	if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
		img_billbanzai = 3.0
		img_bobomb = 26.0
		img_buzzy = 36.0
		img_buzzy_shell = 88.0
		img_muncher = 101.0
		img_chomp = 142.0
		img_bulletbill = 6.0
		img_cannon = 156.0
	if G.bg_level == "ghost" or G.bg_level == "underground" or (G.modo_noche == 1.0 and G.bg_level != "snow" and G.bg_level != "castle"):
		img_cloud_block = 174.0
		img_donut = 178.0
	if G.modo_noche == 1.0 and G.bg_level != "underwater":
		img_hidden_block = 12.0
	for inst in GM.with_list(A.obj_card_item):
		if GM.instance_find(A.obj_levelmanager, 0).editor_sonidos == 1.0:
			match int(inst.obj_sonidos):
				A.obj_ground:
					inst.obj_draw_sonidos = self.img_ground
				A.obj_slopes:
					inst.obj_draw_sonidos = self.img_pendiente1
				A.obj_block_res:
					inst.obj_draw_sonidos = self.img_block
				A.obj_rock_res:
					inst.obj_draw_sonidos = self.img_rock
				A.obj_pinchos_res:
					inst.obj_draw_sonidos = self.img_pinchos
				A.obj_billbanzai_res:
					inst.obj_draw_sonidos = self.img_billbanzai
				A.obj_bobomb_res:
					inst.obj_draw_sonidos = self.img_bobomb
				A.obj_buzzybeetle_res:
					inst.obj_draw_sonidos = self.img_buzzy
				A.obj_buzzy_shell_res:
					inst.obj_draw_sonidos = self.img_buzzy_shell
				A.obj_muncher_res:
					inst.obj_draw_sonidos = self.img_muncher
				A.obj_chomp_res:
					inst.obj_draw_sonidos = self.img_chomp
				A.obj_block_hidden_res:
					inst.obj_draw_sonidos = self.img_hidden_block
				A.obj_nube_res:
					inst.obj_draw_sonidos = self.img_cloud
				A.obj_1up_res:
					inst.obj_draw_sonidos = self.img_1up
				A.obj_bullebill_base_res:
					inst.obj_draw_sonidos = self.img_bulletbill
				A.obj_cannon_res:
					inst.obj_draw_sonidos = self.img_cannon
				A.obj_pokey_res:
					inst.obj_draw_sonidos = self.img_pokey
		else:
			match int(inst.obj):
				A.obj_ground:
					inst.obj_draw = self.img_ground
				A.obj_slopes:
					inst.obj_draw = self.img_pendiente1
				A.obj_block_res:
					inst.obj_draw = self.img_block
				A.obj_rock_res:
					inst.obj_draw = self.img_rock
				A.obj_pinchos_res:
					inst.obj_draw = self.img_pinchos
				A.obj_billbanzai_res:
					inst.obj_draw = self.img_billbanzai
				A.obj_bobomb_res:
					inst.obj_draw = self.img_bobomb
				A.obj_buzzybeetle_res:
					inst.obj_draw = self.img_buzzy
				A.obj_buzzy_shell_res:
					inst.obj_draw = self.img_buzzy_shell
				A.obj_muncher_res:
					inst.obj_draw = self.img_muncher
				A.obj_chomp_res:
					inst.obj_draw = self.img_chomp
				A.obj_block_hidden_res:
					inst.obj_draw = self.img_hidden_block
				A.obj_nube_res:
					inst.obj_draw = self.img_cloud
				A.obj_1up_res:
					inst.obj_draw = self.img_1up
				A.obj_bullebill_base_res:
					inst.obj_draw = self.img_bulletbill
				A.obj_cannon_res:
					inst.obj_draw = self.img_cannon
				A.obj_pokey_res:
					inst.obj_draw = self.img_pokey


# from objects/obj_bg1/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(A.spr_cards_entorno_bg, active, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), (GM.camera_get_view_y(GM.view_get_camera(0)) + y_pos))
	GM.draw_sprite_ext(sprite_index, image_index, (GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos), (GM.camera_get_view_y(GM.view_get_camera(0)) + y_pos), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	if active == 1.0:
		anim += 0.3
		Scr.scr_anim_hover(self, ((GM.camera_get_view_x(GM.view_get_camera(0)) + x_pos) + 1.0), ((GM.camera_get_view_y(GM.view_get_camera(0)) + y_pos) + 1.0), anim, 0.0)


# from objects/obj_bg1/Mouse_4.gml
func _mouse_4() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).editor == 1.0:
		GM.audio_play_sound(A.snd_seleccion_entorno1, 0.0, false)
		if GM.instance_exists(A.obj_player_trail):
			for inst in GM.with_list(A.obj_player_trail):
				inst.instance_destroy()
		G.bg_level = bg_s
		_user_0()
		GM.audio_stop_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
		GM.audio_play_sound(s_music_editor, 99.0, true)
		for inst in GM.with_list(A.obj_creator_jugar_editar):
			inst.music_editor = self.s_music_editor
		if bg_s == "castle":
			if GM.instance_exists(A.obj_lava_water):
				for inst in GM.with_list(A.obj_lava_water):
					inst.instance_destroy()
			for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)):
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_lava
					1.0:
						inst.sprite_index = A.spr_SMB3_lava
					2.0:
						inst.sprite_index = A.spr_lava
					3.0:
						inst.sprite_index = A.spr_NSMBU_lava
		elif bg_s == "forest" and G.modo_noche == 1.0:
			if GM.instance_exists(A.obj_lava_water):
				for inst in GM.with_list(A.obj_lava_water):
					inst.instance_destroy()
			for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)):
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_lava_purple
					1.0:
						inst.sprite_index = A.spr_SMB3_lava_purple
					2.0:
						inst.sprite_index = A.spr_lava_purple
					3.0:
						inst.sprite_index = A.spr_NSMBU_lava
		elif (bg_s == "forest" and G.modo_noche == 0.0) or bg_s == "beach":
			if GM.instance_exists(A.obj_lava_water):
				for inst in GM.with_list(A.obj_lava_water):
					inst.instance_destroy()
			for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)):
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_water
					1.0:
						if self.bg_s == "beach":
							inst.sprite_index = A.spr_SMB3_water_b
						else:
							inst.sprite_index = A.spr_SMB3_water
					2.0:
						inst.sprite_index = A.spr_water
					3.0:
						inst.sprite_index = A.spr_NSMBU_water
		elif bg_s == "mountain" and G.modo_noche == 1.0:
			if GM.instance_exists(A.obj_lava_water):
				for inst in GM.with_list(A.obj_lava_water):
					inst.instance_destroy()
			for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)):
				match G.apariencia:
					0.0:
						inst.sprite_index = A.spr_SMB_lava
					1.0:
						inst.sprite_index = A.spr_SMB3_lava
					2.0:
						inst.sprite_index = A.spr_lava
					3.0:
						inst.sprite_index = A.spr_NSMBU_lava
		elif GM.instance_exists(A.obj_lava_water):
			for inst in GM.with_list(A.obj_lava_water):
				inst.instance_destroy()
		_user_1()
		for inst in GM.with_list(A.obj_editormanager):
			inst.alarm[0] = 15.0
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_bg_selection):
			inst.event_user(0)
		GM.other = _o1


# from objects/obj_bg1/Mouse_10.gml
func _mouse_10() -> void:
	if active == 0.0:
		GM.audio_stop_sound(A.snd_panel_right_move)
		GM.audio_play_sound(A.snd_panel_right_move, 0.0, false)
	active = 1.0


# from objects/obj_bg1/Mouse_11.gml
func _mouse_11() -> void:
	active = 0.0
