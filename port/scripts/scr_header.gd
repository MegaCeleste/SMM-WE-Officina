extends RefCounted


# from scripts/scr_header/scr_header.gml
static func scr_header(me: GMObject, argument0 = null):
	if argument0 == 1.0:
		if GM.instance_find(A.obj_panel_expand, 0).header == 1.0:
			return 105.0
		elif GM.instance_find(A.obj_panel_expand, 0).header == 2.0:
			return 77.0
		else:
			return 49.0
	elif argument0 == 2.0:
		if GM.instance_find(A.obj_panel_expand, 0).header == 0.0:
			return 260.0
		elif GM.instance_find(A.obj_panel_expand, 0).header == 2.0:
			return 105.0
		else:
			return 77.0
	elif argument0 == 3.0:
		if GM.instance_find(A.obj_panel_expand, 0).header == 0.0:
			return 288.0
		elif GM.instance_find(A.obj_panel_expand, 0).header == 1.0:
			return 260.0
		else:
			return 105.0
	elif argument0 == 4.0:
		if GM.instance_find(A.obj_panel_expand, 0).header == 0.0:
			return 316.0
		elif GM.instance_find(A.obj_panel_expand, 0).header == 1.0:
			return 288.0
		elif GM.instance_find(A.obj_panel_expand, 0).header == 2.0:
			return 260.0
		else:
			return 0.0
