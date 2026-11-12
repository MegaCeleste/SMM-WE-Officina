# from objects/obj_levelmanager/（第 3 批移植）
# follow 存的是 object 编号（Other_16 里 follow = obj_mario），读 follow.y 等写成 GM.instance_find(follow, 0).y；见 UNSURE 清单
extends GMObject

var spd: float = 0.0
var tile: float = 0.0
var fallw: float = 0.0
var timp: float = 0.0
var shake_time: float = 0.0
var shake_long: float = 0.0
var airshiptimer: float = 0.0
var temp_ready: float = 0.0
var follow = null  # 存的是 object 编号（GML: follow = obj_mario），或 null（GML: -4）
var view_move: float = 0.0
var real_time: float = 0.0
var camerahigh: float = 0.0
var real_time_ready: float = 0.0
var fallow_mario: float = 0.0
var lock_lock: float = 0.0
var loop_m: float = 0.0
var prev_powerup: float = 0.0
var powerup: float = 0.0
var dead_bowser: float = 0.0
var view_up: float = 0.0
var view_cont: float = 0.0
var banim: float = 0.0
var banim2: float = 0.0
var banim3: float = 0.0
var pswitch_music: float = 0.0
var cont_soplete: float = 0.0
var sound_effect: float = 0.0
var pink_coins_draw: float = 0.0
var jump_condicion: float = 0.0
var f_mario: float = 0.0
var canpause: float = 0.0
var updown: float = 0.0
var texto_draw: String = ""
var editor: float = 0.0
var editor_water: float = 0.0
var editor_sonidos: float = 0.0
var camlock: float = 0.0
var cam_top: float = 0.0
var s_pink_coins = null
var pwarning: float = 0.0
var s_timehud: float = 0.0
var atime: float = 0.0
var nopause: float = 0.0
var modo_noche: float = 0.0
var angrysun: float = 0.0
var leveltime = null
var levelmusic = null
var levelmusic_original = null
var levelmusic_temp = null
var mchange: float = 0.0
var musicdisabled: float = 0.0
var anim: float = 0.0
var barrier: float = 0.0
var switchon: float = 0.0
var pmeter: float = 0.0
var slowdown: float = 0.0
var direct_x: float = 0.0
var direct_y: float = 0.0
var reverb: float = 0.0


# from objects/obj_levelmanager/Create_0.gml
func _create() -> void:
	spd = 0.0
	tile = 0.0
	fallw = 0.0
	timp = 0.0
	shake_time = 0.0
	shake_long = 1.0
	airshiptimer = 0.0
	temp_ready = 0.0
	follow = null  # GML: -4（noone）
	view_move = 0.0
	real_time = 0.0
	camerahigh = 0.0
	real_time_ready = 0.0
	fallow_mario = 0.0
	lock_lock = 0.0
	loop_m = 0.0
	prev_powerup = 0.0
	powerup = 0.0
	dead_bowser = 0.0
	view_up = 0.0
	view_cont = 0.0
	banim = 0.0
	banim2 = 0.0
	banim3 = 0.0
	pswitch_music = 0.0
	cont_soplete = 0.0
	sound_effect = 0.0
	pink_coins_draw = 1.0
	jump_condicion = 0.0
	f_mario = 1.0
	canpause = 1.0
	updown = 0.0
	texto_draw = ""
	editor = 0.0
	editor_water = 0.0
	editor_sonidos = 0.0
	camlock = 1.0
	cam_top = GM.camera_get_view_y(GM.view_camera[0])
	s_pink_coins = A.spr_pinkcoin_hub1
	pwarning = 0.0
	s_timehud = A.spr_timehud
	atime = 0.0
	nopause = 0.0
	modo_noche = 0.0
	angrysun = 0.0
	leveltime = 0.0
	levelmusic = A.snd_SMB_music_ground
	levelmusic_original = A.snd_music_sky
	levelmusic_temp = A.snd_music_mario_land
	mchange = 0.0
	alarm[0] = 2.0
	GM.camera_set_view_target(GM.view_get_camera(0), A.obj_levelmanager)
	musicdisabled = 0.0
	anim = 0.0
	alarm[5] = 7.0
	barrier = 1.0
	alarm[6] = 3.0
	switchon = 0.0
	pmeter = 0.0
	slowdown = 0.0
	direct_x = 0.0
	direct_y = 0.0
	reverb = 1.0
	alarm[7] = 15.0


