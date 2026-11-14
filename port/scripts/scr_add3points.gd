extends RefCounted

# from scripts/scr_add3points/scr_add3points.gml
static func scr_add3points(_me: GMObject, argument0: String, argument1: float, argument2: float) -> Variant:
	var ntext: String = GM.string_copy(argument0, 1.0, float(GM.string_length(argument0)) - 4.0)
	if GM.string_width(GM.string_hash_to_newline(ntext)) > argument1:
		return GM.string_copy(ntext, 0.0, argument2) + "..."
	return ntext
