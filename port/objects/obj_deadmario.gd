extends GMObject

var dead_lava: float = 0.0
var url: String = ""
var timeup: float = 0.0
var direct: float = 0.0
var anim_dead2: float = 0.0


# from objects/obj_deadmario/Create_0.gml
func _create() -> void:
	sprite_index = Scr.scr_mariodead(self)
	image_speed = 0.0
	dead_lava = 0.0
	if G.apariencia == 3.0:
		GM.audio_play_sound(Scr.scr_NSMBU_snd_dead(self, G.dead_type), 0.0, false)
	else:
		GM.audio_play_sound(Scr.scr_snd_dead(self), 1.0, false)
	G.dead_type = 0.0
	if G.powerup == -50.0:
		GM.audio_stop_sound(GM.instance_find(A.obj_levelmanager, 0).get("levelmusic"))
		for inst in GM.with_list(A.obj_levelmanager):
			inst.set("levelmusic", inst.get("levelmusic_temp"))
			inst.set("levelmusic_temp", 0.0)
	var _o1: GMObject = GM.other
	GM.other = self
	for inst in GM.with_list(A.obj_levelmanager):
		inst.event_user(3)
		inst.alarm[2] = 0.0
		inst.alarm[10] = 1.0
		inst.speed = 0.0
	GM.other = _o1
	GM.audio_stop_sound(Scr.scr_snd_starman(self))
	GM.audio_stop_sound(Scr.scr_music_link(self))
	GM.audio_stop_sound(A.snd_n64)
	GM.audio_stop_sound(Scr.scr_snd_skid(self))
	GM.audio_stop_sound(A.snd_pmeter)
	GM.audio_stop_sound(A.snd_NSMBU_vine_up)
	GM.audio_stop_sound(A.snd_clown_damage)
	GM.audio_stop_sound(A.snd_SMB3_clown_damage)
	GM.audio_stop_sound(A.snd_SMB3_clown_fire_charge)
	GM.audio_stop_sound(A.snd_clown_fire_charge)
	GM.audio_stop_sound(A.snd_NSMBU_clown_fly)
	GM.audio_stop_sound(A.snd_NSMBU_clown_charge_start)
	GM.audio_stop_sound(A.snd_NSMBU_clown_charge_end)
	if G.checkpointroom == -4.0 or GM.instance_find(A.obj_levelmanager, 0).get("pink_coins_draw") == 0.0:
		for inst in GM.with_list(A.obj_levelmanager):
			inst.set("pink_coins_draw", 1.0)
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
	if G.checkpointroom != -4.0 and GM.instance_exists(A.obj_checkpoint) and GM.instance_find(A.obj_levelmanager, 0).get("pink_coins_draw") == 1.0 and G.pink_coins != 0.0:
		for inst in GM.with_list(A.obj_checkpoint):
			G.pink_coins = inst.get("pink_coins")
	url = ""
	G.n64_music = 0.0
	G.boss_music = 0.0
	G.bowser_obj = 0.0
	G.bonus_music = 0.0
	G.bonus_obj = 0.0
	G.ef_repeat = 0.0
	timeup = 0.0
	direct = 1.0
	anim_dead2 = 0.0
	G.died = 1.0
	G.powerup = 0.0
	if G.apariencia == 3.0:
		image_speed = 1.0
		alarm[0] = 40.0
	else:
		image_speed = 0.0
		alarm[0] = 30.0


# from objects/obj_deadmario/Destroy_0.gml
func _destroy() -> void:
	G.dead_type = 0.0


# from objects/obj_deadmario/Step_0.gml
func _step() -> void:
	if anim_dead2 == 1.0:
		if image_index >= 23.5:
			image_speed = 0.0
			image_index = 23.0
		else:
			image_speed = 0.5
	if G.bg_level == "underwater" or (G.modo_noche == 1.0 and G.bg_level == "sky") or (G.modo_noche == 1.0 and G.bg_level == "airship") or (GM.instance_exists(A.obj_lava_water) and y > (GM.instance_find(A.obj_lava_water, 0).y + 16.0) and G.bg_level == "forest" and G.modo_noche == 0.0):
		if vspeed > 2.0:
			vspeed = 2.0
			gravity = 0.0
	elif vspeed > 4.0:
		vspeed = 4.0
		gravity = 0.0
	_user_0()