# from objects/obj_levelmanager/Step_2.gml
func _step_end() -> void:
	var val  # 局部变量提升（GML 的 var 是函数作用域）
	var val_2  # 局部变量提升（GML 的 var 是函数作用域）
	if temp_ready == 1.0 and GM.instance_exists(A.obj_mario) and (not GM.instance_exists(A.obj_mario_transform2)):
		G.ms += (1000.0 / GM.room_speed)
	if G.apariencia == 3.0:
		banim += 0.2
	else:
		banim += 0.15
	if G.apariencia == 3.0:
		banim2 += 0.2
	else:
		banim2 += 0.1
	banim3 += 0.1
	if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("dash_atack") == 2.0 and (not GM.audio_is_playing(A.snd_SMB_link_dash_sword)):
		GM.audio_play_sound(A.snd_SMB_link_dash_sword, 1.0, true)
	elif GM.audio_is_playing(A.snd_SMB_link_dash_sword) and ((not GM.instance_exists(A.obj_mario)) or (GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("dash_atack") != 2.0)):
		GM.audio_stop_sound(A.snd_SMB_link_dash_sword)
	if GM.instance_exists(A.obj_bowserjr_shell) and (not GM.audio_is_playing(Scr.scr_snd_bowserjr_shell(self))):
		GM.audio_play_sound(Scr.scr_snd_bowserjr_shell(self), 1.0, true)
	elif GM.audio_is_playing(Scr.scr_snd_bowserjr_shell(self)) and ((not GM.instance_exists(A.obj_bowserjr_shell)) or (not GM.instance_exists(A.obj_mario))):
		GM.audio_stop_sound(Scr.scr_snd_bowserjr_shell(self))
	if G.modo_noche == 1.0 and editor == 0.0 and (G.bg_level == "ghost" or G.bg_level == "underwater"):
		if not GM.instance_exists(A.obj_lighting):
			GM.instance_create(0.0, 0.0, A.obj_lighting)
	elif GM.instance_exists(A.obj_lighting):
		for inst in GM.with_list(A.obj_lighting):
			inst.instance_destroy()
	if G.condiciones_count == 2.0 and (not GM.instance_exists(A.obj_condiciones)) and ((G.bg_level != "forest" and G.bg_level != "beach") or (GM.instance_exists(A.obj_arrow_lock) and GM.instance_exists(A.obj_lava_water) and GM.instance_find(A.obj_lava_water, 0).y > GM.instance_find(A.obj_arrow_lock, 0).y)):
		G.condiciones_count = 0.0
	if GM.keyboard_check_pressed(GM.vk_control) and GM.instance_find(A.obj_persistent, 0).get("modo_android") == 1.0:
		if G.key_br == 0.0:
			G.key_br = 1.0
		else:
			G.key_br = 0.0
	if pmeter < 6.0 or editor == 1.0 or GM.instance_exists(A.obj_player_goal_parent):
		GM.audio_stop_sound(A.snd_pmeter)
	_user_6()
	if GM.instance_exists(A.obj_autoscroll):
		if camlock == 1.0:
			if GM.instance_exists(follow):
				if y < ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 18.0):
					vspeed += 0.4
					if vspeed > 4.0:
						vspeed = 4.0
					x = GM.instance_find(A.obj_autoscroll, 0).x
				else:
					if (GM.instance_find(follow, 0).y + 32.0) < (GM.room_height - Scr.__view_get(self, 3, 0.0)) and GM.variable_instance_exists(GM.instance_find(follow, 0), "state") and GM.instance_find(follow, 0).get("state") < 2.0 and lock_lock == 0.0:
						if y <= ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0):
							vspeed = 0.0
							y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
							lock_lock = 1.0
						else:
							vspeed -= 0.05
					elif lock_lock == 1.0:
						vspeed = 0.0
						y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
					if (GM.instance_find(follow, 0).y + 32.0) > (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)):
						lock_lock = 0.0
						if y < (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)):
							vspeed += 0.05
						else:
							vspeed = 0.0
							y = (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0))
					x = GM.instance_find(A.obj_autoscroll, 0).x
			else:
				speed = 0.0
		elif GM.instance_exists(follow):
			_user_8()
			x = GM.instance_find(A.obj_autoscroll, 0).x
	elif GM.instance_exists(follow):
		if camlock == 1.0:
			if fallow_mario == 1.0:
				_user_7()
			elif y < ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 18.0):
				vspeed += 0.4
				if vspeed > 4.0:
					vspeed = 4.0
				lock_lock = 1.0
				if x != GM.instance_find(follow, 0).x:
					x += ((GM.instance_find(follow, 0).x - x) * 0.2)
			else:
				if (GM.instance_find(follow, 0).y + 32.0) < (GM.room_height - Scr.__view_get(self, 3, 0.0)) and GM.variable_instance_exists(GM.instance_find(follow, 0), "state") and GM.instance_find(follow, 0).get("state") < 2.0 and lock_lock == 0.0:
					if y <= ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0):
						vspeed = 0.0
						y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
						lock_lock = 1.0
					else:
						vspeed -= 0.05
				elif lock_lock == 1.0:
					vspeed = 0.0
					y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
				if (GM.instance_find(follow, 0).y + 32.0) > (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)):
					lock_lock = 0.0
					if y < (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)):
						vspeed += 0.05
					else:
						vspeed = 0.0
						y = (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0))
				if x != GM.instance_find(follow, 0).x:
					x += ((GM.instance_find(follow, 0).x - x) * 0.2)
		elif fallow_mario == 1.0:
			_user_7()
		else:
			_user_8()
			if x != GM.instance_find(follow, 0).x:
				x += ((GM.instance_find(follow, 0).x - x) * 0.2)
	else:
		speed = 0.0
	x = GM.gm_round(x)
	y = GM.gm_round(y)
	_user_11()
	if G.instance_deactivate == 1.0:
		if GM.room != A.rm_editor:
			if loop_m == 0.0:
				GM.instance_deactivate_object(A.obj_ground2)
				GM.instance_deactivate_object(A.obj_solidtop)
				GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0), -96.0, ((GM.camera_get_view_width(GM.view_get_camera(0)) + 128.0) + 128.0), (GM.room_height + 192.0), true)
				GM.instance_deactivate_object(A.obj_deactivation)
				GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 128.0), -96.0, ((GM.camera_get_view_width(GM.view_get_camera(0)) + 128.0) + 128.0), (GM.room_height + 192.0), true)
				GM.instance_deactivate_object(A.obj_modelbgo)
				GM.instance_deactivate_object(A.obj_parent_sound_o)
				GM.instance_activate_region((GM.camera_get_view_x(GM.view_get_camera(0)) - 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) - 32.0), ((GM.camera_get_view_width(GM.view_get_camera(0)) + 32.0) + 32.0), ((GM.camera_get_view_height(GM.view_get_camera(0)) + 32.0) + 32.0), true)
				loop_m = 2.0
			loop_m -= 1.0
	else:
		if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 0.0:
			GM.instance_activate_object(A.obj_levelmanager)
		GM.instance_activate_object(A.obj_solidtop)
		GM.instance_activate_object(A.obj_deactivation)
		GM.instance_activate_object(A.obj_parent_save)
		GM.instance_activate_object(A.obj_parent_sound_o)
	if barrier == 0.0 and GM.instance_exists(A.obj_mario):
		if GM.instance_find(A.obj_mario, 0).x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0):
			for inst in GM.with_list(A.obj_mario):
				inst.x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0)
			if GM.instance_find(A.obj_mario, 0).hspeed < 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = 0.0
			if GM.instance_exists(A.obj_slider):
				for inst in GM.with_list(A.obj_slider):
					inst.x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0)
		elif GM.instance_find(A.obj_mario, 0).x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 5.0):
			for inst in GM.with_list(A.obj_mario):
				inst.x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 5.0)
			if GM.instance_find(A.obj_mario, 0).hspeed > 0.0:
				for inst in GM.with_list(A.obj_mario):
					inst.hspeed = 0.0
			if GM.instance_exists(A.obj_slider):
				for inst in GM.with_list(A.obj_slider):
					inst.x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 5.0)
	if barrier == 0.0 and GM.instance_exists(A.obj_mario_pballon):
		if GM.instance_find(A.obj_mario_pballon, 0).x < (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0):
			for inst in GM.with_list(A.obj_mario_pballon):
				inst.x = (GM.camera_get_view_x(GM.view_get_camera(0)) + 5.0)
			if GM.instance_find(A.obj_mario_pballon, 0).hspeed < 0.0:
				for inst in GM.with_list(A.obj_mario_pballon):
					inst.hspeed = 0.0
		elif GM.instance_find(A.obj_mario_pballon, 0).x > ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 5.0):
			for inst in GM.with_list(A.obj_mario_pballon):
				inst.x = ((GM.camera_get_view_x(GM.view_get_camera(0)) + GM.camera_get_view_width(GM.view_get_camera(0))) - 5.0)
			if GM.instance_find(A.obj_mario_pballon, 0).hspeed > 0.0:
				for inst in GM.with_list(A.obj_mario_pballon):
					inst.hspeed = 0.0
	if G.coins > 99.0:
		G.coins -= 100.0
		if GM.instance_exists(A.obj_mario):
			var _o1: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(GM.instance_create((GM.instance_find(A.obj_mario, 0).x - 8.0), GM.instance_find(A.obj_mario, 0).y, A.obj_score)):
				inst.event_user(7)
			GM.other = _o1
		else:
			var _o2: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(GM.instance_create((x - 8.0), y, A.obj_score)):
				inst.event_user(7)
			GM.other = _o2
	if editor == 1.0:
		jump_condicion = 0.0
		return
	if G.condiciones == 1.0 and editor == 0.0:
		if G.condiciones_type == 0.0:
			match G.condiciones_count:
				0.0:
					if GM.instance_exists(A.obj_deadmario) or (GM.instance_exists(A.obj_mario_transform2) and GM.instance_find(A.obj_mario_transform2, 0).get("powerdown") == 1.0):
						if G.condiciones_clear == 1.0:
							G.condiciones_clear = 0.0
							for inst in GM.with_list(A.obj_alert_condicion):
								inst.instance_destroy()
							for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), A.obj_alert_condicion)):
								inst.set("lose", 1.0)
				1.0:
					if GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("state") > 1.0 and jump_condicion == 0.0:
						jump_condicion = 1.0
					elif GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("inclown") == 0.0 and GM.instance_find(A.obj_mario, 0).get("state") < 2.0 and G.condiciones_clear == 1.0 and jump_condicion == 1.0:
						G.condiciones_clear = 0.0
						for inst in GM.with_list(A.obj_alert_condicion):
							inst.instance_destroy()
						for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), A.obj_alert_condicion)):
							inst.set("lose", 1.0)
				2.0:
					if GM.instance_exists(A.obj_mario) and (G.bg_level == "forest" or G.bg_level == "beach") and GM.instance_find(A.obj_mario, 0).get("isswim") == 0.0:
						G.condiciones_clear = 0.0
						for inst in GM.with_list(A.obj_alert_condicion):
							inst.instance_destroy()
						for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), A.obj_alert_condicion)):
							inst.set("lose", 1.0)
				3.0:
					if G.coins > 0.0 and (not GM.instance_exists(A.obj_player_goal_parent)) and G.condiciones_clear == 1.0:
						G.condiciones_clear = 0.0
						for inst in GM.with_list(A.obj_alert_condicion):
							inst.instance_destroy()
						for inst in GM.with_list(GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 54.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 98.0), A.obj_alert_condicion)):
							inst.set("lose", 1.0)
	if GM.instance_number(A.obj_mario) > 1:
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
			return
	if pwarning == 0.0 and editor == 0.0:
		if alarm[10] > 100.0 and alarm[10] < 120.0:
			GM.audio_play_sound(Scr.scr_snd_switchalert(self), 0.0, false)
			pwarning = 1.0
	if GM.audio_is_playing(Scr.scr_snd_hurryup(self)):
		if GM.audio_is_playing(levelmusic):
			GM.audio_pause_sound(levelmusic)
		elif GM.audio_is_playing(Scr.scr_snd_starman(self)):
			GM.audio_pause_sound(Scr.scr_snd_starman(self))
		elif GM.audio_is_playing(Scr.scr_snd_switchsong(self)):
			GM.audio_pause_sound(Scr.scr_snd_switchsong(self))
	else:
		if G.timer > -1.0 and G.timer < 101.0:
			GM.audio_sound_pitch(levelmusic, 1.1)
			GM.audio_sound_pitch(Scr.scr_snd_starman(self), 1.1)
			GM.audio_sound_pitch(Scr.scr_snd_switchsong(self), 1.1)
		else:
			GM.audio_sound_pitch(levelmusic, 1.0)
			GM.audio_sound_pitch(Scr.scr_snd_starman(self), 1.0)
			GM.audio_sound_pitch(Scr.scr_snd_switchsong(self), 1.0)
		if editor == 0.0:
			if GM.audio_is_paused(levelmusic):
				GM.audio_resume_sound(levelmusic)
			elif GM.audio_is_paused(Scr.scr_snd_starman(self)):
				GM.audio_resume_sound(Scr.scr_snd_starman(self))
			elif GM.audio_is_paused(Scr.scr_snd_switchsong(self)):
				GM.audio_resume_sound(Scr.scr_snd_switchsong(self))
		if editor == 0.0:
			if G.bonus_music > 0.0:
				if G.bonus_music == 2.0:
					if not GM.veq(G.bonus_obj, A.obj_lighting) and (not GM.instance_exists(G.bonus_obj)) and G.ef_repeat == 0.0 and (not GM.instance_exists(A.obj_player_goal_parent)) and (not GM.instance_exists(A.obj_deadmario)):
						GM.audio_stop_sound(levelmusic)
						match G.powerup:
							-50.0:
								levelmusic = A.snd_music_mario_land
							-85.0:
								levelmusic = Scr.scr_music_link(self)
							_:
								levelmusic = levelmusic_temp
						if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
							GM.audio_play_sound(levelmusic, 1.0, true)
						G.bonus_music = 0.0
				elif G.bonus_music == 1.0:
					if levelmusic != A.snd_music_mario_land and levelmusic != A.snd_SMB_master_sword and levelmusic != A.snd_SMB_master_sword_underground and levelmusic != A.snd_SMB_master_sword_castle and G.boss_music == 0.0:
						levelmusic_temp = levelmusic
					else:
						levelmusic_temp = levelmusic_original
					GM.audio_stop_sound(levelmusic)
					match G.apariencia:
						0.0:
							if G.powerup == -85.0:
								levelmusic = A.snd_SMB_bonus_link
							else:
								levelmusic = A.snd_SMB_bonus
						1.0:
							levelmusic = A.snd_SMB3_bonus
						2.0:
							levelmusic = A.snd_SMW_bonus
						3.0:
							levelmusic = A.snd_NSMBU_bonus
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
					G.bonus_music = 2.0
					G.boss_music = 0.0
					G.ef_repeat = 0.0
			if G.boss_music > 0.0:
				if G.boss_music == 2.0:
					if not GM.veq(G.bowser_obj, A.obj_lighting) and (not GM.instance_exists(G.bowser_obj)) and G.ef_repeat == 0.0 and (not GM.instance_exists(A.obj_player_goal_parent)) and (not GM.instance_exists(A.obj_deadmario)):
						GM.audio_stop_sound(levelmusic)
						match G.powerup:
							-50.0:
								levelmusic = A.snd_music_mario_land
							-85.0:
								levelmusic = Scr.scr_music_link(self)
							_:
								levelmusic = levelmusic_temp
						if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
							GM.audio_play_sound(levelmusic, 1.0, true)
						G.boss_music = 0.0
				elif G.boss_music == 1.0:
					if levelmusic != A.snd_music_mario_land and levelmusic != A.snd_SMB_master_sword and levelmusic != A.snd_SMB_master_sword_underground and levelmusic != A.snd_SMB_master_sword_castle and G.bonus_music == 0.0:
						levelmusic_temp = levelmusic
					else:
						levelmusic_temp = levelmusic_original
					GM.audio_stop_sound(levelmusic)
					match G.apariencia:
						0.0:
							if G.powerup == -85.0:
								levelmusic = A.snd_SMB_boss_link
							else:
								levelmusic = A.snd_SMB_boss
						1.0:
							levelmusic = A.snd_SMB3_boss
						2.0:
							levelmusic = A.snd_SMW_boss
						3.0:
							levelmusic = A.snd_NSMBU_boss
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
					G.boss_music = 2.0
					G.bonus_music = 0.0
					G.ef_repeat = 0.0
			if G.n64_music == 1.0:
				if G.bonus_music > 0.0 or G.boss_music > 0.0:
					levelmusic_temp = A.snd_n64
				else:
					levelmusic_temp = levelmusic
					GM.audio_stop_sound(levelmusic)
					levelmusic = A.snd_n64
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
				G.n64_music = 2.0
				G.ef_repeat = 0.0
		else:
			G.n64_music = 0.0
			G.bonus_music = 0.0
			G.boss_music = 0.0
			G.ef_repeat = 0.0
		match mchange:
			1.0:
				if G.bonus_music > 0.0 or G.boss_music > 0.0 or levelmusic == A.snd_n64:
					levelmusic_temp = A.snd_music_mario_land
				else:
					if levelmusic == A.snd_SMB_master_sword or levelmusic == A.snd_SMB_master_sword_underground or levelmusic == A.snd_SMB_master_sword_castle:
						levelmusic_temp = levelmusic_original
					else:
						levelmusic_temp = levelmusic
					GM.audio_stop_sound(levelmusic)
					levelmusic = A.snd_music_mario_land
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
				mchange = 0.0
				G.ef_repeat = 0.0
			2.0:
				GM.audio_stop_sound(levelmusic)
				levelmusic = levelmusic_original
				mchange = 0.0
				G.ef_repeat = 0.0
			3.0:
				if G.bonus_music > 0.0 or G.boss_music > 0.0 or levelmusic == A.snd_n64:
					levelmusic_temp = levelmusic_original
				else:
					GM.audio_stop_sound(levelmusic)
					levelmusic = levelmusic_temp
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
				mchange = 0.0
				G.ef_repeat = 0.0
			4.0:
				if G.bonus_music > 0.0 or G.boss_music > 0.0 or levelmusic == A.snd_n64:
					levelmusic_temp = Scr.scr_music_link(self)
				else:
					if levelmusic == A.snd_music_mario_land:
						levelmusic_temp = levelmusic_original
					else:
						levelmusic_temp = levelmusic
					GM.audio_stop_sound(levelmusic)
					levelmusic = Scr.scr_music_link(self)
					if (not GM.audio_is_playing(Scr.scr_snd_starman(self))) and (not GM.audio_is_playing(Scr.scr_snd_switchsong(self))):
						GM.audio_play_sound(levelmusic, 1.0, true)
				mchange = 0.0
				G.ef_repeat = 0.0
	if GM.audio_is_playing(A.snd_es_ahh) or GM.audio_is_playing(A.snd_es_ubsi) or GM.instance_exists(A.obj_panel_expand):
		if G.sounds_level == 1.0:
			val_2 = 0.0
		else:
			val_2 = 0.2
		val = 0.2
	else:
		if G.sounds_level == 1.0:
			val_2 = 0.0
		else:
			val_2 = 1.0
		val = 1.0
	GM.audio_sound_gain(levelmusic, val_2, 0.0)
	GM.audio_sound_gain(Scr.scr_snd_starman(self), val, 0.0)
	GM.audio_sound_gain(Scr.scr_snd_switchsong(self), val, 0.0)


