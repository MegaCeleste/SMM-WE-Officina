# from scripts/scr_sprite_make_object/scr_sprite_make_object.gml
# 第 6c 批移植，已核对。match 的 subject 用 int() 包起来（case 都是 sprite 编号，int）。
extends RefCounted


# from scripts/scr_sprite_make_object/scr_sprite_make_object.gml
static func scr_sprite_make_object(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	if G.apariencia == 0.0:
		match int(argument2):
			A.spr_SMB_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_SMB2_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_SMB2_mushroom)
			A.spr_SMB_fireflower:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			A.spr_SMB_megamushroom:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_superflower:
				return GM.instance_create(argument0, argument1, A.obj_superflower)
			A.spr_SMB_link:
				return GM.instance_create(argument0, argument1, A.obj_link)
			A.spr_SMB_hen_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			A.spr_NSMBU_superacorn:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			A.spr_leaf:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_shell_drybones:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			A.spr_cap:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_1up:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_rotten_b:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_SMB_star:
				return GM.instance_create(argument0, argument1, A.obj_star)
			A.spr_SMB_goomba_shoe:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			A.spr_SMB_goomba_shoe_red:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			A.spr_SMB_key:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			A.spr_SMB_pink_coin:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			A.spr_SMB_goomba:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			A.spr_SMB_goomba2:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			A.spr_SMB_koopa:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			A.spr_SMB_koopa_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_b)
			A.spr_SMB_koopa_red:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			A.spr_SMB_koopa_red_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red_b)
			A.spr_SMB_bobomb:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB_bobomb_night:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB_bobomb_ready:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			A.spr_SMB_buzzybeetle:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB_buzzybeetle_night:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			A.spr_SMB_hammerbro:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			A.spr_SMB_sledgebro:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			A.spr_SMB_pplant:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			A.spr_SMB_pplant_fire_down:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			A.spr_SMB_drybones:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			A.spr_SMB_podoboo:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			A.spr_SMB_cheepcheep:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			A.spr_SMB_cheepcheep2:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			A.spr_SMB_montymole:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			A.spr_SMB_muncher:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB_muncher_night:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB_boo:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			A.spr_SMB_pswitch:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			A.spr_SMB_pow:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			A.spr_SMB_spring:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			A.spr_SMB_spring_land:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			A.spr_SMB_clown:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			A.spr_SMB_clown_fire:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			A.spr_SMB_shell_empty:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB_shell_empty_night:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB_shell_empty_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
			A.spr_SMB_waddlewing:
				return GM.instance_create(argument0, argument1, A.obj_waddlewing)
	elif G.apariencia == 1.0:
		match int(argument2):
			A.spr_SMB3_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_SMB3_fireflower:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			A.spr_leaf:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_cap:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_NSMBU_superacorn:
				return GM.instance_create(argument0, argument1, A.obj_frogsuit)
			A.spr_SMB_megamushroom:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_SMB2_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_frogsuit:
				return GM.instance_create(argument0, argument1, A.obj_frogsuit)
			A.spr_SMB3_hammersuit:
				return GM.instance_create(argument0, argument1, A.obj_hammersuit)
			A.spr_SMB3_shell_drybones:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			A.spr_SMB3_1up:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_rotten_b:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_SMB3_star:
				return GM.instance_create(argument0, argument1, A.obj_star)
			A.spr_SMB3_goomba_shoe:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			A.spr_SMB3_goomba_shoe_red:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			A.spr_SMB3_key:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			A.spr_SMB3_pink_coin:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			A.spr_SMB3_goomba:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			A.spr_SMB3_goomba2:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			A.spr_SMB3_koopa:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			A.spr_SMB3_koopa_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_b)
			A.spr_SMB3_koopa_red:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			A.spr_SMB3_koopa_red_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red_b)
			A.spr_SMB3_bobomb:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB3_bobomb_night:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB3_bobomb_ready:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			A.spr_SMB3_buzzybeetle:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB3_buzzybeetle_night:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB3_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			A.spr_SMB3_hammerbro:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			A.spr_SMB3_sledgebro:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			A.spr_SMB3_pplant:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			A.spr_SMB3_pplant_fire_down:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			A.spr_SMB3_drybones:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			A.spr_SMB3_podoboo:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			A.spr_SMB3_cheepcheep:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			A.spr_SMB3_cheepcheep2:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			A.spr_SMB3_montymole:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			A.spr_SMB3_muncher:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB3_muncher_night:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB3_boo:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			A.spr_SMB3_pswitch:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			A.spr_SMB3_pow:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			A.spr_SMB3_spring:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			A.spr_SMB3_spring_land:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			A.spr_SMB3_clown:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			A.spr_SMB3_clown_fire:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			A.spr_SMB3_shell_empty:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB3_shell_empty_night:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB3_shell_spiny_empty:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
			A.spr_SMB3_waddlewing:
				return GM.instance_create(argument0, argument1, A.obj_waddlewing)
	elif G.apariencia == 2.0:
		match int(argument2):
			A.spr_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_fireflower:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			A.spr_leaf:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_cap:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_pballon:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			A.spr_NSMBU_superacorn:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			A.spr_SMB_megamushroom:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			A.spr_SMB2_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_shell_drybones:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			A.spr_1up:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_rotten_b:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_star:
				return GM.instance_create(argument0, argument1, A.obj_star)
			A.spr_egg:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			A.spr_egg_red:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			A.spr_key:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			A.spr_pink_coin:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			A.spr_galoomba:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			A.spr_galoomba2:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			A.spr_koopa:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			A.spr_koopa_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_b)
			A.spr_koopa_red:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			A.spr_koopa_red_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red_b)
			A.spr_bobomb:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_bobomb_ready:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			A.spr_buzzybeetle:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			A.spr_hammerbro:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			A.spr_sledgebro:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			A.spr_jumppiranha:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			A.spr_pplant_fire_down:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			A.spr_drybones:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			A.spr_podoboo:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			A.spr_cheepcheep:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			A.spr_cheepcheep2:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			A.spr_montymole:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			A.spr_muncher:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_boo:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			A.spr_pswitch:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			A.spr_block_pow:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			A.spr_spring:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			A.spr_spring_land:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			A.spr_clown:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			A.spr_clown_fire:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			A.spr_shell_buzzy_empty:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_shell_spiny_empty:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
			A.spr_waddlewing:
				return GM.instance_create(argument0, argument1, A.obj_waddlewing)
	elif G.apariencia == 3.0:
		match int(argument2):
			A.spr_NSMBU_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_NSMBU_fireflower:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			A.spr_leaf:
				return GM.instance_create(argument0, argument1, A.obj_propellershroom)
			A.spr_cap:
				return GM.instance_create(argument0, argument1, A.obj_propellershroom)
			A.spr_NSMBU_champicoptero:
				return GM.instance_create(argument0, argument1, A.obj_propellershroom)
			A.spr_SMB_megamushroom:
				return GM.instance_create(argument0, argument1, A.obj_propellershroom)
			A.spr_NSMBU_penguin:
				return GM.instance_create(argument0, argument1, A.obj_penguin_suit)
			A.spr_NSMBU_superacorn:
				return GM.instance_create(argument0, argument1, A.obj_superarcon)
			A.spr_SMB2_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_NSMBU_shell_drybones:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			A.spr_NSMBU_1up:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_rotten_b:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_NSMBU_star:
				return GM.instance_create(argument0, argument1, A.obj_star)
			A.spr_NSMBU_egg:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			A.spr_egg_red:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			A.spr_NSMBU_key:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			A.spr_NSMBU_pink_coin:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			A.spr_NSMBU_goomba:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			A.spr_NSMBU_goombrat:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			A.spr_NSMBU_koopa:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			A.spr_NSMBU_koopa_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_b)
			A.spr_NSMBU_koopa_red:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			A.spr_NSMBU_koopa_red_b:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red_b)
			A.spr_NSMBU_bobomb:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_NSMBU_bobomb_ready:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			A.spr_NSMBU_buzzybeetle:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_NSMBU_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			A.spr_NSMBU_hammerbro:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			A.spr_NSMBU_sledgebro:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			A.spr_NSMBU_pplant:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			A.spr_NSMBU_pplant_fire_down:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			A.spr_NSMBU_drybones:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			A.spr_NSMBU_podoboo:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			A.spr_NSMBU_cheepcheep:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			A.spr_NSMBU_cheepcheep2:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			A.spr_NSMBU_montymole:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			A.spr_NSMBU_muncher:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_NSMBU_boo_overworld:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			A.spr_NSMBU_pswitch:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			A.spr_NSMBU_pow:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			A.spr_NSMBU_spring:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			A.spr_NSMBU_spring_land:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			A.spr_NSMBU_clown:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			A.spr_NSMBU_clown_fire:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			A.spr_NSMBU_shell_buzzy_empty:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_NSMBU_shell_spiny_empty:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
			A.spr_NSMBU_waddlewing:
				return GM.instance_create(argument0, argument1, A.obj_waddlewing)
	elif G.apariencia == 4.0:
		match int(argument2):
			A.spr_SMB2_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_SMB_fireflower:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			A.spr_SMB_megamushroom:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_superflower:
				return GM.instance_create(argument0, argument1, A.obj_superflower)
			A.spr_SMB_link:
				return GM.instance_create(argument0, argument1, A.obj_link)
			A.spr_SMB_hen_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			A.spr_NSMBU_superacorn:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			A.spr_SMB_mushroom:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			A.spr_leaf:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_shell_drybones:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			A.spr_cap:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			A.spr_SMB_1up:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_rotten_b:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			A.spr_SMB_star:
				return GM.instance_create(argument0, argument1, A.obj_star)
			A.spr_SMB_goomba_shoe:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			A.spr_SMB_goomba_shoe_red:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			A.spr_SMB_key:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			A.spr_SMB_pink_coin:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			A.spr_SMB_goomba:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			A.spr_SMB_goomba2:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			A.spr_SMB_koopa:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			A.spr_SMB_koopa_red:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			A.spr_SMB_bobomb:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB_bobomb_night:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			A.spr_SMB_bobomb_ready:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			A.spr_SMB_buzzybeetle:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB_buzzybeetle_night:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			A.spr_SMB_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			A.spr_SMB_hammerbro:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			A.spr_SMB_sledgebro:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			A.spr_SMB_pplant:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			A.spr_SMB_pplant_fire_down:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			A.spr_SMB_drybones:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			A.spr_SMB_podoboo:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			A.spr_SMB_cheepcheep:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			A.spr_SMB_cheepcheep2:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			A.spr_SMB_montymole:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			A.spr_SMB_muncher:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB_muncher_night:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			A.spr_SMB_boo:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			A.spr_SMB_pswitch:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			A.spr_SMB_pow:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			A.spr_SMB_spring:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			A.spr_SMB_spring_land:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			A.spr_SMB_clown:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			A.spr_SMB_clown_fire:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			A.spr_SMB_shell_empty:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB_shell_empty_night:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			A.spr_SMB_shell_empty_spiny:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
	return null
