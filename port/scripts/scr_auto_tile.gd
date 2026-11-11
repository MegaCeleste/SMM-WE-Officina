# from scripts/scr_auto_tile/scr_auto_tile.gml
# 第 3 批移植，已核对。me.vent1…borde2 是调用者（obj_ground）的实例变量，在 obj_ground 里声明。
extends RefCounted


# from scripts/scr_auto_tile/scr_auto_tile.gml
static func scr_auto_tile(me: GMObject) -> Variant:
	var tile  # 局部变量提升（GML 的 var 是函数作用域）
	# gml_Script_scr_auto_tile
	var iw = me.sprite_width
	var w_left = me.place_meeting((me.x - iw), me.y, me.object_index)
	var w_right = me.place_meeting((me.x + iw), me.y, me.object_index)
	var w_up = me.place_meeting(me.x, (me.y - iw), me.object_index)
	var w_down = me.place_meeting(me.x, (me.y + iw), me.object_index)
	var w_upleft = me.place_meeting((me.x - iw), (me.y - iw), me.object_index)
	var w_downleft = me.place_meeting((me.x - iw), (me.y + iw), me.object_index)
	var w_upright = me.place_meeting((me.x + iw), (me.y - iw), me.object_index)
	var w_downright = me.place_meeting((me.x + iw), (me.y + iw), me.object_index)
	me.vent1 = (not me.place_meeting((me.x + (iw * 2.0)), me.y, me.object_index))
	me.vent2 = (not me.place_meeting(me.x, (me.y - (iw * 2.0)), me.object_index))
	me.vent3 = (not me.place_meeting(me.x, (me.y + (iw * 2.0)), me.object_index))
	me.vent4 = (not me.place_meeting((me.x + (iw * 2.0)), (me.y + iw), me.object_index))
	me.borde1 = (not me.place_meeting((me.x - (iw * 2.0)), me.y, me.object_index))
	me.borde2 = (not me.place_meeting(me.x, (me.y + (iw * 2.0)), me.object_index))
	if (me.x - iw) < 0.0:
		w_left = 1.0
		w_upleft = 1.0
		w_downleft = 1.0
	if (me.x + iw) > GM.room_width:
		w_right = 1.0
		w_upright = 1.0
		w_downright = 1.0
	if (me.y - iw) < 0.0:
		w_up = 1.0
		w_upright = 1.0
		w_upleft = 1.0
	if (me.y + iw) > GM.room_height:
		w_down = 1.0
		w_downright = 1.0
		w_downleft = 1.0
	if me.y == (GM.room_height - 16.0):
		tile = 2.0
	else:
		tile = 44.0
	if w_up:
		if me.y == (GM.room_height - 16.0):
			tile = 45.0
		else:
			tile = 0.0
		if w_right:
			if me.y == (GM.room_height - 16.0):
				tile = 17.0
			else:
				tile = 4.0
			if w_down:
				tile = 12.0
				if w_left:
					tile = 28.0
					if w_upright:
						tile = 29.0
						if w_downright:
							tile = 33.0
							if w_downleft:
								tile = 39.0
								if w_upleft:
									if (me.vent1 and me.vent2) or (me.vent3 and me.vent4):
										tile = 49.0
									elif me.borde1 and me.borde2:
										tile = 48.0
									else:
										tile = 43.0
							elif w_upleft:
								tile = 40.0
						elif w_downleft:
							tile = 37.0
							if w_upleft:
								tile = 41.0
						elif w_upleft:
							tile = 36.0
					elif w_downright:
						tile = 30.0
						if w_downleft:
							tile = 34.0
							if w_upleft:
								tile = 42.0
						elif w_upleft:
							tile = 38.0
					elif w_downleft:
						tile = 31.0
						if w_upleft:
							tile = 35.0
					elif w_upleft:
						tile = 32.0
				elif w_upright:
					tile = 16.0
					if w_downright:
						tile = 18.0
				elif w_downright:
					tile = 17.0
			elif w_left:
				if me.y == (GM.room_height - 16.0):
					tile = 34.0
				else:
					tile = 15.0
				if w_upright:
					if me.y == (GM.room_height - 16.0):
						tile = 39.0
					else:
						tile = 25.0
					if w_upleft:
						if me.y == (GM.room_height - 16.0):
							tile = 43.0
						else:
							tile = 27.0
				elif w_upleft:
					if me.y == (GM.room_height - 16.0):
						tile = 42.0
					else:
						tile = 26.0
			elif w_upright:
				if me.y == (GM.room_height - 16.0):
					tile = 18.0
				else:
					tile = 8.0
		elif w_down:
			tile = 45.0
			if w_left:
				tile = 14.0
				if w_downleft:
					tile = 22.0
					if w_upleft:
						tile = 24.0
				elif w_upleft:
					tile = 23.0
		elif w_left:
			if me.y == (GM.room_height - 16.0):
				tile = 22.0
			else:
				tile = 7.0
			if w_upleft:
				if me.y == (GM.room_height - 16.0):
					tile = 24.0
				else:
					tile = 11.0
	elif w_right:
		if me.y == (GM.room_height - 16.0):
			tile = 9.0
		else:
			tile = 1.0
		if w_down:
			tile = 5.0
			if w_left:
				tile = 13.0
				if w_downright:
					tile = 19.0
					if w_downleft:
						tile = 21.0
				elif w_downleft:
					tile = 20.0
			elif w_downright:
				tile = 9.0
		elif w_left:
			if me.y == (GM.room_height - 16.0):
				tile = 21.0
			else:
				tile = 46.0
	elif w_down:
		tile = 2.0
		if w_left:
			tile = 6.0
			if w_downleft:
				tile = 10.0
	elif w_left:
		if me.y == (GM.room_height - 16.0):
			tile = 10.0
		else:
			tile = 3.0
	return tile