# from objects/obj_levelmanager/Alarm_0.gml
func _alarm_0() -> void:
	if not GM.audio_is_playing(levelmusic):
		if musicdisabled == 0.0 and switchon == 0.0 and sound_effect == 0.0 and editor == 0.0 and (not GM.instance_exists(A.obj_player_goal_parent)) and (not GM.instance_exists(A.obj_deadmario)):
			GM.audio_play_sound(levelmusic, 1.0, true)


# from objects/obj_levelmanager/Alarm_1.gml
func _alarm_1() -> void:
	GM.audio_stop_sound(levelmusic)


# from objects/obj_levelmanager/Alarm_2.gml
func _alarm_2() -> void:
	if GM.instance_exists(A.obj_mario):
		if G.timer > 0.0 and editor == 0.0:
			G.timer -= 1.0
			alarm[2] = 60.0
			if G.timer == 101.0:
				alarm[3] = 60.0
			elif G.timer == 0.0:
				alarm[4] = 60.0
	else:
		alarm[2] = 50.0
		return


# from objects/obj_levelmanager/Alarm_3.gml
func _alarm_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_hurryup(self), 0.0, false)


# from objects/obj_levelmanager/Alarm_4.gml
func _alarm_4() -> void:
	if GM.instance_exists(A.obj_mario):
		G.timer = 0.0
		alarm[10] = 1.0
		GM.instance_create(GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_timeup)
		for inst in GM.with_list(GM.instance_create(GM.instance_find(A.obj_mario, 0).x, GM.instance_find(A.obj_mario, 0).y, A.obj_deadmario)):
			inst.set("timeup", 1.0)
		for inst in GM.with_list(A.obj_mario):
			inst.instance_destroy()
		return
	else:
		alarm[4] = 1.0


