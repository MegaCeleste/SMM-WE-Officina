extends RefCounted


# from scripts/scr_toast/scr_toast.gml
static func scr_toast(me: GMObject, argument0 = null, argument1 = null):
	var _me = me
	var _with_target2 = A.obj_toast
	var _other1: GMObject = GM.other
	GM.other = me
	for inst in GM.with_list(_with_target2):
		inst.instance_destroy()
	GM.other = _other1
	_me.texto = argument1
	_me.ancho = GM.string_width(GM.string_hash_to_newline((_me.texto)))
	_me.ancho = (_me.ancho + 49.0)
	_me.xx = ((384.0 - _me.ancho) - 16.0)
	_me.yy = 216.0
	_me.toast = GM.instance_create(_me.xx, _me.yy, A.obj_toast)
	_me.toast.xx = _me.xx
	_me.toast.yy = _me.yy
	_me.toast.ancho = _me.ancho
	_me.toast.texto = _me.texto
	_me.toast.icon = argument0
	return
