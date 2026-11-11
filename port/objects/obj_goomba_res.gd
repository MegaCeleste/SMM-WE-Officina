extends "res://objects/obj_parent_resource.gd"

var rail: float = 0.0


# from objects/obj_goomba_res/Create_0.gml
func _create() -> void:
	super._create()
	w_sprite = A.spr_wings_editor_16x16
	wings_x = 0.0
	wings_y = 0.0
	para_x = 0.0
	para_y = 16.0
	rail = 0.0


# from objects/obj_goomba_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		image_index = G.apariencia
		if G.apariencia == 3.0:
			w_sprite = A.spr_wings_editor
			wings_x = 17.0
			wings_y = 25.0
		else:
			w_sprite = A.spr_wings_editor_16x16
			wings_x = 0.0
			wings_y = 0.0
		if rail == 1.0:
			alarm[1] = 1.0


# from objects/obj_goomba_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.set("id_object", self)
		inst.set("index_object1", 69.0)
		inst.set("index_object2", 70.0)
		inst.set("selected_1", 1.0)
		inst.set("selected_2", 0.0)
		inst.set("s_contorno_1", wings)
		inst.set("s_paracaidas", paracaidas)


# from objects/obj_goomba_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.goomba = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_goombrat_res)):
		inst.set("wings", wings)
		inst.set("paracaidas", paracaidas)
		inst.set("key", key)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.get("obj") == A.obj_goomba_res:
				inst.set("obj", A.obj_goombrat_res)
				inst.set("obj_draw", 70.0)
	instance_destroy()


# from objects/obj_goomba_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_goomba_b_res)):
		inst.set("paracaidas", paracaidas)
		inst.set("wings", wings)
	instance_destroy()


# from objects/obj_goomba_res/Other_14.gml
func _user_4() -> void:
	if wings == 0.0:
		GM.audio_play_sound(A.snd_agregar_wings, 0.0, false)
		wings = 1.0
	else:
		GM.audio_play_sound(A.snd_remove_wings, 0.0, false)
		for inst in GM.with_list(GM.instance_create((x + 17.0), (y + 8.0), A.obj_wings_dead)):
			inst.set("direct", -1.0)
		for inst in GM.with_list(GM.instance_create((x - 3.0), (y + 8.0), A.obj_wings_dead)):
			inst.sprite_index = A.spr_wings_dead2
			inst.set("direct", -1.0)
		wings = 0.0
