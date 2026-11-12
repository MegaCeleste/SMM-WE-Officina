# 第 4 批移植，已核对。
extends GMObject

var ready_v: float = 0.0  # GML 变量名 ready（与 GDScript 冲突改名）
var ready_arrow: float = 0.0


# from objects/obj_link_arrow_anim/Create_0.gml
func _create() -> void:
	image_speed = 0.2
	ready_v = 0.0
	ready_arrow = 0.0
	if GM.instance_exists(A.obj_mario):
		GM.instance_find(A.obj_mario, 0).visible = false


# from objects/obj_link_arrow_anim/Destroy_0.gml
func _destroy() -> void:
	GM.audio_stop_sound(A.snd_SMB_link_charge2)
	GM.audio_play_sound(A.snd_SMB_link_charge2, 0.0, false)
	if not GM.instance_exists(A.obj_mario_transform2):
		for inst in GM.with_list(A.obj_mario):
			inst.arrow_ready = self.ready_arrow
			inst.visible = true
			if inst.image_alpha != 1.0:
				inst.image_alpha = 1.0
			if not GM.instance_exists(A.obj_effect_link):
				GM.instance_create(inst.x, (inst.y + 16.0), A.obj_effect_link)


# from objects/obj_link_arrow_anim/Step_0.gml
func _step() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		if G.powerup == -85.0 and m.arrow > 0.0:
			x = GM.gm_round(m.x)
			y = GM.gm_round(m.y)
			m.visible = false
		else:
			instance_destroy()
	else:
		instance_destroy()


# from objects/obj_link_arrow_anim/Other_7.gml
func _animation_end() -> void:
	ready_arrow = 1.0
	instance_destroy()


# from objects/obj_link_arrow_anim/Draw_0.gml
func _gm_draw() -> void:
	if GM.instance_exists(A.obj_mario):
		var m = GM.instance_find(A.obj_mario, 0)
		GM.draw_sprite_ext(sprite_index, image_index, m.x, (m.y + 1.0), m.direct, 1.0, 0.0, GM.c_white, m.image_alpha)
		if GM.instance_exists(A.obj_invincibility) and G.effect_star == 1.0:
			GM.shader_set(A.sha_blendreplace)
			GM.draw_sprite_ext(sprite_index, image_index, m.x, (m.y + 1.0), m.direct, 1.0, 0.0, m.blend_star, GM.instance_find(A.obj_invincibility, 0).flashAlpha)
			GM.shader_reset()
