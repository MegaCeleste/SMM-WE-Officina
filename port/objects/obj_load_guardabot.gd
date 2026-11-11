# from objects/obj_load_guardabot/（第 3 批移植）
# ds_map/ds_list 按 §3.3 第 18 条换成 Dictionary/Array；LoadJSONFromFile 返回 Dictionary 或 0.0，故用 `not (mundos is Dictionary)` 判失败。
extends GMObject

var no_pausar: float = 0.0
var pos_y = null
var pos_y_limit = null
var water_speed: float = 0.0
var limit_door_1: float = 0.0
var limit_door_2: float = 0.0
var limit_door_3: float = 0.0
var url: String = ""
var entorno: Array = []


# from objects/obj_load_guardabot/Create_0.gml
func _create() -> void:
	no_pausar = 0.0
	pos_y = 0.0
	pos_y_limit = 0.0
	water_speed = 0.0
	limit_door_1 = 0.0
	limit_door_2 = 0.0
	limit_door_3 = 0.0
	url = ""
	GM.aset(entorno, 0, "ground")
	GM.aset(entorno, 1, "underground")
	GM.aset(entorno, 2, "underwater")
	GM.aset(entorno, 3, "castle")
	GM.aset(entorno, 4, "desert")
	GM.aset(entorno, 5, "sky")
	GM.aset(entorno, 6, "airship")
	GM.aset(entorno, 7, "forest")
	GM.aset(entorno, 8, "ghost")
	GM.aset(entorno, 9, "snow")
	GM.aset(entorno, 10, "fall")
	GM.aset(entorno, 11, "beach")
	GM.aset(entorno, 12, "mountain")


# from objects/obj_load_guardabot/Destroy_0.gml
func _destroy() -> void:
	if G.checkpointroom == -4.0 or G.pink_coins == G.pink_coins_total:
		G.pink_coins_total = GM.instance_number(A.obj_pink_coin)


# from objects/obj_load_guardabot/Other_4.gml
func _room_start() -> void:
	G.instance_deactivate = 0.0
	if GM.room == A.rm_title:
		G.levelguardabot = G.last_level
	if G.nm_play == 0.0:
		_user_1()
	else:
		_user_4()


