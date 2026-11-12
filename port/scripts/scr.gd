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

# ---- 已移植脚本（201 个文件） ----
const _m_background_get = preload("res://scripts/__background_get.gd")
const _m_background_get_element = preload("res://scripts/__background_get_element.gd")
const _m_background_get_internal = preload("res://scripts/__background_get_internal.gd")
const _m_background_set = preload("res://scripts/__background_set.gd")
const _m_background_set_element = preload("res://scripts/__background_set_element.gd")
const _m_background_set_internal = preload("res://scripts/__background_set_internal.gd")
const _m_view_get = preload("res://scripts/__view_get.gd")
const _m_background_create_from_surface = preload("res://scripts/background_create_from_surface.gd")
const _m_draw_sprite_custom_origin = preload("res://scripts/draw_sprite_custom_origin.gd")
const _m_draw_sprite_tiled_area_ext = preload("res://scripts/draw_sprite_tiled_area_ext.gd")
const _m_init_shake = preload("res://scripts/init_shake.gd")
const _m_init_shockwave = preload("res://scripts/init_shockwave.gd")
const _m_LoadJSONFromFile = preload("res://scripts/LoadJSONFromFile.gd")
const _m_outside_view = preload("res://scripts/outside_view.gd")
const _m_scr_arcon_fly = preload("res://scripts/scr_arcon_fly.gd")
const _m_scr_arcon_fly_start = preload("res://scripts/scr_arcon_fly_start.gd")
const _m_scr_auto_tile = preload("res://scripts/scr_auto_tile.gd")
const _m_scr_auto_tile_slope = preload("res://scripts/scr_auto_tile_slope.gd")
const _m_scr_bg_airship = preload("res://scripts/scr_bg_airship.gd")
const _m_scr_bg_beach = preload("res://scripts/scr_bg_beach.gd")
const _m_scr_bg_castle = preload("res://scripts/scr_bg_castle.gd")
const _m_scr_bg_desert = preload("res://scripts/scr_bg_desert.gd")
const _m_scr_bg_fall = preload("res://scripts/scr_bg_fall.gd")
const _m_scr_bg_forest = preload("res://scripts/scr_bg_forest.gd")
const _m_scr_bg_ghost_house = preload("res://scripts/scr_bg_ghost_house.gd")
const _m_scr_bg_ground = preload("res://scripts/scr_bg_ground.gd")
const _m_scr_bg_mountain = preload("res://scripts/scr_bg_mountain.gd")
const _m_scr_bg_sky = preload("res://scripts/scr_bg_sky.gd")
const _m_scr_bg_snow = preload("res://scripts/scr_bg_snow.gd")
const _m_scr_bg_underground = preload("res://scripts/scr_bg_underground.gd")
const _m_scr_bg_underwater = preload("res://scripts/scr_bg_underwater.gd")
const _m_scr_canhold = preload("res://scripts/scr_canhold.gd")
const _m_scr_canpull = preload("res://scripts/scr_canpull.gd")
const _m_scr_constant_get_sprite = preload("res://scripts/scr_constant_get_sprite.gd")
const _m_scr_constant_make_object = preload("res://scripts/scr_constant_make_object.gd")
const _m_scr_cont_lives = preload("res://scripts/scr_cont_lives.gd")
const _m_scr_create_bg_anim = preload("res://scripts/scr_create_bg_anim.gd")
const _m_scr_edit_to_play = preload("res://scripts/scr_edit_to_play.gd")
const _m_scr_init_globals = preload("res://scripts/scr_init_globals.gd")
const _m_scr_insideview = preload("res://scripts/scr_insideview.gd")
const _m_scr_jump = preload("res://scripts/scr_jump.gd")
const _m_scr_language = preload("res://scripts/scr_language.gd")
const _m_scr_link_arrow_jump = preload("res://scripts/scr_link_arrow_jump.gd")
const _m_scr_link_arrow_swim = preload("res://scripts/scr_link_arrow_swim.gd")
const _m_scr_link_arrow_walk = preload("res://scripts/scr_link_arrow_walk.gd")
const _m_scr_lose_condition = preload("res://scripts/scr_lose_condition.gd")
const _m_scr_mario_cap_fly = preload("res://scripts/scr_mario_cap_fly.gd")
const _m_scr_mario_cap_fly_acender = preload("res://scripts/scr_mario_cap_fly_acender.gd")
const _m_scr_mario_cap_fly_acender_decender = preload("res://scripts/scr_mario_cap_fly_acender_decender.gd")
const _m_scr_mario_cap_fly_decender = preload("res://scripts/scr_mario_cap_fly_decender.gd")
const _m_scr_mario_drybones = preload("res://scripts/scr_mario_drybones.gd")
const _m_scr_mario_drybones_goal = preload("res://scripts/scr_mario_drybones_goal.gd")
const _m_scr_mario_drybones_jump = preload("res://scripts/scr_mario_drybones_jump.gd")
const _m_scr_mario_pull = preload("res://scripts/scr_mario_pull.gd")
const _m_scr_mario_shoe = preload("res://scripts/scr_mario_shoe.gd")
const _m_scr_mario_shoe_fall = preload("res://scripts/scr_mario_shoe_fall.gd")
const _m_scr_mario_swim_idle = preload("res://scripts/scr_mario_swim_idle.gd")
const _m_scr_mario_yoshi_atack = preload("res://scripts/scr_mario_yoshi_atack.gd")
const _m_scr_mario_yoshi_crouch = preload("res://scripts/scr_mario_yoshi_crouch.gd")
const _m_scr_mario_yoshi_goal = preload("res://scripts/scr_mario_yoshi_goal.gd")
const _m_scr_marioclimb = preload("res://scripts/scr_marioclimb.gd")
const _m_scr_mariodead = preload("res://scripts/scr_mariodead.gd")
const _m_scr_mariodrop = preload("res://scripts/scr_mariodrop.gd")
const _m_scr_marioduck = preload("res://scripts/scr_marioduck.gd")
const _m_scr_marioduckhold = preload("res://scripts/scr_marioduckhold.gd")
const _m_scr_mariogoal = preload("res://scripts/scr_mariogoal.gd")
const _m_scr_mariohold = preload("res://scripts/scr_mariohold.gd")
const _m_scr_mariohold_fall = preload("res://scripts/scr_mariohold_fall.gd")
const _m_scr_mariohold_jump = preload("res://scripts/scr_mariohold_jump.gd")
const _m_scr_marioidle = preload("res://scripts/scr_marioidle.gd")
const _m_scr_mariojump = preload("res://scripts/scr_mariojump.gd")
const _m_scr_mariojumphold = preload("res://scripts/scr_mariojumphold.gd")
const _m_scr_mariojumpstar = preload("res://scripts/scr_mariojumpstar.gd")
const _m_scr_mariokick = preload("res://scripts/scr_mariokick.gd")
const _m_scr_marioride = preload("res://scripts/scr_marioride.gd")
const _m_scr_mariorun = preload("res://scripts/scr_mariorun.gd")
const _m_scr_mariorunjump = preload("res://scripts/scr_mariorunjump.gd")
const _m_scr_marioshoot = preload("res://scripts/scr_marioshoot.gd")
const _m_scr_marioshoot_drybones = preload("res://scripts/scr_marioshoot_drybones.gd")
const _m_scr_marioskid = preload("res://scripts/scr_marioskid.gd")
const _m_scr_marioslide = preload("res://scripts/scr_marioslide.gd")
const _m_scr_marioswim = preload("res://scripts/scr_marioswim.gd")
const _m_scr_marioswim2 = preload("res://scripts/scr_marioswim2.gd")
const _m_scr_marioswim3 = preload("res://scripts/scr_marioswim3.gd")
const _m_scr_marioswim_hold_idle = preload("res://scripts/scr_marioswim_hold_idle.gd")
const _m_scr_marioswim_idle = preload("res://scripts/scr_marioswim_idle.gd")
const _m_scr_marioswimhold = preload("res://scripts/scr_marioswimhold.gd")
const _m_scr_marioup = preload("res://scripts/scr_marioup.gd")
const _m_scr_mariouphold = preload("res://scripts/scr_mariouphold.gd")
const _m_scr_mariowalk = preload("res://scripts/scr_mariowalk.gd")
const _m_scr_mariowarp = preload("res://scripts/scr_mariowarp.gd")
const _m_scr_music_link = preload("res://scripts/scr_music_link.gd")
const _m_scr_musicalscale = preload("res://scripts/scr_musicalscale.gd")
const _m_scr_musicalscale_kick = preload("res://scripts/scr_musicalscale_kick.gd")
const _m_scr_musicalscale_SMB3 = preload("res://scripts/scr_musicalscale_SMB3.gd")
const _m_scr_NSMBU_acrouch = preload("res://scripts/scr_NSMBU_acrouch.gd")
const _m_scr_NSMBU_airspin1 = preload("res://scripts/scr_NSMBU_airspin1.gd")
const _m_scr_NSMBU_climb_pole = preload("res://scripts/scr_NSMBU_climb_pole.gd")
const _m_scr_NSMBU_crouch = preload("res://scripts/scr_NSMBU_crouch.gd")
const _m_scr_NSMBU_crouch_fall = preload("res://scripts/scr_NSMBU_crouch_fall.gd")
const _m_scr_NSMBU_crouch_idle = preload("res://scripts/scr_NSMBU_crouch_idle.gd")
const _m_scr_NSMBU_crouch_jump = preload("res://scripts/scr_NSMBU_crouch_jump.gd")
const _m_scr_NSMBU_drill_spin = preload("res://scripts/scr_NSMBU_drill_spin.gd")
const _m_scr_NSMBU_flip = preload("res://scripts/scr_NSMBU_flip.gd")
const _m_scr_NSMBU_flip_start = preload("res://scripts/scr_NSMBU_flip_start.gd")
const _m_scr_NSMBU_goal_pole = preload("res://scripts/scr_NSMBU_goal_pole.gd")
const _m_scr_NSMBU_ground_idle = preload("res://scripts/scr_NSMBU_ground_idle.gd")
const _m_scr_NSMBU_groundpound = preload("res://scripts/scr_NSMBU_groundpound.gd")
const _m_scr_NSMBU_groundpound_canceled = preload("res://scripts/scr_NSMBU_groundpound_canceled.gd")
const _m_scr_NSMBU_groundpound_stop = preload("res://scripts/scr_NSMBU_groundpound_stop.gd")
const _m_scr_NSMBU_hold = preload("res://scripts/scr_NSMBU_hold.gd")
const _m_scr_NSMBU_hold_airspin = preload("res://scripts/scr_NSMBU_hold_airspin.gd")
const _m_scr_NSMBU_hold_ground = preload("res://scripts/scr_NSMBU_hold_ground.gd")
const _m_scr_NSMBU_hold_jump = preload("res://scripts/scr_NSMBU_hold_jump.gd")
const _m_scr_NSMBU_hold_spinjump = preload("res://scripts/scr_NSMBU_hold_spinjump.gd")
const _m_scr_NSMBU_idle = preload("res://scripts/scr_NSMBU_idle.gd")
const _m_scr_NSMBU_jump1 = preload("res://scripts/scr_NSMBU_jump1.gd")
const _m_scr_NSMBU_jump2 = preload("res://scripts/scr_NSMBU_jump2.gd")
const _m_scr_NSMBU_jump3 = preload("res://scripts/scr_NSMBU_jump3.gd")
const _m_scr_NSMBU_jump_star = preload("res://scripts/scr_NSMBU_jump_star.gd")
const _m_scr_NSMBU_kick = preload("res://scripts/scr_NSMBU_kick.gd")
const _m_scr_NSMBU_marioclimb_start = preload("res://scripts/scr_NSMBU_marioclimb_start.gd")
const _m_scr_NSMBU_musicalscale_minirebote = preload("res://scripts/scr_NSMBU_musicalscale_minirebote.gd")
const _m_scr_NSMBU_musicalscale_rebote = preload("res://scripts/scr_NSMBU_musicalscale_rebote.gd")
const _m_scr_NSMBU_penguin_swim = preload("res://scripts/scr_NSMBU_penguin_swim.gd")
const _m_scr_NSMBU_run = preload("res://scripts/scr_NSMBU_run.gd")
const _m_scr_NSMBU_runmax = preload("res://scripts/scr_NSMBU_runmax.gd")
const _m_scr_NSMBU_skid = preload("res://scripts/scr_NSMBU_skid.gd")
const _m_scr_NSMBU_skid_left = preload("res://scripts/scr_NSMBU_skid_left.gd")
const _m_scr_NSMBU_skid_right = preload("res://scripts/scr_NSMBU_skid_right.gd")
const _m_scr_NSMBU_snd_dead = preload("res://scripts/scr_NSMBU_snd_dead.gd")
const _m_scr_NSMBU_spincrouch = preload("res://scripts/scr_NSMBU_spincrouch.gd")
const _m_scr_NSMBU_spinjump = preload("res://scripts/scr_NSMBU_spinjump.gd")
const _m_scr_NSMBU_spinstomp = preload("res://scripts/scr_NSMBU_spinstomp.gd")
const _m_scr_NSMBU_standup = preload("res://scripts/scr_NSMBU_standup.gd")
const _m_scr_NSMBU_standup_pole = preload("res://scripts/scr_NSMBU_standup_pole.gd")
const _m_scr_NSMBU_stun = preload("res://scripts/scr_NSMBU_stun.gd")
const _m_scr_NSMBU_swim = preload("res://scripts/scr_NSMBU_swim.gd")
const _m_scr_NSMBU_swim2 = preload("res://scripts/scr_NSMBU_swim2.gd")
const _m_scr_NSMBU_swim_fall = preload("res://scripts/scr_NSMBU_swim_fall.gd")
const _m_scr_NSMBU_swim_hold = preload("res://scripts/scr_NSMBU_swim_hold.gd")
const _m_scr_NSMBU_triple_jump0 = preload("res://scripts/scr_NSMBU_triple_jump0.gd")
const _m_scr_NSMBU_triple_jump1 = preload("res://scripts/scr_NSMBU_triple_jump1.gd")
const _m_scr_NSMBU_triple_jump2 = preload("res://scripts/scr_NSMBU_triple_jump2.gd")
const _m_scr_NSMBU_triple_jump3 = preload("res://scripts/scr_NSMBU_triple_jump3.gd")
const _m_scr_NSMBU_walk = preload("res://scripts/scr_NSMBU_walk.gd")
const _m_scr_NSMBU_walkhold = preload("res://scripts/scr_NSMBU_walkhold.gd")
const _m_scr_NSMBU_walkhome = preload("res://scripts/scr_NSMBU_walkhome.gd")
const _m_scr_NSMBU_walkpipes = preload("res://scripts/scr_NSMBU_walkpipes.gd")
const _m_scr_NSMBU_wall_slide = preload("res://scripts/scr_NSMBU_wall_slide.gd")
const _m_scr_pink_coins = preload("res://scripts/scr_pink_coins.gd")
const _m_scr_powerup_editor = preload("res://scripts/scr_powerup_editor.gd")
const _m_scr_restart = preload("res://scripts/scr_restart.gd")
const _m_scr_snd_airship = preload("res://scripts/scr_snd_airship.gd")
const _m_scr_snd_autumn = preload("res://scripts/scr_snd_autumn.gd")
const _m_scr_snd_beach = preload("res://scripts/scr_snd_beach.gd")
const _m_scr_snd_bowserjr_shell = preload("res://scripts/scr_snd_bowserjr_shell.gd")
const _m_scr_snd_break = preload("res://scripts/scr_snd_break.gd")
const _m_scr_snd_bump = preload("res://scripts/scr_snd_bump.gd")
const _m_scr_snd_castle = preload("res://scripts/scr_snd_castle.gd")
const _m_scr_snd_coin = preload("res://scripts/scr_snd_coin.gd")
const _m_scr_snd_dead = preload("res://scripts/scr_snd_dead.gd")
const _m_scr_snd_desert = preload("res://scripts/scr_snd_desert.gd")
const _m_scr_snd_explode = preload("res://scripts/scr_snd_explode.gd")
const _m_scr_snd_fireball = preload("res://scripts/scr_snd_fireball.gd")
const _m_scr_snd_forest = preload("res://scripts/scr_snd_forest.gd")
const _m_scr_snd_ghost_house = preload("res://scripts/scr_snd_ghost_house.gd")
const _m_scr_snd_ground = preload("res://scripts/scr_snd_ground.gd")
const _m_scr_snd_hurryup = preload("res://scripts/scr_snd_hurryup.gd")
const _m_scr_snd_kick = preload("res://scripts/scr_snd_kick.gd")
const _m_scr_snd_mountain = preload("res://scripts/scr_snd_mountain.gd")
const _m_scr_snd_oneway = preload("res://scripts/scr_snd_oneway.gd")
const _m_scr_snd_pipes = preload("res://scripts/scr_snd_pipes.gd")
const _m_scr_snd_powerdown = preload("res://scripts/scr_snd_powerdown.gd")
const _m_scr_snd_powerup = preload("res://scripts/scr_snd_powerup.gd")
const _m_scr_snd_pwarning = preload("res://scripts/scr_snd_pwarning.gd")
const _m_scr_snd_skid = preload("res://scripts/scr_snd_skid.gd")
const _m_scr_snd_sky = preload("res://scripts/scr_snd_sky.gd")
const _m_scr_snd_snow = preload("res://scripts/scr_snd_snow.gd")
const _m_scr_snd_soplete = preload("res://scripts/scr_snd_soplete.gd")
const _m_scr_snd_spinjump = preload("res://scripts/scr_snd_spinjump.gd")
const _m_scr_snd_spring = preload("res://scripts/scr_snd_spring.gd")
const _m_scr_snd_sprout = preload("res://scripts/scr_snd_sprout.gd")
const _m_scr_snd_starman = preload("res://scripts/scr_snd_starman.gd")
const _m_scr_snd_stomp = preload("res://scripts/scr_snd_stomp.gd")
const _m_scr_snd_switchalert = preload("res://scripts/scr_snd_switchalert.gd")
const _m_scr_snd_switchsong = preload("res://scripts/scr_snd_switchsong.gd")
const _m_scr_snd_thwomp = preload("res://scripts/scr_snd_thwomp.gd")
const _m_scr_snd_underground = preload("res://scripts/scr_snd_underground.gd")
const _m_scr_snd_underwater = preload("res://scripts/scr_snd_underwater.gd")
const _m_scr_sprite_get_constant = preload("res://scripts/scr_sprite_get_constant.gd")
const _m_scr_sprite_get_constant_res = preload("res://scripts/scr_sprite_get_constant_res.gd")
const _m_scr_sprite_make_object = preload("res://scripts/scr_sprite_make_object.gd")
const _m_scr_sprite_make_object_rieles = preload("res://scripts/scr_sprite_make_object_rieles.gd")
const _m_scr_step_sounds = preload("res://scripts/scr_step_sounds.gd")
const _m_scr_swim = preload("res://scripts/scr_swim.gd")
const _m_scr_tiles_ground = preload("res://scripts/scr_tiles_ground.gd")
const _m_scr_tiles_ground_start = preload("res://scripts/scr_tiles_ground_start.gd")
const _m_screen_round = preload("res://scripts/screen_round.gd")
const _m_string_add_zeros = preload("res://scripts/string_add_zeros.gd")
const _m_tile_layer_find = preload("res://scripts/tile_layer_find.gd")

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

