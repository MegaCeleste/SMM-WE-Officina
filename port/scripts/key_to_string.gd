extends RefCounted

# from scripts/key_to_string/key_to_string.gml
static func key_to_string(_me: GMObject, argument0: float) -> Variant:
	match int(argument0):
		8: return "backspace"
		9: return "tab"
		12: return "pad-middle"
		13: return "enter"
		16: return "shift"
		17: return "ctrl"
		18: return "alt"
		19: return "pause"
		20: return "c-lock"
		27: return "esc"
		32: return "space"
		33: return "p-up"
		34: return "p-down"
		35: return "end"
		36: return "home"
		37: return "left"
		38: return "up"
		39: return "right"
		40: return "down"
		44: return "p-screen"
		45: return "insert"
		46: return "delito"
		91: return "l-wind"
		92: return "r-wind"
		93: return "menu"
		96, 97, 98, 99, 100, 101, 102, 103, 104, 105: return "pad " + str(int(argument0) - 96)
		106: return "pad *"
		107: return "pad +"
		109: return "pad -"
		110: return "pad ."
		111: return "pad /"
		112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123: return "F" + str(int(argument0) - 111)
		144: return "n-lock"
		145: return "s-lock"
	return GM.chr(argument0)
