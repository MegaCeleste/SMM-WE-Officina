extends RefCounted


# from scripts/hex_string_byte/hex_string_byte.gml
static func hex_string_byte(me: GMObject, argument0 = null, argument1 = null):
	var _hex_string
	var _byte
	var _value
	var _high_char
	var _low_char
	_hex_string = argument0
	_byte = argument1
	_value = 0.0
	_high_char = GM.ord(GM.string_char_at(_hex_string, ((2.0 * _byte) + 1.0)))
	_low_char = GM.ord(GM.string_char_at(_hex_string, ((2.0 * _byte) + 2.0)))
	if _low_char >= 48.0 and _low_char <= 57.0:
		_value += (_low_char - 48.0)
	elif _low_char >= 97.0 and _low_char <= 102.0:
		_value += (_low_char - 87.0)
	if _high_char >= 48.0 and _high_char <= 57.0:
		_value += (int((_high_char - 48.0)) << int(4))
	elif _high_char >= 97.0 and _high_char <= 102.0:
		_value += (int((_high_char - 87.0)) << int(4))
	return _value
