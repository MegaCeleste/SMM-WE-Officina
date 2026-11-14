extends GMObject

var key: float = 0.0
var keyText: String = ""
var keyDefault: float = 0.0
var ready_v: float = 0.0  # 原名 ready，与 Node.ready 冲突
var back: int = -1
var temp_h: Array = []
var temp_v: Array = []


# from objects/obj_titlemenu_key/Create_0.gml
func _create() -> void:
	key = 0.0
	keyText = ""
	keyDefault = 27.0
	ready_v = 0.0
	alarm[0] = 2.0
	var persistent = GM.instance_find(A.obj_persistent, 0)
	var sx: float = persistent.s
	back = int(Scr.background_create_from_surface(self, GM.application_surface, 0.0, 0.0, (G.gw * sx), (G.gh * sx), false, false))
	for i: int in range(8):
		GM.aset(temp_h, i, GM.layer_get_hspeed(i))
		GM.aset(temp_v, i, GM.layer_get_vspeed(i))
		GM.layer_hspeed(0.0, i)
		GM.layer_vspeed(0.0, i)
	GM.instance_deactivate_all(true, self)
	GM.instance_activate_object(A.obj_persistent)


# from objects/obj_titlemenu_key/Alarm_0.gml
func _alarm_0() -> void:
	ready_v = 1.0


# from objects/obj_titlemenu_key/Draw_0.gml
func _gm_draw() -> void:
	if GM.sprite_exists(back):
		GM.gpu_set_blendenable(0.0)
		var sx = 0.5
		GM.draw_sprite_ext(back, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), sx, sx, 0.0, GM.c_white, 1.0)
		GM.gpu_set_blendenable(1.0)
	GM.draw_sprite_stretched_ext(A.spr_keybox, 0.0, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)), GM.c_white, 0.5)
	GM.draw_set_font(G.font_google)
	GM.draw_set_valign(GM.fa_middle)
	GM.draw_set_halign(GM.fa_center)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + (G.gw / 2.0)), ((GM.camera_get_view_y(GM.view_get_camera(0)) + G.gh) - 96.0), keyText)
	GM.draw_set_valign(GM.fa_top)
	GM.draw_set_halign(GM.fa_left)


# from objects/obj_titlemenu_key/KeyPress_1.gml
func _keypress_1() -> void:
	var newKey
	if ready_v == 1.0:
		newKey = GM.keyboard_key
		if newKey == 27.0:
			GM.audio_play_sound(A.snd_wrong, 0.0, false)
			match key:
				0.0:
					G.lanzar_agarrar = 88.0
				1.0:
					G.saltar = 90.0
				2.0:
					G.spacekey = 32.0
				3.0:
					G.pause = 13.0
				4.0:
					G.arriba = 38.0
				5.0:
					G.abajo = 40.0
				6.0:
					G.izquierda = 37.0
				7.0:
					G.derecha = 39.0
				8.0:
					G.saltar_spin = 40.0
		else:
			GM.audio_play_sound(A.snd_correct, 0.0, false)
			match key:
				0.0:
					if (newKey == 162.0) or (newKey == 163.0):
						G.lanzar_agarrar = 17.0
					else:
						G.lanzar_agarrar = newKey
				1.0:
					if (newKey == 160.0) or (newKey == 161.0):
						G.saltar = 16.0
					else:
						G.saltar = newKey
				2.0:
					G.spacekey = newKey
				3.0:
					G.pause = newKey
				4.0:
					G.arriba = newKey
				5.0:
					G.abajo = newKey
				6.0:
					G.izquierda = newKey
				7.0:
					G.derecha = newKey
				8.0:
					G.saltar_spin = newKey
		GM.sprite_delete(back)
		GM.instance_activate_all()
		for i: int in range(8):
			Scr.__background_set(self, Scr.e__BG.HSpeed, i, temp_h[i])
			Scr.__background_set(self, Scr.e__BG.VSpeed, i, temp_v[i])
		instance_destroy()
