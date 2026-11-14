extends RefCounted


# from scripts/SaveStringToFile/SaveStringToFile.gml
static func SaveStringToFile(me: GMObject, argument0 = null, argument1 = null):
	var _filename
	var _string
	var _buffer
	_filename = argument0
	_string = argument1
	_buffer = GM.buffer_create((GM.string_byte_length(_string) + 1.0), GM.buffer_fixed, 1.0)
	GM.buffer_write(_buffer, GM.buffer_string, _string)
	GM.buffer_save(_buffer, _filename)
	GM.buffer_delete(_buffer)
