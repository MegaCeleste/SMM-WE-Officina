# from scripts/scr_sprite_get_constant/scr_sprite_get_constant.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_sprite_get_constant/scr_sprite_get_constant.gml
static func scr_sprite_get_constant(me: GMObject, argument0 = null) -> Variant:
	if G.apariencia == 0.0:
		match argument0:
			A.spr_SMB_mushroom:
				return 1
			A.spr_SMB2_mushroom:
				return -80
			A.spr_SMB_fireflower:
				return 2
			A.spr_SMB_superflower:
				return -50
			A.spr_SMB_megamushroom:
				return -77
			A.spr_SMB_hen_mushroom:
				return -78
			A.spr_SMB_link:
				return -85
			A.spr_SMB3_hammersuit:
				return -78
			A.spr_NSMBU_superacorn:
				return -78
			A.spr_pballon:
				return -78
			A.spr_SMB_koopa:
				return -31
			A.spr_SMB_koopa_b:
				return -90
			A.spr_SMB_koopa_red_b:
				return -91
			A.spr_SMB_shell_drybones:
				return -81
			A.spr_SMB_1up:
				return -18
			A.spr_rotten_b:
				return -18
			A.spr_SMB_star:
				return -21
			A.spr_SMB_coin:
				return -1
			A.spr_SMB_key:
				return -22
			A.spr_SMB_pink_coin:
				return -76
			A.spr_SMB_spring:
				return -23
			A.spr_SMB_pswitch:
				return -25
			A.spr_SMB_vine_green:
				return -28
			A.spr_SMB_koopa_red:
				return -32
			A.spr_SMB_spiny:
				return -33
			A.spr_SMB_buzzybeetle:
				return -34
			A.spr_SMB_buzzybeetle_night:
				return -34
			A.spr_SMB_cheepcheep:
				return -54
			A.spr_SMB_cheepcheep2:
				return -79
			A.spr_SMB_goomba:
				return -55
			A.spr_SMB_goomba2:
				return -56
			A.spr_SMB_bobomb:
				return -57
			A.spr_SMB_bobomb_night:
				return -57
			A.spr_SMB_bobomb_ready:
				return -58
			A.spr_SMB_hammerbro:
				return -59
			A.spr_SMB_boo:
				return -60
			A.spr_SMB_muncher:
				return -61
			A.spr_SMB_muncher_night:
				return -61
			A.spr_SMB_montymole:
				return -62
			A.spr_SMB_pplant:
				return -63
			A.spr_SMB_drybones:
				return -64
			A.spr_SMB_pow:
				return -65
			A.spr_SMB_spring_land:
				return -66
			A.spr_SMB_clown:
				return -67
			A.spr_SMB_clown_fire:
				return -68
			A.spr_SMB_shell_empty:
				return -69
			A.spr_SMB_shell_empty_night:
				return -69
			A.spr_SMB_shell_empty_spiny:
				return -70
			A.spr_SMB_podoboo:
				return -73
			A.spr_SMB_sledgebro:
				return -72
			A.spr_SMB_pplant_fire_down:
				return -71
			A.spr_SMB_goomba_shoe:
				return -74
			A.spr_SMB_goomba_shoe_red:
				return -75
			A.spr_SMB_waddlewing:
				return -106
			_:
				return -1
	elif G.apariencia == 1.0:
		match argument0:
			A.spr_SMB3_mushroom:
				return 1
			A.spr_SMB3_fireflower:
				return 2
			A.spr_SMB2_mushroom:
				return 1
			A.spr_cap_res:
				return 3
			A.spr_pballon:
				return -29
			A.spr_NSMBU_superacorn:
				return -29
			A.spr_leaf:
				return -39
			A.spr_SMB_megamushroom_res:
				return -39
			A.spr_SMB_hen_mushroom:
				return 1
			A.spr_frogsuit:
				return -29
			A.spr_SMB3_hammersuit:
				return -46
			A.spr_SMB3_koopa:
				return -31
			A.spr_SMB3_koopa_b:
				return -90
			A.spr_SMB3_koopa_red_b:
				return -91
			A.spr_SMB3_shell_drybones:
				return -81
			A.spr_SMB3_1up:
				return -18
			A.spr_rotten_b:
				return -18
			A.spr_SMB3_star:
				return -21
			A.spr_SMB3_coin:
				return -1
			A.spr_SMB3_key:
				return -22
			A.spr_SMB3_pink_coin:
				return -76
			A.spr_SMB3_spring:
				return -23
			A.spr_SMB3_pswitch:
				return -25
			A.spr_SMB3_vine_green:
				return -28
			A.spr_SMB3_koopa_red:
				return -32
			A.spr_SMB3_spiny:
				return -33
			A.spr_SMB3_buzzybeetle:
				return -34
			A.spr_SMB3_buzzybeetle_night:
				return -34
			A.spr_SMB3_cheepcheep:
				return -54
			A.spr_SMB3_cheepcheep2:
				return -79
			A.spr_SMB3_goomba:
				return -55
			A.spr_SMB3_goomba2:
				return -56
			A.spr_SMB3_bobomb:
				return -57
			A.spr_SMB3_bobomb_night:
				return -57
			A.spr_SMB3_bobomb_ready:
				return -58
			A.spr_SMB3_hammerbro:
				return -59
			A.spr_SMB3_boo:
				return -60
			A.spr_SMB3_muncher:
				return -61
			A.spr_SMB3_muncher_night:
				return -61
			A.spr_SMB3_montymole:
				return -62
			A.spr_SMB3_pplant:
				return -63
			A.spr_SMB3_drybones:
				return -64
			A.spr_SMB3_pow:
				return -65
			A.spr_SMB3_spring_land:
				return -66
			A.spr_SMB3_clown:
				return -67
			A.spr_SMB3_clown_fire:
				return -68
			A.spr_SMB3_shell_empty:
				return -69
			A.spr_SMB3_shell_empty_night:
				return -69
			A.spr_SMB3_shell_spiny_empty:
				return -70
			A.spr_SMB3_podoboo:
				return -73
			A.spr_SMB3_sledgebro:
				return -72
			A.spr_SMB3_pplant_fire_down:
				return -71
			A.spr_SMB3_goomba_shoe:
				return -74
			A.spr_SMB3_goomba_shoe_red:
				return -75
			A.spr_SMB3_waddlewing:
				return -106
			_:
				return -1
	elif G.apariencia == 2.0:
		match argument0:
			A.spr_mushroom:
				return 1
			A.spr_fireflower:
				return 2
			A.spr_SMB2_mushroom:
				return 1
			A.spr_cap:
				return 3
			A.spr_pballon:
				return -82
			A.spr_NSMBU_superacorn:
				return -82
			A.spr_SMB3_hammersuit:
				return -82
			A.spr_leaf:
				return 3
			A.spr_SMB_megamushroom_res:
				return 3
			A.spr_SMB_hen_mushroom:
				return 1
			A.spr_koopa:
				return -31
			A.spr_koopa_b:
				return -90
			A.spr_koopa_red_b:
				return -91
			A.spr_shell_drybones:
				return -81
			A.spr_1up:
				return -18
			A.spr_rotten_b:
				return -18
			A.spr_star:
				return -21
			A.spr_coin:
				return -1
			A.spr_key:
				return -22
			A.spr_pink_coin:
				return -76
			A.spr_spring:
				return -23
			A.spr_pswitch:
				return -25
			A.spr_vine_green:
				return -28
			A.spr_koopa_red:
				return -32
			A.spr_spiny:
				return -33
			A.spr_buzzybeetle:
				return -34
			A.spr_cheepcheep:
				return -54
			A.spr_cheepcheep2:
				return -79
			A.spr_galoomba:
				return -55
			A.spr_galoomba2:
				return -56
			A.spr_bobomb:
				return -57
			A.spr_bobomb_ready:
				return -58
			A.spr_hammerbro:
				return -59
			A.spr_boo:
				return -60
			A.spr_muncher:
				return -61
			A.spr_montymole:
				return -62
			A.spr_jumppiranha:
				return -63
			A.spr_drybones:
				return -64
			A.spr_block_pow:
				return -65
			A.spr_spring_land:
				return -66
			A.spr_clown:
				return -67
			A.spr_clown_fire:
				return -68
			A.spr_shell_buzzy_empty:
				return -69
			A.spr_shell_spiny_empty:
				return -70
			A.spr_podoboo:
				return -73
			A.spr_sledgebro:
				return -72
			A.spr_pplant_fire_down:
				return -71
			A.spr_egg:
				return -74
			A.spr_egg_red:
				return -75
			A.spr_waddlewing:
				return -106
			_:
				return -1
	elif G.apariencia == 3.0:
		match argument0:
			A.spr_NSMBU_mushroom:
				return 1
			A.spr_NSMBU_fireflower:
				return 2
			A.spr_SMB2_mushroom:
				return 1
			A.spr_cap:
				return -30
			A.spr_SMB3_hammersuit:
				return -38
			A.spr_pballon:
				return -43
			A.spr_leaf:
				return -30
			A.spr_NSMBU_champicoptero:
				return -30
			A.spr_NSMBU_penguin:
				return -38
			A.spr_NSMBU_superacorn:
				return -43
			A.spr_SMB_megamushroom_res:
				return -30
			A.spr_SMB_hen_mushroom:
				return 1
			A.spr_NSMBU_koopa:
				return -31
			A.spr_NSMBU_koopa_b:
				return -90
			A.spr_NSMBU_koopa_red_b:
				return -91
			A.spr_NSMBU_shell_drybones:
				return -81
			A.spr_NSMBU_1up:
				return -18
			A.spr_rotten_b:
				return -18
			A.spr_NSMBU_star:
				return -21
			A.spr_NSMBU_coin:
				return -1
			A.spr_key:
				return -22
			A.spr_pink_coin:
				return -76
			A.spr_NSMBU_spring:
				return -23
			A.spr_NSMBU_pswitch:
				return -25
			A.spr_NSMBU_vine_green:
				return -28
			A.spr_koopa_red:
				return -32
			A.spr_NSMBU_spiny:
				return -33
			A.spr_NSMBU_buzzybeetle:
				return -34
			A.spr_NSMBU_cheepcheep:
				return -54
			A.spr_NSMBU_cheepcheep2:
				return -79
			A.spr_NSMBU_goomba:
				return -55
			A.spr_galoomba2:
				return -56
			A.spr_NSMBU_bobomb:
				return -57
			A.spr_bobomb_ready:
				return -58
			A.spr_hammerbro:
				return -59
			A.spr_NSMBU_boo_overworld:
				return -60
			A.spr_NSMBU_muncher:
				return -61
			A.spr_NSMBU_montymole:
				return -62
			A.spr_NSMBU_pplant:
				return -63
			A.spr_drybones:
				return -64
			A.spr_NSMBU_pow:
				return -65
			A.spr_spring_land:
				return -66
			A.spr_NSMBU_clown:
				return -67
			A.spr_NSMBU_clown_fire:
				return -68
			A.spr_shell_buzzy_empty:
				return -69
			A.spr_shell_spiny_empty:
				return -70
			A.spr_NSMBU_podoboo:
				return -73
			A.spr_sledgebro:
				return -72
			A.spr_pplant_fire_down:
				return -71
			A.spr_NSMBU_egg:
				return -74
			A.spr_egg_red:
				return -75
			A.spr_NSMBU_waddlewing:
				return -106
			_:
				return -1
	elif G.apariencia == 4.0:
		match argument0:
			A.spr_SMB2_mushroom:
				return 1
			A.spr_SMB_fireflower:
				return 2
			A.spr_SMB_mushroom:
				return -80
			A.spr_SMB_superflower:
				return -50
			A.spr_SMB_megamushroom:
				return -77
			A.spr_SMB_hen_mushroom:
				return -78
			A.spr_SMB_link:
				return -85
			A.spr_SMB3_hammersuit:
				return -78
			A.spr_NSMBU_superacorn:
				return -78
			A.spr_pballon:
				return -78
			A.spr_SMB_koopa:
				return -31
			A.spr_SMB_shell_drybones:
				return -81
			A.spr_SMB_1up:
				return -18
			A.spr_rotten_b:
				return -18
			A.spr_SMB_star:
				return -21
			A.spr_SMB_coin:
				return -1
			A.spr_SMB_key:
				return -22
			A.spr_SMB_pink_coin:
				return -76
			A.spr_SMB_spring:
				return -23
			A.spr_SMB_pswitch:
				return -25
			A.spr_SMB_vine_green:
				return -28
			A.spr_SMB_koopa_red:
				return -32
			A.spr_SMB_spiny:
				return -33
			A.spr_SMB_buzzybeetle:
				return -34
			A.spr_SMB_buzzybeetle_night:
				return -34
			A.spr_SMB_cheepcheep:
				return -54
			A.spr_SMB_cheepcheep2:
				return -79
			A.spr_SMB_goomba:
				return -55
			A.spr_SMB_goomba2:
				return -56
			A.spr_SMB_bobomb:
				return -57
			A.spr_SMB_bobomb_night:
				return -57
			A.spr_SMB_bobomb_ready:
				return -58
			A.spr_SMB_hammerbro:
				return -59
			A.spr_SMB_boo:
				return -60
			A.spr_SMB_muncher:
				return -61
			A.spr_SMB_muncher_night:
				return -61
			A.spr_SMB_montymole:
				return -62
			A.spr_SMB_pplant:
				return -63
			A.spr_SMB_drybones:
				return -64
			A.spr_SMB_pow:
				return -65
			A.spr_SMB_spring_land:
				return -66
			A.spr_SMB_clown:
				return -67
			A.spr_SMB_clown_fire:
				return -68
			A.spr_SMB_shell_empty:
				return -69
			A.spr_SMB_shell_empty_night:
				return -69
			A.spr_SMB_shell_empty_spiny:
				return -70
			A.spr_SMB_podoboo:
				return -73
			A.spr_SMB_sledgebro:
				return -72
			A.spr_SMB_pplant_fire_down:
				return -71
			A.spr_SMB_goomba_shoe:
				return -74
			A.spr_SMB_goomba_shoe_red:
				return -75
			_:
				return -1
	return null  # GML 走到结尾返回 undefined
