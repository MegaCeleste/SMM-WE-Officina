# from scripts/LoadJSONFromFile/LoadJSONFromFile.gml
# 第 3 批移植。buffer_load / base64_decode / sha1_string_utf8_hmac / json_decode 由兼容层 GM.swe_load_json 一并完成
# （校验 HMAC、解码；成功返回 Dictionary，失败返回 0.0）。原脚本逻辑保留在下方注释。
extends RefCounted


# from scripts/LoadJSONFromFile/LoadJSONFromFile.gml
static func LoadJSONFromFile(me: GMObject, argument0 = null) -> Variant:
	var _filename: String = argument0
	# var _buffer = buffer_load(_filename)
	# var _string = buffer_read(_buffer, buffer_string)
	# buffer_delete(_buffer)
	# var _expected_hash = string_copy(_string, (string_length(_string) - 39), 40)
	# var _hashless_string = string_copy(_string, 1, (string_length(_string) - 40))
	# var _new_hash = sha1_string_utf8_hmac(global.drez, _hashless_string)
	# if (_expected_hash == _new_hash) { _string_code = base64_decode(_hashless_string); _json = json_decode(_string_code); return _json }
	# else return 0
	return GM.swe_load_json(_filename, G.drez)