# from objects/obj_levelmanager/Alarm_5.gml
func _alarm_5() -> void:
	anim += 1.0
	alarm[5] = 7.0


# from objects/obj_levelmanager/Alarm_6.gml
func _alarm_6() -> void:
	barrier = 0.0


# from objects/obj_levelmanager/Alarm_7.gml
func _alarm_7() -> void:
	if GM.instance_exists(A.obj_mario):
		if (absf(GM.instance_find(A.obj_mario, 0).hspeed) > (2.1 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") == 1.0 and G.apariencia != 3.0) or (absf(GM.instance_find(A.obj_mario, 0).hspeed) > (1.5 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") == 1.0 and G.apariencia == 3.0) or (GM.instance_find(A.obj_mario, 0).get("stompstyle") == 1.0 and GM.instance_find(A.obj_mario, 0).get("canfly") == 1.0 and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (2.1 + absf((1 * GM.instance_number(A.obj_invincibility))))) or (G.apariencia == 3.0 and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (1.8 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") == 2.0):
			if pmeter < 6.0:
				pmeter += 1.0
		elif pmeter > 0.0 and slowdown == 2.0:
			pmeter -= 1.0
		slowdown += 1.0
		if slowdown == 3.0:
			slowdown = 0.0
	elif pmeter > 0.0:
		pmeter -= 1.0
	if pmeter == 6.0:
		if G.apariencia == 1.0 and GM.instance_exists(A.obj_mario):
			GM.audio_play_sound(A.snd_pmeter, 1.0, true)
		alarm[8] = 300.0
		alarm[9] = 7.0
	elif G.apariencia == 3.0:
		alarm[7] = 6.0
	else:
		alarm[7] = 8.0


# from objects/obj_levelmanager/Alarm_8.gml
func _alarm_8() -> void:
	if pmeter > 5.0:
		if (GM.instance_exists(A.obj_mario) and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (2.1 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") < 2.0 and G.apariencia != 3.0) or (GM.instance_exists(A.obj_mario) and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (1.5 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") < 2.0 and G.apariencia == 3.0) or (GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("stompstyle") == 1.0 and GM.instance_find(A.obj_mario, 0).get("canfly") == 1.0 and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (2.1 + absf((1 * GM.instance_number(A.obj_invincibility))))) or (GM.instance_exists(A.obj_mario) and G.apariencia == 3.0 and absf(GM.instance_find(A.obj_mario, 0).hspeed) > (1.8 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("state") == 2.0):
			alarm[8] = 100.0
		else:
			pmeter = 5.0
			alarm[7] = 15.0


# from objects/obj_levelmanager/Alarm_9.gml
func _alarm_9() -> void:
	if (GM.instance_exists(A.obj_mario) and absf(GM.instance_find(A.obj_mario, 0).hspeed) <= (2.1 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("skidnow") == 0.0 and GM.instance_find(A.obj_mario, 0).get("state") < 2.0 and G.apariencia != 3.0) or (GM.instance_exists(A.obj_mario) and absf(GM.instance_find(A.obj_mario, 0).hspeed) <= (1.5 + absf((1 * GM.instance_number(A.obj_invincibility)))) and GM.instance_find(A.obj_mario, 0).get("skidnow") == 0.0 and GM.instance_find(A.obj_mario, 0).get("state") < 2.0 and G.apariencia == 3.0) or (GM.instance_exists(A.obj_mario) and GM.instance_find(A.obj_mario, 0).get("stompstyle") == 1.0 and GM.instance_find(A.obj_mario, 0).get("canfly") == 1.0 and absf(GM.instance_find(A.obj_mario, 0).hspeed) <= (2.1 + absf((1 * GM.instance_number(A.obj_invincibility))))):
		GM.audio_stop_sound(A.snd_pmeter)
		pmeter = 5.0
		alarm[7] = 15.0
	elif pmeter > 5.0:
		if pmeter == 6.0:
			pmeter = 7.0
		else:
			pmeter = 6.0
		alarm[9] = 7.0


# from objects/obj_levelmanager/Alarm_10.gml
func _alarm_10() -> void:
	if switchon == 1.0:
		switchon = 0.0
		pswitch_music = 0.0
		GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		pwarning = 0.0
		if GM.instance_exists(A.obj_invincibility) and editor == 0.0:
			if (GM.instance_find(A.obj_invincibility, 0).alarm[0] > -1.0) and not GM.audio_is_playing(A.snd_n64):
				for inst in GM.with_list(A.obj_invincibility):
					inst.alarm[2] = 2.0
				GM.audio_play_sound(Scr.scr_snd_starman(self), 99.0, true)
				GM.audio_stop_sound(A.snd_n64)
				GM.audio_stop_sound(Scr.scr_music_link(self))
			else:
				alarm[0] = 2.0
		else:
			alarm[0] = 2.0


# from objects/obj_levelmanager/Alarm_11.gml
func _alarm_11() -> void:
	if editor == 0.0:
		if dead_bowser == 1.0:
			GM.audio_stop_sound(Scr.scr_snd_thwomp(self))
			GM.audio_play_sound(Scr.scr_snd_thwomp(self), 0.0, false)
			dead_bowser = 0.0
		match shake_time:
			0.0:
				y -= (8.0 * shake_long)
			1.0:
				y += (1.0 * shake_long)
			2.0:
				y += (7.0 * shake_long)
			3.0:
				y -= (4.0 * shake_long)
			4.0:
				y += (1.0 * shake_long)
			5.0:
				y += (3.0 * shake_long)
			6.0:
				y -= (2.0 * shake_long)
			7.0:
				y += (2.0 * shake_long)
			8.0:
				y -= (1.0 * shake_long)
			9.0:
				y += (1.0 * shake_long)
		if shake_time == 9.0:
			shake_time = 0.0
			shake_long = 1.0
		else:
			shake_time += 1.0
			alarm[11] = 2.0
	else:
		shake_time = 0.0
		shake_long = 1.0
		dead_bowser = 0.0


# from objects/obj_levelmanager/Other_4.gml
func _room_start() -> void:
	if GM.room == A.rm_editor:
		GM.instance_create(0.0, 0.0, A.obj_load_level)
	if G.levelmusic != levelmusic:
		GM.audio_stop_sound(G.levelmusic)
		G.levelmusic = levelmusic
	G.yoshi = 0.0
	G.n64_music = 0.0
	G.boss_music = 0.0
	G.bowser_obj = 0.0
	G.bonus_music = 0.0
	G.bonus_obj = self
	G.ef_repeat = 0.0
	if leveltime > 0.0:
		if G.timer == 0.0:
			G.timer = leveltime
			alarm[2] = 50.0
		elif G.timer > 0.0:
			alarm[2] = 50.0
		temp_ready = 1.0
	if GM.room == G.checkpointroom and GM.room != A.rm_guardabot_play and GM.room != A.rm_title:
		if GM.instance_exists(A.obj_checkpoint):
			var _o3: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(A.obj_checkpoint):
				if inst.x == G.checkpoint_x and inst.y == G.checkpoint_y:
					for inst2 in GM.with_list(self):
						inst2.event_user(0)
					GM.instance_create(G.checkpoint_x, (G.checkpoint_y - 16.0), A.obj_mario)
			GM.other = _o3
	if G.mariostart == 0.0 and GM.room != A.rm_editor and GM.room != A.rm_title:
		G.mariostart = 1.0
		GM.instance_create(0.0, 0.0, A.obj_mariostart)
	if GM.room == A.rm_guardabot_play or GM.room == A.rm_title:
		_user_5()
		if GM.instance_find(A.obj_persistent, 0).get("modo_android") == 1.0 and G.controles_tactiles == 1.0:
			var _o4: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
			GM.other = self
			for inst in GM.with_list(A.obj_persistent):
				inst.event_user(2)
				inst.event_user(3)


			GM.other = _o4
# from objects/obj_levelmanager/Other_5.gml
func _room_end() -> void:
	if switchon == 1.0:
		G.pswitch = alarm[10]
	GM.audio_stop_sound(A.snd_pmeter)
	GM.audio_stop_sound(Scr.scr_snd_soplete(self))
	for inst in GM.with_list(A.obj_rainmaker):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_leafmaker):
		inst.instance_destroy()
	GM.audio_stop_sound(A.bgm_sm1clear)
	GM.audio_stop_sound(A.snd_SMB_course_clear_castle)
	GM.audio_stop_sound(A.snd_SMB3_course_clear)
	GM.audio_stop_sound(A.snd_SMB3_course_clear_castle)
	GM.audio_stop_sound(A.bgm_smwclear)
	GM.audio_stop_sound(A.bgm_smwclear_castle)
	GM.audio_stop_sound(A.snd_NSMBU_clear)
	GM.audio_stop_sound(A.snd_NSMBU_clear_castle)
	GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
	GM.audio_stop_sound(Scr.scr_snd_starman(self))
	GM.audio_stop_sound(A.snd_n64)
	GM.audio_stop_sound(Scr.scr_music_link(self))
	G.timer = 0.0
	if GM.room == A.rm_editor:
		G.powerup = 0.0
	G.condiciones = 0.0
	G.condiciones_type = 0.0
	G.condiciones_object = 0.0
	G.condiciones_count = 0.0
	if GM.instance_find(A.obj_persistent, 0).get("modo_android") == 1.0 and G.controles_tactiles == 1.0 and GM.room == A.rm_title:
		var _o5: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
		GM.other = self
		for inst in GM.with_list(A.obj_persistent):
			inst.event_user(4)
			inst.event_user(5)


		GM.other = _o5
# from objects/obj_levelmanager/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(A.obj_mario):
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_autoscroll):
		inst.instance_destroy()


# from objects/obj_levelmanager/Other_11.gml
func _user_1() -> void:
	if switchon == 0.0:
		switchon = 1.0
		alarm[1] = 1.0
		GM.audio_stop_sound(Scr.scr_snd_switchsong(self))
		pswitch_music = GM.audio_play_sound(Scr.scr_snd_switchsong(self), 1.0, true)
		GM.audio_stop_sound(Scr.scr_snd_starman(self))
		GM.audio_stop_sound(A.snd_n64)
		GM.audio_stop_sound(Scr.scr_music_link(self))
	elif pswitch_music != A.snd_SMB_music_ground:
		GM.audio_sound_set_track_position(pswitch_music, 0.0)


# from objects/obj_levelmanager/Other_12.gml
func _user_2() -> void:
	for inst in GM.with_list(A.obj_flipblock):
		GM.instance_create(inst.x, inst.y, A.obj_coinchange)
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_coin):
		GM.instance_create(inst.x, inst.y, A.obj_flipblock)
		inst.instance_destroy()
	for inst in GM.with_list(A.obj_coinchange):
		GM.instance_create(inst.x, inst.y, A.obj_coin)
		inst.instance_destroy()


# from objects/obj_levelmanager/Other_13.gml
func _user_3() -> void:
	GM.audio_stop_sound(levelmusic)
	GM.audio_stop_sound(Scr.scr_snd_starman(self))
	GM.audio_stop_sound(A.snd_n64)
	GM.audio_stop_sound(Scr.scr_music_link(self))
	GM.audio_stop_sound(Scr.scr_snd_switchsong(self))


# from objects/obj_levelmanager/Other_15.gml
func _user_5() -> void:
	if G.timer > 0.0 and G.timer < 101.0:
		GM.audio_stop_sound(Scr.scr_snd_hurryup(self))
		GM.audio_play_sound(Scr.scr_snd_hurryup(self), 1.0, false)


# from objects/obj_levelmanager/Other_16.gml
func _user_6() -> void:
	if GM.instance_exists(A.obj_mario):
		follow = A.obj_mario
	elif GM.instance_exists(A.obj_player_goal_parent):
		follow = A.obj_player_goal_parent
	elif GM.instance_exists(A.obj_doormario):
		follow = A.obj_doormario
	elif GM.instance_exists(A.obj_doormario_exit):
		follow = A.obj_doormario_exit
	elif GM.instance_exists(A.obj_mario_temp):
		follow = A.obj_mario_temp
	elif GM.instance_exists(A.obj_player_warp):
		follow = A.obj_player_warp
	elif GM.instance_exists(A.obj_frozenmario):
		follow = A.obj_frozenmario
	elif GM.instance_exists(A.obj_slider):
		follow = A.obj_slider
	else:
		follow = null  # GML: -4（noone）


# from objects/obj_levelmanager/Other_17.gml
func _user_7() -> void:
	if GM.instance_exists(A.obj_mario):
		if GM.point_distance(x, y, GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 32.0)) > 6.0:
			move_towards_point(GM.instance_find(A.obj_mario, 0).x, (GM.instance_find(A.obj_mario, 0).y + 32.0), 6.0)
			if camlock == 1.0 and y == ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0):
				y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
		else:
			fallow_mario = 0.0
			speed = 0.0
	elif GM.instance_exists(follow):
		if GM.point_distance(x, y, GM.instance_find(follow, 0).x, (GM.instance_find(follow, 0).y + 32.0)) > 6.0:
			move_towards_point(GM.instance_find(follow, 0).x, (GM.instance_find(follow, 0).y + 32.0), 6.0)
			if camlock == 1.0 and y == ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0):
				y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) - 16.0)
		else:
			fallow_mario = 0.0
			speed = 0.0