# from objects/obj_deadmario/Alarm_0.gml
func _alarm_0() -> void:
	if G.apariencia == 3.0:
		match sprite_index:
			A.spr_NSMBU_mario_small_dead1:
				sprite_index = A.spr_NSMBU_mario_small_dead2
			A.spr_NSMBU_mario_big_dead1:
				sprite_index = A.spr_NSMBU_mario_big_dead2
			A.spr_NSMBU_mario_fire_dead1:
				sprite_index = A.spr_NSMBU_mario_fire_dead2
			A.spr_NSMBU_mario_helice_dead1:
				sprite_index = A.spr_NSMBU_mario_helice_dead2
			A.spr_NSMBU_mario_arcon_dead1:
				sprite_index = A.spr_NSMBU_mario_arcon_dead2
			A.spr_NSMBU_mario_penguin_dead1:
				sprite_index = A.spr_NSMBU_mario_penguin_dead2
		image_index = 0.0
		image_speed = 0.5
		gravity = 0.15
		vspeed = -3.225
		anim_dead2 = 1.0
	else:
		image_speed = 0.15
		gravity = 0.2
		vspeed = -3.5
	if G.apariencia < 2.0:
		alarm[1] = 160.0
	else:
		alarm[1] = 120.0
	if G.nm_play != 0.0:
		GM.instance_create(x, y, A.obj_icon_dead)


# from objects/obj_deadmario/Alarm_1.gml
func _alarm_1() -> void:
	if GM.instance_exists(A.obj_editormanager):
		var _o1: GMObject = GM.other
		GM.other = self
		for inst in GM.with_list(A.obj_creator_jugar_editar):
			inst.event_user(2)
		GM.other = _o1
	else:
		if G.postnivel == 1.0:
			G.checkpoint = -4.0
			G.checkpointroom = -4.0
			G.checkpoint_x = 0.0
			G.checkpoint_y = 0.0
		if G.dsm == 1.0 and not GM.instance_exists(A.obj_button_superado):
			G.coins = 0.0
		Scr.scr_restart(self)