# from objects/obj_load_guardabot/Other_11.gml
func _user_1() -> void:
	var mundos
	var _wrapper
	var _list
	var _map
	var _list2
	var j
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
	var mario_u
	if G.levelguardabot != "":
		if GM.file_exists((G.directorio + G.levelguardabot)):
			mundos = Scr.LoadJSONFromFile(self, (G.directorio + G.levelguardabot))
			if not (mundos is Dictionary) or not mundos.has("MAIN"):
				GM.show_debug_message("Error loading JSON or incorrect structure.")
				GM.room_goto(A.rm_guardabot)
				return
			_wrapper = mundos.get("MAIN")
			if not _wrapper.has("AJUSTES"):
				GM.show_debug_message("Key 'AJUSTES' not found or not a list in JSON.")
				GM.room_goto(A.rm_guardabot)
				return
			_list = _wrapper.get("AJUSTES")
			if float(_list.size()) == 0.0 or not _list[int(0.0)].has("user"):
				GM.show_debug_message("Invalid data structure for 'AJUSTES' in JSON.")
				GM.room_goto(A.rm_guardabot)
				return
			_map = _list[int(0.0)]
			if GM.veq(G.my1, _map.get("user")):
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
			G.timer = _map.get("cronometro")
			if G.timer > 500.0 or G.timer < 10.0:
				G.timer = 300.0
			if GM.instance_exists(A.obj_levelmanager):
				var _o1: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(A.obj_levelmanager):
					if not GM.instance_exists(A.obj_mariostart):
						inst.event_user(5)
					inst.alarm[2] = 1.0
					if G.checkpointroom != -4.0:
						inst.f_mario = 0.0
				GM.other = _o1
			G.autoavance = _map.get("autoavance")
			if G.autoavance > 3.0 or G.autoavance < 0.0:
				G.autoavance = 0.0
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
			if GM.instance_exists(A.obj_ground2):
				for inst in GM.with_list(A.obj_ground2):
					inst.y = _map.get("ground2")
				for inst in GM.with_list(A.obj_ground2):
					inst.size_y = ((432.0 - GM.instance_find(A.obj_ground2, 0).y) / 16.0)
			if GM.instance_exists(A.obj_ground3):
				for inst in GM.with_list(A.obj_ground3):
					inst.x = _map.get("ground3_x")
				for inst in GM.with_list(A.obj_ground3):
					inst.y = _map.get("ground3_y")
				for inst in GM.with_list(A.obj_ground3):
					inst.size_y = ((432.0 - GM.instance_find(A.obj_ground3, 0).y) / 16.0)
			GM.room_width = _map.get("size")
			if GM.room_width > 9216.0:
				GM.room_width = 9216.0
			if GM.room_width < 384.0:
				GM.room_width = 496.0
			pos_y = _map.get("water_level")
			pos_y_limit = _map.get("water_level_limit")
			G.water_speed = _map.get("water_level_speed")
			if not GM.eq(G.water_speed, 0.2) and not GM.eq(G.water_speed, 0.5) and not GM.eq(G.water_speed, 0.8):
				G.water_speed = 0.2
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
				if object != A.obj_tuberia_res and object != A.obj_cannon_res and object != A.obj_cannon_red_res and object != A.obj_semisolid_platform1 and object != A.obj_mushroom_platform_res and object != A.obj_pokey_res and object != A.obj_bullebill_base_red_res and object != A.obj_bullebill_base_res and object != A.obj_vine_res and object != A.obj_platform_res and object != A.obj_platform_blue_res and object != A.obj_puente_res and object != A.obj_door_res and object != A.obj_door_exit_res and object != A.obj_door_switch_res and object != A.obj_door_switch_exit_res and object != A.obj_door_lock_res and object != A.obj_door_lock_exit_res and (object != A.obj_cinta_res) and (object != A.obj_cinta_on_res) and object != A.obj_ground and object != A.obj_slopes:
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
			if GM.instance_exists(A.obj_parent_resource):
				# Check for items and enemies above the camera
				var no_instances_above_camera = true
				for inst in GM.with_list(A.obj_parent_resource):
					if inst.y < GM.instance_find(A.obj_levelmanager, 0).get("cam_top") - 8.0:
						no_instances_above_camera = false
						break
				if no_instances_above_camera:
					for inst in GM.with_list(A.obj_levelmanager):
						inst.camlock = 1.0
				else:
					for inst in GM.with_list(A.obj_levelmanager):
						inst.camlock = 0.0
			if GM.instance_find(A.obj_ground2, 0).y < (GM.instance_find(A.obj_levelmanager, 0).get("cam_top") - 8.0) or GM.instance_find(A.obj_ground3, 0).y < (GM.instance_find(A.obj_levelmanager, 0).get("cam_top") - 8.0):
				for inst in GM.with_list(A.obj_levelmanager):
					inst.camlock = 0.0
			# PORT（非原版，用户 2026-11-11 拍板）：3.5.1 存的地面图块编号超出本源码的图块范围（sprite 只有 50 帧，
			# 文件里有到 64 的编号），照搬会让部分地面变成非实心。3.5.1 格式的文件在这里用源码自己的
			# scr_auto_tile（obj_ground 的 user event 5）按邻接关系重算；源码格式的文件不动。
			if GM.swe_last_was_351:
				for inst in GM.with_list(A.obj_ground):
					if inst.object_index == A.obj_ground:
						inst.event_user(5)
			Scr.scr_edit_to_play(self)
			if GM.instance_exists(A.obj_parent_resource):
				for inst in GM.with_list(A.obj_parent_resource):
					inst.instance_destroy()
			if G.apariencia == 3.0:
				mario_u = A.obj_marioU
				for inst in GM.with_list(A.obj_mario):
					if inst.object_index != A.obj_marioU:
						GM.instance_create(inst.x, inst.y, A.obj_marioU)
						inst.instance_destroy()
			else:
				mario_u = A.obj_mario
			if GM.instance_exists(mario_u):
				if G.checkpointroom == -4.0:
					if GM.instance_exists(A.obj_ground2):
						for inst in GM.with_list(mario_u):
							inst.x = (GM.instance_find(A.obj_ground2, 0).x + 64.0)
						for inst in GM.with_list(mario_u):
							inst.y = (GM.instance_find(A.obj_ground2, 0).y - 32.0)
						for inst in GM.with_list(A.obj_levelmanager):
							inst.x = (GM.instance_find(A.obj_ground2, 0).x + 64.0)
							inst.y = GM.instance_find(A.obj_ground2, 0).y
							inst.speed = 0.0
							inst.fallow_mario = 0.0
				elif GM.room == G.checkpointroom:
					for inst in GM.with_list(mario_u):
						inst.x = G.checkpoint_x
					for inst in GM.with_list(mario_u):
						inst.y = (G.checkpoint_y - 16.0)
					for inst in GM.with_list(A.obj_levelmanager):
						inst.x = G.checkpoint_x
						inst.y = (G.checkpoint_y + 16.0)
						inst.speed = 0.0
						inst.fallow_mario = 0.0
			if G.autoavance != 0.0:
				if GM.room == G.checkpointroom:
					match G.autoavance:
						1.0:
							for inst in GM.with_list(GM.instance_create(G.checkpoint_x, G.checkpoint_y, A.obj_autoscroll)):
								inst.set("velocidad", 0.5)
								inst.set("follow_y", 1.0)
						2.0:
							for inst in GM.with_list(GM.instance_create(G.checkpoint_x, G.checkpoint_y, A.obj_autoscroll)):
								inst.set("velocidad", 1.0)
								inst.set("follow_y", 1.0)
						3.0:
							for inst in GM.with_list(GM.instance_create(G.checkpoint_x, G.checkpoint_y, A.obj_autoscroll)):
								inst.set("velocidad", 1.5)
								inst.set("follow_y", 1.0)
				else:
					match G.autoavance:
						1.0:
							for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - 108.0), A.obj_autoscroll)):
								inst.set("velocidad", 0.5)
						2.0:
							for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - 108.0), A.obj_autoscroll)):
								inst.set("velocidad", 1.0)
						3.0:
							for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 192.0), (GM.room_height - 108.0), A.obj_autoscroll)):
								inst.set("velocidad", 1.5)
			if G.bg_level == "airship" and G.modo_noche == 1.0 and G.apariencia != 0.0 and not GM.instance_exists(A.obj_rainmaker):
				GM.instance_create(0.0, 0.0, A.obj_rainmaker)
			if G.bg_level == "snow" and not GM.instance_exists(A.obj_snowmaker):
				GM.instance_create(0.0, 0.0, A.obj_snowmaker)
			if G.bg_level == "fall" and not GM.instance_exists(A.obj_leafmaker):
				GM.instance_create(0.0, 0.0, A.obj_leafmaker)
			if G.bg_level == "castle" and G.apariencia == 3.0 and not GM.instance_exists(A.obj_firemaker):
				GM.instance_create(0.0, 0.0, A.obj_firemaker)
			if G.bg_level == "mountain" and G.apariencia == 3.0 and G.modo_noche == 1.0 and not GM.instance_exists(A.obj_firemaker):
				GM.instance_create(0.0, 0.0, A.obj_firemaker)
			if G.condiciones == 1.0 and G.condiciones_type == 0.0:
				G.condiciones_clear = 1.0
				for inst in GM.with_list(A.obj_alert_condicion):
					inst.instance_destroy()
				for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 43.0), A.obj_alert_condicion)):
					inst.set("start", 1.0)
			# switch global.bg_level：case "airship" 末尾没有 break，落入 case "sky"（没有 default）
			if G.bg_level == "airship":
				if G.apariencia == 3.0:
					if G.modo_noche == 1.0:
						Scr.__background_set(self, Scr.e__BG.HSpeed, 1.0, -0.1)
						Scr.__background_set(self, Scr.e__BG.HSpeed, 2.0, -0.2)
						Scr.__background_set(self, Scr.e__BG.HSpeed, 3.0, -0.3)
						Scr.__background_set(self, Scr.e__BG.HSpeed, 4.0, -0.4)
						Scr.__background_set(self, Scr.e__BG.HSpeed, 5.0, -0.5)
						Scr.__background_set(self, Scr.e__BG.HSpeed, 7.0, -0.6)
				elif G.apariencia != 3.0:
					if G.modo_noche == 0.0:
						Scr.__background_set(self, Scr.e__BG.HSpeed, 0.0, -0.3)
					else:
						Scr.__background_set(self, Scr.e__BG.HSpeed, 0.0, -1.0)
			if G.bg_level == "airship" or G.bg_level == "sky":
				if G.apariencia == 3.0:
					Scr.__background_set(self, Scr.e__BG.HSpeed, 1.0, -0.1)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 2.0, -0.2)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 3.0, -0.3)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 4.0, -0.4)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 5.0, -0.5)
					Scr.__background_set(self, Scr.e__BG.HSpeed, 7.0, -0.6)
				elif G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.HSpeed, 0.0, -0.2)
			G.instance_deactivate = 1.0
			instance_destroy()
		elif GM.room == A.rm_title:
			_user_5()
	elif GM.room == A.rm_title:
		_user_5()