# from objects/obj_levelmanager/Other_18.gml
func _user_8() -> void:
	var obj  # 局部变量提升（GML 的 var 是函数作用域）
	if y < ((Scr.__view_get(self, 3, 0.0) / 2.0) - 1.0):
		y = (Scr.__view_get(self, 3, 0.0) / 2.0)
		if vspeed < 0.0:
			vspeed = 0.0
	elif y > ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) + 1.0) and alarm[11] != -1.0:
		y = (GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0))
		if vspeed > 0.0:
			vspeed = 0.0
	elif y > ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) + 9.0):
		y = ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) + 8.0)
		if vspeed > 0.0:
			vspeed = 0.0
	match real_time:
		1.0:
			if real_time_ready == 1.0:
				vspeed = 0.0
				y = (GM.instance_find(follow, 0).y + 32.0)
			elif y > (GM.instance_find(follow, 0).y + 30.0):
				vspeed = GM.median(-4.0, (0.04 * ((GM.instance_find(follow, 0).y + 15.0) - y)), 4.0)
				if y < (GM.instance_find(follow, 0).y + 32.0):
					real_time_ready = 1.0
					vspeed = 0.0
			elif y < (GM.instance_find(follow, 0).y + 32.0):
				vspeed = GM.median(4.0, (0.04 * ((GM.instance_find(follow, 0).y + 15.0) - y)), -4.0)
				if y > (GM.instance_find(follow, 0).y + 30.0):
					real_time_ready = 1.0
					vspeed = 0.0
		2.0:
			if real_time_ready == 1.0:
				vspeed = 0.0
				y = (GM.instance_find(follow, 0).y - 8.0)
			elif y >= (GM.instance_find(follow, 0).y - 8.0):
				real_time_ready = 1.0
				vspeed = 0.0
				y = (GM.instance_find(follow, 0).y - 8.0)
			elif y < (GM.instance_find(follow, 0).y - 5.0):
				vspeed = GM.median(4.0, (0.5 * ((GM.instance_find(follow, 0).y + 16.0) - y)), -4.0)
				if y > (GM.instance_find(follow, 0).y - 8.0):
					real_time_ready = 1.0
					vspeed = 0.0
					y = (GM.instance_find(follow, 0).y - 8.0)
		3.0:
			vspeed = 0.0
			y = (GM.instance_find(follow, 0).y + 32.0)
		4.0:
			vspeed = GM.median(-2.0, (0.02 * ((GM.instance_find(follow, 0).y + 15.0) - y)), 2.0)
		5.0:
			vspeed = 0.0
			y = (GM.instance_find(follow, 0).y - 8.0)
		_:
			if (GM.instance_find(follow, 0).y + 32.0) < ((Scr.__view_get(self, 1, 0.0) + (Scr.__view_get(self, 3, 0.0) / 2.0)) - 12.0) and ((GM.variable_instance_exists(GM.instance_find(follow, 0), "state") and GM.instance_find(follow, 0).get("state") < 2.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "inclown") and GM.instance_find(follow, 0).get("inclown") == 2.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "camera_jump") and GM.instance_find(follow, 0).get("camera_jump") == 1.0)):
				if y > GM.instance_find(follow, 0).get("yview"):
					view_move = 1.0
				elif y < GM.instance_find(follow, 0).get("yview"):
					view_move = 2.0
			if GM.instance_exists(A.obj_player_goal_parent):
				obj = (GM.instance_find(follow, 0).y + 32.0)
			else:
				obj = GM.instance_find(follow, 0).get("yview")
			if vspeed < 0.0:
				if y < obj:
					vspeed = 0.0
					view_move = 0.0
			if view_move == 1.0:
				vspeed = GM.median(-4.0, (0.04 * ((obj - 1.0) - y)), 4.0)
			elif view_move == 2.0:
				if vspeed > 3.0:
					vspeed = 3.0
				else:
					vspeed += 0.05
	if (GM.variable_instance_exists(GM.instance_find(follow, 0), "state") and GM.instance_find(follow, 0).get("state") == 3.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "fly_cap") and GM.instance_find(follow, 0).get("fly_cap") > 0.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "modo_vuelo") and GM.instance_find(follow, 0).get("modo_vuelo") == 1.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "disablegrav") and GM.instance_find(follow, 0).get("disablegrav") > 0.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "isswim") and GM.instance_find(follow, 0).get("isswim") == 1.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "helice_fly") and GM.instance_find(follow, 0).get("helice_fly") == 1.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "inclown") and GM.instance_find(follow, 0).get("inclown") == 1.0) or GM.instance_find(follow, 0).object_index == A.obj_doormario or G.powerup == -82.0:
		real_time = 1.0
		view_move = 0.0
	elif GM.instance_find(follow, 0).y >= ((Scr.__view_get(self, 1, 0.0) + (Scr.__view_get(self, 3, 0.0) / 2.0)) + 8.0) and GM.instance_find(follow, 0).y < ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) + 8.0) and GM.instance_find(follow, 0).vspeed > 0.0:
		real_time = 2.0
		view_move = 1.0
		for inst in GM.with_list(follow):
			inst.set("yview", (GM.instance_find(follow, 0).y + 32.0))
	elif GM.instance_find(follow, 0).object_index == A.obj_doormario_exit or GM.instance_find(follow, 0).object_index == A.obj_player_warp:
		real_time = 3.0
		view_move = 0.0
	elif ((GM.variable_instance_exists(GM.instance_find(follow, 0), "walljump_ex") and GM.instance_find(follow, 0).get("walljump_ex") == 1.0) or (GM.variable_instance_exists(GM.instance_find(follow, 0), "doublejump") and GM.instance_find(follow, 0).get("doublejump") != 0.0)) and GM.instance_find(follow, 0).y < (Scr.__view_get(self, 1, 0.0) + 48.0):
		real_time = 4.0
		view_move = 0.0
	elif GM.instance_find(follow, 0).y >= ((Scr.__view_get(self, 1, 0.0) + (Scr.__view_get(self, 3, 0.0) / 2.0)) + 9.0) and GM.instance_find(follow, 0).y < ((GM.room_height - (Scr.__view_get(self, 3, 0.0) / 2.0)) + 8.0) and GM.variable_instance_exists(GM.instance_find(follow, 0), "platform_m") and GM.instance_find(follow, 0).get("platform_m") == 1.0:
		real_time = 5.0
		view_move = 0.0
	else:
		real_time = 0.0
		real_time_ready = 0.0


