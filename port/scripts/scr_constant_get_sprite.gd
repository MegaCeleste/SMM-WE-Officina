# from scripts/scr_constant_get_sprite/scr_constant_get_sprite.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_constant_get_sprite/scr_constant_get_sprite.gml
static func scr_constant_get_sprite(me: GMObject, argument0 = null) -> Variant:
	if G.apariencia == 0.0:
		match int(argument0):
			1:
				return A.spr_SMB_mushroom
			2:
				return A.spr_SMB_fireflower
			-50:
				return A.spr_SMB_superflower
			-80:
				return A.spr_SMB2_mushroom
			-77:
				return A.spr_SMB_megamushroom
			-85:
				return A.spr_SMB_link
			-78:
				return A.spr_SMB_hen_mushroom
			-30:
				return A.spr_SMB_megamushroom
			-46:
				return A.spr_SMB_hen_mushroom
			-43:
				return A.spr_SMB_hen_mushroom
			3:
				return A.spr_SMB_megamushroom
			-82:
				return A.spr_SMB_hen_mushroom
			-39:
				return A.spr_SMB_megamushroom
			-29:
				return A.spr_SMB_hen_mushroom
			-38:
				return A.spr_SMB_hen_mushroom
			-81:
				return A.spr_SMB_shell_drybones
			-18:
				if G.bg_level == "ground" and G.modo_noche == 1.0:
					return A.spr_rotten_b
				else:
					return A.spr_SMB_1up
			-21:
				return A.spr_SMB_star
			-22:
				return A.spr_SMB_key
			-1:
				return A.spr_SMB_coin
			-76:
				return A.spr_SMB_pink_coin
			-23:
				return A.spr_SMB_spring
			-25:
				return A.spr_SMB_pswitch
			-28:
				return A.spr_SMB_beanstalk
			-31:
				return A.spr_SMB_koopa
			-90:
				return A.spr_SMB_koopa_b
			-32:
				return A.spr_SMB_koopa_red
			-91:
				return A.spr_SMB_koopa_red_b
			-33:
				return A.spr_SMB_spiny
			-34:
				return A.spr_SMB_buzzybeetle
			-54:
				return A.spr_SMB_cheepcheep
			-79:
				return A.spr_SMB_cheepcheep2
			-55:
				return A.spr_SMB_goomba
			-56:
				return A.spr_SMB_goomba2
			-57:
				return A.spr_SMB_bobomb
			-58:
				return A.spr_SMB_bobomb_ready
			-59:
				return A.spr_SMB_hammerbro
			-60:
				return A.spr_SMB_boo
			-61:
				return A.spr_SMB_muncher
			-62:
				return A.spr_SMB_montymole
			-63:
				return A.spr_SMB_pplant
			-64:
				return A.spr_SMB_drybones
			-65:
				return A.spr_SMB_pow
			-66:
				return A.spr_SMB_spring_land
			-67:
				return A.spr_SMB_clown
			-68:
				return A.spr_SMB_clown_fire
			-69:
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					return A.spr_SMB_shell_empty_night
				else:
					return A.spr_SMB_shell_empty
			-70:
				return A.spr_SMB_shell_empty_spiny
			-73:
				return A.spr_SMB_podoboo
			-72:
				return A.spr_SMB_sledgebro
			-71:
				return A.spr_SMB_pplant_fire_down
			-74:
				return A.spr_SMB_goomba_shoe
			-75:
				return A.spr_SMB_goomba_shoe_red
			-106:
				return A.spr_SMB_waddlewing
			_:
				return -1
	elif G.apariencia == 1.0:
		match int(argument0):
			1:
				return A.spr_SMB3_mushroom
			2:
				return A.spr_SMB3_fireflower
			-50:
				return A.spr_SMB3_fireflower
			3:
				return A.spr_cap
			-85:
				return A.spr_frogsuit
			-82:
				return A.spr_frogsuit
			-43:
				return A.spr_frogsuit
			-80:
				return A.spr_SMB3_mushroom
			-46:
				return A.spr_SMB3_hammersuit
			-30:
				return A.spr_leaf
			-38:
				return A.spr_SMB3_hammersuit
			-39:
				return A.spr_leaf
			-77:
				return A.spr_leaf
			-78:
				return A.spr_SMB3_mushroom
			-81:
				return A.spr_SMB3_shell_drybones
			-18:
				if G.bg_level == "ground" and G.modo_noche == 1.0:
					return A.spr_rotten_b
				else:
					return A.spr_SMB3_1up
			-29:
				return A.spr_frogsuit
			-21:
				return A.spr_SMB3_star
			-22:
				return A.spr_SMB3_key
			-1:
				return A.spr_SMB3_coin
			-76:
				return A.spr_SMB3_pink_coin
			-23:
				return A.spr_SMB3_spring
			-25:
				return A.spr_SMB3_pswitch
			-28:
				return A.spr_SMB3_beanstalk
			-31:
				return A.spr_SMB3_koopa
			-90:
				return A.spr_SMB3_koopa_b
			-32:
				return A.spr_SMB3_koopa_red
			-91:
				return A.spr_SMB3_koopa_red_b
			-33:
				return A.spr_SMB3_spiny
			-34:
				return A.spr_SMB3_buzzybeetle
			-54:
				return A.spr_SMB3_cheepcheep
			-79:
				return A.spr_SMB3_cheepcheep2
			-55:
				return A.spr_SMB3_goomba
			-56:
				return A.spr_SMB3_goomba2
			-57:
				return A.spr_SMB3_bobomb
			-58:
				return A.spr_SMB3_bobomb_ready
			-59:
				return A.spr_SMB3_hammerbro
			-60:
				return A.spr_SMB3_boo
			-61:
				return A.spr_SMB3_muncher
			-62:
				return A.spr_SMB3_montymole
			-63:
				return A.spr_SMB3_pplant
			-64:
				return A.spr_SMB3_drybones
			-65:
				return A.spr_SMB3_pow
			-66:
				return A.spr_SMB3_spring_land
			-67:
				return A.spr_SMB3_clown
			-68:
				return A.spr_SMB3_clown_fire
			-69:
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					return A.spr_SMB3_shell_empty_night
				else:
					return A.spr_SMB3_shell_empty
			-70:
				return A.spr_SMB3_shell_spiny_empty
			-73:
				return A.spr_SMB3_podoboo
			-72:
				return A.spr_SMB3_sledgebro
			-71:
				return A.spr_SMB3_pplant_fire_down
			-74:
				return A.spr_SMB3_goomba_shoe
			-75:
				return A.spr_SMB3_goomba_shoe_red
			-106:
				return A.spr_SMB3_waddlewing
			_:
				return -1
	elif G.apariencia == 2.0:
		match int(argument0):
			1:
				return A.spr_mushroom
			2:
				return A.spr_fireflower
			-50:
				return A.spr_fireflower
			-80:
				return A.spr_mushroom
			-85:
				return A.spr_pballon
			-46:
				return A.spr_pballon
			-38:
				return A.spr_pballon
			-30:
				return A.spr_cap
			-43:
				return A.spr_pballon
			3:
				return A.spr_cap
			-82:
				return A.spr_pballon
			-39:
				return A.spr_leaf
			-77:
				return A.spr_cap
			-78:
				return A.spr_pballon
			-29:
				return A.spr_pballon
			-81:
				return A.spr_shell_drybones
			-18:
				if G.bg_level == "ground" and G.modo_noche == 1.0:
					return A.spr_rotten_b
				else:
					return A.spr_1up
			-21:
				return A.spr_star
			-22:
				return A.spr_key
			-1:
				return A.spr_coin
			-76:
				return A.spr_pink_coin
			-23:
				return A.spr_spring
			-25:
				return A.spr_pswitch
			-28:
				return A.spr_beanstalk
			-31:
				return A.spr_koopa
			-90:
				return A.spr_koopa_b
			-32:
				return A.spr_koopa_red
			-91:
				return A.spr_koopa_red_b
			-33:
				return A.spr_spiny
			-34:
				return A.spr_buzzybeetle
			-54:
				return A.spr_cheepcheep
			-79:
				return A.spr_cheepcheep2
			-55:
				return A.spr_galoomba
			-56:
				return A.spr_galoomba2
			-57:
				return A.spr_bobomb
			-58:
				return A.spr_bobomb_ready
			-59:
				return A.spr_hammerbro
			-60:
				return A.spr_boo
			-61:
				return A.spr_muncher
			-62:
				return A.spr_montymole
			-63:
				return A.spr_jumppiranha
			-64:
				return A.spr_drybones
			-65:
				return A.spr_block_pow
			-66:
				return A.spr_spring_land
			-67:
				return A.spr_clown
			-68:
				return A.spr_clown_fire
			-69:
				return A.spr_shell_buzzy_empty
			-70:
				return A.spr_shell_spiny_empty
			-73:
				return A.spr_podoboo
			-72:
				return A.spr_sledgebro
			-71:
				return A.spr_pplant_fire_down
			-74:
				return A.spr_egg
			-75:
				return A.spr_egg_red
			-106:
				return A.spr_waddlewing
			_:
				return -1
	elif G.apariencia == 3.0:
		match int(argument0):
			1:
				return A.spr_NSMBU_mushroom
			2:
				return A.spr_NSMBU_fireflower
			-50:
				return A.spr_NSMBU_fireflower
			-80:
				return A.spr_NSMBU_superacorn
			-85:
				return A.spr_NSMBU_superacorn
			-38:
				return A.spr_NSMBU_penguin
			-46:
				return A.spr_NSMBU_penguin
			3:
				return A.spr_cap
			-82:
				return A.spr_NSMBU_penguin
			-43:
				return A.spr_NSMBU_superacorn
			-39:
				return A.spr_leaf
			-77:
				return A.spr_NSMBU_champicoptero
			-30:
				return A.spr_NSMBU_champicoptero
			-78:
				return A.spr_NSMBU_superacorn
			-29:
				return A.spr_NSMBU_superacorn
			-81:
				return A.spr_NSMBU_shell_drybones
			-18:
				if G.bg_level == "ground" and G.modo_noche == 1.0:
					return A.spr_rotten_b
				else:
					return A.spr_NSMBU_1up
			-21:
				return A.spr_NSMBU_star
			-22:
				return A.spr_NSMBU_key
			-1:
				return A.spr_NSMBU_coin
			-76:
				return A.spr_NSMBU_pink_coin
			-23:
				return A.spr_NSMBU_spring
			-25:
				return A.spr_NSMBU_pswitch
			-28:
				return A.spr_NSMBU_beanstalk
			-31:
				return A.spr_NSMBU_koopa
			-90:
				return A.spr_NSMBU_koopa_b
			-32:
				return A.spr_NSMBU_koopa_red
			-91:
				return A.spr_NSMBU_koopa_red_b
			-33:
				return A.spr_NSMBU_spiny
			-34:
				return A.spr_NSMBU_buzzybeetle
			-54:
				return A.spr_NSMBU_cheepcheep
			-79:
				return A.spr_NSMBU_cheepcheep2
			-55:
				return A.spr_NSMBU_goomba
			-56:
				return A.spr_NSMBU_goombrat
			-57:
				return A.spr_NSMBU_bobomb
			-58:
				return A.spr_NSMBU_bobomb_ready
			-59:
				return A.spr_NSMBU_hammerbro
			-60:
				return A.spr_NSMBU_boo_overworld
			-61:
				return A.spr_NSMBU_muncher
			-62:
				return A.spr_NSMBU_montymole
			-63:
				return A.spr_NSMBU_pplant
			-64:
				return A.spr_NSMBU_drybones
			-65:
				return A.spr_NSMBU_pow
			-66:
				return A.spr_NSMBU_spring_land
			-67:
				return A.spr_NSMBU_clown
			-68:
				return A.spr_NSMBU_clown_fire
			-69:
				return A.spr_NSMBU_shell_buzzy_empty
			-70:
				return A.spr_NSMBU_shell_spiny_empty
			-73:
				return A.spr_NSMBU_podoboo
			-72:
				return A.spr_NSMBU_sledgebro
			-71:
				return A.spr_NSMBU_pplant_fire_down
			-74:
				return A.spr_NSMBU_egg
			-75:
				return A.spr_NSMBU_egg_red
			-106:
				return A.spr_NSMBU_waddlewing
			_:
				return -1
	elif G.apariencia == 4.0:
		match int(argument0):
			1:
				return A.spr_SMB2_mushroom
			2:
				return A.spr_SMB_fireflower
			-50:
				return A.spr_SMB_superflower
			-80:
				return A.spr_SMB2_mushroom
			-77:
				return A.spr_SMB_megamushroom
			-85:
				return A.spr_SMB_link
			-78:
				return A.spr_SMB_hen_mushroom
			-30:
				return A.spr_SMB_megamushroom
			-46:
				return A.spr_SMB_hen_mushroom
			-43:
				return A.spr_SMB_hen_mushroom
			3:
				return A.spr_SMB_megamushroom
			-82:
				return A.spr_SMB_hen_mushroom
			-39:
				return A.spr_SMB_megamushroom
			-29:
				return A.spr_SMB_hen_mushroom
			-38:
				return A.spr_SMB_hen_mushroom
			-81:
				return A.spr_SMB_shell_drybones
			-18:
				if G.bg_level == "ground" and G.modo_noche == 1.0:
					return A.spr_rotten_b
				else:
					return A.spr_SMB_1up
			-21:
				return A.spr_SMB_star
			-22:
				return A.spr_SMB_key
			-1:
				return A.spr_SMB_coin
			-76:
				return A.spr_SMB_pink_coin
			-23:
				return A.spr_SMB_spring
			-25:
				return A.spr_SMB_pswitch
			-28:
				return A.spr_SMB_beanstalk
			-31:
				return A.spr_SMB_koopa
			-32:
				return A.spr_SMB_koopa_red
			-33:
				return A.spr_SMB_spiny
			-34:
				return A.spr_SMB_buzzybeetle
			-54:
				return A.spr_SMB_cheepcheep
			-79:
				return A.spr_SMB_cheepcheep2
			-55:
				return A.spr_SMB_goomba
			-56:
				return A.spr_SMB_goomba2
			-57:
				return A.spr_SMB_bobomb
			-58:
				return A.spr_SMB_bobomb_ready
			-59:
				return A.spr_SMB_hammerbro
			-60:
				return A.spr_SMB_boo
			-61:
				return A.spr_SMB_muncher
			-62:
				return A.spr_SMB_montymole
			-63:
				return A.spr_SMB_pplant
			-64:
				return A.spr_SMB_drybones
			-65:
				return A.spr_SMB_pow
			-66:
				return A.spr_SMB_spring_land
			-67:
				return A.spr_SMB_clown
			-68:
				return A.spr_SMB_clown_fire
			-69:
				if G.bg_level == "castle" or G.bg_level == "ghost" or G.bg_level == "underground" or G.modo_noche == 1.0:
					return A.spr_SMB_shell_empty_night
				else:
					return A.spr_SMB_shell_empty
			-70:
				return A.spr_SMB_shell_empty_spiny
			-73:
				return A.spr_SMB_podoboo
			-72:
				return A.spr_SMB_sledgebro
			-71:
				return A.spr_SMB_pplant_fire_down
			-74:
				return A.spr_SMB_goomba_shoe
			-75:
				return A.spr_SMB_goomba_shoe_red
			_:
				return -1
	return null  # GML 走到结尾返回 undefined
