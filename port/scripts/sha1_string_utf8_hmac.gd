extends RefCounted


# from scripts/sha1_string_utf8_hmac/sha1_string_utf8_hmac.gml
static func sha1_string_utf8_hmac(me: GMObject, argument0 = null, argument1 = null):
	var _key
	var _message
	var _block_size
	var _hash_size
	var _inner_size
	var _outer_size
	var _key_buffer
	var _inner_buffer
	var _outer_buffer
	var _sha1_key
	var _i
	var _key_byte
	var _sha1_inner
	var _result
	_key = argument0
	_message = argument1
	_block_size = 64.0
	_hash_size = 20.0
	_inner_size = (_block_size + GM.string_byte_length(_message))
	_outer_size = (_block_size + _hash_size)
	_key_buffer = GM.buffer_create(_block_size, GM.buffer_fixed, 1.0)
	_inner_buffer = GM.buffer_create(_inner_size, GM.buffer_fixed, 1.0)
	_outer_buffer = GM.buffer_create(_outer_size, GM.buffer_fixed, 1.0)
	if GM.string_byte_length(_key) > _block_size:
		_sha1_key = GM.sha1_string_utf8(_key)
		_i = 0.0
		while _i < _hash_size:
			GM.buffer_write(_key_buffer, GM.buffer_u8, Scr.hex_string_byte(me, _sha1_key, _i))
			_i += 1.0
	else:
		GM.buffer_write(_key_buffer, GM.buffer_text, _key)
	_i = 0.0
	while _i < _block_size:
		_key_byte = GM.buffer_peek(_key_buffer, _i, GM.buffer_u8)
		GM.buffer_poke(_inner_buffer, _i, GM.buffer_u8, (int(54) ^ int(_key_byte)))
		GM.buffer_poke(_outer_buffer, _i, GM.buffer_u8, (int(92) ^ int(_key_byte)))
		_i += 1.0
	GM.buffer_seek(_inner_buffer, GM.buffer_seek_start, _block_size)
	GM.buffer_write(_inner_buffer, GM.buffer_text, _message)
	_sha1_inner = GM.buffer_sha1(_inner_buffer, 0.0, _inner_size)
	GM.buffer_seek(_outer_buffer, GM.buffer_seek_start, _block_size)
	_i = 0.0
	while _i < _hash_size:
		GM.buffer_write(_outer_buffer, GM.buffer_u8, Scr.hex_string_byte(me, _sha1_inner, _i))
		_i += 1.0
	_result = GM.buffer_sha1(_outer_buffer, 0.0, _outer_size)
	GM.buffer_delete(_key_buffer)
	GM.buffer_delete(_inner_buffer)
	GM.buffer_delete(_outer_buffer)
	return _result
