extends GMObject

# Assigned by scr_toast in the caller instance, as in GML.
var texto = null
var ancho = null
var xx = null
var yy = null
var toast = null

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
var limit_door_1: float = 0.0
var limit_door_2: float = 0.0
var limit_door_3: float = 0.0
var b_dec = null
var s_dec_hongo = null
var s_block_hidden = null
var s_puente = null
var img_cloud_block = null


# from objects/obj_load_level/Create_0.gml
func _create() -> void:
	G.powerup = 0.0
	img_ground = 72.0
	img_pendiente1 = 195.0
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
	limit_door_1 = 0.0
	limit_door_2 = 0.0
	limit_door_3 = 0.0


# from objects/obj_load_level/Other_4.gml
func _room_start() -> void:
	G.levelguardabot = G.last_level
	_user_0()


# from objects/obj_load_level/Other_10.gml
func _user_0() -> void:
	var mundos
	var _wrapper
	var _list
	var _map
	var _list2
	var j
	var z
	var _map2
	var o_ground
	var _list3
	var k
	var _map3
	var object
	var o_objecto
	var _list4
	var l
	var _map4
	var _list5
	var _map5
	var sprite
	var _list6
	var _map6
	var _list7
	var _map7
	var _list8
	var _map8
	if G.levelguardabot != "":
		if GM.file_exists((G.directorio + G.levelguardabot)):
			mundos = Scr.LoadJSONFromFile(self, (G.directorio + G.levelguardabot))
			_wrapper = mundos.get("MAIN")
			_list = _wrapper.get("AJUSTES")
			_map = _list[int(0.0)]
			if not GM.veq(G.my1, _map.get("user")):
				pass
				Scr.scr_toast(self, 1.0, Scr.scr_language(self, 96.0))
				if GM.instance_exists(A.obj_levelmanager):
					for _obj_write1 in GM.with_list(A.obj_levelmanager):
						_obj_write1.leveltime = 300.0
				_user_1()
				_user_2()
				instance_destroy()
				return
			G.save_changes = G.levelguardabot
			G.last_level = G.levelguardabot
			G.apariencia = _map.get("apariencia")
			if G.apariencia > 3.0 or G.apariencia < 0.0:
				G.apariencia = GM.choose(0.0, 1.0, 2.0, 3.0)
			G.bg_level = _map.get("entorno")
			if G.bg_level != "ground" and G.bg_level != "underground" and G.bg_level != "castle" and G.bg_level != "underwater" and G.bg_level != "desert" and G.bg_level != "ghost" and G.bg_level != "airship" and G.bg_level != "sky" and G.bg_level != "forest" and G.bg_level != "snow" and G.bg_level != "beach" and G.bg_level != "fall" and G.bg_level != "mountain":
				G.bg_level = "ground"
			G.modo_noche = _map.get("modo_noche")
			if G.modo_noche != 0.0 and G.modo_noche != 1.0:
				G.modo_noche = 0.0
			if GM.instance_exists(A.obj_levelmanager):
				for _obj_write2 in GM.with_list(A.obj_levelmanager):
					_obj_write2.leveltime = _map.get("cronometro")
				if GM.instance_find(A.obj_levelmanager, 0).leveltime > 500.0 or GM.instance_find(A.obj_levelmanager, 0).leveltime < 10.0:
					for _obj_write3 in GM.with_list(A.obj_levelmanager):
						_obj_write3.leveltime = 300.0
			G.autoavance = _map.get("autoavance")
			if G.autoavance > 3.0 or G.autoavance < 0.0:
				G.autoavance = 0.0
			if GM.instance_exists(A.obj_ground2):
				for _obj_write4 in GM.with_list(A.obj_ground2):
					_obj_write4.y = _map.get("ground2")
				for _obj_write5 in GM.with_list(A.obj_ground2):
					_obj_write5.size_y = ((432.0 - GM.instance_find(A.obj_ground2, 0).y) / 16.0)
			if GM.instance_exists(A.obj_ground3):
				for _obj_write6 in GM.with_list(A.obj_ground3):
					_obj_write6.x = _map.get("ground3_x")
				for _obj_write7 in GM.with_list(A.obj_ground3):
					_obj_write7.y = _map.get("ground3_y")
				for _obj_write8 in GM.with_list(A.obj_ground3):
					_obj_write8.size_y = ((432.0 - GM.instance_find(A.obj_ground3, 0).y) / 16.0)
			GM.room_width = _map.get("size")
			if GM.room_width > 9216.0:
				GM.room_width = 9216.0
			if GM.room_width < 384.0:
				GM.room_width = 496.0
			if GM.instance_exists(A.obj_card_bout):
				for _obj_write9 in GM.with_list(A.obj_card_bout):
					_obj_write9.pos_y = _map.get("water_level")
				for _obj_write10 in GM.with_list(A.obj_card_bout):
					_obj_write10.pos_y_limit = _map.get("water_level_limit")
				G.water_speed = _map.get("water_level_speed")
				if not GM.eq(G.water_speed, 0.2) and not GM.eq(G.water_speed, 0.5) and not GM.eq(G.water_speed, 0.8):
					G.water_speed = 0.2
			G.etiqueta1_temp = _map.get("etiqueta1")
			G.etiqueta2_temp = _map.get("etiqueta2")
			G.condiciones = _map.get("condiciones")
			G.condiciones_type = _map.get("condiciones_type")
			G.condiciones_object = _map.get("condiciones_object")
			G.condiciones_count = _map.get("condiciones_count")
			if G.condiciones != 0.0 and G.condiciones != 1.0:
				G.condiciones = 0.0
			if G.condiciones_type != 0.0 or G.condiciones_object != 0.0:
				G.condiciones_type = 0.0
				G.condiciones_object = 0.0
			if G.condiciones_count > 3.0 or G.condiciones_count < 0.0:
				G.condiciones_count = 0.0
			if _map.has("ds_s"):
				G.sounds_level = _map.get("ds_s")
			if G.sounds_level != 0.0 and G.sounds_level != 1.0:
				G.sounds_level = 0.0
			if _map.has("meteorites"):
				G.meteoritos = _map.get("meteorites")
			if G.meteoritos != 0.0 and G.meteoritos != 1.0:
				G.meteoritos = 0.0
			if _map.has("description"):
				G.desc = _map.get("description")
			_user_1()
			_user_2()
			_list2 = _wrapper.get("SUELO")
			j = 0.0
			while j < float(_list2.size()):
				_map2 = _list2[int(j)]
				o_ground = GM.instance_create(0.0, 0.0, A.obj_ground)
				o_ground.x = _map2.get("x_pos")
				o_ground.y = _map2.get("y_pos")
				o_ground.x_draw = _map2.get("x_pos")
				o_ground.y_draw = _map2.get("y_pos")
				o_ground.image_index = _map2.get("index")
				j += 1.0
			_list3 = _wrapper.get("NIVEL")
			k = 0.0
			while k < float(_list3.size()):
				_map3 = _list3[int(k)]
				object = GM.asset_get_index(_map3.get("object"))
				if object != A.obj_tuberia_res and object != A.obj_cannon_res and object != A.obj_cannon_red_res and object != A.obj_semisolid_platform1 and object != A.obj_mushroom_platform_res and object != A.obj_vine_res and object != A.obj_pokey_res and object != A.obj_bullebill_base_red_res and object != A.obj_bullebill_base_res and object != A.obj_platform_res and object != A.obj_platform_blue_res and object != A.obj_puente_res and object != A.obj_door_res and object != A.obj_door_exit_res and object != A.obj_door_switch_res and object != A.obj_door_switch_exit_res and object != A.obj_door_lock_res and object != A.obj_door_lock_exit_res and (object != A.obj_cinta_res) and (object != A.obj_cinta_on_res) and object != A.obj_ground and object != A.obj_slopes:
					o_objecto = GM.instance_create(0.0, 0.0, object)
					o_objecto.x = _map3.get("x_pos")
					o_objecto.y = _map3.get("y_pos")
					o_objecto.x_draw = _map3.get("x_pos")
					o_objecto.y_draw = _map3.get("y_pos")
					o_objecto.sprout = _map3.get("sprout")
					o_objecto.direct_t = _map3.get("direct_t")
					o_objecto.progresivo = _map3.get("progresivo")
					o_objecto.wings = _map3.get("wings")
					o_objecto.rotacion = _map3.get("rotacion")
					o_objecto.paracaidas = _map3.get("paracaidas")
					o_objecto.key = _map3.get("key")
					o_objecto.inup = _map3.get("inup")
					o_objecto.modo_water = _map3.get("modo_water")
					o_objecto.s_scaley = _map3.get("s_scaley")
				k += 1.0
			_list4 = _wrapper.get("TUBERIAS")
			l = 0.0
			while l < float(_list4.size()):
				_map4 = _list4[int(l)]
				o_objecto = GM.instance_create(0.0, 0.0, A.obj_tuberia_res)
				o_objecto.x = _map4.get("x_pos")
				o_objecto.y = _map4.get("y_pos")
				o_objecto.x_draw = _map4.get("x_pos")
				o_objecto.y_draw = _map4.get("y_pos")
				o_objecto.size = _map4.get("size")
				o_objecto.rotacion = _map4.get("rotacion")
				o_objecto.R = _map4.get("rotacion")
				o_objecto.direct_t = _map4.get("direct_t")
				o_objecto.s_scalex = _map4.get("scalex")
				o_objecto.color = _map4.get("color")
				o_objecto.plant = _map4.get("mask")
				o_objecto.image_xscale = _map4.get("xscale")
				o_objecto.image_yscale = _map4.get("yscale")
				if _map4.has("warp"):
					o_objecto.warp = _map4.get("warp")
					o_objecto.t_x_pos = _map4.get("t_x_pos")
					o_objecto.t_y_pos = _map4.get("t_y_pos")
					o_objecto.t_size = _map4.get("t_size")
					o_objecto.t_rotacion = _map4.get("t_rotacion")
					o_objecto.t_direct_t = _map4.get("t_direct_t")
					o_objecto.t_s_scalex = _map4.get("t_s_scalex")
					o_objecto.t_color = _map4.get("t_color")
					o_objecto.t_xscale = _map4.get("t_xscale")
					o_objecto.t_yscale = _map4.get("t_yscale")
				l += 1.0
			_list5 = _wrapper.get("DECORACION")
			l = 0.0
			while l < float(_list5.size()):
				_map5 = _list5[int(l)]
				object = GM.asset_get_index(_map5.get("object"))
				sprite = GM.asset_get_index(_map5.get("sprite"))
				o_objecto = GM.instance_create(0.0, 0.0, object)
				o_objecto.x = _map5.get("x_pos")
				o_objecto.y = _map5.get("y_pos")
				o_objecto.sprite_index = sprite
				o_objecto.image_index = _map5.get("index")
				l += 1.0
			_list6 = _wrapper.get("CANNON")
			l = 0.0
			while l < float(_list6.size()):
				_map6 = _list6[int(l)]
				object = GM.asset_get_index(_map6.get("object"))
				o_objecto = GM.instance_create(0.0, 0.0, object)
				o_objecto.x = _map6.get("x_pos")
				o_objecto.y = _map6.get("y_pos")
				o_objecto.x_draw = _map6.get("x_pos")
				o_objecto.y_draw = _map6.get("y_pos")
				o_objecto.direct = _map6.get("direct")
				o_objecto.d = _map6.get("down")
				o_objecto.u = _map6.get("up")
				o_objecto.l = _map6.get("left")
				o_objecto.r = _map6.get("right")
				l += 1.0
			_list7 = _wrapper.get("PLATAFORMAS")
			l = 0.0
			while l < float(_list7.size()):
				_map7 = _list7[int(l)]
				object = GM.asset_get_index(_map7.get("object"))
				o_objecto = GM.instance_create(0.0, 0.0, object)
				o_objecto.x = _map7.get("x_pos")
				o_objecto.y = _map7.get("y_pos")
				o_objecto.x_draw = _map7.get("x_pos")
				o_objecto.y_draw = _map7.get("y_pos")
				o_objecto.size_x = _map7.get("width")
				o_objecto.size_y = _map7.get("height")
				o_objecto.sprite_index = GM.asset_get_index(_map7.get("sprite"))
				o_objecto.color = _map7.get("color")
				o_objecto.depth = _map7.get("depth")
				o_objecto.direct_t = _map7.get("direct_t")
				o_objecto.wings = _map7.get("wings")
				l += 1.0
			_list8 = _wrapper.get("PUERTAS")
			l = 0.0
			while l < float(_list8.size()):
				_map8 = _list8[int(l)]
				object = GM.asset_get_index(_map8.get("object"))
				if (object == A.obj_door_res and limit_door_1 < 4.0) or (object == A.obj_door_switch_res and limit_door_2 < 4.0) or (object == A.obj_door_lock_res and limit_door_3 < 4.0):
					o_objecto = GM.instance_create(0.0, 0.0, object)
					o_objecto.x = _map8.get("x_pos")
					o_objecto.y = _map8.get("y_pos")
					o_objecto.x_draw = _map8.get("x_pos")
					o_objecto.y_draw = _map8.get("y_pos")
					o_objecto.door_x = _map8.get("door_x")
					o_objecto.door_y = _map8.get("door_y")
					if object == A.obj_door_res:
						limit_door_1 += 1.0
					elif object == A.obj_door_switch_res:
						limit_door_2 += 1.0
					else:
						limit_door_3 += 1.0
				l += 1.0
			pass
			instance_destroy()
		else:
			if GM.instance_exists(A.obj_levelmanager):
				for _obj_write11 in GM.with_list(A.obj_levelmanager):
					_obj_write11.leveltime = 300.0
			_user_1()
			_user_2()
			instance_destroy()
	else:
		if GM.instance_exists(A.obj_levelmanager):
			for _obj_write12 in GM.with_list(A.obj_levelmanager):
				_obj_write12.leveltime = 300.0
		_user_1()
		_user_2()
		instance_destroy()


