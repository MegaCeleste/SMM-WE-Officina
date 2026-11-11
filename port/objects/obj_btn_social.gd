# from objects/obj_btn_social/（第 2 批移植，已逐事件核对）
extends GMObject

var url_fb: String = ""
var url_dc: String = ""
var url_yt: String = ""
var url_tw: String = ""
var link: String = ""


# from objects/obj_btn_social/Create_0.gml
func _create() -> void:
	image_speed = 0.0
	image_index = 0.0
	url_fb = "https://www.facebook.com/groups/488458248636741/?ref=share"
	url_dc = "https://discord.gg/YwpyCfHgSr"
	url_yt = "https://youtube.com/@Andoyt951"
	url_tw = "https://twitter.com/EngineKingdom"
	link = url_fb


# from objects/obj_btn_social/Mouse_4.gml
func _mouse_4() -> void:
	GM.url_open(link)


# from objects/obj_btn_social/Mouse_10.gml
func _mouse_10() -> void:
	sprite_index = A.spr_social_hover


# from objects/obj_btn_social/Mouse_11.gml
func _mouse_11() -> void:
	sprite_index = A.spr_social
