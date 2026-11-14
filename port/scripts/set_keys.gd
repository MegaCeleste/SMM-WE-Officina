extends RefCounted

# from scripts/set_keys/set_keys.gml
static func set_keys(me: GMObject, argument0: float, argument1: String, argument2: float) -> Variant:
	var id = GM.instance_create(0.0, 0.0, A.obj_titlemenu_key)
	me.set("ID", id)
	id.key = argument0
	id.keyText = argument1
	id.keyDefault = argument2
	return null