# from objects/obj_load_level/Other_11.gml
func _user_1() -> void:
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
			for _obj_write13 in GM.with_list(A.obj_levelmanager):
				_obj_write13.levelmusic = Scr.scr_snd_ground(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
			b_dec = 39.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
		"underground":
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underground(self))
			for _obj_write14 in GM.with_list(A.obj_levelmanager):
				_obj_write14.levelmusic = Scr.scr_snd_underground(self)
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
			for _obj_write15 in GM.with_list(A.obj_levelmanager):
				_obj_write15.levelmusic = Scr.scr_snd_castle(self)
			s_music_editor = Scr.scr_snd_editor_castle(self)
			b_dec = 35.0
			s_dec_hongo = 69.0
			s_block_hidden = 8.0
			s_puente = 96.0
		"underwater":
			Scr.__background_set(self, Scr.e__BG.Index, (int(0) << int(0)), Scr.scr_bg_underwater(self))
			for _obj_write16 in GM.with_list(A.obj_levelmanager):
				_obj_write16.levelmusic = Scr.scr_snd_underwater(self)
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
			for _obj_write17 in GM.with_list(A.obj_levelmanager):
				_obj_write17.levelmusic = Scr.scr_snd_ghost_house(self)
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
			for _obj_write18 in GM.with_list(A.obj_levelmanager):
				_obj_write18.levelmusic = Scr.scr_snd_airship(self)
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
			for _obj_write19 in GM.with_list(A.obj_levelmanager):
				_obj_write19.levelmusic = Scr.scr_snd_forest(self)
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
			for _obj_write20 in GM.with_list(A.obj_levelmanager):
				_obj_write20.levelmusic = Scr.scr_snd_sky(self)
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
			for _obj_write21 in GM.with_list(A.obj_levelmanager):
				_obj_write21.levelmusic = Scr.scr_snd_desert(self)
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
					Scr.__background_set(self, Scr.e__BG.Visible, 6.0, 1.0)
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
			for _obj_write22 in GM.with_list(A.obj_levelmanager):
				_obj_write22.levelmusic = Scr.scr_snd_snow(self)
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
			for _obj_write23 in GM.with_list(A.obj_levelmanager):
				_obj_write23.levelmusic = Scr.scr_snd_ground(self)
			s_music_editor = Scr.scr_snd_editor_forest(self)
			b_dec = 41.0
			s_dec_hongo = 70.0
			s_block_hidden = 7.0
			s_puente = 95.0
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
			for _obj_write24 in GM.with_list(A.obj_levelmanager):
				_obj_write24.levelmusic = Scr.scr_snd_beach(self)
			s_music_editor = Scr.scr_snd_editor_ground(self)
			b_dec = 41.0
			s_dec_hongo = 70.0
			s_block_hidden = 7.0
			s_puente = 95.0
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
			for _obj_write25 in GM.with_list(A.obj_levelmanager):
				_obj_write25.levelmusic = Scr.scr_snd_mountain(self)
			s_music_editor = Scr.scr_snd_editor_mountain(self)
			b_dec = 40.0
			s_dec_hongo = 69.0
			s_block_hidden = 7.0
			s_puente = 94.0
	for _obj_write26 in GM.with_list(A.obj_levelmanager):
		_obj_write26.levelmusic_original = GM.instance_find(A.obj_levelmanager, 0).levelmusic
	if GM.instance_exists(A.obj_creator_jugar_editar) and GM.audio_is_playing(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor):
		GM.audio_stop_sound(GM.instance_find(A.obj_creator_jugar_editar, 0).music_editor)
	GM.audio_stop_sound(GM.instance_find(A.obj_levelmanager, 0).levelmusic)
	GM.audio_play_sound(s_music_editor, 99.0, true)
	if GM.instance_exists(A.obj_creator_jugar_editar):
		for _obj_write27 in GM.with_list(A.obj_creator_jugar_editar):
			_obj_write27.music_editor = s_music_editor
	if G.bg_level == "castle":
		if GM.instance_exists(A.obj_lava_water):
			var _with_target29 = A.obj_lava_water
			var _other28: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target29):
				inst.instance_destroy()
			GM.other = _other28
		var _with_target31 = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)
		var _other30: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target31):
			match float(G.apariencia):
				0.0:
					inst.sprite_index = A.spr_SMB_lava
				1.0:
					inst.sprite_index = A.spr_SMB3_lava
				2.0:
					inst.sprite_index = A.spr_lava
				3.0:
					inst.sprite_index = A.spr_NSMBU_lava
				4.0:
					inst.sprite_index = inst.spr_SMB2_lava
		GM.other = _other30
	elif G.bg_level == "forest" and G.modo_noche == 1.0:
		if GM.instance_exists(A.obj_lava_water):
			var _with_target33 = A.obj_lava_water
			var _other32: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target33):
				inst.instance_destroy()
			GM.other = _other32
		var _with_target35 = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)
		var _other34: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target35):
			match float(G.apariencia):
				0.0:
					inst.sprite_index = A.spr_SMB_lava_purple
				1.0:
					inst.sprite_index = A.spr_SMB3_lava_purple
				2.0:
					inst.sprite_index = A.spr_lava_purple
				3.0:
					inst.sprite_index = A.spr_NSMBU_lava
				4.0:
					inst.sprite_index = inst.spr_SMB2_lava_purple
		GM.other = _other34
	elif (G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach":
		if GM.instance_exists(A.obj_lava_water):
			var _with_target37 = A.obj_lava_water
			var _other36: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target37):
				inst.instance_destroy()
			GM.other = _other36
		var _with_target39 = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)
		var _other38: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target39):
			match float(G.apariencia):
				0.0:
					inst.sprite_index = A.spr_SMB_water
				1.0:
					if G.bg_level == "beach":
						inst.sprite_index = A.spr_SMB3_water_b
					else:
						inst.sprite_index = A.spr_SMB3_water
				2.0:
					inst.sprite_index = A.spr_water
				3.0:
					inst.sprite_index = A.spr_NSMBU_water
				4.0:
					inst.sprite_index = inst.spr_SMB2_water
		GM.other = _other38
	elif not GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)):
		if GM.instance_exists(A.obj_lava_water):
			var _with_target41 = A.obj_lava_water
			var _other40: GMObject = GM.other
			GM.other = self
			for inst in GM.with_list(_with_target41):
				inst.instance_destroy()
			GM.other = _other40
		var _with_target43 = GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (GM.room_height - 4.0), A.obj_lava_water)
		var _other42: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target43):
			match float(G.apariencia):
				0.0:
					inst.sprite_index = A.spr_SMB_lava
				1.0:
					inst.sprite_index = A.spr_SMB3_lava
				2.0:
					inst.sprite_index = A.spr_lava
				3.0:
					inst.sprite_index = A.spr_NSMBU_lava
		GM.other = _other42
	elif GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 0.0)):
		var _with_target45 = A.obj_lava_water
		var _other44: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target45):
			inst.instance_destroy()
		GM.other = _other44
	elif GM.instance_exists(A.obj_lava_water):
		var _with_target47 = A.obj_lava_water
		var _other46: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target47):
			inst.instance_destroy()
		GM.other = _other46
	Scr.scr_create_bg_anim(self)


