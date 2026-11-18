extends GMObject

var surf: int = -1


# from objects/obj_lighting/Create_0.gml
func _create() -> void:
	surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	GM.surface_set_target(surf)
	GM.draw_clear_alpha(GM.c_black, 0.0)
	GM.surface_reset_target()


# from objects/obj_lighting/Step_0.gml
func _step() -> void:
	if GM.surface_exists(surf):
		GM.surface_set_target(surf)
		var vx: float = GM.camera_get_view_x(GM.view_get_camera(0))
		var vy: float = GM.camera_get_view_y(GM.view_get_camera(0))
		GM.draw_set_colour(GM.c_black)
		GM.draw_set_alpha(1.0)
		GM.draw_rectangle(0.0, 0.0, GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)), false)
		GM.gpu_set_blendmode(GM.bm_subtract)
		GM.draw_set_colour(GM.c_black)
		GM.draw_set_alpha(0.7)
		if GM.instance_exists(A.obj_mario):
			if GM.instance_exists(A.obj_invincibility):
				for inst in GM.with_list(A.obj_mario):
					GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 216.0, false)
				GM.draw_set_colour(GM.c_white)
				GM.draw_set_alpha(1.0)
				for inst in GM.with_list(A.obj_mario):
					GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 200.0, false)
			else:
				for inst in GM.with_list(A.obj_mario):
					GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
				GM.draw_set_colour(GM.c_white)
				GM.draw_set_alpha(1.0)
				for inst in GM.with_list(A.obj_mario):
					GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_doormario):
			for inst in GM.with_list(A.obj_doormario):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_doormario):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_player_goal_smw):
			for inst in GM.with_list(A.obj_player_goal_smw):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_player_goal_smw):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_player_goal_smb3):
			for inst in GM.with_list(A.obj_player_goal_smb3):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_player_goal_smb3):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_player_goal_smb1):
			for inst in GM.with_list(A.obj_player_goal_smb1):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_player_goal_smb1):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_player_warp):
			for inst in GM.with_list(A.obj_player_warp):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_player_warp):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		elif GM.instance_exists(A.obj_deadmario):
			for inst in GM.with_list(A.obj_deadmario):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 62.0, false)
			GM.draw_set_colour(GM.c_white)
			GM.draw_set_alpha(1.0)
			for inst in GM.with_list(A.obj_deadmario):
				GM.draw_circle((inst.x - vx), ((inst.y + 16.0) - vy), 54.0, false)
		GM.draw_set_colour(GM.c_black)
		GM.draw_set_alpha(0.2)
		if GM.instance_exists(A.obj_enemyparent):
			for inst in GM.with_list(A.obj_enemyparent):
				if inst.visible:
					if inst.object_index == A.obj_thwomp:
						GM.draw_circle((inst.x - vx), (inst.y - vy), 30.0, false)
					elif inst.object_index == A.obj_banzaibill:
						GM.draw_circle((inst.x - vx), (inst.y - vy), 55.0, false)
					elif inst.object_index == A.obj_jumppiranha:
						GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 25.0, false)
					else:
						GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_cannon):
			for inst in GM.with_list(A.obj_cannon):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_key):
			for inst in GM.with_list(A.obj_key):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_key_appear):
			for inst in GM.with_list(A.obj_key_appear):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_torbellino):
			for inst in GM.with_list(A.obj_torbellino):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_muncher):
			for inst in GM.with_list(A.obj_muncher):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_boomboom):
			for inst in GM.with_list(A.obj_boomboom):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 30.0, false)
		if GM.instance_exists(A.obj_bullebill_base):
			for inst in GM.with_list(A.obj_bullebill_base):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 35.0, false)
		if GM.instance_exists(A.obj_wrench):
			for inst in GM.with_list(A.obj_wrench):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_brohammer):
			for inst in GM.with_list(A.obj_brohammer):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_shell):
			for inst in GM.with_list(A.obj_shell):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_powerupparent):
			for inst in GM.with_list(A.obj_powerupparent):
				if inst.object_index == A.obj_1up or inst.object_index == A.obj_fireflower:
					GM.draw_circle((inst.x - vx), (inst.y - vy), 20.0, false)
				else:
					GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 20.0, false)
		if GM.instance_exists(A.obj_checkpoint):
			for inst in GM.with_list(A.obj_checkpoint):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_clown):
			for inst in GM.with_list(A.obj_clown):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 30.0, false)
		if GM.instance_exists(A.obj_arrow):
			for inst in GM.with_list(A.obj_arrow):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_ground2):
			for inst in GM.with_list(A.obj_ground2):
				GM.draw_circle(((inst.x + 24.0) - vx), ((inst.y - 24.0) - vy), 35.0, false)
		if GM.instance_exists(A.obj_bowser_fire):
			for inst in GM.with_list(A.obj_bowser_fire):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		GM.draw_set_colour(GM.c_black)
		GM.draw_set_alpha(0.8)
		if GM.instance_exists(A.obj_soplete):
			for inst in GM.with_list(A.obj_soplete):
				if inst.invisible == 0.0:
					GM.draw_circle((inst.x - vx), ((inst.y - 24.0) - vy), 45.0, false)
		if GM.instance_exists(A.obj_angrysun):
			for inst in GM.with_list(A.obj_angrysun):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 30.0, false)
		if GM.instance_exists(A.obj_podoboo):
			for inst in GM.with_list(A.obj_podoboo):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_egg_hatch):
			for inst in GM.with_list(A.obj_egg_hatch):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_yoshi_abandon):
			for inst in GM.with_list(A.obj_yoshi_abandon):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 25.0, false)
		if GM.instance_exists(A.obj_explosion):
			for inst in GM.with_list(A.obj_explosion):
				GM.draw_circle(((inst.x + 11.0) - vx), ((inst.y + 11.0) - vy), 25.0, false)
		if GM.instance_exists(A.obj_plantfire):
			for inst in GM.with_list(A.obj_plantfire):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 15.0, false)
		if GM.instance_exists(A.obj_coin):
			for inst in GM.with_list(A.obj_coin):
				GM.draw_circle(((inst.x + 8.0) - vx), ((inst.y + 8.0) - vy), 20.0, false)
		if GM.instance_exists(A.obj_coin10):
			for inst in GM.with_list(A.obj_coin10):
				GM.draw_circle(((inst.x + 16.0) - vx), ((inst.y + 16.0) - vy), 25.0, false)
		if GM.instance_exists(A.obj_flagpole):
			for inst in GM.with_list(A.obj_flagpole):
				GM.draw_circle(((inst.x + 105.0) - vx), ((inst.y + 80.0) - vy), 190.0, false)
		if GM.instance_exists(A.obj_goalcard):
			for inst in GM.with_list(A.obj_goalcard):
				GM.draw_circle(((inst.x + 16.0) - vx), ((inst.y + 16.0) - vy), 25.0, false)
		if GM.instance_exists(A.obj_goalgate):
			for inst in GM.with_list(A.obj_goalgate):
				GM.draw_circle(((inst.x + 105.0) - vx), ((inst.y + 80.0) - vy), 190.0, false)
		if GM.instance_exists(A.obj_fireball):
			for inst in GM.with_list(A.obj_fireball):
				GM.draw_circle((inst.x - vx), (inst.y - vy), 16.0, false)
		if GM.instance_exists(A.obj_crystalorb):
			for inst in GM.with_list(A.obj_crystalorb):
				GM.draw_circle(((inst.x + 8.0) - vx), (inst.y - vy), 25.0, false)
		GM.gpu_set_blendmode(GM.bm_normal)
		GM.draw_set_alpha(1.0)
		GM.surface_reset_target()
	else:
		surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
		GM.surface_set_target(surf)
		GM.draw_clear_alpha(GM.c_black, 0.0)
		GM.surface_reset_target()


# from objects/obj_lighting/Other_5.gml
func _room_end() -> void:
	if GM.surface_exists(surf):
		GM.surface_free(surf)


# from objects/obj_lighting/Draw_0.gml
func _gm_draw() -> void:
	if not GM.surface_exists(surf):
		surf = GM.surface_create(GM.camera_get_view_width(GM.view_get_camera(0)), GM.camera_get_view_height(GM.view_get_camera(0)))
	else:  # The compatibility layer only draws view 0.
		GM.draw_surface(surf, GM.camera_get_view_x(GM.view_get_camera(0)), GM.camera_get_view_y(GM.view_get_camera(0)))


# PORT: Lighting can also be destroyed mid-room when level conditions change.
func _cleanup() -> void:
	if GM.surface_exists(surf):
		GM.surface_free(surf)
