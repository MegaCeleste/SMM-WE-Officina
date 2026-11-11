extends "res://objects/obj_parent_resource.gd"


# from objects/obj_koopa_res/Create_0.gml
func _create() -> void:
	super._create()
	wings_x = 17.0
	wings_y = 25.0
	para_x = 3.0
	para_y = 16.0


# from objects/obj_koopa_res/Step_2.gml
func _step_end() -> void:
	if GM.instance_find(A.obj_levelmanager, 0).get("editor") == 1.0:
		image_index = G.apariencia
		match G.apariencia:
			0.0:
				para_y = 14.0
			_:
				para_y = 16.0


# from objects/obj_koopa_res/Other_10.gml
func _user_0() -> void:
	for inst in GM.with_list(GM.instance_create((x + 8.0), (y + 9.0), A.obj_ventana)):
		inst.set("id_object", self)
		inst.set("index_object1", 94.0)
		inst.set("index_object2", 95.0)
		inst.set("selected_1", 1.0)
		inst.set("selected_2", 0.0)
		inst.set("s_contorno_1", wings)
		inst.set("s_paracaidas", paracaidas)


# from objects/obj_koopa_res/Other_11.gml
func _user_1() -> void:
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_smoke)):
		inst.sprite_index = A.spr_effect_transform
		inst.image_speed = 0.3
	G.koopa = 1.0
	for inst in GM.with_list(GM.instance_create(x, y, A.obj_koopa_red_res)):
		inst.set("wings", wings)
		inst.set("paracaidas", paracaidas)
		inst.set("key", key)
	if GM.instance_exists(A.obj_card_item):
		for inst in GM.with_list(A.obj_card_item):
			if inst.get("obj") == A.obj_koopa_res:
				inst.set("obj", A.obj_koopa_red_res)
				inst.set("obj_draw", 95.0)
	instance_destroy()


# from objects/obj_koopa_res/Other_13.gml
func _user_3() -> void:
	GM.audio_play_sound(Scr.scr_snd_powerup(self), 0.0, false)
	for inst in GM.with_list(GM.instance_create((x - 16.0), (y - 16.0), A.obj_koopa_b_res)):
		inst.set("wings", wings)
		inst.set("paracaidas", paracaidas)
		inst.set("key", key)
	instance_destroy()
