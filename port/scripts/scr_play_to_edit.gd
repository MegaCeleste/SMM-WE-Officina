extends RefCounted


# from scripts/scr_play_to_edit/scr_play_to_edit.gml
static func scr_play_to_edit(me: GMObject):
	if GM.instance_exists(A.obj_flagpole):
		var _with_target2 = A.obj_flagpole
		var _other1: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target2):
			inst.instance_destroy()
		GM.other = _other1
	if GM.instance_exists(A.obj_SMB_castle):
		var _with_target4 = A.obj_SMB_castle
		var _other3: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target4):
			inst.instance_destroy()
		GM.other = _other3
	if GM.instance_exists(A.obj_goalcard):
		var _with_target6 = A.obj_goalcard
		var _other5: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target6):
			inst.instance_destroy()
		GM.other = _other5
	if GM.instance_exists(A.obj_goalgate):
		var _with_target8 = A.obj_goalgate
		var _other7: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target8):
			inst.instance_destroy()
		GM.other = _other7
	if GM.instance_exists(A.obj_axe_smw):
		var _with_target10 = A.obj_axe_smw
		var _other9: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target10):
			inst.instance_destroy()
		GM.other = _other9
	if GM.instance_exists(A.obj_crystalorb):
		var _with_target12 = A.obj_crystalorb
		var _other11: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target12):
			inst.instance_destroy()
		GM.other = _other11
	if GM.instance_exists(A.obj_hawmask):
		var _with_target14 = A.obj_hawmask
		var _other13: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target14):
			inst.instance_destroy()
		GM.other = _other13
	if GM.instance_exists(A.obj_block_rock):
		var _with_target16 = A.obj_block_rock
		var _other15: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target16):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_rock_res)
		GM.other = _other15
	if GM.instance_exists(A.obj_block_ice):
		var _with_target18 = A.obj_block_ice
		var _other17: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target18):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_ice_res)
		GM.other = _other17
	if GM.instance_exists(A.obj_pinchos):
		var _with_target20 = A.obj_pinchos
		var _other19: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target20):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_pinchos_res)
		GM.other = _other19
	if GM.instance_exists(A.obj_onoffblock):
		var _with_target22 = A.obj_onoffblock
		var _other21: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target22):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_onoffblock_res)
		GM.other = _other21
	if GM.instance_exists(A.obj_onoffplatform):
		var _with_target24 = A.obj_onoffplatform
		var _other23: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target24):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_onoffplatform_res)
		GM.other = _other23
	if GM.instance_exists(A.obj_onoffplatform_blue):
		var _with_target26 = A.obj_onoffplatform_blue
		var _other25: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target26):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_onoffplatform_blue_res)
		GM.other = _other25
	if GM.instance_exists(A.obj_coin):
		var _with_target28 = A.obj_coin
		var _other27: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target28):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_coin_res)
		GM.other = _other27
	if GM.instance_exists(A.obj_torbellino):
		var _with_target30 = A.obj_torbellino
		var _other29: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target30):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_torbellino_res)
		GM.other = _other29
	if GM.instance_exists(A.obj_meteorites):
		var _with_target32 = A.obj_meteorites
		var _other31: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target32):
			inst.instance_destroy()
		GM.other = _other31
	if GM.instance_exists(A.obj_meteorites_big):
		var _with_target34 = A.obj_meteorites_big
		var _other33: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target34):
			inst.instance_destroy()
		GM.other = _other33
	if GM.instance_exists(A.obj_meteorites_maker):
		var _with_target36 = A.obj_meteorites_maker
		var _other35: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target36):
			inst.instance_destroy()
		GM.other = _other35
	#
	# 	if instance_exists(obj_audio_control)
	# 	{
	# 		with (obj_audio_control)
	# 		{
	# 			instance_destroy()
	# 		}
	# 	}
	# 	/*
	if GM.instance_exists(A.obj_pswitch):
		var _with_target38 = A.obj_pswitch
		var _other37: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target38):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_pswitch_res)
		GM.other = _other37
	if GM.instance_exists(A.obj_block_pow_hold):
		var _with_target40 = A.obj_block_pow_hold
		var _other39: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target40):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_pow_res)
		GM.other = _other39
	if GM.instance_exists(A.obj_key):
		var _with_target42 = A.obj_key
		var _other41: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target42):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_key_res)
		GM.other = _other41
	if GM.instance_exists(A.obj_galoomba):
		var _with_target44 = A.obj_galoomba
		var _other43: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target44):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_goomba_res)
		GM.other = _other43
	if GM.instance_exists(A.obj_galoomba_b):
		var _with_target46 = A.obj_galoomba_b
		var _other45: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target46):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_goomba_b_res)
		GM.other = _other45
	if GM.instance_exists(A.obj_galoomba2_b):
		var _with_target48 = A.obj_galoomba2_b
		var _other47: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target48):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_goombrat_b_res)
		GM.other = _other47
	if GM.instance_exists(A.obj_galoomba2):
		var _with_target50 = A.obj_galoomba2
		var _other49: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target50):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_goombrat_res)
		GM.other = _other49
	if GM.instance_exists(A.obj_waddlewing):
		var _with_target52 = A.obj_waddlewing
		var _other51: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target52):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_waddlewing_res)
		GM.other = _other51
	if GM.instance_exists(A.obj_koopa):
		var _with_target54 = A.obj_koopa
		var _other53: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target54):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_koopa_res)
		GM.other = _other53
	if GM.instance_exists(A.obj_monty_chase):
		var _with_target56 = A.obj_monty_chase
		var _other55: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target56):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_monty_res)
		GM.other = _other55
	if GM.instance_exists(A.obj_buzzybeetle):
		var _with_target58 = A.obj_buzzybeetle
		var _other57: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target58):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_buzzybeetle_res)
		GM.other = _other57
	if GM.instance_exists(A.obj_chain_chomp_free):
		var _with_target60 = A.obj_chain_chomp_free
		var _other59: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target60):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_chomp_res)
		GM.other = _other59
	if GM.instance_exists(A.obj_jumppiranha):
		var _with_target62 = A.obj_jumppiranha
		var _other61: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target62):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_pplant_res)
		GM.other = _other61
	if GM.instance_exists(A.obj_big_pplant):
		var _with_target64 = A.obj_big_pplant
		var _other63: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target64):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_big_pplant_res)
		GM.other = _other63
	if GM.instance_exists(A.obj_big_pplant_b):
		var _with_target66 = A.obj_big_pplant_b
		var _other65: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target66):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_big_pplant_b_res)
		GM.other = _other65
	if GM.instance_exists(A.obj_plant_fire):
		var _with_target68 = A.obj_plant_fire
		var _other67: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target68):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_plant_fire_res)
		GM.other = _other67
	if GM.instance_exists(A.obj_spike):
		var _with_target70 = A.obj_spike
		var _other69: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target70):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_spike_res)
		GM.other = _other69
	if GM.instance_exists(A.obj_muncher):
		var _with_target72 = A.obj_muncher
		var _other71: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target72):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_muncher_res)
		GM.other = _other71
	if GM.instance_exists(A.obj_spiny):
		var _with_target74 = A.obj_spiny
		var _other73: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target74):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_spiny_res)
		GM.other = _other73
	if GM.instance_exists(A.obj_hammerbro):
		var _with_target76 = A.obj_hammerbro
		var _other75: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target76):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_hammerbro_res)
		GM.other = _other75
	if GM.instance_exists(A.obj_icebro):
		var _with_target78 = A.obj_icebro
		var _other77: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target78):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_icebro_res)
		GM.other = _other77
	if GM.instance_exists(A.obj_boomerangbro):
		var _with_target80 = A.obj_boomerangbro
		var _other79: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target80):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_boomerangbro_res)
		GM.other = _other79
	if GM.instance_exists(A.obj_firebro):
		var _with_target82 = A.obj_firebro
		var _other81: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target82):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_firebro_res)
		GM.other = _other81
	if GM.instance_exists(A.obj_thwomp):
		var _with_target84 = A.obj_thwomp
		var _other83: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target84):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_thwomp_res)
		GM.other = _other83
	if GM.instance_exists(A.obj_thwomp_b):
		var _with_target86 = A.obj_thwomp_b
		var _other85: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target86):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_thwomp_b_res)
		GM.other = _other85
	if GM.instance_exists(A.obj_podoboo):
		var _with_target88 = A.obj_podoboo
		var _other87: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target88):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_podoboo_res)
		GM.other = _other87
	if GM.instance_exists(A.obj_clown):
		var _with_target90 = A.obj_clown
		var _other89: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target90):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_clown_res)
		GM.other = _other89
	if GM.instance_exists(A.obj_rails_res):
		var _with_target92 = A.obj_rails
		var _other91: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target92):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_rails_res)
		GM.other = _other91
	if GM.instance_exists(A.obj_banzaibill):
		var _with_target94 = A.obj_banzaibill
		var _other93: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target94):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_billbanzai_res)
		GM.other = _other93
	if GM.instance_exists(A.obj_bobomb):
		var _with_target96 = A.obj_bobomb
		var _other95: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target96):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_bobomb_res)
		GM.other = _other95
	if GM.instance_exists(A.obj_boo):
		var _with_target98 = A.obj_boo
		var _other97: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target98):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_boo_res)
		GM.other = _other97
	if GM.instance_exists(A.obj_egg):
		var _with_target100 = A.obj_egg
		var _other99: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target100):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_egg_res)
		GM.other = _other99
	if GM.instance_exists(A.obj_egg_blue):
		var _with_target102 = A.obj_egg_blue
		var _other101: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target102):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_egg_res)
		GM.other = _other101
	if GM.instance_exists(A.obj_1up):
		var _with_target104 = A.obj_1up
		var _other103: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target104):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_1up_res)
		GM.other = _other103
	if GM.instance_exists(A.obj_mushroom):
		var _with_target106 = A.obj_mushroom
		var _other105: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target106):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_mushroom_res)
		GM.other = _other105
	if GM.instance_exists(A.obj_SMB2_mushroom):
		var _with_target108 = A.obj_SMB2_mushroom
		var _other107: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target108):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_SMB2_mushroom_res)
		GM.other = _other107
	if GM.instance_exists(A.obj_link):
		var _with_target110 = A.obj_link
		var _other109: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target110):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_link_res)
		GM.other = _other109
	if GM.instance_exists(A.obj_fireflower):
		var _with_target112 = A.obj_fireflower
		var _other111: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target112):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_fireflower_res)
		GM.other = _other111
	if GM.instance_exists(A.obj_superflower):
		var _with_target114 = A.obj_superflower
		var _other113: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target114):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_superflower_res)
		GM.other = _other113
	if GM.instance_exists(A.obj_cap):
		var _with_target116 = A.obj_cap
		var _other115: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target116):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_cap_res)
		GM.other = _other115
	if GM.instance_exists(A.obj_spring):
		var _with_target118 = A.obj_spring
		var _other117: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target118):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_spring_res)
		GM.other = _other117
	if GM.instance_exists(A.obj_nube):
		var _with_target120 = A.obj_nube
		var _other119: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target120):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_nube_res)
		GM.other = _other119
	if GM.instance_exists(A.obj_noteblock):
		var _with_target122 = A.obj_noteblock
		var _other121: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target122):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_noteblock_res)
		GM.other = _other121
	if GM.instance_exists(A.obj_block):
		var _with_target124 = A.obj_block
		var _other123: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target124):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_block_res)
			GM.instance_activate_object(A.obj_qblock_res)
		GM.other = _other123
	if GM.instance_exists(A.obj_flipblock):
		var _with_target126 = A.obj_flipblock
		var _other125: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target126):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_block_res)
		GM.other = _other125
	if GM.instance_exists(A.obj_block_multicoin):
		var _with_target128 = A.obj_block_multicoin
		var _other127: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target128):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_block_res)
			GM.instance_activate_object(A.obj_qblock_res)
		GM.other = _other127
	if GM.instance_exists(A.obj_grinder):
		var _with_target130 = A.obj_grinder
		var _other129: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target130):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_grinder_res)
		GM.other = _other129
	if GM.instance_exists(A.obj_bumper):
		var _with_target132 = A.obj_bumper
		var _other131: GMObject = GM.other
		GM.other = me
		for inst in GM.with_list(_with_target132):
			inst.instance_destroy()
			GM.instance_activate_object(A.obj_bumper_res)
		GM.other = _other131
	G.instance_deactivate = 1.0
