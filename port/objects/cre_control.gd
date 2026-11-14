extends GMObject

var c_title: float = 0.0
var c_letter: float = 0.0
var x_pos = null
var ready_v: float = 0.0  # 原名 ready，与 Node.ready 冲突
var alpha: float = 0.0
var yy: float = 0.0
var index: float = 0.0


# from objects/cre_control/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	c_title = GM.make_colour_rgb(223.0, 197.0, 140.0)
	c_letter = 16777215.0
	x_pos = (GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0))
	x_pos = (GM.camera_get_view_x(GM.view_get_camera(0)) + (GM.camera_get_view_width(GM.view_get_camera(0)) / 2.0))
	ready_v = 1.0
	alpha = 0.0
	yy = 0.0
	index = 0.0
	Scr.scr_init_globals(self)
	G.timer = 0.0
	G.powerup = 0.0
	G.apariencia = 2.0


# from objects/cre_control/Step_0.gml
func _step() -> void:
	match ready_v:
		1.0:
			alpha += 0.015
			if alpha > 1.0:
				alpha = 1.0
				ready_v = 2.0
		2.0:
			yy += 0.4
			if yy > 1400.0:
				ready_v = 3.0
		3.0:
			alpha -= 0.015
			if alpha < 0.0:
				alpha = 0.0
				ready_v = 4.0
				GM.room_goto(A.rm_title)
	index += 1.0


# from objects/cre_control/Other_4.gml
func _room_start() -> void:
	GM.audio_play_sound(A.snd_credits, 99.0, false)


# from objects/cre_control/Other_5.gml
func _room_end() -> void:
	GM.audio_stop_sound(A.snd_credits)


# from objects/cre_control/Draw_0.gml
func _gm_draw() -> void:
	GM.draw_set_font(G.font_google)
	GM.draw_set_color(c_letter)
	GM.draw_set_alpha(alpha)
	var num = 26.0
	GM.draw_set_halign(GM.fa_center)
	# /Si vas a moverle a los creditos almejos deja los que ya estan porfavor :)
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("SUPER MARIO MAKER WORLD ENGINE | 2019 - 2023")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 32.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Franyer Farías")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 33.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("DangerousZone")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Julia")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Spriters")), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Danny Sliverd")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("EmaxCapoYT")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Francozkai29")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Isaías")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("JoaDash")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Julia")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Keira")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("LucasGamer")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("MauroGRF")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Mega Mario Bros 789")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("NANO")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nintenderos Android")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Policombo")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("TheMaker")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("!z014yfsi_")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 34.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Isaías")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Julia")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Tokarev")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 35.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Aseprite")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 36.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Alexader R.")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Angela Gonzales")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Endood")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gabriel Gamer 2.0")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gatu's")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("iDomi")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("MatheusGamer")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Med Animation")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nicolas Peixoto")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("TheMario")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("¡TraxerGames")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("WillyMaker")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Zaid Eduardo")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 37.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("AlexisJR")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Androacks22")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Anndy Mike")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("DangerousZone")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Francozkai29")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gabs")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gatete")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("iDomi")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Jeanyer")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Julia")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Lilistalker")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("MauroGRF")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Winter")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 38.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gatete Mario Engine")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Hello Mario Engine")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Mario Worlds Delta")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Unimaker")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Game Forever | Enginer Dev Team")), c_title, c_title, c_title, c_title, alpha)
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 32.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Andoyt")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Spriters")), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Kike19")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("NaNo")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Apolos")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Suil")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Urikett")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("NoobTime")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("David Nintenplay")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Andoyt")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Varnat")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Cupaban")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Mega Mario Bros 789")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gatuping")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nameless")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("HeXp")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 170.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Vini")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nameless")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Andoyt")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("NicoplaysZ")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("GustaSaiyajin06")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 36.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nemiad")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Varnat")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Sicraft")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Les")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("DangerousZone")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("TheWatermelon24")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("New-Drago")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Polartic")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Kass")))
	num += 24.0
	GM.draw_text_color(x_pos, ((y + num) - yy), GM.string_hash_to_newline((Scr.scr_language(self, 37.0))), c_title, c_title, c_title, c_title, alpha)
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Sicraft")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("MarioFranyer")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Nemiad")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Gatuping")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("HeXp")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Varnat")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("New-Drago")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("DangerousZone")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Les")))
	num += 12.0
	GM.draw_text(x_pos, ((y + num) - yy), GM.string_hash_to_newline(("Polartic")))
	num += 24.0
	GM.draw_set_halign(GM.fa_left)
	GM.draw_sprite(A.spr_NSMBU_mario_small_walk, index, 240.0, ((y + num) - yy))
	GM.draw_sprite(A.spr_NSMBU_luigi_walk, index, 208.0, ((y + num) - yy))
	GM.draw_sprite(A.spr_NSMBU_toad_small_walk, index, 176.0, ((y + num) - yy))
	GM.draw_sprite(A.spr_NSMBU_toadette_walk, index, 144.0, ((y + num) - yy))
	num += 48.0
	GM.draw_set_halign(GM.fa_center)
	GM.draw_sprite(A.spr_emilio, index, 176.0, ((y + num) - yy))
