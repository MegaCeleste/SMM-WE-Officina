extends RefCounted


# from scripts/draw_circle_colour_precise/draw_circle_colour_precise.gml
static func draw_circle_colour_precise(_me: GMObject, x: float, y: float, radius: float, centre: int, edge: int, outline: bool, precision: float) -> void:
	GM.draw_circle_colour(x, y, radius, centre, edge, outline)
	# The source sets the precision after drawing, affecting subsequent draws.
	GM.draw_set_circle_precision(precision)