# from objects/obj_load_level/Other_12.gml
func _user_2() -> void:
	if G.bg_level == "snow" and G.modo_noche == 1.0:
		img_ground = 85.0
		img_pendiente1 = 208.0
		img_block = 68.0
		img_rock = 22.0
		img_pinchos = 109.0
		img_donut = 181.0
		img_cloud = 177.0
		img_pokey = 153.0
	elif G.bg_level == "snow":
		img_ground = 84.0
		img_pendiente1 = 207.0
		img_block = 67.0
		img_rock = 21.0
		img_pinchos = 108.0
		img_donut = 180.0
		img_cloud = 176.0
		img_pokey = 153.0
	elif G.bg_level == "desert":
		img_pendiente1 = 206.0
		img_ground = 83.0
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
		img_cloud = 104.0
		img_hidden_block = 8.0
	elif G.bg_level == "castle" and G.modo_noche == 1.0:
		img_ground = 75.0
		img_pendiente1 = 198.0
		img_block = 66.0
		img_rock = 19.0
		img_donut = 179.0
		img_cloud = 175.0
		img_hidden_block = 12.0
	elif G.bg_level == "castle":
		img_ground = 74.0
		img_pendiente1 = 197.0
		img_block = 66.0
		img_rock = 19.0
		img_donut = 179.0
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
	if GM.instance_exists(A.obj_card_item):
		var _with_target49 = A.obj_card_item
		var _other48: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(_with_target49):
			if inst.obj == A.obj_ground:
				inst.obj_draw = self.img_ground
			if inst.obj == A.obj_slopes:
				inst.obj_draw = self.img_pendiente1
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
			elif inst.obj == A.obj_buzzy_shell_res:
				inst.obj_draw = self.img_buzzy_shell
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
				inst.obj_draw = self.img_bulletbill
			elif inst.obj == A.obj_cannon_res:
				inst.obj_draw = self.img_cannon
			elif inst.obj == A.obj_pokey_res:
				inst.obj_draw = self.img_pokey
		GM.other = _other48