# from objects/obj_deadmario/Other_10.gml
func _user_0() -> void:
	if GM.instance_exists(A.obj_physicsparent):
		for inst in GM.with_list(A.obj_physicsparent):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_shell_held):
		inst.speed = 0.0
		inst.gravity = 0.0
		inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_piranhaplant):
		for _i in range(4):
			inst.alarm[_i] = -1.0
		inst.set("i", 4.0)  # GML for-loop variable i is an instance variable of the with target
		inst.vspeed = 0.0
	for inst in GM.with_list(A.obj_soplete_global):
		for _i in range(3):
			inst.alarm[_i] = -1.0
		inst.set("i", 3.0)  # GML for-loop variable i is an instance variable of the with target
		inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_soplete_invert_global):
		for _i in range(3):
			inst.alarm[_i] = -1.0
		inst.set("i", 3.0)  # GML for-loop variable i is an instance variable of the with target
		inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_enemy_dead):
		inst.speed = 0.0
		inst.gravity = 0.0
		inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_bowser_dead):
		inst.speed = 0.0
		inst.gravity = 0.0
		inst.image_speed = 0.0
	for inst in GM.with_list(A.obj_enemy_dead_castle):
		inst.speed = 0.0
		inst.gravity = 0.0
		inst.image_speed = 0.0
	if GM.instance_exists(A.obj_brohammer):
		for inst in GM.with_list(A.obj_brohammer):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
	if GM.instance_exists(A.obj_magic):
		for inst in GM.with_list(A.obj_magic):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_powerupparent):
		for inst in GM.with_list(A.obj_powerupparent):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_solidtop):
		for inst in GM.with_list(A.obj_solidtop):
			inst.speed = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_plataforma):
		for inst in GM.with_list(A.obj_plataforma):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_plataforma_blue):
		for inst in GM.with_list(A.obj_plataforma_blue):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
	if GM.instance_exists(A.obj_lava_lift):
		for inst in GM.with_list(A.obj_lava_lift):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
	if GM.instance_exists(A.obj_holdparent):
		for inst in GM.with_list(A.obj_holdparent):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_spike):
		for inst in GM.with_list(A.obj_spike):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_spike_ball):
		for inst in GM.with_list(A.obj_spike_ball):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.set("ready_v", 2.0)
	if GM.instance_exists(A.obj_key_appear):
		for inst in GM.with_list(A.obj_key_appear):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_magikoopa):
		for inst in GM.with_list(A.obj_magikoopa):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_boomboom):
		for inst in GM.with_list(A.obj_boomboom):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_icecoin):
		for inst in GM.with_list(A.obj_icecoin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
	if GM.instance_exists(A.obj_pink_coin):
		for inst in GM.with_list(A.obj_pink_coin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_key):
		for inst in GM.with_list(A.obj_key):
			inst.speed = 0.0
			inst.image_index = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_egg):
		for inst in GM.with_list(A.obj_egg):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[2] = -1.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_cheepcheep):
		for inst in GM.with_list(A.obj_cheepcheep):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_cheepcheep2):
		# ORIG-BUG: checks obj_cheepcheep2 but affects obj_cheepcheep
		for inst in GM.with_list(A.obj_cheepcheep):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.gravity = 0.0
			inst.image_index = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_chain_chomp_free):
		for inst in GM.with_list(A.obj_chain_chomp_free):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.set("fallow_chomp", 0.0)
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_1up):
		for inst in GM.with_list(A.obj_1up):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_torbellino):
		for inst in GM.with_list(A.obj_torbellino):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_bullebill_base):
		for inst in GM.with_list(A.obj_bullebill_base):
			inst.image_speed = 0.0
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_galoomba):
		for inst in GM.with_list(A.obj_galoomba):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_plant_fire):
		for inst in GM.with_list(A.obj_plant_fire):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[2] = -1.0
	if GM.instance_exists(A.obj_jumppiranha):
		for inst in GM.with_list(A.obj_jumppiranha):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_hammerbro):
		for inst in GM.with_list(A.obj_hammerbro):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_firebro):
		for inst in GM.with_list(A.obj_firebro):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[2] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_sledgebro):
		for inst in GM.with_list(A.obj_sledgebro):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[1] = -1.0
			inst.alarm[3] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_bobomb_ready):
		for inst in GM.with_list(A.obj_bobomb_ready):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[1] = -1.0
	if GM.instance_exists(A.obj_banzaibill):
		for inst in GM.with_list(A.obj_banzaibill):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[10] = -1.0
	if GM.instance_exists(A.obj_smoke):
		for inst in GM.with_list(A.obj_smoke):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_rotten_signal):
		for inst in GM.with_list(A.obj_rotten_signal):
			inst.vspeed = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_blockparent):
		for inst in GM.with_list(A.obj_blockparent):
			inst.image_speed = 0.0
			inst.speed = 0.0
	if GM.instance_exists(A.obj_cap):
		for inst in GM.with_list(A.obj_cap):
			inst.speed = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_coin):
		for inst in GM.with_list(A.obj_coin):
			inst.image_speed = 0.0
			inst.image_index = 0.0
			inst.speed = 0.0
	if GM.instance_exists(A.obj_coin10):
		for inst in GM.with_list(A.obj_coin10):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_drybones):
		for inst in GM.with_list(A.obj_drybones):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_clown):
		for inst in GM.with_list(A.obj_clown):
			inst.image_speed = 0.0
			inst.alarm[0] = -1.0
			inst.alarm[4] = -1.0
	if GM.instance_exists(A.obj_bumper):
		for inst in GM.with_list(A.obj_bumper):
			inst.alarm[0] = -1.0
	if GM.instance_exists(A.obj_checkpoint):
		for inst in GM.with_list(A.obj_checkpoint):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_pinchos):
		for inst in GM.with_list(A.obj_pinchos):
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_cinta):
		for inst in GM.with_list(A.obj_cinta):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_meteorites):
		for inst in GM.with_list(A.obj_meteorites):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0
	if GM.instance_exists(A.obj_meteorites_big):
		for inst in GM.with_list(A.obj_meteorites_big):
			inst.speed = 0.0
			inst.gravity = 0.0
			inst.alarm[0] = -1.0
			inst.image_speed = 0.0


# from objects/obj_deadmario/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_sprite(sprite_index, image_index, GM.gm_round(x), y)
