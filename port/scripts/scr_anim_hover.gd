extends RefCounted


# from scripts/scr_anim_hover/scr_anim_hover.gml
static func scr_anim_hover(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null):
	var xx = argument0
	var yy = argument1
	var anim = argument2
	var pos = argument3
	GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, xx, yy, 1.0, 1.0, 0.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, (xx + me.sprite_width), yy, 1.0, 1.0, 270.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, xx, (yy + (me.sprite_height - pos)), 1.0, 1.0, 90.0, GM.c_white, 1.0)
	GM.draw_sprite_ext(A.spr_nm_buttons_hover, anim, (xx + me.sprite_width), (yy + (me.sprite_height - pos)), 1.0, 1.0, 180.0, GM.c_white, 1.0)
