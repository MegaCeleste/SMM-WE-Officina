# 由 tools/gen_scr.py 生成，不要手改。
# 脚本门面：原版的全部宏、枚举，以及 port/scripts/*.gd 里每个已移植脚本函数的转发。
class_name Scr
extends RefCounted

# ---- 宏（28） ----
const DISCORD_APP_ID: String = "699637175360421948"
const dcw_noone: String = "\\u00ad"
const cs_small: float = 0.0
const cs_big: float = 1.0
const cs_fire: float = 2.0
const cs_hero: float = 3.0
const cs_helice: float = -30.0
const cs_arcon: float = -43.0
const cs_penguin: float = -38.0
const cs_superball: float = -50.0
const cs_mega: float = -77.0
const cs_hen: float = -78.0
const cs_link: float = -85.0
const cs_racoon: float = -39.0
const cs_frog: float = -29.0
const cs_hammer: float = -46.0
const cs_pballoon: float = -82.0
const cs_turnip: float = 104.0
const cs_boomerang: float = -105.0
const mario: float = 0.0
const luigi: float = 1.0
const toad: float = 2.0
const toadette: float = 3.0
const SMB: float = 0.0
const SMB3: float = 1.0
const SMW: float = 2.0
const NSMBU: float = 3.0
const SMB2: float = 4.0

# ---- 枚举（2） ----
enum e__BG { Visible, Foreground, Index, X, Y, Width, Height, HTiled, VTiled, XScale, YScale, HSpeed, VSpeed, Blend, Alpha }
enum e__VW { XView, YView, WView, HView, Angle, HBorder, VBorder, HSpeed, VSpeed, Object, Visible, XPort, YPort, WPort, HPort, Camera, SurfaceID }

# ---- 已移植脚本（11 个文件） ----
const _m_background_get = preload("res://scripts/__background_get.gd")
const _m_background_get_element = preload("res://scripts/__background_get_element.gd")
const _m_background_get_internal = preload("res://scripts/__background_get_internal.gd")
const _m_background_set = preload("res://scripts/__background_set.gd")
const _m_background_set_element = preload("res://scripts/__background_set_element.gd")
const _m_background_set_internal = preload("res://scripts/__background_set_internal.gd")
const _m_background_create_from_surface = preload("res://scripts/background_create_from_surface.gd")
const _m_init_shockwave = preload("res://scripts/init_shockwave.gd")
const _m_scr_init_globals = preload("res://scripts/scr_init_globals.gd")
const _m_scr_language = preload("res://scripts/scr_language.gd")
const _m_scr_snd_switchalert = preload("res://scripts/scr_snd_switchalert.gd")

static func __background_get(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	return _m_background_get.__background_get(me, argument0, argument1)

static func __background_get_element(me: GMObject, argument0 = null) -> Variant:
	return _m_background_get_element.__background_get_element(me, argument0)

static func __background_get_internal(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	return _m_background_get_internal.__background_get_internal(me, argument0, argument1, argument2)

static func __background_set(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	return _m_background_set.__background_set(me, argument0, argument1, argument2)

static func __background_set_element(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null, argument10 = null, argument11 = null, argument12 = null, argument13 = null, argument14 = null) -> Variant:
	return _m_background_set_element.__background_set_element(me, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12, argument13, argument14)

static func __background_set_internal(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null) -> Variant:
	return _m_background_set_internal.__background_set_internal(me, argument0, argument1, argument2, argument3)

static func background_create_from_surface(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null) -> Variant:
	return _m_background_create_from_surface.background_create_from_surface(me, argument0, argument1, argument2, argument3, argument4, argument5, argument6)

static func init_shockwave(me: GMObject) -> void:
	_m_init_shockwave.init_shockwave(me)

static func scr_init_globals(me: GMObject) -> void:
	_m_scr_init_globals.scr_init_globals(me)

static func scr_language(me: GMObject, argument0: float = 0.0) -> Variant:
	return _m_scr_language.scr_language(me, argument0)

static func scr_snd_switchalert(me: GMObject) -> Variant:
	return _m_scr_snd_switchalert.scr_snd_switchalert(me)
