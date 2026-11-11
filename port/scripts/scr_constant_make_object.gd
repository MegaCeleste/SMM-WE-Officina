# from scripts/scr_constant_make_object/scr_constant_make_object.gml
# 第 3 批移植，已核对。
extends RefCounted


# from scripts/scr_constant_make_object/scr_constant_make_object.gml
static func scr_constant_make_object(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	if argument2 == -78 or argument2 == -29 or argument2 == -82 or argument2 == -43:
		match int(G.apariencia):
			0:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			1:
				return GM.instance_create(argument0, argument1, A.obj_frogsuit)
			2:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			3:
				return GM.instance_create(argument0, argument1, A.obj_superarcon)
	elif argument2 == -85:
		match int(G.apariencia):
			0:
				return GM.instance_create(argument0, argument1, A.obj_link)
			1:
				return GM.instance_create(argument0, argument1, A.obj_frogsuit)
			2:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			3:
				return GM.instance_create(argument0, argument1, A.obj_superarcon)
	elif argument2 == -80:
		match int(G.apariencia):
			0:
				return GM.instance_create(argument0, argument1, A.obj_SMB2_mushroom)
			1:
				return GM.instance_create(argument0, argument1, A.obj_frogsuit)
			2:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			3:
				return GM.instance_create(argument0, argument1, A.obj_superarcon)
	elif argument2 == -46 or argument2 == -38:
		match int(G.apariencia):
			0:
				return GM.instance_create(argument0, argument1, A.obj_hen_mushroom)
			1:
				return GM.instance_create(argument0, argument1, A.obj_hammersuit)
			2:
				return GM.instance_create(argument0, argument1, A.obj_pballon)
			3:
				return GM.instance_create(argument0, argument1, A.obj_penguin_suit)
	elif argument2 == -77 or argument2 == 3 or argument2 == -39 or argument2 == -30:
		match int(G.apariencia):
			0:
				return GM.instance_create(argument0, argument1, A.obj_megamushroom)
			1:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			2:
				return GM.instance_create(argument0, argument1, A.obj_cap)
			3:
				return GM.instance_create(argument0, argument1, A.obj_propellershroom)
	else:
		match int(argument2):
			1:
				return GM.instance_create(argument0, argument1, A.obj_mushroom)
			2:
				return GM.instance_create(argument0, argument1, A.obj_fireflower)
			-50:
				if G.apariencia == 0.0:
					return GM.instance_create(argument0, argument1, A.obj_superflower)
				else:
					return GM.instance_create(argument0, argument1, A.obj_fireflower)
			-21:
				return GM.instance_create(argument0, argument1, A.obj_star)
			-18:
				return GM.instance_create(argument0, argument1, A.obj_1up)
			-81:
				return GM.instance_create(argument0, argument1, A.obj_shell_drybones)
			-74:
				return GM.instance_create(argument0, argument1, A.obj_egg)
			-75:
				return GM.instance_create(argument0, argument1, A.obj_egg_red)
			-22:
				return GM.instance_create(argument0, argument1, A.obj_key_appear)
			-76:
				return GM.instance_create(argument0, argument1, A.obj_pink_coin)
			-55:
				return GM.instance_create(argument0, argument1, A.obj_galoomba)
			-56:
				return GM.instance_create(argument0, argument1, A.obj_galoomba2)
			-31:
				return GM.instance_create(argument0, argument1, A.obj_koopa)
			-90:
				return GM.instance_create(argument0, argument1, A.obj_koopa_b)
			-32:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red)
			-91:
				return GM.instance_create(argument0, argument1, A.obj_koopa_red_b)
			-57:
				return GM.instance_create(argument0, argument1, A.obj_bobomb)
			-58:
				return GM.instance_create(argument0, argument1, A.obj_bobomb_ready)
			-34:
				return GM.instance_create(argument0, argument1, A.obj_buzzybeetle)
			-33:
				return GM.instance_create(argument0, argument1, A.obj_spiny)
			-59:
				return GM.instance_create(argument0, argument1, A.obj_hammerbro)
			-72:
				return GM.instance_create(argument0, argument1, A.obj_sledgebro)
			-63:
				return GM.instance_create(argument0, argument1, A.obj_jumppiranha)
			-71:
				return GM.instance_create(argument0, argument1, A.obj_plant_fire)
			-64:
				return GM.instance_create(argument0, argument1, A.obj_drybones)
			-73:
				return GM.instance_create(argument0, argument1, A.obj_podoboo)
			-54:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep)
			-79:
				return GM.instance_create(argument0, argument1, A.obj_cheepcheep2)
			-62:
				return GM.instance_create(argument0, argument1, A.obj_monty_chase)
			-61:
				return GM.instance_create(argument0, argument1, A.obj_muncher)
			-60:
				return GM.instance_create(argument0, argument1, A.obj_boo)
			-25:
				return GM.instance_create(argument0, argument1, A.obj_pswitch)
			-65:
				return GM.instance_create(argument0, argument1, A.obj_block_pow_hold)
			-23:
				return GM.instance_create(argument0, argument1, A.obj_spring)
			-66:
				return GM.instance_create(argument0, argument1, A.obj_spring_land)
			-67:
				return GM.instance_create(argument0, argument1, A.obj_clown)
			-68:
				return GM.instance_create(argument0, argument1, A.obj_clown_fire)
			-69:
				return GM.instance_create(argument0, argument1, A.obj_shell_empty)
			-70:
				return GM.instance_create(argument0, argument1, A.obj_spiny_empty)
			-106:
				return GM.instance_create(argument0, argument1, A.obj_waddlewing)
	return null  # GML 走到结尾返回 undefined
