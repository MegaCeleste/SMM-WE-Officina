extends RefCounted


# from scripts/scr_resources_get_sprite/scr_resources_get_sprite.gml
static func scr_resources_get_sprite(me: GMObject, argument0 = null):
	match int(argument0):
		A.obj_coin10_res:
			return A.spr_grid_selected_32x32
		A.obj_tuberia_res:
			return A.spr_grid_selected_32x32_2
		A.obj_boomboom_res:
			return A.spr_grid_selected_32x32_2
		A.obj_thwomp_res:
			return A.spr_grid_selected_32x32
		A.obj_grinder_res:
			return A.spr_grid_selected_48x48
		A.obj_bumper_res:
			return A.spr_grid_selected_48x48
		A.obj_bullebill_base_res:
			return A.spr_grid_selected_16x32
		A.obj_billbanzai_res:
			return A.spr_grid_selected_64x64
		A.obj_oneway_res:
			return A.spr_grid_selected_32x32_2
		A.obj_checkpoint_res:
			return A.spr_grid_selected_32x32_2
		A.obj_clown_res:
			return A.spr_grid_selected_32x32_2
		A.obj_clown_fire_res:
			return A.spr_grid_selected_32x32_2
		A.obj_icicle_res:
			return A.spr_grid_selected_16x32_2
		A.obj_icicle2_res:
			return A.spr_grid_selected_16x32_2
		A.obj_arrow_res:
			return A.spr_grid_selected_32x32_2
		_:
			return A.spr_grid_selected_16x16