# from objects/obj_levelmanager/Other_19.gml
func _user_9() -> void:
	s_pink_coins = Scr.scr_pink_coins(self)
	match G.apariencia:
		0.0:
			GM.draw_set_font(G.wdigits_SMB)
		1.0:
			GM.draw_set_font(G.wdigits_SMB3)
		2.0:
			GM.draw_set_font(G.wdigits)
		4.0:
			GM.draw_set_font(G.wdigits_SMB2)
	GM.draw_set_colour(GM.c_white)
	GM.draw_set_alpha(1.0)
	if G.dsm == 0.0:
		GM.draw_sprite_ext(A.spr_coinhud, G.apariencia, (GM.camera_get_view_x(GM.view_get_camera(0)) + 15.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 32.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.coins, 2.0)))
		if G.apariencia == 1.0:
			GM.draw_sprite(A.spr_pmeter, pmeter, (GM.camera_get_view_x(GM.view_get_camera(0)) + 15.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 26.0))
	else:
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 36.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.lives, 2.0)))
		GM.draw_sprite_ext(Scr.scr_cont_lives(self), G.liveleves, (GM.camera_get_view_x(GM.view_get_camera(0)) + 53.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 4.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
		GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 36.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 25.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.coins, 2.0)))
		if G.apariencia == 1.0:
			GM.draw_sprite(A.spr_pmeter, pmeter, (GM.camera_get_view_x(GM.view_get_camera(0)) + 15.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 40.0))
	if G.condiciones == 1.0 and editor == 0.0:
		if G.dsm == 0.0:
			GM.draw_sprite(A.spr_cond_hud, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 58.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 6.0))
		else:
			GM.draw_sprite(A.spr_cond_hud, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 108.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 6.0))
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 257.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, GM.score, 9.0)))
	GM.draw_sprite_ext(A.spr_timehud, G.apariencia, (GM.camera_get_view_x(GM.view_get_camera(0)) + 337.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_text((GM.camera_get_view_x(GM.view_get_camera(0)) + 346.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 11.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.timer, 3.0)))
	if G.pink_coins_total != 0.0 and pink_coins_draw == 1.0:
		GM.draw_sprite_ext(s_pink_coins, G.pink_coins, (GM.camera_get_view_x(GM.view_get_camera(0)) + 235.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 22.0), 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_set_alpha(1.0)


# from objects/obj_levelmanager/Other_20.gml
func _user_10() -> void:
	s_pink_coins = Scr.scr_pink_coins(self)
	GM.draw_set_font(G.wdigits_NSMBU)
	GM.draw_set_colour(GM.c_white)
	GM.draw_set_alpha(1.0)
	if G.dsm == 0.0:
		GM.draw_sprite_ext(A.spr_NSMBU_coinhud, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 13.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0), 0.5, 0.5, 0.0, GM.c_white, 1.0)
		GM.draw_text_transformed((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 12.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.coins, 2.0)), 0.5, 0.5, 0.0)
	else:
		GM.draw_text_transformed((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 9.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.lives, 2.0)), 0.5, 0.5, 0.0)
		GM.draw_sprite_ext(A.spr_NSMBU_cont_lives, G.liveleves, (GM.camera_get_view_x(GM.view_get_camera(0)) + 47.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 7.5), 0.5, 0.5, 0.0, GM.c_white, 1.0)
		GM.draw_sprite_ext(A.spr_NSMBU_coinhud, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) + 13.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 22.0), 0.5, 0.5, 0.0, GM.c_white, 1.0)
		GM.draw_text_transformed((GM.camera_get_view_x(GM.view_get_camera(0)) + 29.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 25.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.coins, 2.0)), 0.5, 0.5, 0.0)
	if G.condiciones == 1.0 and editor == 0.0:
		if G.dsm == 0.0:
			GM.draw_sprite(A.spr_cond_hud, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 58.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 6.0))
		else:
			GM.draw_sprite(A.spr_cond_hud, G.condiciones_count, (GM.camera_get_view_x(GM.view_get_camera(0)) + 108.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 6.0))
	GM.draw_set_font(G.wdigits_NSMBU_points)
	GM.draw_text_transformed((GM.camera_get_view_x(GM.view_get_camera(0)) + 266.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, GM.score, 9.0)), 0.5, 0.5, 0.0)
	GM.draw_set_font(G.wdigits_NSMBU)
	GM.draw_sprite_ext(A.spr_NSMBU_timehud, G.apariencia, (GM.camera_get_view_x(GM.view_get_camera(0)) + 338.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0), 0.5, 0.5, 0.0, GM.c_white, 1.0)
	GM.draw_text_transformed((GM.camera_get_view_x(GM.view_get_camera(0)) + 348.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 10.0), GM.string_hash_to_newline(Scr.string_add_zeros(self, G.timer, 3.0)), 0.5, 0.5, 0.0)
	if G.pink_coins_total != 0.0 and pink_coins_draw == 1.0:
		GM.draw_sprite_ext(s_pink_coins, G.pink_coins, (GM.camera_get_view_x(GM.view_get_camera(0)) + 240.0), (GM.camera_get_view_y(GM.view_get_camera(0)) + 24.0), 0.5, 0.5, 0.0, GM.c_white, 1.0)
	GM.draw_set_alpha(1.0)