# from objects/obj_load_guardabot/Other_12.gml
func _user_2() -> void:
	Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 3.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 4.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 5.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 6.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.Visible, 7.0, 0.0)
	Scr.__background_set(self, Scr.e__BG.HTiled, 3.0, 0x000001)
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
				Scr.__background_set(self, Scr.e__BG.HTiled, 3.0, GM.c_black)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_ground(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_ground(self)
		"underground":
			Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_underground(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_underground(self)
		"castle":
			if G.apariencia == 3.0 and G.modo_noche == 0.0:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_castle_1)
				Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_castle_2)
				Scr.__background_set(self, Scr.e__BG.Index, 2.0, A.bg_NSMBU_castle_3)
				Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				Scr.__background_set(self, Scr.e__BG.Visible, 2.0, 1.0)
			else:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_castle(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_castle(self)
		"underwater":
			Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_underwater(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_underwater(self)
		"ghost":
			if G.apariencia == 3.0:
				if G.modo_noche == 0.0:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, A.bg_NSMBU_ghost_house_1)
					Scr.__background_set(self, Scr.e__BG.Index, 1.0, A.bg_NSMBU_ghost_house_2)
					Scr.__background_set(self, Scr.e__BG.Visible, 1.0, 1.0)
				else:
					Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_ghost_house(self))
			else:
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_ghost_house(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_ghost_house(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_airship(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_airship(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_sky(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_sky(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_forest(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_forest(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_desert(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_desert(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_snow(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_snow(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_fall(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_autumn(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_beach(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_beach(self)
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
				Scr.__background_set(self, Scr.e__BG.Index, 0.0, Scr.scr_bg_mountain(self))
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = Scr.scr_snd_mountain(self)
	for inst in GM.with_list(A.obj_levelmanager):
		inst.levelmusic_original = GM.instance_find(A.obj_levelmanager, 0).get("levelmusic")
	if GM.room == A.rm_title:
		if (G.bg_level != "mountain") and (G.modo_noche == 1.0):
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = A.snd_titlemusic_night
		elif G.apariencia == 3.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = A.snd_titlemusic_modern
		elif G.apariencia == 2.0:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = A.snd_titlemusic_smw
		else:
			for inst in GM.with_list(A.obj_levelmanager):
				inst.levelmusic = A.snd_titlemusic
	if G.bg_level == "castle":
		if GM.instance_exists(A.obj_lava_water):
			for inst in GM.with_list(A.obj_lava_water):
				inst.instance_destroy()
		for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (pos_y + 12.0), A.obj_lava_water)):
			match G.apariencia:
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
			inst.pos_y = self.pos_y
			inst.pos_y_limit = self.pos_y_limit
	elif G.bg_level == "forest" and G.modo_noche == 1.0:
		if GM.instance_exists(A.obj_lava_water):
			for inst in GM.with_list(A.obj_lava_water):
				inst.instance_destroy()
		for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (pos_y + 12.0), A.obj_lava_water)):
			match G.apariencia:
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
			inst.pos_y = self.pos_y
			inst.pos_y_limit = self.pos_y_limit
	elif (G.bg_level == "forest" and G.modo_noche == 0.0) or G.bg_level == "beach":
		if GM.instance_exists(A.obj_lava_water):
			for inst in GM.with_list(A.obj_lava_water):
				inst.instance_destroy()
		for inst in GM.with_list(GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), (pos_y + 12.0), A.obj_lava_water)):
			match G.apariencia:
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
			inst.pos_y = self.pos_y
			inst.pos_y_limit = self.pos_y_limit
	elif not GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 1.0)):
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
			inst.pos_y = self.pos_y
			inst.pos_y_limit = self.pos_y_limit
	elif GM.instance_exists(A.obj_lava_water) and ((G.bg_level == "mountain") and (G.modo_noche == 0.0)):
		for inst in GM.with_list(A.obj_lava_water):
			inst.instance_destroy()
	elif GM.instance_exists(A.obj_lava_water):
		for inst in GM.with_list(A.obj_lava_water):
			inst.instance_destroy()
	Scr.scr_create_bg_anim(self)


# from objects/obj_load_guardabot/Other_13.gml
func _user_3() -> void:
	if G.apariencia == 0.0:
		if GM.instance_exists(A.obj_ground3):
			if G.bg_level == "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 4.0), (GM.instance_find(A.obj_ground3, 0).y - 176.0), A.obj_flagpole)
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 80.0), (GM.instance_find(A.obj_ground3, 0).y - 48.0), A.obj_SMB_castle)
	elif G.apariencia == 1.0:
		if GM.instance_exists(A.obj_ground3):
			if G.bg_level == "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif (G.bg_level != "castle") and (not GM.instance_exists(A.obj_goalcard)):
				GM.instance_create(GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 64.0), A.obj_goalcard)
	elif G.apariencia == 2.0:
		if GM.instance_exists(A.obj_ground3):
			if G.bg_level == "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create(GM.instance_find(A.obj_ground3, 0).x, (GM.instance_find(A.obj_ground3, 0).y - 137.0), A.obj_goalgate)
	elif G.apariencia == 3.0:
		if GM.instance_exists(A.obj_ground3):
			if G.bg_level == "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 16.0), (GM.instance_find(A.obj_ground3, 0).y - 16.0), A.obj_axe_smw)
			elif G.bg_level != "castle":
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 8.0), (GM.instance_find(A.obj_ground3, 0).y - 170.0), A.obj_flagpole)
				GM.instance_create((GM.instance_find(A.obj_ground3, 0).x + 80.0), (GM.instance_find(A.obj_ground3, 0).y - 48.0), A.obj_SMB_castle)


# from objects/obj_load_guardabot/Other_14.gml
func _user_4() -> void:
	pass


# from objects/obj_load_guardabot/Other_15.gml
func _user_5() -> void:
	G.apariencia = GM.irandom_range(0.0, 3.0)
	G.bg_level = entorno[GM.irandom_range(0.0, 11.0)]
	G.modo_noche = GM.irandom_range(0.0, 1.0)
	if G.apariencia == 3.0:
		for inst in GM.with_list(A.obj_mario):
			GM.instance_create(inst.x, inst.y, A.obj_marioU)
			inst.instance_destroy()
	pos_y = (GM.room_height - 16.0)
	pos_y_limit = pos_y
	G.timer = 300.0
	_user_2()
	_user_3()
