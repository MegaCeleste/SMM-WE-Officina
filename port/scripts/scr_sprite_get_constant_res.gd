# from scripts/scr_sprite_get_constant_res/scr_sprite_get_constant_res.gml
# 第 3 批移植，已核对。match 的 subject 用 int() 包起来（case 都是 sprite 编号，int）。
extends RefCounted


# from scripts/scr_sprite_get_constant_res/scr_sprite_get_constant_res.gml
static func scr_sprite_get_constant_res(me: GMObject, argument0 = null) -> Variant:
	# gml_Script_scr_sprite_get_constant_res
	if G.apariencia == 0.0:
		match int(argument0):
			A.spr_SMB_mushroom:
				return 1.0
			A.spr_SMB_fireflower_res:
				return 2.0
			A.spr_SMB_superflower_res:
				return -50.0
			A.spr_SMB_megamushroom_res:
				return -77.0
			A.spr_SMB_link_res:
				return -85.0
			A.spr_frogsuit:
				return -78.0
			A.spr_SMB_hen_mushroom:
				return -78.0
			A.spr_koopa_res:
				return -31.0
			A.spr_koopa_b_res:
				return -90.0
			A.spr_koopa_red_res:
				return -32.0
			A.spr_koopa_red_b_res:
				return -91.0
			A.spr_shell_drybones_res:
				return -81.0
			A.spr_SMB_1up:
				return -18.0
			A.spr_rotten_b:
				return -18.0
			A.spr_star_res:
				return -21.0
			A.spr_SMB_coin:
				return -1.0
			A.spr_SMB_key:
				return -22.0
			A.spr_SMB3_pink_coin:
				return -76.0
			A.spr_SMB_spring:
				return -23.0
			A.spr_SMB_pswitch:
				return -25.0
			A.spr_SMB_vine_green:
				return -28.0
			A.spr_spiny_res:
				return -33.0
			A.spr_spiny_wings_res:
				return -33.0
			A.spr_SMB_buzzybeetle_res:
				return -34.0
			A.spr_SMB_buzzybeetle_night_res:
				return -34.0
			A.spr_SMB_buzzy_wings_res:
				return -34.0
			A.spr_cheepcheep_res:
				return -54.0
			A.spr_cheepcheep2_res:
				return -79.0
			A.spr_goomba_res:
				return -55.0
			A.spr_goombrat_res:
				return -56.0
			A.spr_bobomb_res:
				return -57.0
			A.spr_bobomb_ready_res:
				return -58.0
			A.spr_hammerbro_res:
				return -59.0
			A.spr_SMB_boo_res:
				return -60.0
			A.spr_muncher_res:
				return -61.0
			A.spr_muncher_night_res:
				return -61.0
			A.spr_monty_res:
				return -62.0
			A.spr_pplant_res:
				return -63.0
			A.spr_drybones_res:
				return -64.0
			A.spr_SMB_pow:
				return -65.0
			A.spr_spring_land_res:
				return -66.0
			A.spr_SMB_clown:
				return -67.0
			A.spr_SMB_clown_fire:
				return -68.0
			A.spr_shell_empty_res:
				return -69.0
			A.spr_spiny_shell_res:
				return -70.0
			A.spr_podoboo_res:
				return -73.0
			A.spr_SMB3_sledgebro:
				return -72.0
			A.spr_plant_fire_res:
				return -71.0
			A.spr_SMB_shoe_res:
				return -74.0
			A.spr_SMB_shoe_red_res:
				return -75.0
			A.spr_chainchomp_res:
				return -83.0
			A.spr_SMB_waddlewing:
				return -106.0
			_:
				return -1.0
	elif G.apariencia == 1.0:
		match int(argument0):
			A.spr_SMB3_mushroom:
				return 1.0
			A.spr_SMB3_fireflower_res:
				return 2.0
			A.spr_SMB_superflower_res:
				return 2.0
			A.spr_cap_res:
				return 3.0
			A.spr_SMB_megamushroom_res:
				return 3.0
			A.spr_frogsuit:
				return -29.0
			A.spr_SMB3_hammersuit_res:
				return -46.0
			A.spr_SMB_hen_mushroom:
				return 1.0
			A.spr_SMB3_leaf_res:
				return -39.0
			A.spr_koopa_res:
				return -31.0
			A.spr_koopa_b_res:
				return -90.0
			A.spr_koopa_red_res:
				return -32.0
			A.spr_koopa_red_b_res:
				return -91.0
			A.spr_shell_drybones_res:
				return -81.0
			A.spr_SMB3_1up:
				return -18.0
			A.spr_rotten_b:
				return -18.0
			A.spr_star_res:
				return -21.0
			A.spr_SMB3_coin:
				return -1.0
			A.spr_SMB3_key:
				return -22.0
			A.spr_SMB3_pink_coin:
				return -76.0
			A.spr_SMB3_spring:
				return -23.0
			A.spr_SMB3_pswitch:
				return -25.0
			A.spr_SMB3_vine_green:
				return -28.0
			A.spr_spiny_res:
				return -33.0
			A.spr_spiny_wings_res:
				return -33.0
			A.spr_SMB3_buzzybeetle_res:
				return -34.0
			A.spr_SMB3_buzzybeetle_night_res:
				return -34.0
			A.spr_SMB3_buzzy_wings_res:
				return -34.0
			A.spr_cheepcheep_res:
				return -54.0
			A.spr_cheepcheep2_res:
				return -79.0
			A.spr_goomba_res:
				return -55.0
			A.spr_goombrat_res:
				return -56.0
			A.spr_bobomb_res:
				return -57.0
			A.spr_bobomb_ready_res:
				return -58.0
			A.spr_hammerbro_res:
				return -59.0
			A.spr_SMB3_boo_res:
				return -60.0
			A.spr_muncher_res:
				return -61.0
			A.spr_muncher_night_res:
				return -61.0
			A.spr_monty_res:
				return -62.0
			A.spr_pplant_res:
				return -63.0
			A.spr_SMB3_drybones:
				return -64.0
			A.spr_SMB3_pow:
				return -65.0
			A.spr_spring_land_res:
				return -66.0
			A.spr_SMB3_clown:
				return -67.0
			A.spr_SMB3_clown_fire:
				return -68.0
			A.spr_shell_empty_res:
				return -69.0
			A.spr_spiny_shell_res:
				return -70.0
			A.spr_podoboo_res:
				return -73.0
			A.spr_SMB3_sledgebro:
				return -72.0
			A.spr_plant_fire_res:
				return -71.0
			A.spr_shoe_res:
				return -74.0
			A.spr_shoe_red_res:
				return -75.0
			A.spr_chainchomp_res:
				return -83.0
			A.spr_SMB3_waddlewing:
				return -106.0
			_:
				return -1.0
	elif G.apariencia == 2.0:
		match int(argument0):
			A.spr_mushroom:
				return 1.0
			A.spr_fireflower_res:
				return 2.0
			A.spr_SMB_superflower_res:
				return 2.0
			A.spr_cap_res:
				return 3.0
			A.spr_SMB_megamushroom_res:
				return 3.0
			A.spr_SMB_hen_mushroom:
				return 1.0
			A.spr_pballon_res:
				return -82.0
			A.spr_SMB3_leaf_res:
				return 3.0
			A.spr_koopa_res:
				return -31.0
			A.spr_koopa_b_res:
				return -90.0
			A.spr_koopa_red_res:
				return -32.0
			A.spr_koopa_red_b_res:
				return -91.0
			A.spr_shell_drybones_res:
				return -81.0
			A.spr_1up:
				return -18.0
			A.spr_rotten_b:
				return -18.0
			A.spr_star_res:
				return -21.0
			A.spr_coin:
				return -1.0
			A.spr_key:
				return -22.0
			A.spr_pink_coin:
				return -76.0
			A.spr_spring:
				return -23.0
			A.spr_pswitch:
				return -25.0
			A.spr_vine_green:
				return -28.0
			A.spr_spiny_res:
				return -33.0
			A.spr_spiny_wings_res:
				return -33.0
			A.spr_buzzybeetle_res:
				return -34.0
			A.spr_buzzy_wings_res:
				return -34.0
			A.spr_cheepcheep_res:
				return -54.0
			A.spr_cheepcheep2_res:
				return -79.0
			A.spr_goomba_res:
				return -55.0
			A.spr_goombrat_res:
				return -56.0
			A.spr_bobomb_res:
				return -57.0
			A.spr_bobomb_ready_res:
				return -58.0
			A.spr_hammerbro_res:
				return -59.0
			A.spr_boo_res:
				return -60.0
			A.spr_muncher_res:
				return -61.0
			A.spr_muncher_night_res:
				return -61.0
			A.spr_monty_res:
				return -62.0
			A.spr_pplant_res:
				return -63.0
			A.spr_drybones_res:
				return -64.0
			A.spr_block_pow:
				return -65.0
			A.spr_spring_land_res:
				return -66.0
			A.spr_clown:
				return -67.0
			A.spr_clown_fire:
				return -68.0
			A.spr_shell_empty_res:
				return -69.0
			A.spr_spiny_shell_res:
				return -70.0
			A.spr_podoboo_res:
				return -73.0
			A.spr_sledgebro:
				return -72.0
			A.spr_plant_fire_res:
				return -71.0
			A.spr_egg:
				return -74.0
			A.spr_egg_red:
				return -75.0
			A.spr_chainchomp_res:
				return -83.0
			A.spr_waddlewing:
				return -106.0
			_:
				return -1.0
	elif G.apariencia == 3.0:
		match int(argument0):
			A.spr_NSMBU_mushroom:
				return 1.0
			A.spr_NSMBU_fireflower_res:
				return 2.0
			A.spr_SMB_superflower_res:
				return 2.0
			A.spr_cap_res:
				return 3.0
			A.spr_NSMBU_penguin_suit_res:
				return -38.0
			A.spr_NSMBU_champicoptero_res:
				return -30.0
			A.spr_NSMBU_superacorn_res:
				return -43.0
			A.spr_SMB_megamushroom_res:
				return 3.0
			A.spr_SMB_hen_mushroom:
				return 1.0
			A.spr_SMB3_leaf_res:
				return 3.0
			A.spr_koopa_res:
				return -31.0
			A.spr_koopa_b_res:
				return -90.0
			A.spr_koopa_red_b_res:
				return -91.0
			A.spr_shell_drybones_res:
				return -81.0
			A.spr_koopa_red_res:
				return -32.0
			A.spr_NSMBU_1up:
				return -18.0
			A.spr_rotten_b:
				return -18.0
			A.spr_star_res:
				return -21.0
			A.spr_NSMBU_coin:
				return -1.0
			A.spr_NSMBU_key:
				return -22.0
			A.spr_pink_coin:
				return -76.0
			A.spr_NSMBU_spring:
				return -23.0
			A.spr_NSMBU_pswitch:
				return -25.0
			A.spr_NSMBU_vine_green:
				return -28.0
			A.spr_spiny_res:
				return -33.0
			A.spr_spiny_wings_res:
				return -33.0
			A.spr_NSMBU_buzzybeetle_res:
				return -34.0
			A.spr_cheepcheep_res:
				return -54.0
			A.spr_cheepcheep2_res:
				return -79.0
			A.spr_goomba_res:
				return -55.0
			A.spr_goombrat_res:
				return -56.0
			A.spr_bobomb_res:
				return -57.0
			A.spr_bobomb_ready_res:
				return -58.0
			A.spr_hammerbro_res:
				return -59.0
			A.spr_NSMBU_boo_overworld_res:
				return -60.0
			A.spr_NSMBU_boo_ghost_res:
				return -60.0
			A.spr_muncher_res:
				return -61.0
			A.spr_muncher_night_res:
				return -61.0
			A.spr_monty_res:
				return -62.0
			A.spr_pplant_res:
				return -63.0
			A.spr_drybones_res:
				return -64.0
			A.spr_NSMBU_pow:
				return -65.0
			A.spr_spring_land_res:
				return -66.0
			A.spr_NSMBU_clown:
				return -67.0
			A.spr_NSMBU_clown_fire:
				return -68.0
			A.spr_shell_empty_res:
				return -69.0
			A.spr_spiny_shell_res:
				return -70.0
			A.spr_podoboo_res:
				return -73.0
			A.spr_sledgebro_res:
				return -72.0
			A.spr_plant_fire_res:
				return -71.0
			A.spr_NSMBU_egg:
				return -74.0
			A.spr_NSMBU_egg_red:
				return -75.0
			A.spr_chainchomp_res:
				return -83.0
			A.spr_NSMBU_waddlewing_res:
				return -106.0
			_:
				return -1.0
	elif G.apariencia == 4.0:
		match int(argument0):
			A.spr_SMB_mushroom:
				return 1.0
			A.spr_SMB_fireflower_res:
				return 2.0
			A.spr_SMB_superflower_res:
				return -50.0
			A.spr_SMB_megamushroom_res:
				return -77.0
			A.spr_SMB_link_res:
				return -85.0
			A.spr_frogsuit:
				return -78.0
			A.spr_SMB_hen_mushroom:
				return -78.0
			A.spr_koopa_res:
				return -31.0
			A.spr_koopa_b_res:
				return -90.0
			A.spr_koopa_red_res:
				return -32.0
			A.spr_shell_drybones_res:
				return -81.0
			A.spr_SMB_1up:
				return -18.0
			A.spr_rotten_b:
				return -18.0
			A.spr_star_res:
				return -21.0
			A.spr_SMB_coin:
				return -1.0
			A.spr_SMB_key:
				return -22.0
			A.spr_SMB3_pink_coin:
				return -76.0
			A.spr_SMB_spring:
				return -23.0
			A.spr_SMB_pswitch:
				return -25.0
			A.spr_SMB_vine_green:
				return -28.0
			A.spr_spiny_res:
				return -33.0
			A.spr_spiny_wings_res:
				return -33.0
			A.spr_SMB_buzzybeetle_res:
				return -34.0
			A.spr_SMB_buzzybeetle_night_res:
				return -34.0
			A.spr_SMB_buzzy_wings_res:
				return -34.0
			A.spr_cheepcheep_res:
				return -54.0
			A.spr_cheepcheep2_res:
				return -79.0
			A.spr_goomba_res:
				return -55.0
			A.spr_goombrat_res:
				return -56.0
			A.spr_bobomb_res:
				return -57.0
			A.spr_bobomb_ready_res:
				return -58.0
			A.spr_hammerbro_res:
				return -59.0
			A.spr_SMB_boo_res:
				return -60.0
			A.spr_muncher_res:
				return -61.0
			A.spr_muncher_night_res:
				return -61.0
			A.spr_monty_res:
				return -62.0
			A.spr_pplant_res:
				return -63.0
			A.spr_drybones_res:
				return -64.0
			A.spr_SMB_pow:
				return -65.0
			A.spr_spring_land_res:
				return -66.0
			A.spr_SMB_clown:
				return -67.0
			A.spr_SMB_clown_fire:
				return -68.0
			A.spr_shell_empty_res:
				return -69.0
			A.spr_spiny_shell_res:
				return -70.0
			A.spr_podoboo_res:
				return -73.0
			A.spr_SMB3_sledgebro:
				return -72.0
			A.spr_plant_fire_res:
				return -71.0
			A.spr_SMB_shoe_res:
				return -74.0
			A.spr_SMB_shoe_red_res:
				return -75.0
			A.spr_chainchomp_res:
				return -83.0
			_:
				return -1.0
	return null