# from objects/obj_levelmanager/Other_21.gml
func _user_11() -> void:
	if G.apariencia == 3.0 and G.bg_level == "ground" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_camera[0])))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.9) - spd)
		Scr.__background_set(self, Scr.e__BG.X, 2.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, lerpf(0.0, GM.camera_get_view_x(GM.view_camera[0]), 0.4))
	elif G.apariencia == 3.0 and G.modo_noche == 0.0 and editor == 0.0 and (G.bg_level == "sky"):
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
	elif G.apariencia == 3.0 and G.modo_noche == 1.0 and editor == 0.0 and (G.bg_level == "airship"):
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
	elif G.apariencia == 3.0 and G.modo_noche == 0.0 and (G.bg_level == "forest"):
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.modo_noche == 0.0 and (editor == 1.0 and (G.bg_level == "sky")):
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.modo_noche == 1.0 and (editor == 1.0 and (G.bg_level == "airship")):
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.bg_level == "snow":
		if G.modo_noche == 0.0:
			if editor == 0.0:
				spd += 0.1
			else:
				spd = 0.0
			Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
			Scr.__background_set(self, Scr.e__BG.X, 1.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8) - spd))
			Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
			Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
			Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
			Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
		else:
			Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
			Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
			Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
			Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
			Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.3))
	elif G.apariencia == 3.0 and G.bg_level == "desert" and G.modo_noche == 0.0:
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 1.0))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
	elif G.apariencia == 3.0 and G.bg_level == "beach" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 1.0))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9) - spd))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8) - (spd * 2.0)))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7) - (spd * 3.0)))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
	elif G.apariencia == 3.0 and G.bg_level == "sky" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 1.0))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.bg_level == "airship" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6) - spd))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5) - (spd * 2.0)))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.bg_level == "airship" and G.modo_noche == 1.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 1.0))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.bg_level == "mountain" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7 - spd)))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
	elif G.apariencia == 3.0 and G.bg_level == "mountain" and G.modo_noche == 1.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9)))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 4.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 5.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 7.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))
	elif G.apariencia == 3.0 and G.bg_level == "fall" and G.modo_noche == 0.0:
		if editor == 0.0:
			spd += 0.1
		else:
			spd = 0.0
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0))))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, ((GM.camera_get_view_x(GM.view_get_camera(0)) * 0.9) - spd))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 3.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
	elif G.apariencia == 3.0 and G.bg_level != "sky" and G.bg_level != "airship" and G.bg_level != "mountain" and G.bg_level != "fall" and G.bg_level != "ground" and G.bg_level != "snow" and G.bg_level != "desert" and G.bg_level != "beach":
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.8))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.7))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
	elif G.apariencia == 2.0 and G.bg_level != "sky" and G.bg_level != "airship":
		Scr.__background_set(self, Scr.e__BG.X, 0.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.6))
		Scr.__background_set(self, Scr.e__BG.X, 1.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.5))
		Scr.__background_set(self, Scr.e__BG.X, 2.0, (GM.camera_get_view_x(GM.view_get_camera(0)) * 0.4))


# from objects/obj_levelmanager/Draw_0.gml
func _gm_draw() -> void:
	if editor == 0.0:
		if G.apariencia == 3.0:
			_user_10()
		else:
			_user_9()


# from objects/obj_levelmanager/KeyPress_13.gml
func _keypress_13() -> void:
	if canpause == 1.0 and (not GM.instance_exists(A.obj_player_goal_parent)):
		if GM.room != A.rm_editor and GM.room != A.rm_title:
			if G.dsm == 1.0:
				if not GM.instance_exists(A.obj_deadmario):
					GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 239.0), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_menu_pausa)
			elif G.dsm == 0.0:
				GM.instance_create((GM.camera_get_view_x(GM.view_get_camera(0)) + 239.0), GM.camera_get_view_y(GM.view_get_camera(0)), A.obj_menu_pausa)
			if GM.instance_find(A.obj_persistent, 0).get("modo_android") == 1.0 and G.controles_tactiles == 1.0:
				var _o6: GMObject = GM.other  # with 块体里调用了 event_user（§3.3 第 17 条）
				GM.other = self
				for inst in GM.with_list(A.obj_persistent):
					inst.event_user(4)
					inst.event_user(5)

				GM.other = _o6