static func __view_get(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	return _m_view_get.__view_get(me, argument0, argument1)

static func background_create_from_surface(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null) -> Variant:
	return _m_background_create_from_surface.background_create_from_surface(me, argument0, argument1, argument2, argument3, argument4, argument5, argument6)

static func draw_sprite_custom_origin(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null, argument10 = null) -> void:
	_m_draw_sprite_custom_origin.draw_sprite_custom_origin(me, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10)

static func draw_sprite_tiled_area_ext(me: GMObject, argument0 = null, argument1 = null, argument2 = null, argument3 = null, argument4 = null, argument5 = null, argument6 = null, argument7 = null, argument8 = null, argument9 = null) -> Variant:
	return _m_draw_sprite_tiled_area_ext.draw_sprite_tiled_area_ext(me, argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9)

static func init_shake(me: GMObject, argument0 = null) -> void:
	_m_init_shake.init_shake(me, argument0)

static func init_shockwave(me: GMObject) -> void:
	_m_init_shockwave.init_shockwave(me)

static func LoadJSONFromFile(me: GMObject, argument0 = null) -> Variant:
	return _m_LoadJSONFromFile.LoadJSONFromFile(me, argument0)

static func outside_view(me: GMObject) -> float:
	return _m_outside_view.outside_view(me)

static func scr_arcon_fly(me: GMObject):
	return _m_scr_arcon_fly.scr_arcon_fly(me)

static func scr_arcon_fly_start(me: GMObject):
	return _m_scr_arcon_fly_start.scr_arcon_fly_start(me)

static func scr_auto_tile(me: GMObject) -> Variant:
	return _m_scr_auto_tile.scr_auto_tile(me)

static func scr_auto_tile_slope(me: GMObject) -> void:
	_m_scr_auto_tile_slope.scr_auto_tile_slope(me)

static func scr_bg_airship(me: GMObject) -> Variant:
	return _m_scr_bg_airship.scr_bg_airship(me)

static func scr_bg_beach(me: GMObject) -> Variant:
	return _m_scr_bg_beach.scr_bg_beach(me)

static func scr_bg_castle(me: GMObject) -> Variant:
	return _m_scr_bg_castle.scr_bg_castle(me)

static func scr_bg_desert(me: GMObject) -> Variant:
	return _m_scr_bg_desert.scr_bg_desert(me)

static func scr_bg_fall(me: GMObject) -> Variant:
	return _m_scr_bg_fall.scr_bg_fall(me)

static func scr_bg_forest(me: GMObject) -> Variant:
	return _m_scr_bg_forest.scr_bg_forest(me)

static func scr_bg_ghost_house(me: GMObject) -> Variant:
	return _m_scr_bg_ghost_house.scr_bg_ghost_house(me)

static func scr_bg_ground(me: GMObject) -> Variant:
	return _m_scr_bg_ground.scr_bg_ground(me)

static func scr_bg_mountain(me: GMObject) -> Variant:
	return _m_scr_bg_mountain.scr_bg_mountain(me)

static func scr_bg_sky(me: GMObject) -> Variant:
	return _m_scr_bg_sky.scr_bg_sky(me)

static func scr_bg_snow(me: GMObject) -> Variant:
	return _m_scr_bg_snow.scr_bg_snow(me)

static func scr_bg_underground(me: GMObject) -> Variant:
	return _m_scr_bg_underground.scr_bg_underground(me)

static func scr_bg_underwater(me: GMObject) -> Variant:
	return _m_scr_bg_underwater.scr_bg_underwater(me)

static func scr_canhold(me: GMObject) -> Variant:
	return _m_scr_canhold.scr_canhold(me)

static func scr_canpull(me: GMObject) -> Variant:
	return _m_scr_canpull.scr_canpull(me)

static func scr_constant_get_sprite(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_constant_get_sprite.scr_constant_get_sprite(me, argument0)

static func scr_constant_make_object(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	return _m_scr_constant_make_object.scr_constant_make_object(me, argument0, argument1, argument2)

static func scr_cont_lives(me: GMObject) -> Variant:
	return _m_scr_cont_lives.scr_cont_lives(me)

static func scr_create_bg_anim(me: GMObject) -> Variant:
	return _m_scr_create_bg_anim.scr_create_bg_anim(me)

static func scr_edit_to_play(me: GMObject):
	return _m_scr_edit_to_play.scr_edit_to_play(me)

static func scr_init_globals(me: GMObject) -> void:
	_m_scr_init_globals.scr_init_globals(me)

static func scr_insideview(me: GMObject) -> Variant:
	return _m_scr_insideview.scr_insideview(me)

static func scr_jump(me: GMObject) -> Variant:
	return _m_scr_jump.scr_jump(me)

static func scr_language(me: GMObject, argument0: float = 0.0) -> Variant:
	return _m_scr_language.scr_language(me, argument0)

static func scr_link_arrow_jump(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_link_arrow_jump.scr_link_arrow_jump(me, argument0)

static func scr_link_arrow_swim(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_link_arrow_swim.scr_link_arrow_swim(me, argument0)

static func scr_link_arrow_walk(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_link_arrow_walk.scr_link_arrow_walk(me, argument0)

static func scr_lose_condition(me: GMObject) -> Variant:
	return _m_scr_lose_condition.scr_lose_condition(me)

static func scr_mario_cap_fly(me: GMObject) -> Variant:
	return _m_scr_mario_cap_fly.scr_mario_cap_fly(me)

static func scr_mario_cap_fly_acender(me: GMObject) -> Variant:
	return _m_scr_mario_cap_fly_acender.scr_mario_cap_fly_acender(me)

static func scr_mario_cap_fly_acender_decender(me: GMObject) -> Variant:
	return _m_scr_mario_cap_fly_acender_decender.scr_mario_cap_fly_acender_decender(me)

static func scr_mario_cap_fly_decender(me: GMObject) -> Variant:
	return _m_scr_mario_cap_fly_decender.scr_mario_cap_fly_decender(me)

static func scr_mario_drybones(me: GMObject):
	return _m_scr_mario_drybones.scr_mario_drybones(me)

static func scr_mario_drybones_goal(me: GMObject):
	return _m_scr_mario_drybones_goal.scr_mario_drybones_goal(me)

static func scr_mario_drybones_jump(me: GMObject):
	return _m_scr_mario_drybones_jump.scr_mario_drybones_jump(me)

static func scr_mario_pull(me: GMObject):
	return _m_scr_mario_pull.scr_mario_pull(me)

static func scr_mario_shoe(me: GMObject):
	return _m_scr_mario_shoe.scr_mario_shoe(me)

static func scr_mario_shoe_fall(me: GMObject):
	return _m_scr_mario_shoe_fall.scr_mario_shoe_fall(me)

static func scr_mario_swim_idle(me: GMObject):
	return _m_scr_mario_swim_idle.scr_mario_swim_idle(me)

static func scr_mario_yoshi_atack(me: GMObject):
	return _m_scr_mario_yoshi_atack.scr_mario_yoshi_atack(me)

static func scr_mario_yoshi_crouch(me: GMObject):
	return _m_scr_mario_yoshi_crouch.scr_mario_yoshi_crouch(me)

static func scr_mario_yoshi_goal(me: GMObject):
	return _m_scr_mario_yoshi_goal.scr_mario_yoshi_goal(me)

static func scr_marioclimb(me: GMObject) -> Variant:
	return _m_scr_marioclimb.scr_marioclimb(me)

static func scr_mariodead(me: GMObject) -> Variant:
	return _m_scr_mariodead.scr_mariodead(me)

static func scr_mariodrop(me: GMObject) -> Variant:
	return _m_scr_mariodrop.scr_mariodrop(me)

static func scr_marioduck(me: GMObject) -> Variant:
	return _m_scr_marioduck.scr_marioduck(me)

static func scr_marioduckhold(me: GMObject) -> Variant:
	return _m_scr_marioduckhold.scr_marioduckhold(me)

static func scr_mariogoal(me: GMObject):
	return _m_scr_mariogoal.scr_mariogoal(me)

static func scr_mariohold(me: GMObject) -> Variant:
	return _m_scr_mariohold.scr_mariohold(me)

static func scr_mariohold_fall(me: GMObject):
	return _m_scr_mariohold_fall.scr_mariohold_fall(me)

static func scr_mariohold_jump(me: GMObject):
	return _m_scr_mariohold_jump.scr_mariohold_jump(me)

static func scr_marioidle(me: GMObject) -> Variant:
	return _m_scr_marioidle.scr_marioidle(me)

static func scr_mariojump(me: GMObject) -> Variant:
	return _m_scr_mariojump.scr_mariojump(me)

static func scr_mariojumphold(me: GMObject) -> Variant:
	return _m_scr_mariojumphold.scr_mariojumphold(me)

static func scr_mariojumpstar(me: GMObject) -> Variant:
	return _m_scr_mariojumpstar.scr_mariojumpstar(me)

static func scr_mariokick(me: GMObject) -> Variant:
	return _m_scr_mariokick.scr_mariokick(me)

static func scr_marioride(me: GMObject):
	return _m_scr_marioride.scr_marioride(me)

static func scr_mariorun(me: GMObject) -> Variant:
	return _m_scr_mariorun.scr_mariorun(me)

static func scr_mariorunjump(me: GMObject) -> Variant:
	return _m_scr_mariorunjump.scr_mariorunjump(me)

static func scr_marioshoot(me: GMObject) -> Variant:
	return _m_scr_marioshoot.scr_marioshoot(me)

static func scr_marioshoot_drybones(me: GMObject):
	return _m_scr_marioshoot_drybones.scr_marioshoot_drybones(me)

static func scr_marioskid(me: GMObject) -> Variant:
	return _m_scr_marioskid.scr_marioskid(me)

static func scr_marioslide(me: GMObject):
	return _m_scr_marioslide.scr_marioslide(me)

static func scr_marioswim(me: GMObject) -> Variant:
	return _m_scr_marioswim.scr_marioswim(me)

static func scr_marioswim2(me: GMObject) -> Variant:
	return _m_scr_marioswim2.scr_marioswim2(me)

static func scr_marioswim3(me: GMObject) -> Variant:
	return _m_scr_marioswim3.scr_marioswim3(me)

static func scr_marioswim_hold_idle(me: GMObject) -> Variant:
	return _m_scr_marioswim_hold_idle.scr_marioswim_hold_idle(me)

static func scr_marioswim_idle(me: GMObject) -> Variant:
	return _m_scr_marioswim_idle.scr_marioswim_idle(me)

static func scr_marioswimhold(me: GMObject) -> Variant:
	return _m_scr_marioswimhold.scr_marioswimhold(me)

static func scr_marioup(me: GMObject) -> Variant:
	return _m_scr_marioup.scr_marioup(me)

static func scr_mariouphold(me: GMObject) -> Variant:
	return _m_scr_mariouphold.scr_mariouphold(me)

static func scr_mariowalk(me: GMObject) -> Variant:
	return _m_scr_mariowalk.scr_mariowalk(me)

static func scr_mariowarp(me: GMObject) -> Variant:
	return _m_scr_mariowarp.scr_mariowarp(me)

static func scr_music_link(me: GMObject) -> Variant:
	return _m_scr_music_link.scr_music_link(me)

static func scr_musicalscale(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_musicalscale.scr_musicalscale(me, argument0, argument1, argument2)

static func scr_musicalscale_kick(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_musicalscale_kick.scr_musicalscale_kick(me, argument0, argument1, argument2)

static func scr_musicalscale_SMB3(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_musicalscale_SMB3.scr_musicalscale_SMB3(me, argument0, argument1, argument2)

static func scr_NSMBU_acrouch(me: GMObject):
	return _m_scr_NSMBU_acrouch.scr_NSMBU_acrouch(me)

static func scr_NSMBU_airspin1(me: GMObject):
	return _m_scr_NSMBU_airspin1.scr_NSMBU_airspin1(me)

static func scr_NSMBU_climb_pole(me: GMObject):
	return _m_scr_NSMBU_climb_pole.scr_NSMBU_climb_pole(me)

static func scr_NSMBU_crouch(me: GMObject):
	return _m_scr_NSMBU_crouch.scr_NSMBU_crouch(me)

static func scr_NSMBU_crouch_fall(me: GMObject):
	return _m_scr_NSMBU_crouch_fall.scr_NSMBU_crouch_fall(me)

static func scr_NSMBU_crouch_idle(me: GMObject):
	return _m_scr_NSMBU_crouch_idle.scr_NSMBU_crouch_idle(me)

static func scr_NSMBU_crouch_jump(me: GMObject):
	return _m_scr_NSMBU_crouch_jump.scr_NSMBU_crouch_jump(me)

static func scr_NSMBU_drill_spin(me: GMObject):
	return _m_scr_NSMBU_drill_spin.scr_NSMBU_drill_spin(me)

static func scr_NSMBU_flip(me: GMObject):
	return _m_scr_NSMBU_flip.scr_NSMBU_flip(me)

static func scr_NSMBU_flip_start(me: GMObject):
	return _m_scr_NSMBU_flip_start.scr_NSMBU_flip_start(me)

static func scr_NSMBU_goal_pole(me: GMObject):
	return _m_scr_NSMBU_goal_pole.scr_NSMBU_goal_pole(me)

static func scr_NSMBU_ground_idle(me: GMObject):
	return _m_scr_NSMBU_ground_idle.scr_NSMBU_ground_idle(me)

static func scr_NSMBU_groundpound(me: GMObject):
	return _m_scr_NSMBU_groundpound.scr_NSMBU_groundpound(me)

static func scr_NSMBU_groundpound_canceled(me: GMObject):
	return _m_scr_NSMBU_groundpound_canceled.scr_NSMBU_groundpound_canceled(me)

static func scr_NSMBU_groundpound_stop(me: GMObject):
	return _m_scr_NSMBU_groundpound_stop.scr_NSMBU_groundpound_stop(me)

static func scr_NSMBU_hold(me: GMObject):
	return _m_scr_NSMBU_hold.scr_NSMBU_hold(me)

static func scr_NSMBU_hold_airspin(me: GMObject):
	return _m_scr_NSMBU_hold_airspin.scr_NSMBU_hold_airspin(me)

static func scr_NSMBU_hold_ground(me: GMObject):
	return _m_scr_NSMBU_hold_ground.scr_NSMBU_hold_ground(me)

static func scr_NSMBU_hold_jump(me: GMObject):
	return _m_scr_NSMBU_hold_jump.scr_NSMBU_hold_jump(me)

static func scr_NSMBU_hold_spinjump(me: GMObject):
	return _m_scr_NSMBU_hold_spinjump.scr_NSMBU_hold_spinjump(me)

static func scr_NSMBU_idle(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_NSMBU_idle.scr_NSMBU_idle(me, argument0)

static func scr_NSMBU_jump1(me: GMObject):
	return _m_scr_NSMBU_jump1.scr_NSMBU_jump1(me)

static func scr_NSMBU_jump2(me: GMObject):
	return _m_scr_NSMBU_jump2.scr_NSMBU_jump2(me)

static func scr_NSMBU_jump3(me: GMObject):
	return _m_scr_NSMBU_jump3.scr_NSMBU_jump3(me)

static func scr_NSMBU_jump_star(me: GMObject):
	return _m_scr_NSMBU_jump_star.scr_NSMBU_jump_star(me)

static func scr_NSMBU_kick(me: GMObject, argument0 = null):
	return _m_scr_NSMBU_kick.scr_NSMBU_kick(me, argument0)

static func scr_NSMBU_marioclimb_start(me: GMObject):
	return _m_scr_NSMBU_marioclimb_start.scr_NSMBU_marioclimb_start(me)

static func scr_NSMBU_musicalscale_minirebote(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_NSMBU_musicalscale_minirebote.scr_NSMBU_musicalscale_minirebote(me, argument0, argument1, argument2)

static func scr_NSMBU_musicalscale_rebote(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_NSMBU_musicalscale_rebote.scr_NSMBU_musicalscale_rebote(me, argument0, argument1, argument2)

static func scr_NSMBU_penguin_swim(me: GMObject, argument0 = null):
	return _m_scr_NSMBU_penguin_swim.scr_NSMBU_penguin_swim(me, argument0)

static func scr_NSMBU_run(me: GMObject):
	return _m_scr_NSMBU_run.scr_NSMBU_run(me)

static func scr_NSMBU_runmax(me: GMObject):
	return _m_scr_NSMBU_runmax.scr_NSMBU_runmax(me)

static func scr_NSMBU_skid(me: GMObject) -> Variant:
	return _m_scr_NSMBU_skid.scr_NSMBU_skid(me)

static func scr_NSMBU_skid_left(me: GMObject):
	return _m_scr_NSMBU_skid_left.scr_NSMBU_skid_left(me)

static func scr_NSMBU_skid_right(me: GMObject):
	return _m_scr_NSMBU_skid_right.scr_NSMBU_skid_right(me)

static func scr_NSMBU_snd_dead(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_NSMBU_snd_dead.scr_NSMBU_snd_dead(me, argument0)

static func scr_NSMBU_spincrouch(me: GMObject):
	return _m_scr_NSMBU_spincrouch.scr_NSMBU_spincrouch(me)

static func scr_NSMBU_spinjump(me: GMObject):
	return _m_scr_NSMBU_spinjump.scr_NSMBU_spinjump(me)

static func scr_NSMBU_spinstomp(me: GMObject, argument0 = null, argument1 = null, argument2 = null):
	return _m_scr_NSMBU_spinstomp.scr_NSMBU_spinstomp(me, argument0, argument1, argument2)

static func scr_NSMBU_standup(me: GMObject):
	return _m_scr_NSMBU_standup.scr_NSMBU_standup(me)

static func scr_NSMBU_standup_pole(me: GMObject):
	return _m_scr_NSMBU_standup_pole.scr_NSMBU_standup_pole(me)

static func scr_NSMBU_stun(me: GMObject):
	return _m_scr_NSMBU_stun.scr_NSMBU_stun(me)

static func scr_NSMBU_swim(me: GMObject) -> Variant:
	return _m_scr_NSMBU_swim.scr_NSMBU_swim(me)

static func scr_NSMBU_swim2(me: GMObject):
	return _m_scr_NSMBU_swim2.scr_NSMBU_swim2(me)

static func scr_NSMBU_swim_fall(me: GMObject):
	return _m_scr_NSMBU_swim_fall.scr_NSMBU_swim_fall(me)

static func scr_NSMBU_swim_hold(me: GMObject):
	return _m_scr_NSMBU_swim_hold.scr_NSMBU_swim_hold(me)

static func scr_NSMBU_triple_jump0(me: GMObject):
	return _m_scr_NSMBU_triple_jump0.scr_NSMBU_triple_jump0(me)

static func scr_NSMBU_triple_jump1(me: GMObject):
	return _m_scr_NSMBU_triple_jump1.scr_NSMBU_triple_jump1(me)

static func scr_NSMBU_triple_jump2(me: GMObject):
	return _m_scr_NSMBU_triple_jump2.scr_NSMBU_triple_jump2(me)

static func scr_NSMBU_triple_jump3(me: GMObject):
	return _m_scr_NSMBU_triple_jump3.scr_NSMBU_triple_jump3(me)

static func scr_NSMBU_walk(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_NSMBU_walk.scr_NSMBU_walk(me, argument0)

static func scr_NSMBU_walkhold(me: GMObject):
	return _m_scr_NSMBU_walkhold.scr_NSMBU_walkhold(me)

static func scr_NSMBU_walkhome(me: GMObject):
	return _m_scr_NSMBU_walkhome.scr_NSMBU_walkhome(me)

static func scr_NSMBU_walkpipes(me: GMObject):
	return _m_scr_NSMBU_walkpipes.scr_NSMBU_walkpipes(me)

static func scr_NSMBU_wall_slide(me: GMObject):
	return _m_scr_NSMBU_wall_slide.scr_NSMBU_wall_slide(me)

static func scr_pink_coins(me: GMObject) -> Variant:
	return _m_scr_pink_coins.scr_pink_coins(me)

static func scr_powerup_editor(me: GMObject, argument0 = null):
	return _m_scr_powerup_editor.scr_powerup_editor(me, argument0)

static func scr_restart(me: GMObject) -> Variant:
	return _m_scr_restart.scr_restart(me)

static func scr_snd_airship(me: GMObject) -> Variant:
	return _m_scr_snd_airship.scr_snd_airship(me)

static func scr_snd_autumn(me: GMObject) -> Variant:
	return _m_scr_snd_autumn.scr_snd_autumn(me)

static func scr_snd_beach(me: GMObject) -> Variant:
	return _m_scr_snd_beach.scr_snd_beach(me)

static func scr_snd_bowserjr_shell(me: GMObject) -> Variant:
	return _m_scr_snd_bowserjr_shell.scr_snd_bowserjr_shell(me)

static func scr_snd_break(me: GMObject) -> Variant:
	return _m_scr_snd_break.scr_snd_break(me)

static func scr_snd_bump(me: GMObject) -> Variant:
	return _m_scr_snd_bump.scr_snd_bump(me)

static func scr_snd_castle(me: GMObject) -> Variant:
	return _m_scr_snd_castle.scr_snd_castle(me)

static func scr_snd_coin(me: GMObject) -> Variant:
	return _m_scr_snd_coin.scr_snd_coin(me)

static func scr_snd_dead(me: GMObject) -> Variant:
	return _m_scr_snd_dead.scr_snd_dead(me)

static func scr_snd_desert(me: GMObject) -> Variant:
	return _m_scr_snd_desert.scr_snd_desert(me)

static func scr_snd_explode(me: GMObject) -> Variant:
	return _m_scr_snd_explode.scr_snd_explode(me)

static func scr_snd_fireball(me: GMObject) -> Variant:
	return _m_scr_snd_fireball.scr_snd_fireball(me)

static func scr_snd_forest(me: GMObject) -> Variant:
	return _m_scr_snd_forest.scr_snd_forest(me)

static func scr_snd_ghost_house(me: GMObject) -> Variant:
	return _m_scr_snd_ghost_house.scr_snd_ghost_house(me)

static func scr_snd_ground(me: GMObject) -> Variant:
	return _m_scr_snd_ground.scr_snd_ground(me)

static func scr_snd_hurryup(me: GMObject) -> Variant:
	return _m_scr_snd_hurryup.scr_snd_hurryup(me)

static func scr_snd_kick(me: GMObject) -> Variant:
	return _m_scr_snd_kick.scr_snd_kick(me)

static func scr_snd_mountain(me: GMObject) -> Variant:
	return _m_scr_snd_mountain.scr_snd_mountain(me)

static func scr_snd_oneway(me: GMObject) -> Variant:
	return _m_scr_snd_oneway.scr_snd_oneway(me)

static func scr_snd_pipes(me: GMObject):
	return _m_scr_snd_pipes.scr_snd_pipes(me)

static func scr_snd_powerdown(me: GMObject) -> Variant:
	return _m_scr_snd_powerdown.scr_snd_powerdown(me)

static func scr_snd_powerup(me: GMObject) -> Variant:
	return _m_scr_snd_powerup.scr_snd_powerup(me)

static func scr_snd_pwarning(me: GMObject) -> Variant:
	return _m_scr_snd_pwarning.scr_snd_pwarning(me)

static func scr_snd_skid(me: GMObject) -> Variant:
	return _m_scr_snd_skid.scr_snd_skid(me)

static func scr_snd_sky(me: GMObject) -> Variant:
	return _m_scr_snd_sky.scr_snd_sky(me)

static func scr_snd_snow(me: GMObject) -> Variant:
	return _m_scr_snd_snow.scr_snd_snow(me)

static func scr_snd_soplete(me: GMObject) -> Variant:
	return _m_scr_snd_soplete.scr_snd_soplete(me)

static func scr_snd_spinjump(me: GMObject) -> Variant:
	return _m_scr_snd_spinjump.scr_snd_spinjump(me)

static func scr_snd_spring(me: GMObject) -> Variant:
	return _m_scr_snd_spring.scr_snd_spring(me)

static func scr_snd_sprout(me: GMObject) -> Variant:
	return _m_scr_snd_sprout.scr_snd_sprout(me)

static func scr_snd_starman(me: GMObject) -> Variant:
	return _m_scr_snd_starman.scr_snd_starman(me)

static func scr_snd_stomp(me: GMObject) -> Variant:
	return _m_scr_snd_stomp.scr_snd_stomp(me)

static func scr_snd_switchalert(me: GMObject) -> Variant:
	return _m_scr_snd_switchalert.scr_snd_switchalert(me)

static func scr_snd_switchsong(me: GMObject) -> Variant:
	return _m_scr_snd_switchsong.scr_snd_switchsong(me)

static func scr_snd_thwomp(me: GMObject) -> Variant:
	return _m_scr_snd_thwomp.scr_snd_thwomp(me)

static func scr_snd_underground(me: GMObject) -> Variant:
	return _m_scr_snd_underground.scr_snd_underground(me)

static func scr_snd_underwater(me: GMObject) -> Variant:
	return _m_scr_snd_underwater.scr_snd_underwater(me)

static func scr_sprite_get_constant(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_sprite_get_constant.scr_sprite_get_constant(me, argument0)

static func scr_sprite_get_constant_res(me: GMObject, argument0 = null) -> Variant:
	return _m_scr_sprite_get_constant_res.scr_sprite_get_constant_res(me, argument0)

static func scr_sprite_make_object(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	return _m_scr_sprite_make_object.scr_sprite_make_object(me, argument0, argument1, argument2)

static func scr_sprite_make_object_rieles(me: GMObject, argument0 = null, argument1 = null, argument2 = null) -> Variant:
	return _m_scr_sprite_make_object_rieles.scr_sprite_make_object_rieles(me, argument0, argument1, argument2)

static func scr_step_sounds(me: GMObject, argument0 = null, argument1 = null):
	return _m_scr_step_sounds.scr_step_sounds(me, argument0, argument1)

static func scr_swim(me: GMObject) -> Variant:
	return _m_scr_swim.scr_swim(me)

static func scr_tiles_ground(me: GMObject) -> Variant:
	return _m_scr_tiles_ground.scr_tiles_ground(me)

static func scr_tiles_ground_start(me: GMObject) -> Variant:
	return _m_scr_tiles_ground_start.scr_tiles_ground_start(me)

static func screen_round(me: GMObject, value = null):
	return _m_screen_round.screen_round(me, value)

static func string_add_zeros(me: GMObject, argument0 = null, argument1 = null) -> Variant:
	return _m_string_add_zeros.string_add_zeros(me, argument0, argument1)

static func tile_layer_find(me: GMObject, argument0: float, argument1: float, argument2: float) -> Variant:
	return _m_tile_layer_find.tile_layer_find(me, argument0, argument1, argument2)
