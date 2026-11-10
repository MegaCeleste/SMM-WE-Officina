# OpenWE (SMM_WE) 项目清单

> 范围：`C:\Working\openwe\original\openwe-ref`（只读）。本文所有路径相对 `openwe-ref`。仅陈述事实，不含移植建议。
> 行号规则：`path:行号` 为 1 起始。`.gml` 行号指原文件行；统计时已排除注释（`//`、`/* */`）并将字符串字面量内容置空，以免误匹配。
> 本文由脚本生成（Python，正则见文末与各节），统计可复现。

## 1. 项目概况

### 1.1 版本与工程

| 项 | 值 | 来源 |
|---|---|---|
| 工程文件 | SMM_WE.yyp，`resourceType`=GMProject，`resourceVersion`=1.7 | SMM_WE.yyp:3 |
| IDEVersion | 2023.11.1.129 （GMS 2.3+ 格式，对象/脚本 `resourceVersion`=1.0，脚本为 `function` 语法） | SMM_WE.yyp:352 |
| defaultScriptType | 1 | SMM_WE.yyp:12 |
| option_author | ERROR404 | options/main/options_main.yy:5 |
| option_game_speed | 60 | options/main/options_main.yy:9 |
| option_collision_compatibility | True | options/main/options_main.yy:6 |
| option_copy_on_write_enabled | False | options/main/options_main.yy:7 |
| option_window_colour | 255 | options/main/options_main.yy:19 |
| option_windows_allow_fullscreen_switching | True | options/windows/options_windows.yy:5 |
| option_windows_borderless | False | options/windows/options_windows.yy:6 |
| option_windows_display_name | SMM_WE | options/windows/options_windows.yy:13 |
| option_windows_interpolate_pixels | False | options/windows/options_windows.yy:19 |
| option_windows_resize_window | False | options/windows/options_windows.yy:23 |
| option_windows_scale | 1 | options/windows/options_windows.yy:25 |
| option_windows_sleep_margin | 10 | options/windows/options_windows.yy:26 |
| option_windows_start_fullscreen | False | options/windows/options_windows.yy:28 |
| AudioGroups | ['audiogroup_default'] | SMM_WE.yyp:5 |
| TextureGroups | ['Default'] | SMM_WE.yyp:6849 |
| options 目录平台 | android, extensions, html5, ios, linux, mac, main, operagx, ps4, ps5, switch, tvos, wasm, windows, xboxseriesxs | options/ |

### 1.2 资源数量

计算方式：解析 SMM_WE.yyp 的 `resources` 数组（SMM_WE.yyp:354 起），按 `id.path` 第一段分组；“磁盘文件数”为 `find <dir> -type f | wc -l`。

| 资源类型 | yyp 登记数 | 磁盘文件数 | 目录 |
|---|---|---|---|
| sprites | 4645 | 70294 | sprites/ |
| objects | 811 | 5513 | objects/ |
| scripts | 294 | 588 | scripts/ |
| sounds | 707 | 1414 | sounds/ |
| rooms | 10 | 24 | rooms/ |
| paths | 5 | 5 | paths/ |
| shaders | 3 | 9 | shaders/ |
| extensions | 2 | 10 | extensions/ |
| notes | 3 | 6 | notes/ |
| IncludedFiles (datafiles) | 3 | 3 | datafiles/ (SMM_WE.yyp:344) |
| RoomOrderNodes | 10 | - | SMM_WE.yyp:6836 |
| Folders (yyp 登记) | 329 | - | SMM_WE.yyp:13 |

说明：objects/ 磁盘 5513 个文件 = 811 个 .yy + 4702 个 .gml（可复核：`find objects -name "*.gml" | wc -l`）。sprites/ 未打开图片，仅用目录/ yy 统计。

### 1.3 GML 行数

计算方式：遍历 objects/ scripts/ rooms/ extensions/ 下全部 `*.gml`，行数 = Python `str.splitlines()` 的长度（含注释与空行）。sprites/ 下无 .gml。

| 目录 | .gml 文件数 | 行数 |
|---|---|---|
| objects/ | 4702 | 115931 |
| scripts/ | 294 | 22628 |
| rooms/ | 14 | 67 |
| extensions/ | 1 | 4 |
| 合计 | 5011 | 138630 |

去注释后非空行数（同一 `strip()` 规则）：130453。

### 1.4 起始 room 与 room 顺序

`RoomOrderNodes` 顺序（SMM_WE.yyp:6836）：rm_logo → rm_intro → rm_title → rm_template → rm_gameover → rm_credito → rm_course_world → rm_guardabot → rm_guardabot_play → rm_editor。第一项 `rm_logo` 为 GMS 的起始 room（依据：GMS 以 room order 第一项启动；本节只陈述 yyp 内容）。

### 1.5 资源目录分组（Folders）

计算方式：每个资源 .yy 的 `parent.path`（`folders/…yy`）取其逻辑路径，按资源类型统计到各级文件夹（SMM_WE.yyp 的 `Folders` 定义了这些路径，见 SMM_WE.yyp:13 起）。下表列出每种资源类型的前3级文件夹及直属资源数。

**objects**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Objects/Blocks | 20 |
| Objects/Blocks/Bricks | 3 |
| Objects/Blocks/Item Blocks | 3 |
| Objects/Collisions | 8 |
| Objects/Decorations | 10 |
| Objects/Decorations/Hazards | 2 |
| Objects/Discord Webhook | 1 |
| Objects/Editor Res Objects | 149 |
| Objects/Editor Res Sounds Effects | 21 |
| Objects/Editor Sounds Effects | 25 |
| Objects/Enemies | 11 |
| Objects/Enemies/Airship | 10 |
| Objects/Enemies/Beach | 6 |
| Objects/Enemies/Boss | 20 |
| Objects/Enemies/Castle | 19 |
| Objects/Enemies/Desert | 8 |
| Objects/Enemies/Forest | 6 |
| Objects/Enemies/Ghost | 2 |
| Objects/Enemies/Land | 17 |
| Objects/Enemies/Sky | 1 |
| Objects/Enemies/Snow | 2 |
| Objects/Enemies/Underground | 3 |
| Objects/Enemies/Underwater | 5 |
| Objects/Interactive | 1 |
| Objects/Interactive/Collectables | 42 |
| Objects/Interactive/Goals | 18 |
| Objects/Interactive/Others | 19 |
| Objects/Interactive/Platforms | 12 |
| Objects/Interactive/Special | 95 |
| Objects/Main | 2 |
| Objects/Main/Controllers | 45 |
| Objects/Main/Parents | 34 |
| Objects/Main/Player | 34 |
| Objects/UI/Editor | 64 |
| Objects/UI/Guardabot | 8 |
| Objects/UI/Intro | 4 |
| Objects/UI/Login | 18 |
| Objects/UI/Menu Principal | 5 |
| Objects/UI/Niveles Mundiales | 1 |
| Objects/UI/Others | 27 |
| Objects/UI/Settings | 21 |
| Objects/UI/Title | 9 |

**scripts**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Scripts | 43 |
| Scripts/Backgrounds | 16 |
| Scripts/Editor | 2 |
| Scripts/Mario | 48 |
| Scripts/Misc | 23 |
| Scripts/Music/Editor Music | 13 |
| Scripts/Music/Level music | 15 |
| Scripts/Sounds | 41 |
| Scripts/Sprites | 14 |
| Scripts/compatibility | 2 |
| Scripts/compatibility/action | 3 |
| Scripts/compatibility/background | 12 |
| Scripts/compatibility/draw | 2 |
| Scripts/compatibility/instance | 1 |
| Scripts/compatibility/object | 1 |
| Scripts/compatibility/tile | 1 |
| Scripts/compatibility/view | 4 |
| Scripts/marioU | 53 |

**sprites**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Backgrounds | 1 |
| Backgrounds/DSM | 4 |
| Backgrounds/NM | 5 |
| Backgrounds/NSMBU | 94 |
| Backgrounds/Other | 2 |
| Backgrounds/SMB | 20 |
| Backgrounds/SMB3 | 21 |
| Backgrounds/SMW | 36 |
| Objects/UI/Others | 1 |
| Sprites/Blocks | 1 |
| Sprites/Blocks/NSMBU | 23 |
| Sprites/Blocks/SMB | 24 |
| Sprites/Blocks/SMB3 | 30 |
| Sprites/Blocks/SMW | 24 |
| Sprites/Decos/NSMBU | 16 |
| Sprites/Decos/SMB | 8 |
| Sprites/Decos/SMB3 | 11 |
| Sprites/Decos/SMW | 9 |
| Sprites/Effects | 179 |
| Sprites/Effects/Lava | 13 |
| Sprites/Effects/Parts | 14 |
| Sprites/Enemies/Bosses | 102 |
| Sprites/Enemies/Deads | 123 |
| Sprites/Enemies/Global | 3 |
| Sprites/Enemies/NSMBU | 181 |
| Sprites/Enemies/Res | 167 |
| Sprites/Enemies/SMB | 156 |
| Sprites/Enemies/SMB3 | 159 |
| Sprites/Enemies/SMW | 168 |
| Sprites/Enemies/Wings | 23 |
| Sprites/Icons | 9 |
| Sprites/Items/Coins | 39 |
| Sprites/Items/Collectibles | 158 |
| Sprites/Items/Global | 15 |
| Sprites/Items/Meteorites | 16 |
| Sprites/Items/NSMBU | 44 |
| Sprites/Items/SMB | 54 |
| Sprites/Items/SMB3 | 54 |
| Sprites/Items/SMW | 54 |
| Sprites/Items/SoundEffects | 19 |
| Sprites/Masks | 115 |
| Sprites/Metas/Global | 6 |
| Sprites/Metas/NSMBU | 9 |
| Sprites/Metas/SMB | 7 |
| Sprites/Metas/SMB3 | 11 |
| Sprites/Metas/SMW | 6 |
| Sprites/Platforms/Bouncycloud | 14 |
| Sprites/Platforms/Donut | 8 |
| Sprites/Platforms/LavaLIft | 7 |
| Sprites/Platforms/NSMBU | 3 |
| Sprites/Platforms/Puentes | 29 |
| Sprites/Platforms/SMB | 3 |
| Sprites/Platforms/SMB3 | 3 |
| Sprites/Platforms/SMW | 3 |
| Sprites/Platforms/Semisolids | 293 |
| Sprites/Player/Link | 34 |
| Sprites/Player/Luigi | 257 |
| Sprites/Player/Mario | 670 |
| Sprites/Player/Toad | 316 |
| Sprites/Player/Toadette | 296 |
| Sprites/Tiles/NSMBU | 24 |
| Sprites/Tiles/SMB | 16 |
| Sprites/Tiles/SMB3 | 22 |
| Sprites/Tiles/SMW | 18 |
| Sprites/UI/Coursebot | 24 |
| Sprites/UI/Editor | 179 |
| Sprites/UI/HUD | 66 |
| Sprites/UI/Intro | 4 |
| Sprites/UI/Mario Start | 6 |
| Sprites/UI/Menu | 4 |
| Sprites/UI/Niveles Mundiales | 19 |
| Sprites/UI/Other | 73 |
| Sprites/UI/Settings | 1 |
| Sprites/UI/Title | 19 |

**sounds**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Sounds | 665 |
| Sounds/Editor songs | 42 |

**rooms**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Rooms | 10 |

**paths**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Paths | 5 |

**shaders**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Shaders | 3 |

**extensions**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Extensions | 2 |

**notes**（资源 .yy 的 `parent.path`）：

| 文件夹(前3级) | 直属资源数 |
|---|---|
| Notes | 3 |

## 2. object 清单

共 811 个 object（`objects/*/*.yy`，与 yyp 登记数 811 一致）。
列说明：parent = `.yy` 中 `parentObjectId`（行号见 yy列）；事件 = 该 object 目录下实际存在的 .gml 文件名（去掉 `.gml`；文件均位于 `objects/<object>/`）；调用 = 对 `scripts/` 中定义的函数的调用，格式 `函数名(首处文件:行 ×总次数)`（调用检测规则见 §5 头部）。`yy行` = parent行/sprite行。

### 2.1 继承树

根（无父或父不存在）object 共 265 个，其中有子类的 30 个；有子类的树如下（缩进 = 继承层级，括号内 = 后代数；父关系来源 `objects/<名>/<名>.yy` 的 `parentObjectId`）。无父且无子的独立 object 见 §2.2 表。

```
obj_deactivation (205)
  obj_arrow
  obj_beanstalk
  obj_block_hidden
  obj_bortice
  obj_bumper
  obj_claw
  obj_climb (2)
    obj_vine
    obj_vine_green
  obj_cloud_lakitu
  obj_coin
  obj_coin10 (2)
    obj_coin30
    obj_coin50
  obj_firebar
  obj_flipblock_anim
  obj_key
  obj_modelbgo (1)
    obj_modelbgo_dec
  obj_modelsizable
  obj_onewaygate_bottom
  obj_onewaygate_left (1)
    obj_shield_left
  obj_onewaygate_right (1)
    obj_shield_right
  obj_onewaygate_top
  obj_onoffplatform
  obj_onoffplatform_blue
  obj_paracaidas_dead
  obj_pblock (1)
    obj_anti_pblock
  obj_physicsparent (167)
    obj_bossparent (11)
      obj_NSMBU_bowser
      obj_SMB3_bowser
      obj_SMB_bowser
      obj_SMW_bowser
      obj_boomboom (3)
        obj_NSMBU_boomboom (1)
          obj_NSMBU_boomboom_b
        obj_boomboom_b
      obj_bowserjr (2)
        obj_NSMBU_bowserjr (1)
          obj_NSMBU_bowserjr_b
    obj_bullebill_base (1)
      obj_bullebill_base_red
    obj_clown (1)
      obj_clown_fire
    obj_coin_pow (1)
      obj_coin_pow_big
    obj_egg_hatch
    obj_enemyparent (84)
      obj_angrysun
      obj_bulletbill
      obj_bulletbull_red
      obj_buzzy_ceiling
      obj_cannonball (1)
        obj_cannonball_red
      obj_chain_chomp_free (1)
        obj_chain_chomp_free_b
      obj_crumblebones (2)
        obj_crumblebony
        obj_crumblebony_b
      obj_deactenemyparent (61)
        obj_NSMBU_ninji
        obj_banzaibill (1)
          obj_billbanzai_red
        obj_beachkoopa (3)
          obj_beachkoopa_b (1)
            obj_beachkoopa_red_b
          obj_beachkoopa_red
        obj_big_pplant (1)
          obj_big_pplant_b
        obj_blooper
        obj_bobomb (1)
          obj_bobomb_ready
        obj_bonybeetle (1)
          obj_bonybeetle_b
        obj_boo
        obj_bowserjr_shell
        obj_buzzybeetle (1)
          obj_buzzybeetle_b
        obj_charginchuck (1)
          obj_NSMBU_charginchuck
        obj_cheepcheep (1)
          obj_cheepcheep2
        obj_cooligan
        obj_drybones
        obj_egg (2)
          obj_egg_blue
          obj_egg_red
        obj_fishbone
        obj_floruga
        obj_foo
        obj_galoomba (4)
          obj_galoomba2
          obj_galoomba_b (1)
            obj_galoomba2_b
          obj_goomba_swim
        obj_grinder
        obj_grrrol
        obj_grrrol_b
        obj_grrrol_new
        obj_hammerbro (3)
          obj_boomerangbro
          obj_firebro
          obj_icebro
        obj_jumppiranha
        obj_koopa (1)
          obj_koopa_b
        obj_koopa_red (1)
          obj_koopa_red_b
        obj_mechakoopa
        obj_monty_chase
        obj_ninji
        obj_piranhaplant
        obj_pokey
        obj_rocangrejo
        obj_rocky
        obj_sledgebro
        obj_spike
        obj_spiny (1)
          obj_spiny_thrown
        obj_spiny_ball
        obj_waddlewing
      obj_floruga_body
      obj_lakitu
      obj_magikoopa
      obj_plant_fire
      obj_podoboo (1)
        obj_podoboo_b
      obj_shell_held (1)
        obj_shell_drybones_held
      obj_snow_ball_held
      obj_thwomp (1)
        obj_thwomp_b
    obj_fireball (3)
      obj_fire_clown_small (1)
        obj_fire_clown
      obj_fireball_b
    obj_fireball_bro
    obj_getshoe
    obj_holdparent (18)
      obj_block_pow_hold
      obj_enemyparent_held (13)
        obj_enemyfrozen
        obj_galoomba_hold (5)
          obj_bobomb_hold
          obj_galoomba_hold2 (1)
            obj_galoomba_hold2_b
          obj_galoomba_hold_b
          obj_mechakoopa_held
        obj_shell (3)
          obj_shell_drybones
          obj_shell_empty (1)
            obj_spiny_empty
        obj_snow_ball (1)
          obj_snow_ball_b
      obj_link_bomb
      obj_pswitch
      obj_spring
    obj_multiveggiecoin
    obj_parcarry
    obj_physicssolid (4)
      obj_cannon (1)
        obj_cannon_red
      obj_muncher (1)
        obj_muncher_b
    obj_powerupparent (16)
      obj_1up
      obj_SMB2_mushroom
      obj_cap
      obj_fireflower
      obj_frogsuit
      obj_hammersuit
      obj_hen_mushroom
      obj_link
      obj_megamushroom
      obj_mushroom
      obj_pballon
      obj_penguin_suit
      obj_propellershroom
      obj_star
      obj_superarcon
      obj_superflower
    obj_pswitch_press
    obj_snowball (1)
      obj_snowball_bro
    obj_spike_ball (1)
      obj_spike_ball_b
    obj_spring_land
    obj_torbellino
    obj_yoshi_abandon
    obj_yoshi_runaway (2)
      obj_yoshi_runaway_blue
      obj_yoshi_runaway_red
    obj_yoshifire (2)
      obj_yoshifire_one
      obj_yoshifire_purple
  obj_pink_coin
  obj_skewertrunk
  obj_soplete (1)
    obj_soplete_invert
  obj_wings_dead (1)
    obj_wings_dead_b
obj_parent_save (183)
  obj_decoracion_parent (4)
    obj_decoracion_1
    obj_decoracion_2
    obj_decoracion_3
    obj_decoracion_4
  obj_parent_resource (177)
    obj_1up_res
    obj_SMB2_mushroom_res
    obj_angrysun_res
    obj_arrow_res
    obj_big_pplant_b_res
    obj_big_pplant_res
    obj_billbanzai_red_res
    obj_billbanzai_res
    obj_block_gold_res
    obj_block_hidden_res
    obj_blooper_res
    obj_bobomb_ready_res
    obj_bobomb_res
    obj_bonybeetle_b_res
    obj_bonybeetle_res
    obj_boo_res
    obj_boomboom_b_res
    obj_boomboom_res
    obj_boomerangbro_res
    obj_bouncycloud_res
    obj_bowser_res
    obj_bowserjr_res
    obj_bullebill_base_red_res
    obj_bullebill_base_res
    obj_bumper_res
    obj_buzzy_shell_res
    obj_buzzybeetle_b_res
    obj_buzzybeetle_res
    obj_cannon_red_res
    obj_cannon_res
    obj_cap_res
    obj_charginchuck_res
    obj_checkpoint_res
    obj_cheepcheep2_res
    obj_cheepcheep_res
    obj_chomp_b_res
    obj_chomp_res
    obj_cinta_on_res
    obj_cinta_res
    obj_claw_res
    obj_clown_fire_res
    obj_clown_res
    obj_coin10_res
    obj_coin30_res
    obj_coin50_res
    obj_coin_res
    obj_cooligan_res
    obj_donut_res
    obj_door_exit_res
    obj_door_lock_exit_res
    obj_door_lock_res
    obj_door_res
    obj_door_switch_exit_res
    obj_door_switch_res
    obj_drybones_res
    obj_egg_red_res
    obj_egg_res
    obj_fast_lava_lift_res
    obj_firebro_res
    obj_fireflower_res
    obj_fishbone_res
    obj_floruga_angry_res
    obj_floruga_res
    obj_foo_res
    obj_frogsuit_res
    obj_goomba_b_res
    obj_goomba_res
    obj_goombrat_b_res
    obj_goombrat_res
    obj_grinder_res
    obj_ground (2)
      obj_ground_slope
      obj_slopes
    obj_grrrol_b_res
    obj_grrrol_new_res
    obj_grrrol_res
    obj_hammerbro_res
    obj_hen_mushroom_res
    obj_icebro_res
    obj_icicle2_res
    obj_icicle_res
    obj_key_res
    obj_koopa_b_res
    obj_koopa_red_b_res
    obj_koopa_red_res
    obj_koopa_res
    obj_lakitu_res
    obj_lava_lift_res
    obj_link_res
    obj_ludwig_res
    obj_magikoopa_res
    obj_mechakoopa_res
    obj_mini_icicle2_res
    obj_mini_icicle_res
    obj_monty_res
    obj_muncher_b_res
    obj_muncher_res
    obj_mushroom_platform_res
    obj_mushroom_res
    obj_ninji_res
    obj_nube_res
    obj_oneway_res
    obj_onoffplatform_blue_res
    obj_parent_resource_block (15)
      obj_block_res
      obj_firebar_res
      obj_ice_res
      obj_icecoin_res
      obj_musicblock_res
      obj_noteblock_res
      obj_noteblock_s_res
      obj_onoffblock_res
      obj_onoffplatform_res
      obj_pblock_res
      obj_pinchos_res
      obj_pipebase_res
      obj_qblock_res
      obj_rock_res
      obj_tuberia_res
    obj_parent_sounds (21)
      obj_ahh_snd_res
      obj_aplausos_snd_res
      obj_auh_snd_res
      obj_bebe_snd_res
      obj_bocina_snd_res
      obj_bombilla_snd_res
      obj_bonus_snd_res
      obj_boss_snd_res
      obj_cerdito_snd_res
      obj_chisporreteo_snd_res
      obj_destello_snd_res
      obj_error_snd_res
      obj_fuegos_snd_res
      obj_golpe_gato_snd_res
      obj_n64_snd_res
      obj_nota_musical_snd_res
      obj_remolino_snd_res
      obj_risas_snd_res
      obj_serpentina_snd_res
      obj_ubsi_snd_res
      obj_uhh_snd_res
    obj_pblock2_res
    obj_pink_coin_res
    obj_plant_fire_res
    obj_platform_blue_res
    obj_platform_res
    obj_podoboo_b_res
    obj_podoboo_res
    obj_pokey_res
    obj_pow_res
    obj_pplant_res
    obj_pswitch_res
    obj_puente_res
    obj_rails_res
    obj_resource_empty
    obj_rocangrejo_res
    obj_rocky_res
    obj_semisolid_platform1
    obj_shell_drybones_res
    obj_skewer_res
    obj_sledgebro_res
    obj_slopesa
    obj_soplete_res
    obj_spike_ball_b_res
    obj_spike_ball_res
    obj_spike_res
    obj_spiny_res
    obj_spiny_shell_res
    obj_spring_land_res
    obj_spring_res
    obj_star_res
    obj_superflower_res
    obj_thwomp_b_res
    obj_thwomp_res
    obj_torbellino_res
    obj_vine_res
    obj_waddlewing_res
obj_solidtop (45)
  obj_castle_floor
  obj_hurtsolid2
  obj_nube
  obj_platform_parent (10)
    obj_donut
    obj_icicle (3)
      obj_icicle2 (1)
        obj_mini_icicle2
      obj_mini_icicle
    obj_lava_lift (2)
      obj_fast_lava_lift
      obj_lava_lift_part
    obj_plataforma
    obj_plataforma_blue
  obj_solid (29)
    obj_blockparent (9)
      obj_block
      obj_block_coinchain
      obj_block_multicoin (1)
        obj_block_gold
      obj_flipblock
      obj_noteblock (2)
        obj_musicblock
        obj_noteblock_s
      obj_onoffblock
    obj_bouncycloud
    obj_cinta_parent (2)
      obj_cinta
      obj_cinta_switch
    obj_enabledsolid (1)
      obj_solidhold
    obj_groundparent (2)
      obj_ground2
      obj_ground3
    obj_modelsolid
    obj_pinchos
    obj_pipebase
    obj_platform_help
    obj_rockparent (3)
      obj_block_ice
      obj_block_rock
      obj_icecoin
    obj_skewer
    obj_tuberia
  obj_solidphy
obj_parent_sound_o (21)
  obj_ahh_or
  obj_aplausos_or
  obj_auh_or
  obj_bebe_or
  obj_bocina_or
  obj_bombilla_or
  obj_bonus_or
  obj_boss_or
  obj_cerdito_or
  obj_chisporreo_or
  obj_destello_or
  obj_error_or
  obj_fuegos_or
  obj_golpe_gato_or
  obj_n64_or
  obj_nota_musical_or
  obj_remolino_or
  obj_risas_or
  obj_serpentina_or
  obj_ubsi_or
  obj_uhh_or
obj_parent_layout (18)
  obj_card_item
  obj_card_rocket
  obj_creator_jugar_editar
  obj_dog
  obj_erase
  obj_expand
  obj_menu_editor
  obj_menu_editor_ext
  obj_night_change
  obj_panel_left
  obj_panelsparent (6)
    obj_card_autoavance
    obj_card_bg
    obj_card_block_sounds
    obj_card_condiciones
    obj_logo_game
    obj_panel_time
  obj_robot
obj_button_parent (13)
  obj_alert_button
  obj_btn_iniciar
  obj_btn_invitado
  obj_button_autoavance
  obj_button_notification_aceptar
  obj_button_ok
  obj_button_settings_close
  obj_button_settings_close2
  obj_button_superado
  obj_continue_btn
  obj_noti_load_button
  obj_pausa_button
  obj_rename_button2
obj_panelparent (6)
  obj_apariencia
  obj_autoavance
  obj_bg_selection
  obj_condiciones
  obj_panel_save_load
  obj_time
obj_player_goal_parent (6)
  obj_player_goal_smb1 (1)
    obj_player_goal_nsmbu
  obj_player_goal_smb3 (1)
    obj_player_goal_smb2
  obj_player_goal_smw (1)
    obj_player_goal_smw_castle
obj_bowser_fire (5)
  obj_NSMBU_bowser_fire
  obj_NSMBU_bowser_fire_up
  obj_NSMBU_bowserjr_fire
  obj_bowserfire_up
  obj_bowserjr_fire
obj_button_close (5)
  obj_alert_close
  obj_button_close_menu
  obj_button_notification_cancelar
  obj_load_btn_c
  obj_zoomclose
obj_smoke (5)
  obj_clown_explotion
  obj_effect_link
  obj_gold_explosion
  obj_smoke_cap
  obj_spinsmoke
obj_brohammer_yoshi (4)
  obj_bones_yoshi
  obj_bones_yoshi_one
  obj_hammer (1)
    obj_hammer_b
obj_btn_header_parent (4)
  obj_btn_header_1
  obj_btn_header_2
  obj_btn_header_3
  obj_btn_header_4
obj_rainmaker (3)
  obj_firemaker
  obj_leafmaker
  obj_snowmaker
obj_spinner (3)
  obj_link_atack
  obj_link_dash_atack
  obj_link_down_atack
obj_enemy_dead_castle (2)
  obj_bowser_dead_castle (1)
    obj_bowserjr_dead_castle
obj_kuriboshoe (2)
  obj_kuribo_drybones
  obj_kuriboshoe2
obj_slopeparent (2)
  obj_slopeleft
  obj_sloperight
obj_wrench (2)
  obj_bone
  obj_rorock
obj_yoshi2 (2)
  obj_yoshi_blue
  obj_yoshi_red
obj_big_plant_dead (1)
  obj_big_plant_b_dead
obj_bt_gb_play (1)
  obj_bt_gb_edit
obj_helmet (1)
  obj_helmet_spiny
obj_iname_control (1)
  obj_iname_control2
obj_lun (1)
  obj_lp
obj_mario (1)
  obj_marioU
obj_play_screen (1)
  obj_editor_screen
obj_score (1)
  obj_score_flag
obj_settings_button (1)
  obj_profile
obj_sparkletrail (1)
  obj_sparkles_coin
```

parent 指向不存在 object 的数量：0。

### 2.2 全部 object 表

| object | parent | sprite | 事件(.gml) | GML行 | 调用的脚本函数 | yy行 |
|---|---|---|---|---|---|---|
| [cre_control](objects/cre_control/cre_control.yy) | - | spr_marker_event | Create_0, Draw_0, Other_4, Other_5, Step_0 | 278 | scr_init_globals(Create_0:11), scr_language(Draw_0:9 ×11) | 18/34 |
| [obj_1up](objects/obj_1up/obj_1up.yy) | obj_powerupparent | spr_1up | Alarm_10, Alarm_11, Collision_obj_blockparent, Collision_obj_mario, Create_0, Draw_0, Other_13, Step_0 | 308 | instance_create(Collision_obj_blockparent:5 ×7), scr_snd_kick(Collision_obj_mario:7) | 21/43 |
| [obj_1up_res](objects/obj_1up_res/obj_1up_res.yy) | obj_parent_resource | spr_1up | Create_0, Other_10, Other_14, Step_2 | 59 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_NSMBU_boomboom](objects/obj_NSMBU_boomboom/obj_NSMBU_boomboom.yy) | obj_boomboom | spr_NSMBU_boomboom | Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_9, Create_0, Destroy_0, Other_10, Other_11, Other_14, Other_17, Other_7, Step_2 | 412 | instance_create(Other_10:3 ×8), outside_view(Step_2:48 ×3) | 30/49 |
| [obj_NSMBU_boomboom_b](objects/obj_NSMBU_boomboom_b/obj_NSMBU_boomboom_b.yy) | obj_NSMBU_boomboom | spr_NSMBU_boomboom_b | Alarm_10, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_7, Create_0, Other_10, Other_11, Other_14, Other_17, Other_7, Step_2 | 394 | instance_create(Other_10:3 ×8), outside_view(Step_2:56 ×3) | 26/45 |
| [obj_NSMBU_bowser](objects/obj_NSMBU_bowser/obj_NSMBU_bowser.yy) | obj_bossparent | spr_NSMBU_bowser_walk | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Collision_obj_blockparent, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_13, Other_14, Other_7, Step_0, Step_2 | 721 | instance_create(Alarm_2:4 ×17), outside_view(Step_2:118), scr_snd_thwomp(Other_14:30 ×2) | 30/49 |
| [obj_NSMBU_bowser_fire](objects/obj_NSMBU_bowser_fire/obj_NSMBU_bowser_fire.yy) | obj_bowser_fire | spr_NSMBU_fire_big | Create_0, Draw_0, Other_10 | 26 | instance_create(Other_10:1) | 16/35 |
| [obj_NSMBU_bowser_fire_up](objects/obj_NSMBU_bowser_fire_up/obj_NSMBU_bowser_fire_up.yy) | obj_bowser_fire | spr_NSMBU_fire_big | Create_0, Draw_0, Other_10 | 11 | instance_create(Other_10:1) | 16/35 |
| [obj_NSMBU_bowserjr](objects/obj_NSMBU_bowserjr/obj_NSMBU_bowserjr.yy) | obj_bowserjr | spr_NSMBU_bowserjr_idle | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Alarm_8, Alarm_9, Create_0, Draw_0, Other_10, Other_11, Other_14, Other_7, Step_0, Step_2 | 557 | instance_create(Alarm_8:6 ×16), scr_snd_thwomp(Other_14:21) | 28/47 |
| [obj_NSMBU_bowserjr_b](objects/obj_NSMBU_bowserjr_b/obj_NSMBU_bowserjr_b.yy) | obj_NSMBU_bowserjr | - | Create_0 | 26 | - | 14/33 |
| [obj_NSMBU_bowserjr_fire](objects/obj_NSMBU_bowserjr_fire/obj_NSMBU_bowserjr_fire.yy) | obj_bowser_fire | spr_NSMBU_bowserjr_fireball | Create_0, Draw_0, Step_0 | 38 | - | 16/35 |
| [obj_NSMBU_charginchuck](objects/obj_NSMBU_charginchuck/obj_NSMBU_charginchuck.yy) | obj_charginchuck | spr_NSMBU_charginchuck | Alarm_0, Alarm_1, Alarm_10, Other_10, Other_11, Other_18, Other_7, Step_0 | 286 | instance_create(Alarm_0:9 ×13) | 21/43 |
| [obj_NSMBU_flag_mario](objects/obj_NSMBU_flag_mario/obj_NSMBU_flag_mario.yy) | - | spr_NSMBU_flag_mario | Alarm_0, Alarm_1, Collision_obj_flagpole, Create_0, Step_0 | 36 | instance_create(Create_0:1) | 18/34 |
| [obj_NSMBU_ninji](objects/obj_NSMBU_ninji/obj_NSMBU_ninji.yy) | obj_deactenemyparent | spr_NSMBU_ninji_idle | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 142 | - | 18/37 |
| [obj_SMB2_mushroom](objects/obj_SMB2_mushroom/obj_SMB2_mushroom.yy) | obj_powerupparent | spr_SMB2_mushroom | Alarm_0, Alarm_10, Collision_obj_blockparent, Collision_obj_mario, Create_0, Other_13, Step_0 | 265 | instance_create(Collision_obj_blockparent:5 ×6), scr_snd_powerup(Collision_obj_mario:35 ×6), scr_sprite_get_constant(Collision_obj_mario:24) | 20/42 |
| [obj_SMB2_mushroom_res](objects/obj_SMB2_mushroom_res/obj_SMB2_mushroom_res.yy) | obj_parent_resource | spr_SMB2_mushroom | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 84 | instance_create(Other_10:1 ×6), scr_snd_powerdown(Other_13:1) | 19/38 |
| [obj_SMB3_bowser](objects/obj_SMB3_bowser/obj_SMB3_bowser.yy) | obj_bossparent | spr_SMB3_bowser_walk | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Collision_obj_blockparent, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_13, Other_14, Other_7, Step_0, Step_2 | 489 | instance_create(Alarm_2:4 ×10), scr_snd_thwomp(Other_14:36) | 31/50 |
| [obj_SMB_bowser](objects/obj_SMB_bowser/obj_SMB_bowser.yy) | obj_bossparent | spr_SMB_bowser | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Collision_obj_blockparent, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_13, Other_14, Step_0 | 329 | instance_create(Alarm_2:4 ×7) | 25/44 |
| [obj_SMB_castle](objects/obj_SMB_castle/obj_SMB_castle.yy) | - | spr_castle | Alarm_0, Create_0, Destroy_0, Step_0 | 67 | instance_create(Alarm_0:1 ×2) | 17/33 |
| [obj_SMB_castle_front](objects/obj_SMB_castle_front/obj_SMB_castle_front.yy) | - | spr_SMB_castle_front | Collision_obj_player_goal_nsmbu, Collision_obj_player_goal_smb1, Create_0, Draw_0 | 43 | - | 17/33 |
| [obj_SMB_flag](objects/obj_SMB_flag/obj_SMB_flag.yy) | - | spr_SMB_flags | Alarm_0, Alarm_1, Collision_obj_flagpole, Create_0, Other_10, Step_0 | 81 | instance_create(Alarm_0:4 ×2) | 19/35 |
| [obj_SMW_bowser](objects/obj_SMW_bowser/obj_SMW_bowser.yy) | obj_bossparent | spr_bowser_walk | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Collision_obj_blockparent, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_13, Other_14, Step_0, Step_2 | 607 | instance_create(Alarm_2:4 ×9) | 32/51 |
| [obj_ahh_or](objects/obj_ahh_or/obj_ahh_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 15 | init_shake(Other_10:9), instance_create(Other_10:1) | 15/34 |
| [obj_ahh_snd_res](objects/obj_ahh_snd_res/obj_ahh_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_alert_button](objects/obj_alert_button/obj_alert_button.yy) | obj_button_parent | spr_bt_parent | Alarm_2, Create_0, Mouse_4 | 17 | scr_language(Create_0:3) | 16/35 |
| [obj_alert_close](objects/obj_alert_close/obj_alert_close.yy) | obj_button_close | spr_button_close | Alarm_2, Create_0, Mouse_4 | 15 | - | 16/35 |
| [obj_alert_condicion](objects/obj_alert_condicion/obj_alert_condicion.yy) | - | spr_cond_alert | Alarm_0, Create_0, Draw_0 | 24 | scr_language(Create_0:4 ×5) | 16/32 |
| [obj_alert_load](objects/obj_alert_load/obj_alert_load.yy) | - | spr_window_alert | Create_0, Destroy_0, Draw_0 | 15 | instance_create(Create_0:2 ×2), scr_language(Draw_0:5) | 16/32 |
| [obj_alert_message](objects/obj_alert_message/obj_alert_message.yy) | - | spr_window_alert | Create_0, Destroy_0, Draw_0 | 18 | instance_create(Create_0:2 ×2), scr_language(Create_0:5) | 16/32 |
| [obj_angrysun](objects/obj_angrysun/obj_angrysun.yy) | obj_enemyparent | spr_angrysun | Alarm_0, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_10, Other_15, Other_24, Step_0 | 229 | instance_create(Alarm_0:3 ×12) | 22/44 |
| [obj_angrysun_movement](objects/obj_angrysun_movement/obj_angrysun_movement.yy) | - | - | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Create_0, Other_8, Step_0 | 63 | - | 22/38 |
| [obj_angrysun_res](objects/obj_angrysun_res/obj_angrysun_res.yy) | obj_parent_resource | spr_angrysun | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 603 | __background_set(Other_11:11 ×159), instance_create(Other_10:1 ×3), scr_bg_airship(Other_11:126), scr_bg_beach(Other_11:262), scr_bg_castle(Other_11:63), scr_bg_desert(Other_11:191), scr_bg_fall(Other_11:241), scr_bg_forest(Other_11:149), scr_bg_ghost_house(Other_11:84 ×2), scr_bg_ground(Other_11:42), scr_bg_mountain(Other_11:301), scr_bg_sky(Other_11:172), scr_bg_snow(Other_11:224), scr_bg_underground(Other_11:48), scr_bg_underwater(Other_11:69), scr_create_bg_anim(Other_11:309), scr_snd_airship(Other_11:127), scr_snd_autumn(Other_11:242), scr_snd_beach(Other_11:263), scr_snd_castle(Other_11:64), scr_snd_desert(Other_11:192), scr_snd_editor_airship(Other_11:128), scr_snd_editor_castle(Other_11:65), scr_snd_editor_desert(Other_11:193), scr_snd_editor_forest(Other_11:151 ×2), scr_snd_editor_ghost(Other_11:89), scr_snd_editor_ground(Other_11:44 ×2), scr_snd_editor_mountain(Other_11:304), scr_snd_editor_sky(Other_11:174), scr_snd_editor_snow(Other_11:226), scr_snd_editor_underground(Other_11:50), scr_snd_editor_underwater(Other_11:71), scr_snd_forest(Other_11:150), scr_snd_ghost_house(Other_11:88), scr_snd_ground(Other_11:43), scr_snd_mountain(Other_11:303), scr_snd_sky(Other_11:173), scr_snd_snow(Other_11:225), scr_snd_underground(Other_11:49), scr_snd_underwater(Other_11:70) | 19/38 |
| [obj_anti_pblock](objects/obj_anti_pblock/obj_anti_pblock.yy) | obj_pblock | spr_pblock | Create_0, Destroy_0, Step_0 | 43 | instance_create(Step_0:4), scr_snd_switchsong(Step_0:1) | 16/35 |
| [obj_apariencia](objects/obj_apariencia/obj_apariencia.yy) | obj_panelparent | spr_panel_apariencia_anim | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0, Step_1 | 72 | instance_create(Other_7:5 ×4), scr_language(Draw_0:12) | 20/39 |
| [obj_aplausos_or](objects/obj_aplausos_or/obj_aplausos_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_aplausos_snd_res](objects/obj_aplausos_snd_res/obj_aplausos_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_arrow](objects/obj_arrow/obj_arrow.yy) | obj_deactivation | spr_arrow_res | Create_0, Draw_0 | 6 | - | 15/34 |
| [obj_arrow_big](objects/obj_arrow_big/obj_arrow_big.yy) | - | spr_arrow_big | Alarm_0, Create_0, Step_0 | 25 | scr_bg_snow(Step_0:1) | 16/32 |
| [obj_arrow_lock](objects/obj_arrow_lock/obj_arrow_lock.yy) | - | spr_arrow_block | Collision_obj_parent_resource, Step_2 | 26 | instance_create(Collision_obj_parent_resource:8) | 15/31 |
| [obj_arrow_res](objects/obj_arrow_res/obj_arrow_res.yy) | obj_parent_resource | spr_arrow_res | Alarm_1, Create_0, Draw_0, Mouse_4, Step_2 | 84 | instance_create(Mouse_4:41) | 18/37 |
| [obj_audio_control](objects/obj_audio_control/obj_audio_control.yy) | - | spr_marker_event | Create_0, Destroy_0 | 14 | - | 15/31 |
| [obj_auh_or](objects/obj_auh_or/obj_auh_or.yy) | obj_parent_sound_o | spr_square | Create_0 | 4 | - | 14/33 |
| [obj_auh_snd_res](objects/obj_auh_snd_res/obj_auh_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_autoavance](objects/obj_autoavance/obj_autoavance.yy) | obj_panelparent | spr_panel_autoavance_anim | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0, Step_1 | 103 | instance_create(Other_7:5 ×5), scr_language(Draw_0:18 ×5) | 20/39 |
| [obj_autoscroll](objects/obj_autoscroll/obj_autoscroll.yy) | - | spr_marker_event | Alarm_0, Create_0, Step_0 | 58 | instance_create(Step_0:15 ×3) | 16/32 |
| [obj_axe_smw](objects/obj_axe_smw/obj_axe_smw.yy) | - | spr_axe_smw | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_10, Step_0 | 309 | init_shake(Step_0:10), instance_create(Alarm_3:13 ×24), scr_restart(Alarm_3:9), scr_snd_thwomp(Step_0:9) | 24/40 |
| [obj_banzaibill](objects/obj_banzaibill/obj_banzaibill.yy) | obj_deactenemyparent | spr_banzaibill | Alarm_0, Alarm_10, Collision_obj_blockparent, Create_0, Draw_0, Other_10, Other_11, Step_0 | 193 | instance_create(Alarm_0:4 ×7) | 21/43 |
| [obj_beachkoopa](objects/obj_beachkoopa/obj_beachkoopa.yy) | obj_deactenemyparent | spr_beachkoopa | Alarm_10, Alarm_11, Collision_obj_blockparent, Collision_obj_mario, Collision_obj_shell, Create_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Step_0 | 218 | instance_create(Collision_obj_mario:7 ×6) | 25/44 |
| [obj_beachkoopa_b](objects/obj_beachkoopa_b/obj_beachkoopa_b.yy) | obj_beachkoopa | spr_beachkoopa_b | Alarm_10, Collision_obj_shell, Other_10, Other_11, Other_13, Step_0 | 178 | instance_create(Other_10:1 ×5) | 19/38 |
| [obj_beachkoopa_red](objects/obj_beachkoopa_red/obj_beachkoopa_red.yy) | obj_beachkoopa | spr_beachkoopa_red | Alarm_10, Collision_obj_shell, Other_10, Other_13, Step_0 | 121 | instance_create(Other_10:1 ×3) | 18/37 |
| [obj_beachkoopa_red_b](objects/obj_beachkoopa_red_b/obj_beachkoopa_red_b.yy) | obj_beachkoopa_b | spr_beachkoopa_red_b | Alarm_10, Collision_obj_shell, Other_13 | 83 | - | 16/35 |
| [obj_beanstalk](objects/obj_beanstalk/obj_beanstalk.yy) | obj_deactivation | spr_beanstalk | Alarm_0, Alarm_1, Alarm_2, Collision_obj_solid, Collision_obj_solidtop, Create_0, Draw_0, Step_0 | 108 | instance_create(Alarm_0:2) | 21/43 |
| [obj_bebe_or](objects/obj_bebe_or/obj_bebe_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_bebe_snd_res](objects/obj_bebe_snd_res/obj_bebe_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_bg1](objects/obj_bg1/obj_bg1.yy) | - | spr_cards_entorno | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Other_11 | 790 | __background_set(Other_10:1 ×159), instance_create(Mouse_4:21 ×4), scr_anim_hover(Draw_0:6), scr_bg_airship(Other_10:129), scr_bg_beach(Other_10:283), scr_bg_castle(Other_10:57), scr_bg_desert(Other_10:203), scr_bg_fall(Other_10:259), scr_bg_forest(Other_10:155), scr_bg_ghost_house(Other_10:84 ×2), scr_bg_ground(Other_10:30), scr_bg_mountain(Other_10:324), scr_bg_sky(Other_10:181), scr_bg_snow(Other_10:239), scr_bg_underground(Other_10:39), scr_bg_underwater(Other_10:66), scr_create_bg_anim(Other_10:335), scr_snd_airship(Other_10:130), scr_snd_autumn(Other_10:260), scr_snd_beach(Other_10:284), scr_snd_castle(Other_10:58), scr_snd_desert(Other_10:204), scr_snd_editor_airship(Other_10:131), scr_snd_editor_castle(Other_10:59), scr_snd_editor_desert(Other_10:205), scr_snd_editor_forest(Other_10:157 ×2), scr_snd_editor_ghost(Other_10:89), scr_snd_editor_ground(Other_10:32 ×2), scr_snd_editor_mountain(Other_10:326), scr_snd_editor_sky(Other_10:183), scr_snd_editor_snow(Other_10:241), scr_snd_editor_underground(Other_10:41), scr_snd_editor_underwater(Other_10:68), scr_snd_forest(Other_10:156), scr_snd_ghost_house(Other_10:88), scr_snd_ground(Other_10:31), scr_snd_mountain(Other_10:325), scr_snd_sky(Other_10:182), scr_snd_snow(Other_10:240), scr_snd_underground(Other_10:40), scr_snd_underwater(Other_10:67) | 20/36 |
| [obj_bg_selection](objects/obj_bg_selection/obj_bg_selection.yy) | obj_panelparent | spr_panel_entorno_anim | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0 | 148 | instance_create(Other_7:5 ×14), scr_language(Draw_0:14 ×2) | 19/38 |
| [obj_bganimator](objects/obj_bganimator/obj_bganimator.yy) | - | - | Alarm_0, Create_0 | 89 | __background_set(Alarm_0:63 ×3), action_set_motion(Alarm_0:81) | 15/31 |
| [obj_big_plant_b_dead](objects/obj_big_plant_b_dead/obj_big_plant_b_dead.yy) | obj_big_plant_dead | spr_NSMBU_big_pplant_dead_b | Create_0, Other_7 | 2 | - | 15/34 |
| [obj_big_plant_dead](objects/obj_big_plant_dead/obj_big_plant_dead.yy) | - | spr_NSMBU_big_pplant_dead | Create_0, Other_7 | 2 | - | 15/31 |
| [obj_big_pplant](objects/obj_big_pplant/obj_big_pplant.yy) | obj_deactenemyparent | spr_NSMBU_big_pplant | Alarm_11, Alarm_2, Create_0, Draw_0, Other_10, Step_0 | 42 | - | 19/38 |
| [obj_big_pplant_b](objects/obj_big_pplant_b/obj_big_pplant_b.yy) | obj_big_pplant | spr_NSMBU_big_pplant_b | Create_0, Other_10 | 29 | - | 15/34 |
| [obj_big_pplant_b_res](objects/obj_big_pplant_b_res/obj_big_pplant_b_res.yy) | obj_parent_resource | spr_big_pplant_b_res | Create_0, Draw_0, Other_10, Other_13, Other_14, Step_2 | 81 | instance_create(Other_10:1 ×2), outside_view(Draw_0:1), scr_snd_powerdown(Other_13:1) | 19/38 |
| [obj_big_pplant_res](objects/obj_big_pplant_res/obj_big_pplant_res.yy) | obj_parent_resource | spr_big_pplant_res | Create_0, Draw_0, Other_10, Other_13, Other_14, Step_2 | 81 | instance_create(Other_10:1 ×2), outside_view(Draw_0:1), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_billbanzai_red](objects/obj_billbanzai_red/obj_billbanzai_red.yy) | obj_banzaibill | spr_billbanzai_red | Alarm_2, Alarm_3, Create_0, Draw_0, Other_11, Step_0 | 57 | instance_create(Other_11:1) | 19/38 |
| [obj_billbanzai_red_res](objects/obj_billbanzai_red_res/obj_billbanzai_red_res.yy) | obj_parent_resource | spr_billbanzai_red_res | Alarm_1, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Step_1, Step_2 | 132 | instance_create(Mouse_4:45 ×4) | 21/40 |
| [obj_billbanzai_res](objects/obj_billbanzai_res/obj_billbanzai_res.yy) | obj_parent_resource | spr_banzaibill | Alarm_1, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Step_1, Step_2 | 197 | instance_create(Mouse_4:45 ×4) | 21/40 |
| [obj_bl2](objects/obj_bl2/obj_bl2.yy) | - | spr_bt_lg | Create_0, Mouse_10, Mouse_11, Mouse_4 | 72 | - | 17/33 |
| [obj_blend_ring](objects/obj_blend_ring/obj_blend_ring.yy) | - | spr_blend_ring | Create_0, Draw_0, Step_0 | 35 | gpu_set_blendmode(Draw_0:4 ×2) | 16/32 |
| [obj_block](objects/obj_block/obj_block.yy) | obj_blockparent | spr_qblock | Alarm_1, Create_0, Draw_0, Other_10 | 228 | draw_sprite_custom_origin(Draw_0:6), instance_create(Alarm_1:9 ×4), scr_constant_get_sprite(Alarm_1:11 ×3) | 17/39 |
| [obj_block_coinchain](objects/obj_block_coinchain/obj_block_coinchain.yy) | obj_blockparent | spr_qblock | Alarm_1, Create_0, Other_11 | 21 | instance_create(Alarm_1:3 ×2) | 16/38 |
| [obj_block_gold](objects/obj_block_gold/obj_block_gold.yy) | obj_block_multicoin | spr_flipblock_gold | Alarm_1, Create_0, Draw_0, Other_10 | 100 | draw_sprite_custom_origin(Draw_0:6), instance_create(Alarm_1:7 ×10) | 17/39 |
| [obj_block_gold_res](objects/obj_block_gold_res/obj_block_gold_res.yy) | obj_parent_resource | spr_flipblock_gold | Other_10, Other_11, Step_2 | 43 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_block_hidden](objects/obj_block_hidden/obj_block_hidden.yy) | obj_deactivation | spr_block_hidden | Collision_obj_shell, Collision_obj_shell_held, Collision_obj_spinner, Create_0, Draw_0, Step_0 | 96 | instance_create(Collision_obj_shell:3 ×4) | 19/41 |
| [obj_block_hidden_res](objects/obj_block_hidden_res/obj_block_hidden_res.yy) | obj_parent_resource | spr_block_hidden | Collision_obj_parent_resource, Create_0, Draw_0, Other_12, Step_2 | 97 | outside_view(Draw_0:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 18/37 |
| [obj_block_ice](objects/obj_block_ice/obj_block_ice.yy) | obj_rockparent | spr_block_ice | Create_0 | 27 | - | 14/33 |
| [obj_block_multicoin](objects/obj_block_multicoin/obj_block_multicoin.yy) | obj_blockparent | spr_qblock | Alarm_1, Alarm_4, Create_0, Draw_0, Other_10, Other_11 | 147 | draw_sprite_custom_origin(Draw_0:7), instance_create(Other_10:1) | 19/41 |
| [obj_block_pow_active](objects/obj_block_pow_active/obj_block_pow_active.yy) | - | spr_pow_explode | Alarm_0, Create_0, Other_7 | 144 | instance_create(Alarm_0:70 ×3) | 16/32 |
| [obj_block_pow_hold](objects/obj_block_pow_hold/obj_block_pow_hold.yy) | obj_holdparent | spr_block_pow | Alarm_1, Collision_obj_blockparent, Collision_obj_boomboom, Collision_obj_enemyparent, Collision_obj_mario, Collision_obj_thwomp, Create_0, Destroy_0, Draw_0, Other_12, Other_13, Other_14, Other_16, Step_0, Step_1 | 536 | init_shake(Other_16:3), instance_create(Alarm_1:5 ×8), scr_canhold(Step_0:53), scr_snd_kick(Other_12:16 ×2) | 28/47 |
| [obj_block_res](objects/obj_block_res/obj_block_res.yy) | obj_parent_resource_block | spr_flipblock | Collision_obj_parent_resource, Create_0, Draw_0, Other_10, Other_11, Other_12, Step_2 | 124 | instance_create(Other_10:1 ×3), outside_view(Draw_0:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 20/39 |
| [obj_block_rock](objects/obj_block_rock/obj_block_rock.yy) | obj_rockparent | spr_block_rock | Create_0 | 139 | - | 14/33 |
| [obj_blockbumper](objects/obj_blockbumper/obj_blockbumper.yy) | - | spr_24mask | Alarm_0, Collision_obj_blockparent, Collision_obj_enemyparent, Create_0 | 39 | scr_musicalscale(Collision_obj_enemyparent:3) | 17/36 |
| [obj_blockcoin](objects/obj_blockcoin/obj_blockcoin.yy) | - | spr_coin | Alarm_0, Create_0, Step_0 | 107 | instance_create(Step_0:5 ×4), scr_snd_coin(Create_0:68 ×2) | 16/35 |
| [obj_blockparent](objects/obj_blockparent/obj_blockparent.yy) | obj_solid | spr_qblock | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Collision_obj_mario, Collision_obj_meteorites, Collision_obj_meteorites_big, Create_0, Draw_0, Other_11, Other_12, Other_13, Other_25, Step_0, Step_1 | 573 | draw_sprite_custom_origin(Draw_0:7), instance_create(Alarm_2:8 ×20), scr_snd_break(Alarm_2:148 ×4), scr_snd_kick(Alarm_2:7) | 28/50 |
| [obj_blooper](objects/obj_blooper/obj_blooper.yy) | obj_deactenemyparent | spr_blooper | Alarm_0, Alarm_1, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_11, Other_24, Step_0, Step_2 | 122 | instance_create(Other_10:1) | 23/45 |
| [obj_blooper_res](objects/obj_blooper_res/obj_blooper_res.yy) | obj_parent_resource | spr_blooper_res | Step_2 | 3 | - | 14/33 |
| [obj_blownbubble](objects/obj_blownbubble/obj_blownbubble.yy) | - | spr_bubble | Create_0, Step_0 | 6 | - | 15/34 |
| [obj_bobomb](objects/obj_bobomb/obj_bobomb.yy) | obj_deactenemyparent | spr_bobomb | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Other_17, Step_0 | 322 | instance_create(Destroy_0:5 ×10) | 22/44 |
| [obj_bobomb_hold](objects/obj_bobomb_hold/obj_bobomb_hold.yy) | obj_galoomba_hold | spr_bobomb_hold | Alarm_1, Alarm_2, Alarm_4, Create_0, Destroy_0, Other_10, Other_11, Step_0 | 128 | instance_create(Alarm_1:14 ×6) | 21/43 |
| [obj_bobomb_ready](objects/obj_bobomb_ready/obj_bobomb_ready.yy) | obj_bobomb | spr_bobomb_ready | Alarm_0, Alarm_1, Alarm_10, Create_0, Destroy_0, Other_10, Other_11 | 108 | instance_create(Alarm_0:1 ×5), outside_view(Create_0:20) | 20/39 |
| [obj_bobomb_ready_res](objects/obj_bobomb_ready_res/obj_bobomb_ready_res.yy) | obj_parent_resource | spr_bobomb_ready_res | Create_0, Other_10, Other_11, Other_14, Step_2 | 67 | instance_create(Other_10:1 ×5) | 18/37 |
| [obj_bobomb_res](objects/obj_bobomb_res/obj_bobomb_res.yy) | obj_parent_resource | spr_bobomb_res | Create_0, Other_10, Other_11, Step_2 | 74 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_bocina_or](objects/obj_bocina_or/obj_bocina_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_bocina_snd_res](objects/obj_bocina_snd_res/obj_bocina_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_bombilla_or](objects/obj_bombilla_or/obj_bombilla_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10, Step_0 | 20 | instance_create(Other_10:1) | 16/35 |
| [obj_bombilla_snd_res](objects/obj_bombilla_snd_res/obj_bombilla_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_bone](objects/obj_bone/obj_bone.yy) | obj_wrench | spr_bone | Create_0, Draw_0, Step_0 | 22 | - | 16/35 |
| [obj_bones_yoshi](objects/obj_bones_yoshi/obj_bones_yoshi.yy) | obj_brohammer_yoshi | spr_bone | Alarm_1, Alarm_2, Collision_obj_enemyparent, Collision_obj_shell, Create_0, Draw_0, Other_10, Step_0 | 56 | instance_create(Collision_obj_enemyparent:4 ×3) | 21/43 |
| [obj_bones_yoshi_one](objects/obj_bones_yoshi_one/obj_bones_yoshi_one.yy) | obj_brohammer_yoshi | spr_bone | Collision_obj_enemyparent, Collision_obj_shell, Create_0, Draw_0, Other_10, Step_0 | 53 | instance_create(Collision_obj_enemyparent:4 ×3) | 19/41 |
| [obj_bonus_or](objects/obj_bonus_or/obj_bonus_or.yy) | obj_parent_sound_o | spr_square | Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw, Create_0, Other_10 | 64 | instance_create(Other_10:1) | 19/38 |
| [obj_bonus_snd_res](objects/obj_bonus_snd_res/obj_bonus_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_13 | 7 | instance_create(Other_13:1) | 15/34 |
| [obj_bonus_trail](objects/obj_bonus_trail/obj_bonus_trail.yy) | - | spr_marker_event | Create_0, Draw_0, Step_0, Step_2 | 17 | - | 17/36 |
| [obj_bonybeetle](objects/obj_bonybeetle/obj_bonybeetle.yy) | obj_deactenemyparent | spr_bonybeetle | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Step_0, Step_2 | 290 | instance_create(Destroy_0:3 ×7), scr_snd_break(Other_10:1 ×2) | 25/47 |
| [obj_bonybeetle_b](objects/obj_bonybeetle_b/obj_bonybeetle_b.yy) | obj_bonybeetle | spr_bonybeetle_b | Alarm_0, Create_0, Other_10, Other_11, Step_2 | 200 | instance_create(Other_10:19 ×5), scr_snd_break(Other_10:1 ×2) | 18/37 |
| [obj_bonybeetle_b_res](objects/obj_bonybeetle_b_res/obj_bonybeetle_b_res.yy) | obj_parent_resource | spr_bonybeetle_b_res | Create_0, Draw_0, Other_10, Other_13, Other_14, Step_2 | 57 | instance_create(Other_10:1 ×3), scr_snd_powerdown(Other_13:1) | 19/38 |
| [obj_bonybeetle_res](objects/obj_bonybeetle_res/obj_bonybeetle_res.yy) | obj_parent_resource | spr_bonybeetle_res | Create_0, Draw_0, Other_10, Other_13, Other_14, Step_2 | 45 | instance_create(Other_10:1 ×2), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_boo](objects/obj_boo/obj_boo.yy) | obj_deactenemyparent | spr_boo | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Collision_obj_blockparent, Create_0, Destroy_0, Draw_0, Other_10, Other_15, Other_16, Other_18, Other_7, Step_0, Step_1, Step_2 | 419 | instance_create(Collision_obj_blockparent:6 ×5), outside_view(Other_18:36 ×6), scr_snd_kick(Collision_obj_blockparent:3 ×2) | 29/51 |
| [obj_boo_res](objects/obj_boo_res/obj_boo_res.yy) | obj_parent_resource | spr_boo_res | Create_0, Draw_0, Step_2 | 65 | outside_view(Draw_0:1) | 16/35 |
| [obj_boomboom](objects/obj_boomboom/obj_boomboom.yy) | obj_bossparent | spr_boomboom3 | Alarm_0, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_9, Create_0, Draw_0, Other_10, Other_11, Other_17, Other_7, Step_2 | 321 | instance_create(Other_10:3 ×7) | 27/49 |
| [obj_boomboom_b](objects/obj_boomboom_b/obj_boomboom_b.yy) | obj_boomboom | spr_boomboom_b | Alarm_10, Alarm_11, Alarm_3, Alarm_4, Alarm_9, Create_0, Other_11, Step_2 | 253 | instance_create(Other_11:16 ×4) | 21/40 |
| [obj_boomboom_b_res](objects/obj_boomboom_b_res/obj_boomboom_b_res.yy) | obj_parent_resource | spr_boomboom_res_b | Create_0, Other_10, Other_13, Step_2 | 22 | instance_create(Other_10:1 ×2), scr_snd_powerdown(Other_13:1) | 17/36 |
| [obj_boomboom_res](objects/obj_boomboom_res/obj_boomboom_res.yy) | obj_parent_resource | spr_boomboom_res | Create_0, Step_2 | 6 | - | 15/34 |
| [obj_boomerang](objects/obj_boomerang/obj_boomerang.yy) | - | spr_boomerang | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Collision_obj_mario, Create_0, Draw_0, Step_0 | 132 | outside_view(Step_0:63) | 22/38 |
| [obj_boomerangbro](objects/obj_boomerangbro/obj_boomerangbro.yy) | obj_hammerbro | spr_boomerangbro | Alarm_2, Alarm_3, Alarm_7, Create_0, Other_17, Other_7 | 195 | instance_create(Alarm_3:10 ×3) | 19/38 |
| [obj_boomerangbro_res](objects/obj_boomerangbro_res/obj_boomerangbro_res.yy) | obj_parent_resource | spr_boomerangbro_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 106 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_bortice](objects/obj_bortice/obj_bortice.yy) | obj_deactivation | spr_bortice_start | Collision_obj_holdparent, Collision_obj_mario, Collision_obj_muncher, Collision_obj_physicsparent, Collision_obj_thwomp, Create_0, Other_7, Step_0 | 154 | - | 21/40 |
| [obj_boss_or](objects/obj_boss_or/obj_boss_or.yy) | obj_parent_sound_o | spr_square | Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw, Create_0, Other_10 | 68 | instance_create(Other_10:1) | 19/38 |
| [obj_boss_snd_res](objects/obj_boss_snd_res/obj_boss_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_13 | 5 | instance_create(Other_13:1) | 15/34 |
| [obj_bossparent](objects/obj_bossparent/obj_bossparent.yy) | obj_physicsparent | spr_boomboom | Collision_obj_enemyparent_held, Collision_obj_fireball, Collision_obj_hammer, Collision_obj_icicle, Collision_obj_link_arrow, Collision_obj_link_atack, Collision_obj_link_dash_atack, Collision_obj_link_down_atack, Collision_obj_mario, Collision_obj_shell_held, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_superball, Collision_obj_yoshifire, Create_0, Other_11, Other_12, Other_16, Other_25, Step_0 | 515 | instance_create(Collision_obj_mario:20 ×2) | 33/55 |
| [obj_bouncycloud](objects/obj_bouncycloud/obj_bouncycloud.yy) | obj_solid | spr_mask16x64 | Create_0, Draw_0, Step_0 | 141 | - | 16/35 |
| [obj_bouncycloud_res](objects/obj_bouncycloud_res/obj_bouncycloud_res.yy) | obj_parent_resource | spr_bouncycloud_res | Create_0, Step_2 | 78 | - | 15/34 |
| [obj_bowser_dead](objects/obj_bowser_dead/obj_bowser_dead.yy) | - | spr_SMB_bowse_fire | Alarm_0, Create_0, Destroy_0, Draw_0, Step_0 | 98 | instance_create(Alarm_0:4 ×2) | 18/34 |
| [obj_bowser_dead_castle](objects/obj_bowser_dead_castle/obj_bowser_dead_castle.yy) | obj_enemy_dead_castle | spr_SMB_bowse_fire | Alarm_0, Alarm_1, Alarm_2, Step_0 | 82 | instance_create(Alarm_2:4 ×2) | 17/36 |
| [obj_bowser_fire](objects/obj_bowser_fire/obj_bowser_fire.yy) | - | spr_SMB3_fire_clown_big | Collision_obj_helmet, Collision_obj_invincibility, Collision_obj_kuribo_drybones, Collision_obj_mario, Collision_obj_shield_left, Collision_obj_shield_right, Create_0, Draw_0, Other_10, Other_40, Step_0 | 115 | instance_create(Other_10:1), scr_snd_bump(Collision_obj_helmet:1 ×4) | 24/40 |
| [obj_bowser_fire_down](objects/obj_bowser_fire_down/obj_bowser_fire_down.yy) | - | spr_bowserfire_down | Alarm_0, Collision_obj_blockparent, Collision_obj_helmet, Collision_obj_invincibility, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_14, Step_0 | 89 | instance_create(Other_10:1), scr_bg_underwater(Other_14:40) | 23/39 |
| [obj_bowser_res](objects/obj_bowser_res/obj_bowser_res.yy) | obj_parent_resource | spr_bowser_res | Create_0, Step_2 | 9 | - | 15/34 |
| [obj_bowserfire_up](objects/obj_bowserfire_up/obj_bowserfire_up.yy) | obj_bowser_fire | spr_bowserfire_up | Alarm_0, Create_0, Draw_0, Other_11, Step_0 | 63 | instance_create(Alarm_0:3 ×20) | 18/37 |
| [obj_bowserjr](objects/obj_bowserjr/obj_bowserjr.yy) | obj_bossparent | spr_SMB_bowserjr_walk | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_7, Alarm_8, Alarm_9, Create_0, Draw_0, Other_10, Other_11, Other_14, Other_7, Step_0, Step_2 | 666 | instance_create(Alarm_11:8 ×20), scr_snd_thwomp(Other_14:22) | 31/50 |
| [obj_bowserjr_dead_castle](objects/obj_bowserjr_dead_castle/obj_bowserjr_dead_castle.yy) | obj_bowser_dead_castle | spr_SMB_bowserjr_walk | Alarm_0, Alarm_1 | 47 | - | 15/34 |
| [obj_bowserjr_fire](objects/obj_bowserjr_fire/obj_bowserjr_fire.yy) | obj_bowser_fire | spr_bowserjr_fireball | Create_0, Draw_0, Step_0 | 29 | - | 16/35 |
| [obj_bowserjr_res](objects/obj_bowserjr_res/obj_bowserjr_res.yy) | obj_parent_resource | spr_bowserjr_res | Create_0, Other_10, Step_2 | 31 | instance_create(Other_10:1) | 16/35 |
| [obj_bowserjr_shell](objects/obj_bowserjr_shell/obj_bowserjr_shell.yy) | obj_deactenemyparent | spr_SMB_bowserjr_shell | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Create_0, Other_10, Other_11, Other_13, Other_16, Other_7, Step_0, Step_2 | 333 | instance_create(Alarm_1:13 ×14), scr_musicalscale(Collision_obj_enemyparent:14), scr_musicalscale_SMB3(Collision_obj_enemyparent:8 ×2), scr_musicalscale_kick(Collision_obj_enemyparent:17), scr_snd_bump(Other_13:40 ×2), scr_snd_kick(Collision_obj_enemyparent_held:3) | 28/47 |
| [obj_brickhelmet](objects/obj_brickhelmet/obj_brickhelmet.yy) | - | spr_brickhelmet | Alarm_4, Collision_obj_mario, Create_0, Draw_0, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_22, Other_23, Step_0, Step_2 | 1038 | instance_create(Alarm_4:5 ×3), scr_marioclimb(Other_16:14 ×3), scr_marioduck(Other_23:79 ×2) | 27/43 |
| [obj_brohammer](objects/obj_brohammer/obj_brohammer.yy) | - | spr_hammer | Collision_obj_invincibility, Collision_obj_mario, Create_0, Draw_0, Other_10, Step_0 | 95 | instance_create(Other_10:1 ×3) | 19/38 |
| [obj_brohammer_yoshi](objects/obj_brohammer_yoshi/obj_brohammer_yoshi.yy) | - | spr_hammer | Collision_obj_enemyparent, Collision_obj_enemyparent_held, Create_0, Draw_0, Other_10, Step_0 | 68 | instance_create(Collision_obj_enemyparent:5 ×3) | 19/38 |
| [obj_bt_close_water](objects/obj_bt_close_water/obj_bt_close_water.yy) | - | spr_button_close | Create_0, Draw_0, Mouse_4, Step_2 | 34 | - | 17/33 |
| [obj_bt_gb_close](objects/obj_bt_gb_close/obj_bt_gb_close.yy) | - | spr_button_close | Alarm_0, Create_0, Mouse_4 | 18 | - | 16/32 |
| [obj_bt_gb_delete](objects/obj_bt_gb_delete/obj_bt_gb_delete.yy) | - | spr_bt_delete | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 40 | scr_anim_hover(Draw_0:5) | 20/36 |
| [obj_bt_gb_edit](objects/obj_bt_gb_edit/obj_bt_gb_edit.yy) | obj_bt_gb_play | spr_bt_play | Alarm_1, Create_0, Mouse_10, Mouse_4, Step_2 | 33 | scr_language(Create_0:3) | 18/37 |
| [obj_bt_gb_play](objects/obj_bt_gb_play/obj_bt_gb_play.yy) | - | spr_bt_play | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 53 | scr_anim_hover(Draw_0:11), scr_language(Create_0:5) | 20/36 |
| [obj_bt_rename](objects/obj_bt_rename/obj_bt_rename.yy) | - | spr_bt_rename | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 46 | scr_anim_hover(Draw_0:10) | 18/34 |
| [obj_btn_header_1](objects/obj_btn_header_1/obj_btn_header_1.yy) | obj_btn_header_parent | spr_header_icons | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 58 | instance_create(Mouse_4:8), scr_anim_hover(Draw_0:4) | 19/38 |
| [obj_btn_header_2](objects/obj_btn_header_2/obj_btn_header_2.yy) | obj_btn_header_parent | spr_header_icons | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 57 | instance_create(Mouse_4:8), scr_anim_hover(Draw_0:4) | 19/38 |
| [obj_btn_header_3](objects/obj_btn_header_3/obj_btn_header_3.yy) | obj_btn_header_parent | spr_header_icons | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 61 | instance_create(Mouse_4:8), scr_anim_hover(Draw_0:4) | 19/38 |
| [obj_btn_header_4](objects/obj_btn_header_4/obj_btn_header_4.yy) | obj_btn_header_parent | spr_header_icons | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 55 | instance_create(Mouse_4:8), scr_anim_hover(Draw_0:4) | 19/38 |
| [obj_btn_header_parent](objects/obj_btn_header_parent/obj_btn_header_parent.yy) | - | - | Create_0, Draw_0, Mouse_10, Mouse_11 | 78 | scr_anim_hover(Draw_0:4) | 17/33 |
| [obj_btn_iniciar](objects/obj_btn_iniciar/obj_btn_iniciar.yy) | obj_button_parent | spr_btn_online | Draw_0, Mouse_4 | 2 | - | 15/34 |
| [obj_btn_invitado](objects/obj_btn_invitado/obj_btn_invitado.yy) | obj_button_parent | spr_btn_invite | Create_0, Draw_0, Mouse_4 | 14 | instance_create(Mouse_4:2), scr_language(Create_0:3) | 16/35 |
| [obj_btn_reload](objects/obj_btn_reload/obj_btn_reload.yy) | - | spr_gb_button_reload | Alarm_0, Create_0, Mouse_4 | 7 | - | 16/32 |
| [obj_btn_settings_hd](objects/obj_btn_settings_hd/obj_btn_settings_hd.yy) | - | spr_settings_btn_hd | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 52 | scr_anim_hover(Draw_0:8) | 18/34 |
| [obj_btn_social](objects/obj_btn_social/obj_btn_social.yy) | - | spr_social | Create_0, Mouse_10, Mouse_11, Mouse_4 | 14 | - | 17/33 |
| [obj_bubble](objects/obj_bubble/obj_bubble.yy) | - | spr_bubble | Create_0, Other_10, Other_7, Step_0 | 12 | - | 17/36 |
| [obj_bullebill_base](objects/obj_bullebill_base/obj_bullebill_base.yy) | obj_physicsparent | spr_SMB_bulletbill_base | Alarm_0, Alarm_1, Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_mario, Collision_obj_powerupparent, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_24, Step_0 | 555 | instance_create(Alarm_0:24 ×16), scr_constant_get_sprite(Other_11:13 ×2), scr_snd_kick(Collision_obj_bossparent:7 ×6), scr_sprite_make_object(Other_11:38 ×2) | 31/50 |
| [obj_bullebill_base_red](objects/obj_bullebill_base_red/obj_bullebill_base_red.yy) | obj_bullebill_base | spr_SMB_bulletbill_base_red | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Step_0 | 353 | instance_create(Alarm_0:29 ×13), scr_constant_get_sprite(Other_11:18 ×2), scr_sprite_make_object(Other_11:43 ×2) | 22/41 |
| [obj_bullebill_base_red_res](objects/obj_bullebill_base_red_res/obj_bullebill_base_red_res.yy) | obj_parent_resource | spr_SMB_bulletbill_base_red | Alarm_3, Alarm_5, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Step_2 | 223 | instance_create(Collision_obj_parent_resource:8 ×6), scr_insideview(Mouse_4:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:19) | 23/42 |
| [obj_bullebill_base_res](objects/obj_bullebill_base_res/obj_bullebill_base_res.yy) | obj_parent_resource | spr_SMB_bulletbill_base | Alarm_3, Alarm_5, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Step_2 | 231 | instance_create(Collision_obj_parent_resource:8 ×6), scr_insideview(Mouse_4:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:19) | 23/42 |
| [obj_bulletbill](objects/obj_bulletbill/obj_bulletbill.yy) | obj_enemyparent | spr_bulletbill | Alarm_0, Alarm_1, Collision_obj_blockparent, Create_0, Draw_0, Other_10, Other_11, Other_40, Step_0 | 148 | instance_create(Alarm_1:5 ×7) | 22/44 |
| [obj_bulletbull_red](objects/obj_bulletbull_red/obj_bulletbull_red.yy) | obj_enemyparent | spr_bulletbill_red | Alarm_0, Alarm_2, Alarm_3, Collision_obj_blockparent, Create_0, Draw_0, Other_10, Other_11, Step_0 | 112 | instance_create(Other_10:1 ×3), outside_view(Step_0:18) | 22/44 |
| [obj_bumper](objects/obj_bumper/obj_bumper.yy) | obj_deactivation | spr_bumper | Alarm_0, Collision_obj_clown, Collision_obj_mario, Create_0, Draw_0, Step_0 | 124 | - | 19/38 |
| [obj_bumper_res](objects/obj_bumper_res/obj_bumper_res.yy) | obj_parent_resource | spr_bumper_res | Create_0, Step_2 | 6 | - | 15/34 |
| [obj_button_autoavance](objects/obj_button_autoavance/obj_button_autoavance.yy) | obj_button_parent | spr_button_autoavance_bg | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 58 | scr_anim_hover(Draw_0:11), scr_language(Create_0:5) | 19/38 |
| [obj_button_back](objects/obj_button_back/obj_button_back.yy) | - | spr_back_button_white | Mouse_4 | 0 | - | 14/30 |
| [obj_button_close](objects/obj_button_close/obj_button_close.yy) | - | spr_button_close | Create_0, Mouse_4 | 25 | - | 15/31 |
| [obj_button_close_menu](objects/obj_button_close_menu/obj_button_close_menu.yy) | obj_button_close | spr_button_close | Create_0, Mouse_4 | 24 | - | 15/34 |
| [obj_button_creditos](objects/obj_button_creditos/obj_button_creditos.yy) | - | spr_settings_button_credito | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 26 | scr_anim_hover(Draw_0:5) | 18/34 |
| [obj_button_home](objects/obj_button_home/obj_button_home.yy) | - | spr_buttons_plays | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 170 | instance_create(Mouse_4:34 ×2), scr_anim_hover(Draw_0:35 ×2), scr_language(Draw_0:41 ×2), scr_stop_effect_sounds(Mouse_4:15) | 21/37 |
| [obj_button_meteoritos](objects/obj_button_meteoritos/obj_button_meteoritos.yy) | - | spr_button_meteoritos_active_1 | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 47 | scr_anim_hover(Draw_0:6) | 19/35 |
| [obj_button_notification_aceptar](objects/obj_button_notification_aceptar/obj_button_notification_aceptar.yy) | obj_button_parent | spr_bt_parent | Alarm_0, Create_0, Mouse_4, Other_10 | 278 | SaveStringToFile(Other_10:215), instance_create(Mouse_4:12), scr_language(Alarm_0:8 ×6), scr_toast(Alarm_0:8 ×6), sha1_string_utf8_hmac(Other_10:213) | 17/36 |
| [obj_button_notification_cancelar](objects/obj_button_notification_cancelar/obj_button_notification_cancelar.yy) | obj_button_close | spr_button_close | Create_0, Mouse_4 | 14 | - | 15/34 |
| [obj_button_ok](objects/obj_button_ok/obj_button_ok.yy) | obj_button_parent | spr_bt_aceptar_autoscroll | Alarm_0, Create_0, Draw_0, KeyPress_13, Mouse_4 | 69 | scr_anim_hover(Draw_0:10), scr_language(Create_0:2) | 18/37 |
| [obj_button_parent](objects/obj_button_parent/obj_button_parent.yy) | - | spr_bt_parent | Create_0, Draw_0, Mouse_10, Mouse_11 | 39 | scr_anim_hover(Draw_0:10), scr_language(Create_0:4) | 17/33 |
| [obj_button_save_changes](objects/obj_button_save_changes/obj_button_save_changes.yy) | - | spr_button_save_changes | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10 | 317 | SaveStringToFile(Other_10:215), instance_create(Mouse_4:10), scr_anim_hover(Draw_0:14), scr_language(Alarm_0:8 ×4), scr_toast(Alarm_0:8 ×3), sha1_string_utf8_hmac(Other_10:213) | 20/36 |
| [obj_button_save_load](objects/obj_button_save_load/obj_button_save_load.yy) | - | spr_button_save | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 66 | instance_create(Mouse_4:11 ×2), scr_anim_hover(Draw_0:10), scr_language(Draw_0:17 ×2) | 18/34 |
| [obj_button_sdog](objects/obj_button_sdog/obj_button_sdog.yy) | - | spr_card_multiplayer | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 39 | scr_anim_hover(Draw_0:4) | 19/35 |
| [obj_button_settings_close](objects/obj_button_settings_close/obj_button_settings_close.yy) | obj_button_parent | spr_bt_parent | Alarm_2, Create_0, Mouse_4 | 37 | scr_language(Create_0:3) | 16/35 |
| [obj_button_settings_close2](objects/obj_button_settings_close2/obj_button_settings_close2.yy) | obj_button_parent | spr_bt_parent | Alarm_2, Create_0, Mouse_4 | 37 | scr_language(Create_0:3) | 16/35 |
| [obj_button_settings_controls](objects/obj_button_settings_controls/obj_button_settings_controls.yy) | - | spr_settings_button_activate | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 41 | scr_anim_hover(Draw_0:8), scr_language(Create_0:7 ×4) | 18/34 |
| [obj_button_settings_estrella](objects/obj_button_settings_estrella/obj_button_settings_estrella.yy) | - | spr_settings_button_activate | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 48 | scr_anim_hover(Draw_0:8), scr_language(Create_0:9 ×4) | 18/34 |
| [obj_button_settings_idioma](objects/obj_button_settings_idioma/obj_button_settings_idioma.yy) | - | spr_settings_button_language | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 40 | scr_anim_hover(Draw_0:8), scr_language(Create_0:6 ×2) | 19/35 |
| [obj_button_settings_sm4j](objects/obj_button_settings_sm4j/obj_button_settings_sm4j.yy) | - | spr_settings_button_activate | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 42 | scr_anim_hover(Draw_0:8), scr_language(Create_0:7 ×4) | 18/34 |
| [obj_button_settings_sombras](objects/obj_button_settings_sombras/obj_button_settings_sombras.yy) | - | spr_settings_button_disabled | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 22 | scr_anim_hover(Draw_0:8) | 18/34 |
| [obj_button_sombras](objects/obj_button_sombras/obj_button_sombras.yy) | - | spr_settings_button_sombras | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 49 | scr_anim_hover(Draw_0:8) | 19/35 |
| [obj_button_speed_water](objects/obj_button_speed_water/obj_button_speed_water.yy) | - | spr_button_speed_water | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 31 | scr_anim_hover(Draw_0:5) | 19/35 |
| [obj_button_superado](objects/obj_button_superado/obj_button_superado.yy) | obj_button_parent | spr_bt_parent_white | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_4, Step_0 | 61 | scr_anim_hover(Draw_0:10), scr_language(Create_0:4 ×2) | 19/38 |
| [obj_button_time](objects/obj_button_time/obj_button_time.yy) | - | spr_button_time_up | Alarm_0, Create_0, Mouse_4 | 54 | - | 16/32 |
| [obj_button_trail](objects/obj_button_trail/obj_button_trail.yy) | - | spr_button_trail | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 39 | scr_anim_hover(Draw_0:4) | 19/35 |
| [obj_button_wings](objects/obj_button_wings/obj_button_wings.yy) | - | spr_window_button | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 90 | instance_create(Mouse_4:31), scr_anim_hover(Draw_0:7) | 18/34 |
| [obj_buzzy_ceiling](objects/obj_buzzy_ceiling/obj_buzzy_ceiling.yy) | obj_enemyparent | spr_shell_buzzy | Alarm_10, Create_0, Draw_0, Other_10, Other_11, Other_14, Other_24, Step_0 | 223 | instance_create(Other_10:1 ×4) | 21/43 |
| [obj_buzzy_shell_res](objects/obj_buzzy_shell_res/obj_buzzy_shell_res.yy) | obj_parent_resource | spr_shell_empty_res | Other_10, Other_11, Step_2 | 77 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_buzzybeetle](objects/obj_buzzybeetle/obj_buzzybeetle.yy) | obj_deactenemyparent | spr_buzzybeetle | Alarm_0, Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Other_18, Other_19, Step_0 | 518 | instance_create(Alarm_10:42 ×13) | 24/46 |
| [obj_buzzybeetle_b](objects/obj_buzzybeetle_b/obj_buzzybeetle_b.yy) | obj_buzzybeetle | spr_buzzybeetle_b | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Other_19, Step_0 | 493 | instance_create(Alarm_10:43 ×13) | 22/41 |
| [obj_buzzybeetle_b_res](objects/obj_buzzybeetle_b_res/obj_buzzybeetle_b_res.yy) | obj_parent_resource | spr_SMB_buzzybeetle_b_res | Create_0, Draw_0, Other_10, Other_13, Step_2 | 85 | instance_create(Other_10:1 ×3), scr_snd_powerdown(Other_13:1) | 18/37 |
| [obj_buzzybeetle_res](objects/obj_buzzybeetle_res/obj_buzzybeetle_res.yy) | obj_parent_resource | spr_buzzybeetle_res | Create_0, Draw_0, Other_10, Other_11, Other_13, Step_2 | 126 | instance_create(Other_10:1 ×4), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_call_mario](objects/obj_call_mario/obj_call_mario.yy) | - | spr_square | Alarm_0, Alarm_1, Create_0, Mouse_4 | 27 | instance_create(Mouse_4:7) | 17/33 |
| [obj_cannon](objects/obj_cannon/obj_cannon.yy) | obj_physicssolid | spr_cannon | Alarm_0, Alarm_1, Create_0, Draw_0, Other_10, Other_11, Other_14, Other_24, Step_0 | 309 | instance_create(Alarm_0:12 ×3), outside_view(Step_0:31), scr_snd_explode(Alarm_0:6 ×2) | 22/41 |
| [obj_cannon_red](objects/obj_cannon_red/obj_cannon_red.yy) | obj_cannon | spr_cannon_red | Alarm_0, Create_0, Other_10 | 71 | instance_create(Alarm_0:12 ×3), scr_snd_explode(Alarm_0:6 ×2) | 16/35 |
| [obj_cannon_red_res](objects/obj_cannon_red_res/obj_cannon_red_res.yy) | obj_parent_resource | spr_cannon_red | Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_24, Other_25, Step_2 | 237 | instance_create(Mouse_4:66 ×4), scr_insideview(Mouse_4:1) | 21/40 |
| [obj_cannon_res](objects/obj_cannon_res/obj_cannon_res.yy) | obj_parent_resource | spr_cannon | Alarm_1, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_24, Other_25, Step_2 | 242 | instance_create(Mouse_4:66 ×4), scr_insideview(Mouse_4:1) | 22/41 |
| [obj_cannonball](objects/obj_cannonball/obj_cannonball.yy) | obj_enemyparent | spr_cannonball | Alarm_0, Collision_obj_blockparent, Create_0, Other_10, Other_11, Other_40, Step_0 | 68 | instance_create(Other_10:1 ×2) | 20/42 |
| [obj_cannonball_red](objects/obj_cannonball_red/obj_cannonball_red.yy) | obj_cannonball | spr_cannonball | Create_0, Other_10, Other_11 | 30 | instance_create(Other_10:1 ×2) | 16/35 |
| [obj_cap](objects/obj_cap/obj_cap.yy) | obj_powerupparent | spr_cap | Alarm_0, Alarm_10, Collision_obj_mario, Create_0, Step_0 | 244 | instance_create(Collision_obj_mario:13 ×17), scr_snd_powerup(Collision_obj_mario:63) | 18/37 |
| [obj_cap_mario](objects/obj_cap_mario/obj_cap_mario.yy) | - | spr_cap_stay_start | Collision_obj_blockparent, Collision_obj_bowser_fire, Collision_obj_bowser_fire_down, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_spike_ball, Collision_obj_wrench, Create_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_7, Step_0, Step_2 | 507 | instance_create(Collision_obj_enemyparent:11), scr_mariogoal(Other_17:16), scr_mariohold(Other_16:35), scr_mariorunjump(Other_16:25), scr_marioswim(Other_16:30), scr_marioswimhold(Other_16:30), scr_snd_kick(Collision_obj_spike_ball:5 ×2) | 33/49 |
| [obj_cap_res](objects/obj_cap_res/obj_cap_res.yy) | obj_parent_resource | spr_cap_res | Create_0, Other_10, Other_13, Other_14, Step_2 | 105 | instance_create(Other_10:1 ×6) | 18/37 |
| [obj_card_autoavance](objects/obj_card_autoavance/obj_card_autoavance.yy) | obj_panelsparent | spr_panel_autoscroll | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 80 | instance_create(Mouse_4:16), scr_anim_hover(Draw_0:7) | 19/38 |
| [obj_card_bg](objects/obj_card_bg/obj_card_bg.yy) | obj_panelsparent | spr_card_bgs | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 129 | instance_create(Mouse_4:16), scr_anim_hover(Draw_0:7) | 19/38 |
| [obj_card_block_sounds](objects/obj_card_block_sounds/obj_card_block_sounds.yy) | obj_panelsparent | spr_card_block_blocks | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Other_11, Other_12, Step_0 | 230 | instance_create(Other_12:7), scr_anim_hover(Draw_0:5) | 22/41 |
| [obj_card_bout](objects/obj_card_bout/obj_card_bout.yy) | - | spr_card_bout | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 126 | instance_create(Mouse_4:6), scr_anim_hover(Draw_0:5) | 19/35 |
| [obj_card_circle](objects/obj_card_circle/obj_card_circle.yy) | - | spr_cards_SMB | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10 | 230 | - | 19/35 |
| [obj_card_condiciones](objects/obj_card_condiciones/obj_card_condiciones.yy) | obj_panelsparent | spr_panel_checkpoint | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 82 | instance_create(Mouse_4:16), scr_anim_hover(Draw_0:7) | 19/38 |
| [obj_card_item](objects/obj_card_item/obj_card_item.yy) | obj_parent_layout | spr_card_item | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 160 | outside_view(Draw_0:1) | 19/38 |
| [obj_card_logo](objects/obj_card_logo/obj_card_logo.yy) | - | spr_carteles | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Other_11, Step_0 | 656 | __background_set(Mouse_4:3 ×159), scr_anim_hover(Draw_0:6), scr_bg_airship(Mouse_4:118), scr_bg_beach(Mouse_4:254), scr_bg_castle(Mouse_4:55), scr_bg_desert(Mouse_4:183), scr_bg_fall(Mouse_4:233), scr_bg_forest(Mouse_4:164), scr_bg_ghost_house(Mouse_4:76 ×2), scr_bg_ground(Mouse_4:34), scr_bg_mountain(Mouse_4:293), scr_bg_sky(Mouse_4:141), scr_bg_snow(Mouse_4:216), scr_bg_underground(Mouse_4:40), scr_bg_underwater(Mouse_4:61), scr_create_bg_anim(Mouse_4:313), scr_snd_airship(Mouse_4:119), scr_snd_autumn(Mouse_4:234), scr_snd_beach(Mouse_4:255), scr_snd_castle(Mouse_4:56), scr_snd_desert(Mouse_4:184), scr_snd_editor_airship(Mouse_4:120), scr_snd_editor_castle(Mouse_4:57), scr_snd_editor_desert(Mouse_4:185), scr_snd_editor_forest(Mouse_4:166 ×2), scr_snd_editor_ghost(Mouse_4:81), scr_snd_editor_ground(Mouse_4:36 ×2), scr_snd_editor_mountain(Mouse_4:296), scr_snd_editor_sky(Mouse_4:143), scr_snd_editor_snow(Mouse_4:218), scr_snd_editor_underground(Mouse_4:42), scr_snd_editor_underwater(Mouse_4:63), scr_snd_forest(Mouse_4:165), scr_snd_ghost_house(Mouse_4:80), scr_snd_ground(Mouse_4:35), scr_snd_mountain(Mouse_4:295), scr_snd_sky(Mouse_4:142), scr_snd_snow(Mouse_4:217), scr_snd_underground(Mouse_4:41), scr_snd_underwater(Mouse_4:62) | 21/37 |
| [obj_card_rocket](objects/obj_card_rocket/obj_card_rocket.yy) | obj_parent_layout | spr_rocket | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Step_0 | 125 | instance_create(Step_0:18) | 21/40 |
| [obj_castle](objects/obj_castle/obj_castle.yy) | - | spr_castle_opendoor | Alarm_0, Create_0, Destroy_0, Draw_0, Other_7, Step_0 | 53 | instance_create(Create_0:19) | 19/35 |
| [obj_castle_floor](objects/obj_castle_floor/obj_castle_floor.yy) | obj_solidtop | spr_castle_floor | Alarm_0, Create_0, Step_0 | 13 | - | 16/35 |
| [obj_castle_front](objects/obj_castle_front/obj_castle_front.yy) | - | spr_castle_front | Collision_obj_player_goal_nsmbu, Collision_obj_player_goal_smb1, Create_0 | 7 | - | 16/32 |
| [obj_ccred](objects/obj_ccred/obj_ccred.yy) | - | spr_button_close | Create_0, Mouse_4 | 5 | - | 15/31 |
| [obj_cerdito_or](objects/obj_cerdito_or/obj_cerdito_or.yy) | obj_parent_sound_o | spr_square | Create_0 | 5 | - | 14/33 |
| [obj_cerdito_snd_res](objects/obj_cerdito_snd_res/obj_cerdito_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_chain_chomp_free](objects/obj_chain_chomp_free/obj_chain_chomp_free.yy) | obj_enemyparent | spr_chainchomp | Alarm_10, Create_0, Draw_0, Other_10, Step_0 | 119 | instance_create(Other_10:1 ×2), outside_view(Step_0:24) | 18/37 |
| [obj_chain_chomp_free_b](objects/obj_chain_chomp_free_b/obj_chain_chomp_free_b.yy) | obj_chain_chomp_free | spr_chainchomp_b | Create_0 | 55 | - | 14/33 |
| [obj_change_view](objects/obj_change_view/obj_change_view.yy) | - | spr_change_view | Draw_0, Mouse_4, Step_2 | 22 | - | 16/32 |
| [obj_charginchuck](objects/obj_charginchuck/obj_charginchuck.yy) | obj_deactenemyparent | spr_charginchuck | Alarm_0, Alarm_1, Alarm_10, Create_0, Draw_0, Other_10, Other_11, Other_18, Other_7, Step_0 | 348 | instance_create(Other_10:1 ×11), scr_snd_bump(Alarm_0:6 ×2), scr_snd_stomp(Other_11:1 ×2) | 23/45 |
| [obj_charginchuck_res](objects/obj_charginchuck_res/obj_charginchuck_res.yy) | obj_parent_resource | spr_charginchuck_res | Create_0, Other_10, Other_11, Step_2 | 23 | instance_create(Other_11:1 ×2) | 17/36 |
| [obj_checkpoint](objects/obj_checkpoint/obj_checkpoint.yy) | - | spr_flag_bowser | Collision_obj_mario, Collision_obj_shell_held, Create_0, Draw_0, Other_10, Other_11, Other_4, Other_7 | 411 | instance_create(Collision_obj_mario:57 ×2), scr_constant_get_sprite(Collision_obj_mario:65 ×2), scr_snd_getcheckpoint(Collision_obj_mario:1 ×4), scr_sprite_make_object(Collision_obj_mario:66 ×2) | 21/40 |
| [obj_checkpoint_res](objects/obj_checkpoint_res/obj_checkpoint_res.yy) | obj_parent_resource | spr_checkpoint_res | Alarm_1, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Step_2 | 99 | instance_create(Mouse_4:41), scr_insideview(Mouse_4:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 19/38 |
| [obj_cheepcheep](objects/obj_cheepcheep/obj_cheepcheep.yy) | obj_deactenemyparent | spr_cheepcheep | Alarm_0, Alarm_1, Alarm_10, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_24, Step_0 | 343 | instance_create(Alarm_1:1 ×8) | 24/46 |
| [obj_cheepcheep2](objects/obj_cheepcheep2/obj_cheepcheep2.yy) | obj_cheepcheep | spr_cheepcheep2 | Alarm_10, Alarm_2, Create_0, Other_10, Step_0 | 240 | instance_create(Other_10:1 ×5) | 18/37 |
| [obj_cheepcheep2_res](objects/obj_cheepcheep2_res/obj_cheepcheep2_res.yy) | obj_parent_resource | spr_cheepcheep2_res | Create_0, Other_10, Other_11, Step_2 | 44 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_cheepcheep_res](objects/obj_cheepcheep_res/obj_cheepcheep_res.yy) | obj_parent_resource | spr_cheepcheep_res | Create_0, Other_10, Other_11, Step_2 | 44 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_chisporreo_or](objects/obj_chisporreo_or/obj_chisporreo_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 15 | instance_create(Other_10:1) | 15/34 |
| [obj_chisporreteo_snd_res](objects/obj_chisporreteo_snd_res/obj_chisporreteo_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_chomp_b_res](objects/obj_chomp_b_res/obj_chomp_b_res.yy) | obj_parent_resource | spr_chainchomp_b_res | Create_0, Other_10, Other_13, Other_14, Step_2 | 23 | instance_create(Other_10:1 ×2), scr_snd_powerdown(Other_13:1) | 18/37 |
| [obj_chomp_res](objects/obj_chomp_res/obj_chomp_res.yy) | obj_parent_resource | spr_chainchomp_res | Other_10, Other_13, Other_14, Step_2 | 21 | instance_create(Other_10:1 ×2), scr_snd_powerup(Other_13:1) | 17/36 |
| [obj_cinta](objects/obj_cinta/obj_cinta.yy) | obj_cinta_parent | spr_SMB_cinta_left | Create_0, Draw_0, Step_0 | 88 | scr_snd_switchsong(Step_0:1) | 16/35 |
| [obj_cinta_on_res](objects/obj_cinta_on_res/obj_cinta_on_res.yy) | obj_parent_resource | spr_SMB_cinta_on_res | Alarm_3, Alarm_5, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Other_15, Step_2 | 272 | instance_create(Collision_obj_parent_resource:8 ×6) | 24/43 |
| [obj_cinta_parent](objects/obj_cinta_parent/obj_cinta_parent.yy) | obj_solid | spr_SMB_cinta_left | - | 0 | - | 12/31 |
| [obj_cinta_res](objects/obj_cinta_res/obj_cinta_res.yy) | obj_parent_resource | spr_SMB_cinta_res | Alarm_3, Alarm_5, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Other_15, Step_2 | 310 | instance_create(Collision_obj_parent_resource:8 ×6) | 24/43 |
| [obj_cinta_switch](objects/obj_cinta_switch/obj_cinta_switch.yy) | obj_cinta_parent | spr_SMB_cinta_on_left | Create_0, Draw_0, Step_0 | 123 | scr_snd_switchsong(Step_0:1) | 16/35 |
| [obj_claw](objects/obj_claw/obj_claw.yy) | obj_deactivation | spr_claw | Alarm_0, Alarm_1, Collision_obj_egg, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_mario, Collision_obj_muncher, Collision_obj_podoboo, Collision_obj_powerupparent, Collision_obj_shell_drybones_held, Collision_obj_shell_held, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_spring_land, Collision_obj_yoshi_abandon, Collision_obj_yoshi_runaway, Create_0, Draw_0, Other_10, Other_11, Step_0, Step_2 | 1006 | instance_create(Collision_obj_shell_drybones_held:6 ×6), outside_view(Step_2:209), scr_jump(Step_2:93), scr_snd_spinjump(Step_2:139) | 35/54 |
| [obj_claw_res](objects/obj_claw_res/obj_claw_res.yy) | obj_parent_resource | spr_claw_res | Create_0, Step_2 | 6 | - | 15/34 |
| [obj_climb](objects/obj_climb/obj_climb.yy) | obj_deactivation | spr_square_c | - | 0 | - | 12/34 |
| [obj_cloud_lakitu](objects/obj_cloud_lakitu/obj_cloud_lakitu.yy) | obj_deactivation | spr_cloud_latiku | Alarm_0, Alarm_1, Alarm_2, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_13, Other_14, Step_0, Step_2 | 338 | scr_jump(Step_0:97), scr_marioduck(Step_2:36), scr_marioduckhold(Step_2:25) | 24/43 |
| [obj_clown](objects/obj_clown/obj_clown.yy) | obj_physicsparent | spr_clown | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Collision_obj_boomboom, Collision_obj_clown, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_mario, Collision_obj_pinchos, Collision_obj_powerupparent, Create_0, Destroy_0, Draw_0, Other_10, Other_13, Other_14, Step_0, Step_2 [yy登记但无gml: Collision_(yy缺collisionObjectId).gml] | 661 | instance_create(Other_10:1 ×2), scr_jump(Step_0:89 ×2), scr_marioduck(Step_2:21), scr_marioduckhold(Step_2:10), scr_snd_clown_damage(Alarm_2:2 ×3), scr_snd_clown_fire_charge(Step_0:237), scr_snd_spinjump(Step_0:108 ×2) | 33/52 |
| [obj_clown_explotion](objects/obj_clown_explotion/obj_clown_explotion.yy) | obj_smoke | spr_clown_explotion | Collision_obj_block_ice, Collision_obj_block_rock, Collision_obj_blockparent, Collision_obj_enemyparent, Create_0 | 33 | instance_create(Collision_obj_enemyparent:4), scr_snd_kick(Collision_obj_enemyparent:3) | 18/37 |
| [obj_clown_fire](objects/obj_clown_fire/obj_clown_fire.yy) | obj_clown | spr_clown_fire | Alarm_4, Create_0, Destroy_0, Draw_0, Step_1 | 201 | instance_create(Alarm_4:3 ×9), scr_snd_clown_fire_charge(Destroy_0:2 ×3) | 18/37 |
| [obj_clown_fire_res](objects/obj_clown_fire_res/obj_clown_fire_res.yy) | obj_parent_resource | spr_clown_fire | Create_0, Draw_0, Other_10, Other_11, Step_1, Step_2 | 69 | instance_create(Other_10:1 ×3) | 19/38 |
| [obj_clown_res](objects/obj_clown_res/obj_clown_res.yy) | obj_parent_resource | spr_clown | Create_0, Draw_0, Other_10, Other_11, Step_1, Step_2 | 69 | instance_create(Other_10:1 ×3) | 19/38 |
| [obj_coin](objects/obj_coin/obj_coin.yy) | obj_deactivation | spr_coin | Alarm_10, Collision_obj_blockparent, Collision_obj_clown, Collision_obj_enemyparent_held, Collision_obj_link_arrow, Collision_obj_mario, Collision_obj_player_goal_parent, Collision_obj_shell_held, Collision_obj_spinner, Collision_obj_superball, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Step_2 | 340 | instance_create(Collision_obj_blockparent:3 ×11), scr_snd_coin(Other_11:1 ×4), scr_snd_switchsong(Step_2:3 ×2) | 30/52 |
| [obj_coin10](objects/obj_coin10/obj_coin10.yy) | obj_deactivation | spr_coin_10 | Collision_obj_enemyparent_held, Collision_obj_link_arrow, Collision_obj_mario, Collision_obj_player_goal_parent, Collision_obj_shell_held, Create_0, Draw_0, Other_10, Other_11, Other_12, Step_0 | 126 | instance_create(Other_10:8 ×2) | 24/46 |
| [obj_coin10_res](objects/obj_coin10_res/obj_coin10_res.yy) | obj_parent_resource | spr_coin_10 | Create_0, Other_10, Other_11, Step_2 | 128 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_coin30](objects/obj_coin30/obj_coin30.yy) | obj_coin10 | spr_coin_30 | Create_0 | 58 | - | 14/33 |
| [obj_coin30_res](objects/obj_coin30_res/obj_coin30_res.yy) | obj_parent_resource | spr_coin_30 | Create_0, Other_10, Other_11, Step_2 | 128 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_coin50](objects/obj_coin50/obj_coin50.yy) | obj_coin10 | spr_coin_50 | Create_0 | 58 | - | 14/33 |
| [obj_coin50_res](objects/obj_coin50_res/obj_coin50_res.yy) | obj_parent_resource | spr_coin_50 | Create_0, Other_10, Other_11, Step_2 | 128 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_coin_pow](objects/obj_coin_pow/obj_coin_pow.yy) | obj_physicsparent | spr_coin | Alarm_0, Alarm_1, Collision_obj_mario, Create_0, Draw_0, Other_14, Step_0 | 240 | instance_create(Collision_obj_mario:6 ×10), scr_snd_coin(Collision_obj_mario:3 ×2) | 20/39 |
| [obj_coin_pow_big](objects/obj_coin_pow_big/obj_coin_pow_big.yy) | obj_coin_pow | spr_coin_10 | - | 0 | - | 12/31 |
| [obj_coin_res](objects/obj_coin_res/obj_coin_res.yy) | obj_parent_resource | spr_coin | Create_0, Other_10, Other_11, Other_14, Step_2 | 133 | instance_create(Other_10:1 ×5) | 18/37 |
| [obj_coinchain](objects/obj_coinchain/obj_coinchain.yy) | - | spr_coin | Alarm_0, Alarm_1, Alarm_2, Collision_obj_slopeparent, Create_0, Other_0, Step_2 | 55 | instance_create(Alarm_0:5) | 20/39 |
| [obj_coinchange](objects/obj_coinchange/obj_coinchange.yy) | - | spr_coin | - | 0 | - | 12/31 |
| [obj_condiciones](objects/obj_condiciones/obj_condiciones.yy) | obj_panelparent | spr_panel_condiciones | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0, Step_1 | 115 | instance_create(Other_7:6 ×7), scr_language(Create_0:3 ×9) | 20/39 |
| [obj_condiciones_button](objects/obj_condiciones_button/obj_condiciones_button.yy) | - | spr_condiciones_button_up | Create_0, Mouse_4 | 28 | - | 15/31 |
| [obj_configurar_controles](objects/obj_configurar_controles/obj_configurar_controles.yy) | - | spr_st_btn_controls | Create_0, Destroy_0, Draw_0, Mouse_10, Mouse_11 | 17 | scr_language(Create_0:6) | 18/34 |
| [obj_configurar_controles_reset](objects/obj_configurar_controles_reset/obj_configurar_controles_reset.yy) | - | spr_st_btn_controls2 | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_1 | 24 | scr_anim_hover(Draw_0:5) | 19/35 |
| [obj_continue_btn](objects/obj_continue_btn/obj_continue_btn.yy) | obj_button_parent | spr_bt_parent | Alarm_0, Alarm_2, Create_0, Mouse_4 | 54 | scr_language(Create_0:3) | 17/36 |
| [obj_cooligan](objects/obj_cooligan/obj_cooligan.yy) | obj_deactenemyparent | spr_cooligan_idle | Alarm_0, Alarm_1, Create_0, Draw_0, Other_10, Other_11, Other_15, Other_25, Step_0, Step_1, Step_2 | 322 | instance_create(Other_10:1 ×4) | 24/46 |
| [obj_cooligan_res](objects/obj_cooligan_res/obj_cooligan_res.yy) | obj_parent_resource | spr_cooligan_fly | Create_0, Draw_0, Step_2 | 66 | draw_sprite_custom_origin(Draw_0:11), outside_view(Draw_0:1) | 16/35 |
| [obj_create_account](objects/obj_create_account/obj_create_account.yy) | - | spr_create_account | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 26 | scr_language(Create_0:5) | 18/34 |
| [obj_creation_preview](objects/obj_creation_preview/obj_creation_preview.yy) | - | spr_cursor_square | Create_0, Draw_0, Step_1 | 29 | scr_resources_get_sprite(Step_1:13) | 16/32 |
| [obj_creator_jugar_editar](objects/obj_creator_jugar_editar/obj_creator_jugar_editar.yy) | obj_parent_layout | spr_creator_play | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Other_11, Other_12, Other_13, Other_7, Step_0 | 473 | __background_set(Other_13:70 ×23), instance_create(Other_13:40 ×13), scr_anim_hover2(Draw_0:8), scr_edit_to_play(Other_13:31), scr_play_to_edit(Other_13:220), scr_reset_variables(Other_13:249), scr_stop_effect_sounds(Other_13:221) | 33/52 |
| [obj_crumblebones](objects/obj_crumblebones/obj_crumblebones.yy) | obj_enemyparent | spr_drybones_crumble | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Create_0, Draw_0, Other_10, Other_7 | 139 | instance_create(Alarm_3:1 ×5), scr_snd_break(Other_10:1 ×2) | 21/43 |
| [obj_crumblebony](objects/obj_crumblebony/obj_crumblebony.yy) | obj_crumblebones | spr_bonybeetle_crumble | Alarm_1, Alarm_3, Create_0, Other_10, Other_7, Step_2 | 135 | instance_create(Alarm_3:1 ×5), scr_snd_break(Other_10:1 ×2) | 19/38 |
| [obj_crumblebony_b](objects/obj_crumblebony_b/obj_crumblebony_b.yy) | obj_crumblebones | spr_bonybeetle_crumble_b | Alarm_1, Alarm_3, Create_0, Other_10, Other_7, Step_2 | 135 | instance_create(Alarm_3:1 ×5), scr_snd_break(Other_10:1 ×2) | 19/38 |
| [obj_crystalorb](objects/obj_crystalorb/obj_crystalorb.yy) | - | - | Collision_obj_mario, Create_0, Destroy_0, Draw_0 | 78 | instance_create(Collision_obj_mario:3 ×4), scr_snd_starman(Collision_obj_mario:9), scr_snd_switchsong(Collision_obj_mario:8) | 17/33 |
| [obj_cursor](objects/obj_cursor/obj_cursor.yy) | - | spr_cursor_inv | Alarm_0, Create_0, Draw_0, Mouse_50, Mouse_51, Mouse_53, Mouse_56, Mouse_57, Other_10, Other_11, Other_12, Other_13, Other_14, Step_1 | 537 | instance_create(Create_0:35 ×7), scr_insideview(Mouse_50:2 ×2) | 27/43 |
| [obj_curtainin](objects/obj_curtainin/obj_curtainin.yy) | - | spr_marker_event | Alarm_0, CleanUp_0, Create_0, Draw_0, Other_10, Step_0 | 51 | draw_circle_colour_precise(Step_0:9), gpu_set_blendmode(Draw_0:1 ×4) | 19/35 |
| [obj_curtainout](objects/obj_curtainout/obj_curtainout.yy) | - | spr_marker_event | CleanUp_0, Create_0, Draw_0, Other_10, Step_0 | 39 | background_create_from_surface(Create_0:2), draw_circle_colour_precise(Step_0:9), gpu_set_blendmode(Draw_0:1 ×4), instance_create(Other_10:8) | 18/34 |
| [obj_dcw](objects/obj_dcw/obj_dcw.yy) | - | - | Create_0, Destroy_0, Other_10 | 151 | - | 16/60 |
| [obj_deactenemyparent](objects/obj_deactenemyparent/obj_deactenemyparent.yy) | obj_enemyparent | spr_SMB3_goomba | - | 0 | - | 12/34 |
| [obj_deactivation](objects/obj_deactivation/obj_deactivation.yy) | - | spr_deactivation | - | 0 | - | 12/31 |
| [obj_deadmario](objects/obj_deadmario/obj_deadmario.yy) | - | spr_mario_dead | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Step_0 | 657 | instance_create(Alarm_0:42), scr_NSMBU_snd_dead(Create_0:5), scr_mariodead(Create_0:1), scr_music_link(Create_0:26), scr_restart(Alarm_1:17), scr_snd_dead(Create_0:7), scr_snd_skid(Create_0:28), scr_snd_starman(Create_0:25) | 20/39 |
| [obj_decoracion_1](objects/obj_decoracion_1/obj_decoracion_1.yy) | obj_decoracion_parent | spr_decoracion_1 | Other_13, Step_2 | 106 | instance_create(Other_13:1) | 15/34 |
| [obj_decoracion_2](objects/obj_decoracion_2/obj_decoracion_2.yy) | obj_decoracion_parent | spr_decoracion_2 | Other_13, Step_2 | 109 | instance_create(Other_13:1) | 15/34 |
| [obj_decoracion_3](objects/obj_decoracion_3/obj_decoracion_3.yy) | obj_decoracion_parent | spr_decoracion_3 | Other_13, Step_2 | 109 | instance_create(Other_13:1) | 15/34 |
| [obj_decoracion_4](objects/obj_decoracion_4/obj_decoracion_4.yy) | obj_decoracion_parent | spr_decoracion_4 | Other_13, Step_2 | 113 | instance_create(Other_13:1) | 15/34 |
| [obj_decoracion_parent](objects/obj_decoracion_parent/obj_decoracion_parent.yy) | obj_parent_save | - | Create_0, Draw_0, Other_0, Step_1 | 29 | - | 17/36 |
| [obj_destello_or](objects/obj_destello_or/obj_destello_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_destello_snd_res](objects/obj_destello_snd_res/obj_destello_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_detroy_enemy](objects/obj_detroy_enemy/obj_detroy_enemy.yy) | - | spr_destroy_enemy | Create_0, Other_7 | 4 | - | 15/31 |
| [obj_dog](objects/obj_dog/obj_dog.yy) | obj_parent_layout | spr_dog | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 41 | scr_anim_hover(Draw_0:5) | 19/38 |
| [obj_donut](objects/obj_donut/obj_donut.yy) | obj_platform_parent | spr_donut | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Alarm_3, Create_0, Draw_0, Other_10, Step_2 | 234 | instance_create(Alarm_0:5 ×3) | 22/44 |
| [obj_donut_res](objects/obj_donut_res/obj_donut_res.yy) | obj_parent_resource | spr_donut_res | Create_0, Other_10, Other_14, Step_2 | 65 | instance_create(Other_14:9 ×2) | 17/36 |
| [obj_door](objects/obj_door/obj_door.yy) | - | spr_door | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Create_0, Draw_0, Other_7, Step_0 | 160 | instance_create(Alarm_0:13 ×4), scr_snd_door_close(Other_7:26), scr_snd_door_open(Step_0:9) | 21/40 |
| [obj_door_exit](objects/obj_door_exit/obj_door_exit.yy) | - | spr_door | Alarm_0, Alarm_1, Alarm_3, Create_0, Draw_0, Other_7, Step_0 | 158 | instance_create(Alarm_0:13 ×3), scr_snd_door_close(Other_7:26), scr_snd_door_open(Step_0:9) | 20/36 |
| [obj_door_exit_res](objects/obj_door_exit_res/obj_door_exit_res.yy) | obj_parent_resource | spr_door | Create_0, Destroy_0, Draw_0, Step_2 | 48 | - | 17/36 |
| [obj_door_lock](objects/obj_door_lock/obj_door_lock.yy) | - | spr_doorlock_anim | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Create_0, Draw_0, Other_7, Step_0 | 311 | instance_create(Alarm_0:13 ×8), scr_snd_door_close(Other_7:18), scr_snd_door_open(Alarm_3:1 ×2) | 22/41 |
| [obj_door_lock_exit](objects/obj_door_lock_exit/obj_door_lock_exit.yy) | - | spr_doorlock_anim | Alarm_0, Alarm_1, Alarm_3, Alarm_4, Create_0, Draw_0, Other_7, Step_0 | 302 | instance_create(Alarm_0:13 ×7), scr_snd_door_close(Other_7:18), scr_snd_door_open(Alarm_3:1 ×2) | 21/37 |
| [obj_door_lock_exit_res](objects/obj_door_lock_exit_res/obj_door_lock_exit_res.yy) | obj_parent_resource | spr_door_lock_res | Create_0, Destroy_0, Draw_0, Step_2 | 30 | - | 17/36 |
| [obj_door_lock_res](objects/obj_door_lock_res/obj_door_lock_res.yy) | obj_parent_resource | spr_door_lock_res | Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_2 | 133 | instance_create(Alarm_1:1 ×6) | 20/39 |
| [obj_door_res](objects/obj_door_res/obj_door_res.yy) | obj_parent_resource | spr_door | Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_2 | 148 | instance_create(Alarm_1:1 ×6) | 20/39 |
| [obj_door_switch](objects/obj_door_switch/obj_door_switch.yy) | - | spr_door_switch | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Create_0, Draw_0, Other_7, Step_0 | 142 | instance_create(Alarm_0:13 ×4), scr_snd_door_close(Other_7:11), scr_snd_door_open(Step_0:13), scr_snd_switchsong(Step_0:1) | 21/40 |
| [obj_door_switch_exit](objects/obj_door_switch_exit/obj_door_switch_exit.yy) | - | spr_door_switch | Alarm_0, Alarm_1, Alarm_3, Create_0, Draw_0, Other_7, Step_0 | 136 | instance_create(Alarm_0:13 ×3), scr_snd_door_close(Other_7:11), scr_snd_door_open(Step_0:13), scr_snd_switchsong(Step_0:1) | 20/36 |
| [obj_door_switch_exit_res](objects/obj_door_switch_exit_res/obj_door_switch_exit_res.yy) | obj_parent_resource | spr_door_switch | Create_0, Destroy_0, Draw_0, Step_2 | 48 | - | 17/36 |
| [obj_door_switch_res](objects/obj_door_switch_res/obj_door_switch_res.yy) | obj_parent_resource | spr_door_switch | Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_2 | 148 | instance_create(Alarm_1:1 ×6) | 20/39 |
| [obj_doormario](objects/obj_doormario/obj_doormario.yy) | - | spr_mario_small_idle | Create_0, Draw_0 | 161 | scr_NSMBU_hold(Draw_0:88), scr_mario_drybones(Draw_0:60 ×2), scr_mario_shoe(Draw_0:68 ×4), scr_mariohold(Draw_0:90), scr_marioidle(Draw_0:95), scr_marioride(Draw_0:53) | 15/34 |
| [obj_doormario_exit](objects/obj_doormario_exit/obj_doormario_exit.yy) | - | spr_mario_small_idle | Alarm_0, Create_0, Draw_0 | 158 | instance_create(Alarm_0:8), scr_NSMBU_ground_idle(Draw_0:97), scr_NSMBU_hold_ground(Draw_0:89), scr_mario_drybones(Draw_0:60 ×2), scr_mario_shoe(Draw_0:68 ×4), scr_mariohold(Draw_0:93), scr_marioidle(Draw_0:101), scr_marioride(Draw_0:53) | 16/32 |
| [obj_drybones](objects/obj_drybones/obj_drybones.yy) | obj_deactenemyparent | spr_drybones | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_15, Other_7, Step_0 | 284 | instance_create(Destroy_0:3 ×8), scr_snd_break(Other_10:1) | 26/48 |
| [obj_drybones_res](objects/obj_drybones_res/obj_drybones_res.yy) | obj_parent_resource | spr_drybones_res | Create_0, Other_10, Other_11, Step_2 | 29 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_edit_menu](objects/obj_edit_menu/obj_edit_menu.yy) | - | spr_menu_editor | Create_0, Destroy_0, Draw_0, Step_0 | 72 | instance_create(Create_0:5 ×7) | 17/33 |
| [obj_editor_screen](objects/obj_editor_screen/obj_editor_screen.yy) | obj_play_screen | spr_creator_create_base | Create_0, Other_12 | 42 | scr_stop_effect_sounds(Other_12:10) | 15/34 |
| [obj_editormanager](objects/obj_editormanager/obj_editormanager.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, Other_10, Other_12, Other_13, Step_0, Step_1 | 1634 | __view_get(Step_1:13 ×51), __view_set(Step_1:76 ×12), instance_create(Alarm_1:12 ×11), scr_language(Draw_0:12 ×4) | 23/39 |
| [obj_efecto_musica](objects/obj_efecto_musica/obj_efecto_musica.yy) | - | spr_marker_event | Create_0, Draw_0, Step_2 | 35 | - | 16/32 |
| [obj_efecto_musica_bonus](objects/obj_efecto_musica_bonus/obj_efecto_musica_bonus.yy) | - | spr_marker_event | Alarm_0, Create_0, Draw_0, Step_2 | 28 | - | 17/33 |
| [obj_efecto_sonido](objects/obj_efecto_sonido/obj_efecto_sonido.yy) | - | spr_marker_event | Alarm_0, Create_0, Draw_0, Other_7, Step_2 | 35 | - | 18/34 |
| [obj_effect_link](objects/obj_effect_link/obj_effect_link.yy) | obj_smoke | spr_SMB_link_effect | Create_0, Draw_0, Step_0 | 43 | - | 16/38 |
| [obj_effect_touch](objects/obj_effect_touch/obj_effect_touch.yy) | - | spr_effect_touch | Create_0, Other_7 | 4 | - | 15/31 |
| [obj_egg](objects/obj_egg/obj_egg.yy) | obj_deactenemyparent | spr_egg | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_11, Other_17, Other_7, Step_0 | 484 | instance_create(Alarm_1:22 ×15) | 25/44 |
| [obj_egg_blue](objects/obj_egg_blue/obj_egg_blue.yy) | obj_egg | spr_egg_blue | Alarm_2, Draw_0 | 58 | instance_create(Alarm_2:10) | 15/34 |
| [obj_egg_hatch](objects/obj_egg_hatch/obj_egg_hatch.yy) | obj_physicsparent | spr_hatch | Alarm_0, Collision_obj_mario, Create_0, Draw_0, Other_7, Step_0 | 72 | instance_create(Collision_obj_mario:16 ×4) | 19/41 |
| [obj_egg_red](objects/obj_egg_red/obj_egg_red.yy) | obj_egg | spr_egg_red | Alarm_2, Draw_0 | 44 | instance_create(Alarm_2:10) | 15/34 |
| [obj_egg_red_res](objects/obj_egg_red_res/obj_egg_red_res.yy) | obj_parent_resource | spr_egg_red | Create_0, Other_10, Other_11, Other_13, Other_14, Other_7, Step_2 | 153 | instance_create(Other_10:3 ×8) | 20/39 |
| [obj_egg_res](objects/obj_egg_res/obj_egg_res.yy) | obj_parent_resource | spr_egg | Create_0, Other_10, Other_11, Other_13, Other_14, Other_7, Step_2 | 138 | instance_create(Other_10:3 ×7), scr_snd_powerup(Other_13:3) | 20/39 |
| [obj_enabledsolid](objects/obj_enabledsolid/obj_enabledsolid.yy) | obj_solid | spr_square | Create_0, Other_10, Step_0 | 109 | instance_create(Other_10:18 ×4) | 16/38 |
| [obj_enemy_dead](objects/obj_enemy_dead/obj_enemy_dead.yy) | - | spr_beachkoopa | Alarm_0, Create_0, Destroy_0, Draw_0, Step_0 | 118 | instance_create(Step_0:10 ×2) | 18/34 |
| [obj_enemy_dead_castle](objects/obj_enemy_dead_castle/obj_enemy_dead_castle.yy) | - | spr_beachkoopa_red | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 65 | instance_create(Step_0:4) | 18/34 |
| [obj_enemy_multidead](objects/obj_enemy_multidead/obj_enemy_multidead.yy) | - | - | Alarm_0, Create_0, Draw_0 | 19 | instance_create(Alarm_0:1) | 16/32 |
| [obj_enemyfrozen](objects/obj_enemyfrozen/obj_enemyfrozen.yy) | obj_enemyparent_held | spr_frozenblock_24x24 | Alarm_4, Alarm_5, Alarm_6, Alarm_7, Create_0, Destroy_0, Draw_0, Other_10, Other_13, Other_14, Other_18, Step_0, Step_1 | 474 | instance_create(Alarm_5:9 ×17), scr_canhold(Step_0:21) | 26/45 |
| [obj_enemyparent](objects/obj_enemyparent/obj_enemyparent.yy) | obj_physicsparent | spr_bulletbill | Alarm_10, Collision_obj_blockparent, Collision_obj_mario, Create_0, Other_10, Other_11, Other_12, Other_15, Other_16, Step_0, Step_1 | 479 | instance_create(Collision_obj_blockparent:9 ×26), scr_NSMBU_musicalscale_minirebote(Collision_obj_mario:179), scr_NSMBU_musicalscale_rebote(Collision_obj_mario:177), scr_NSMBU_spinstomp(Collision_obj_mario:101), scr_musicalscale(Collision_obj_mario:20 ×4), scr_musicalscale_kick(Collision_obj_mario:29), scr_snd_kick(Collision_obj_blockparent:3 ×6), scr_snd_stomp(Collision_obj_mario:61 ×6) | 24/46 |
| [obj_enemyparent_held](objects/obj_enemyparent_held/obj_enemyparent_held.yy) | obj_holdparent | spr_galoomba_hold | Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_explosion, Collision_obj_fireball, Collision_obj_invincibility, Collision_obj_shell_held, Create_0, Other_10, Other_17, Step_0, Step_2 [yy登记但无gml: Collision_(yy缺collisionObjectId).gml] | 450 | __view_get(Step_2:90 ×2), instance_create(Collision_obj_blockparent:6 ×17), scr_canhold(Step_0:12), scr_snd_kick(Collision_obj_blockparent:3 ×9) | 26/45 |
| [obj_enemyparent_lava](objects/obj_enemyparent_lava/obj_enemyparent_lava.yy) | - | spr_galoomba_hold | Alarm_0, Collision_obj_mario, Create_0, Draw_0, Step_0 | 34 | - | 18/34 |
| [obj_erase](objects/obj_erase/obj_erase.yy) | obj_parent_layout | spr_clean | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Step_0 | 89 | scr_anim_hover(Draw_0:5) | 22/41 |
| [obj_error_or](objects/obj_error_or/obj_error_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 13 | instance_create(Other_10:1) | 15/34 |
| [obj_error_snd_res](objects/obj_error_snd_res/obj_error_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_espina](objects/obj_espina/obj_espina.yy) | - | spr_spiny_espina | Alarm_0, Alarm_1, Collision_obj_mario, Create_0, Draw_0, Step_2 | 24 | - | 19/35 |
| [obj_etiquetas](objects/obj_etiquetas/obj_etiquetas.yy) | - | spr_etiquetas_bg | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_2 | 128 | scr_anim_hover(Draw_0:10), scr_language(Create_0:10 ×14) | 19/35 |
| [obj_expand](objects/obj_expand/obj_expand.yy) | obj_parent_layout | spr_card_expand | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 66 | instance_create(Mouse_4:7), scr_anim_hover(Draw_0:5) | 20/39 |
| [obj_expand_paneles_top](objects/obj_expand_paneles_top/obj_expand_paneles_top.yy) | - | spr_expand_panels_top | Create_0, Draw_0, Mouse_4, Step_0 | 31 | - | 17/33 |
| [obj_expand_panels](objects/obj_expand_panels/obj_expand_panels.yy) | - | spr_expand_panels | Create_0, Draw_0, Mouse_4, Step_0 | 31 | - | 17/33 |
| [obj_expand_panels_left](objects/obj_expand_panels_left/obj_expand_panels_left.yy) | - | spr_expand_panels_left | Create_0, Draw_0, Mouse_4, Step_0 | 38 | - | 17/33 |
| [obj_explosion](objects/obj_explosion/obj_explosion.yy) | - | spr_explosion | Collision_obj_block_ice, Collision_obj_block_pow_hold, Collision_obj_block_rock, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_mario, Collision_obj_onoffblock, Create_0, Draw_0, Other_7 | 99 | outside_view(Create_0:18), scr_musicalscale(Collision_obj_enemyparent:3), scr_snd_explode(Create_0:27 ×2) | 23/42 |
| [obj_fadein](objects/obj_fadein/obj_fadein.yy) | - | spr_marker_event | Create_0, Draw_0, Step_2 | 23 | background_create_from_surface(Create_0:2), gpu_set_blendenable(Draw_0:3 ×2), sprite_delete(Step_2:6), sprite_exists(Draw_0:1 ×2) | 16/32 |
| [obj_fadeout](objects/obj_fadeout/obj_fadeout.yy) | - | spr_marker_event | Create_0, Draw_0, Step_2 | 7 | - | 16/32 |
| [obj_fallow_view](objects/obj_fallow_view/obj_fallow_view.yy) | - | - | Step_0 | 6 | - | 14/30 |
| [obj_fast_lava_lift](objects/obj_fast_lava_lift/obj_fast_lava_lift.yy) | obj_lava_lift | spr_fast_lava_lift | Create_0, Other_11 | 70 | instance_create(Create_0:23 ×3) | 15/34 |
| [obj_fast_lava_lift_res](objects/obj_fast_lava_lift_res/obj_fast_lava_lift_res.yy) | obj_parent_resource | spr_fast_lava_lift_res | Create_0, Other_10, Other_11, Step_2 | 35 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_fire_clown](objects/obj_fire_clown/obj_fire_clown.yy) | obj_fire_clown_small | spr_fire_clown_big | Alarm_0, Collision_obj_bobomb, Collision_obj_boomboom, Collision_obj_enemyparent, Collision_obj_onoffblock, Create_0, Draw_0, Other_10, Step_0 | 63 | instance_create(Alarm_0:1 ×5), outside_view(Step_0:8), scr_musicalscale(Collision_obj_bobomb:2 ×2) | 22/41 |
| [obj_fire_clown_small](objects/obj_fire_clown_small/obj_fire_clown_small.yy) | obj_fireball | spr_fireball | Step_0 | 7 | outside_view(Step_0:6) | 14/33 |
| [obj_fireball](objects/obj_fireball/obj_fireball.yy) | obj_physicsparent | spr_fireball | Alarm_0, Collision_obj_bobomb, Collision_obj_bobomb_hold, Collision_obj_enemyparent, Collision_obj_grrrol, Collision_obj_spike_ball, Create_0, Other_10, Other_14, Step_0 | 187 | instance_create(Alarm_0:1 ×8), outside_view(Step_0:13), scr_snd_bump(Other_10:2 ×2), scr_snd_fireball(Create_0:15 ×2), scr_snd_kick(Collision_obj_bobomb:1 ×2) | 23/45 |
| [obj_fireball_b](objects/obj_fireball_b/obj_fireball_b.yy) | obj_fireball | spr_firegold_ball | Create_0, Other_10 | 23 | instance_create(Other_10:2), scr_snd_fireball(Create_0:15) | 15/34 |
| [obj_fireball_bro](objects/obj_fireball_bro/obj_fireball_bro.yy) | obj_physicsparent | spr_fireball | Collision_obj_bobomb, Collision_obj_bobomb_hold, Collision_obj_enemyparent, Collision_obj_mario, Create_0, Other_10, Step_0 | 85 | instance_create(Other_10:1), outside_view(Step_0:25), scr_snd_fireball(Create_0:15 ×2) | 20/42 |
| [obj_firebar](objects/obj_firebar/obj_firebar.yy) | obj_deactivation | spr_firebar_base | Create_0, Destroy_0, Draw_0, Step_0 | 42 | instance_create(Create_0:7) | 17/36 |
| [obj_firebar_res](objects/obj_firebar_res/obj_firebar_res.yy) | obj_parent_resource_block | spr_firebar_base | Create_0, Draw_0, Mouse_4, Other_15, Step_2 | 176 | instance_create(Mouse_4:38), scr_insideview(Mouse_4:1) | 18/37 |
| [obj_firebro](objects/obj_firebro/obj_firebro.yy) | obj_hammerbro | spr_firebro | Alarm_2, Alarm_3, Alarm_7, Create_0, Other_17, Other_7 | 182 | instance_create(Alarm_3:10 ×3) | 19/41 |
| [obj_firebro_res](objects/obj_firebro_res/obj_firebro_res.yy) | obj_parent_resource | spr_firebro_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 107 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_fireflower](objects/obj_fireflower/obj_fireflower.yy) | obj_powerupparent | spr_fireflower | Create_0, Step_0 | 37 | - | 15/37 |
| [obj_fireflower_res](objects/obj_fireflower_res/obj_fireflower_res.yy) | obj_parent_resource | spr_fireflower_res | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 104 | instance_create(Other_10:3 ×8) | 19/38 |
| [obj_firemaker](objects/obj_firemaker/obj_firemaker.yy) | obj_rainmaker | spr_marker_event | Create_0, Destroy_0, Other_10, Step_2 | 29 | - | 17/36 |
| [obj_fishbone](objects/obj_fishbone/obj_fishbone.yy) | obj_deactenemyparent | spr_fishbone | Alarm_0, Alarm_1, Alarm_10, Create_0, Draw_0, Other_0, Other_14, Step_0 | 64 | - | 21/40 |
| [obj_fishbone_res](objects/obj_fishbone_res/obj_fishbone_res.yy) | obj_parent_resource | spr_square | Create_0, Step_2 | 9 | - | 15/34 |
| [obj_flagpole](objects/obj_flagpole/obj_flagpole.yy) | - | spr_SMB_flagpole | Alarm_0, Alarm_1, Alarm_2, Collision_obj_mario, Collision_obj_marioU, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_2 | 376 | instance_create(Alarm_0:14 ×26), scr_init_globals(Alarm_0:8), scr_restart(Alarm_0:12) | 24/40 |
| [obj_flipblock](objects/obj_flipblock/obj_flipblock.yy) | obj_blockparent | spr_flipblock | Alarm_0, Alarm_1, Create_0, Draw_0, Other_11, Other_20, Step_0 | 325 | draw_sprite_custom_origin(Draw_0:7), instance_create(Alarm_1:5 ×15), scr_snd_switchsong(Step_0:4 ×2) | 20/42 |
| [obj_flipblock_anim](objects/obj_flipblock_anim/obj_flipblock_anim.yy) | obj_deactivation | spr_flipblock | Create_0, Other_7, Step_0 | 31 | instance_create(Other_7:5 ×3), scr_snd_switchsong(Step_0:3 ×2) | 16/35 |
| [obj_floruga](objects/obj_floruga/obj_floruga.yy) | obj_deactenemyparent | spr_floruga_head | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_16, Step_0, Step_1 | 465 | instance_create(Alarm_2:2 ×7), outside_view(Alarm_10:1) | 27/46 |
| [obj_floruga_angry_res](objects/obj_floruga_angry_res/obj_floruga_angry_res.yy) | obj_parent_resource | spr_floruga_angry_res | Create_0, Other_10, Other_11, Step_2 | 40 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_floruga_body](objects/obj_floruga_body/obj_floruga_body.yy) | obj_enemyparent | spr_floruga_body | Create_0, Draw_0, Other_10, Other_11, Step_0 | 53 | outside_view(Other_10:1 ×2) | 18/37 |
| [obj_floruga_res](objects/obj_floruga_res/obj_floruga_res.yy) | obj_parent_resource | spr_floruga_res | Create_0, Other_10, Other_11, Step_2 | 30 | instance_create(Other_11:1 ×2) | 17/36 |
| [obj_foo](objects/obj_foo/obj_foo.yy) | obj_deactenemyparent | spr_foo_idle | Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_7, Step_0 | 170 | instance_create(Other_10:14 ×3) | 20/39 |
| [obj_foo_fog](objects/obj_foo_fog/obj_foo_fog.yy) | - | spr_foo_fog | Create_0, Draw_0, Step_0 | 34 | - | 16/32 |
| [obj_foo_res](objects/obj_foo_res/obj_foo_res.yy) | obj_parent_resource | spr_foo_res | Other_10, Other_11, Step_2 | 33 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_frogsuit](objects/obj_frogsuit/obj_frogsuit.yy) | obj_powerupparent | spr_frogsuit | Alarm_10, Collision_obj_mario, Create_0, Step_0 | 103 | instance_create(Collision_obj_mario:13 ×3), scr_snd_powerup(Collision_obj_mario:43 ×2), scr_sprite_get_constant(Collision_obj_mario:15) | 17/39 |
| [obj_frogsuit_res](objects/obj_frogsuit_res/obj_frogsuit_res.yy) | obj_parent_resource | spr_frogsuit | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 106 | instance_create(Other_10:1 ×7) | 19/38 |
| [obj_frozenmario](objects/obj_frozenmario/obj_frozenmario.yy) | - | spr_frozenblock_32x48 | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Other_11, Step_0 | 166 | instance_create(Alarm_1:4 ×9) | 20/36 |
| [obj_fuegos_or](objects/obj_fuegos_or/obj_fuegos_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 15 | instance_create(Other_10:1) | 15/34 |
| [obj_fuegos_snd_res](objects/obj_fuegos_snd_res/obj_fuegos_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_galoomba](objects/obj_galoomba/obj_galoomba.yy) | obj_deactenemyparent | spr_galoomba | Alarm_0, Alarm_1, Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Other_17, Step_0, Step_2 | 414 | instance_create(Destroy_0:5 ×16) | 25/47 |
| [obj_galoomba2](objects/obj_galoomba2/obj_galoomba2.yy) | obj_galoomba | spr_galoomba2 | Create_0, Other_10, Other_11, Other_15, Step_0 | 154 | instance_create(Other_10:1 ×12) | 18/37 |
| [obj_galoomba2_b](objects/obj_galoomba2_b/obj_galoomba2_b.yy) | obj_galoomba_b | spr_galoomba2_b | Create_0, Other_10, Other_11, Other_15, Step_0 | 159 | instance_create(Other_10:1 ×9) | 18/37 |
| [obj_galoomba_b](objects/obj_galoomba_b/obj_galoomba_b.yy) | obj_galoomba | spr_galoomba_b | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_17, Step_0 | 344 | instance_create(Destroy_0:5 ×12) | 21/40 |
| [obj_galoomba_hold](objects/obj_galoomba_hold/obj_galoomba_hold.yy) | obj_enemyparent_held | spr_galoomba_hold | Alarm_1, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11 | 100 | instance_create(Alarm_1:9 ×6) | 20/42 |
| [obj_galoomba_hold2](objects/obj_galoomba_hold2/obj_galoomba_hold2.yy) | obj_galoomba_hold | spr_galoomba_hold2 | Alarm_1 | 19 | instance_create(Alarm_1:9) | 14/33 |
| [obj_galoomba_hold2_b](objects/obj_galoomba_hold2_b/obj_galoomba_hold2_b.yy) | obj_galoomba_hold2 | spr_galoomba_hold2_b | Alarm_1 | 19 | instance_create(Alarm_1:9) | 14/33 |
| [obj_galoomba_hold_b](objects/obj_galoomba_hold_b/obj_galoomba_hold_b.yy) | obj_galoomba_hold | spr_galoomba_hold_b | Alarm_1 | 19 | instance_create(Alarm_1:9) | 14/36 |
| [obj_game_over](objects/obj_game_over/obj_game_over.yy) | - | spr_game_over | Alarm_0, Create_0, Other_7 | 15 | - | 16/32 |
| [obj_gb_button](objects/obj_gb_button/obj_gb_button.yy) | - | spr_cb_button | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 57 | instance_create(Mouse_4:14), scr_add3points(Draw_0:4), scr_anim_hover(Draw_0:9) | 20/36 |
| [obj_gb_level](objects/obj_gb_level/obj_gb_level.yy) | - | spr_guardabot_level | Create_0, Destroy_0, Draw_0 | 180 | LoadJSONFromFile(Create_0:49), instance_create(Create_0:2 ×4), scr_add3points(Draw_0:6), scr_language(Create_0:15 ×16), scr_toast(Create_0:52) | 16/32 |
| [obj_getshoe](objects/obj_getshoe/obj_getshoe.yy) | obj_physicsparent | spr_kuriboshoe | Alarm_0, Alarm_1, Alarm_2, Collision_obj_mario, Create_0, Draw_0, Other_11, Step_0 | 61 | instance_create(Other_11:8 ×2) | 21/43 |
| [obj_goalcard](objects/obj_goalcard/obj_goalcard.yy) | - | spr_SMB3_goalcard | Alarm_0, Alarm_2, Alarm_3, Collision_obj_mario, Create_0, Draw_0, Other_12, Step_0 | 160 | instance_create(Alarm_2:14 ×4), scr_init_globals(Alarm_2:8), scr_music_link(Collision_obj_mario:11), scr_restart(Alarm_2:12), scr_snd_starman(Collision_obj_mario:10), scr_snd_switchsong(Collision_obj_mario:9) | 21/37 |
| [obj_goalcard_get](objects/obj_goalcard_get/obj_goalcard_get.yy) | - | spr_SMB3_goalcard_mush | Create_0, Other_40 | 4 | - | 15/31 |
| [obj_goalgate](objects/obj_goalgate/obj_goalgate.yy) | - | spr_goalgate | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Step_0 | 99 | instance_create(Alarm_1:14 ×3), scr_init_globals(Alarm_1:8), scr_restart(Alarm_1:12) | 19/35 |
| [obj_goalgate_front](objects/obj_goalgate_front/obj_goalgate_front.yy) | - | spr_goalgate | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 41 | - | 18/34 |
| [obj_goalgate_tape](objects/obj_goalgate_tape/obj_goalgate_tape.yy) | - | spr_goal | Collision_obj_mario, Create_0, Draw_0, Other_10, Step_0 | 118 | instance_create(Other_10:21 ×3) | 18/34 |
| [obj_gold_explosion](objects/obj_gold_explosion/obj_gold_explosion.yy) | obj_smoke | spr_clown_explotion | Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_muncher, Collision_obj_rockparent, Collision_obj_snow_ball, Collision_obj_spike_ball, Create_0 | 111 | instance_create(Collision_obj_blockparent:3 ×9), scr_snd_kick(Collision_obj_bossparent:1 ×12) | 22/41 |
| [obj_golpe_gato_or](objects/obj_golpe_gato_or/obj_golpe_gato_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 16 | instance_create(Other_10:1) | 15/34 |
| [obj_golpe_gato_snd_res](objects/obj_golpe_gato_snd_res/obj_golpe_gato_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_goomba_b_res](objects/obj_goomba_b_res/obj_goomba_b_res.yy) | obj_parent_resource | spr_goomba_b_res | Create_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 110 | instance_create(Other_10:1 ×7), outside_view(Draw_0:1), scr_snd_powerdown(Other_13:1) | 20/39 |
| [obj_goomba_intro](objects/obj_goomba_intro/obj_goomba_intro.yy) | - | spr_goomba_intro | Alarm_0, Alarm_1, Alarm_2, Create_0 | 15 | - | 17/33 |
| [obj_goomba_res](objects/obj_goomba_res/obj_goomba_res.yy) | obj_parent_resource | spr_goomba_res | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 89 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_goomba_swim](objects/obj_goomba_swim/obj_goomba_swim.yy) | obj_galoomba | spr_goomba_float | - | 0 | - | 12/31 |
| [obj_goombrat_b_res](objects/obj_goombrat_b_res/obj_goombrat_b_res.yy) | obj_parent_resource | spr_goombrat_b_res | Create_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 110 | instance_create(Other_10:1 ×7), outside_view(Draw_0:1), scr_snd_powerdown(Other_13:1) | 20/39 |
| [obj_goombrat_res](objects/obj_goombrat_res/obj_goombrat_res.yy) | obj_parent_resource | spr_goombrat_res | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 86 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_gotas](objects/obj_gotas/obj_gotas.yy) | - | spr_bubble | Collision_obj_helmet, Collision_obj_pinchos, Collision_obj_solidtop, Create_0 | 8 | - | 17/33 |
| [obj_grid](objects/obj_grid/obj_grid.yy) | - | spr_new_grid | Create_0, Draw_0 | 34 | - | 15/31 |
| [obj_grinder](objects/obj_grinder/obj_grinder.yy) | obj_deactenemyparent | spr_grinder | Alarm_0, Alarm_10, Collision_obj_blockparent, Collision_obj_clown, Collision_obj_helmet, Collision_obj_mario, Create_0, Draw_0, Step_0, Step_1 | 77 | instance_create(Collision_obj_mario:7) | 23/45 |
| [obj_grinder_res](objects/obj_grinder_res/obj_grinder_res.yy) | obj_parent_resource | spr_grinder_res | Alarm_0, Create_0, Step_2 | 90 | - | 16/35 |
| [obj_ground](objects/obj_ground/obj_ground.yy) | obj_parent_resource | spr_ground_2 | Alarm_0, Alarm_3, Alarm_5, Alarm_6, Collision_obj_tile_trigger, Create_0, Mouse_0, Mouse_1, Mouse_4, Mouse_7, Other_0, Other_10, Other_12, Other_13, Other_15, Other_18, Step_2 | 166 | instance_create(Alarm_5:14 ×7), scr_auto_tile(Other_15:1), scr_insideview(Mouse_0:1 ×3), scr_tiles_ground(Other_10:1) | 30/49 |
| [obj_ground2](objects/obj_ground2/obj_ground2.yy) | obj_groundparent | spr_ground_2 | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_4, Other_10, Step_0 | 192 | instance_create(Create_0:19), scr_tiles_ground(Create_0:1), scr_tiles_ground_start(Step_0:1) | 20/39 |
| [obj_ground3](objects/obj_ground3/obj_ground3.yy) | obj_groundparent | spr_ground_2 | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_4, Other_10, Step_0, Step_1 | 239 | scr_tiles_ground(Create_0:1), scr_tiles_ground_start(Step_0:1) | 21/40 |
| [obj_ground_slope](objects/obj_ground_slope/obj_ground_slope.yy) | obj_ground | spr_ground_2 | Draw_0, Other_15 | 10 | scr_auto_tile_slope(Other_15:1) | 15/34 |
| [obj_groundparent](objects/obj_groundparent/obj_groundparent.yy) | obj_solid | spr_ground_2 | Alarm_2, Collision_obj_parent_resource | 21 | instance_create(Collision_obj_parent_resource:8 ×2) | 15/34 |
| [obj_groundpount](objects/obj_groundpount/obj_groundpount.yy) | - | spr_groundpount | Alarm_0, Collision_obj_blockparent, Create_0, Step_0 | 107 | - | 17/33 |
| [obj_grrrol](objects/obj_grrrol/obj_grrrol.yy) | obj_deactenemyparent | spr_grrrol_old | Alarm_10, Collision_obj_block_pow_hold, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_spike_ball, Create_0, Draw_0, Other_10, Other_12, Other_13, Step_0 | 280 | instance_create(Other_10:1 ×5), scr_snd_bump(Other_13:82 ×2), scr_snd_kick(Collision_obj_enemyparent:3 ×3) | 24/43 |
| [obj_grrrol_b](objects/obj_grrrol_b/obj_grrrol_b.yy) | obj_deactenemyparent | spr_grrrol_b | Alarm_10, Collision_obj_block_pow_hold, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_spike_ball, Create_0, Draw_0, Other_10, Other_12, Other_13, Step_0 | 280 | instance_create(Other_10:1 ×5), scr_snd_bump(Other_13:82 ×2), scr_snd_kick(Collision_obj_enemyparent:3 ×3) | 24/43 |
| [obj_grrrol_b_res](objects/obj_grrrol_b_res/obj_grrrol_b_res.yy) | obj_parent_resource | spr_grrrol_b | Create_0, Draw_0, Mouse_4, Other_10, Other_13, Step_2 | 96 | instance_create(Mouse_4:43 ×3), outside_view(Draw_0:1), scr_snd_powerdown(Other_13:1) | 19/38 |
| [obj_grrrol_new](objects/obj_grrrol_new/obj_grrrol_new.yy) | obj_deactenemyparent | spr_grrrol | Alarm_10, Collision_obj_block_pow_hold, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_spike_ball, Create_0, Draw_0, Other_10, Other_12, Other_13, Step_0 | 280 | instance_create(Other_10:1 ×5), scr_snd_bump(Other_13:82 ×2), scr_snd_kick(Collision_obj_enemyparent:3 ×3) | 24/43 |
| [obj_grrrol_new_res](objects/obj_grrrol_new_res/obj_grrrol_new_res.yy) | obj_parent_resource | spr_grrrol | Create_0, Draw_0, Mouse_4, Other_10, Other_13, Step_2 | 96 | instance_create(Mouse_4:43 ×3), outside_view(Draw_0:1), scr_snd_powerup(Other_13:1) | 19/38 |
| [obj_grrrol_res](objects/obj_grrrol_res/obj_grrrol_res.yy) | obj_parent_resource | spr_grrrol_old | Create_0, Draw_0, Mouse_4, Step_2 | 71 | instance_create(Mouse_4:43), outside_view(Draw_0:1) | 17/36 |
| [obj_guardabot](objects/obj_guardabot/obj_guardabot.yy) | - | spr_marker_event | Alarm_0, Create_0, Draw_0, Other_10, Other_4, Other_5 | 83 | instance_create(Create_0:10 ×3), scr_language(Create_0:28) | 19/35 |
| [obj_hammer](objects/obj_hammer/obj_hammer.yy) | obj_brohammer_yoshi | spr_SMB3_hammer | Collision_obj_block_pow_hold, Collision_obj_bowserjr_shell, Collision_obj_brohammer, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_spike_ball, Create_0, Step_0 | 89 | instance_create(Collision_obj_enemyparent:5 ×5) | 21/40 |
| [obj_hammer_b](objects/obj_hammer_b/obj_hammer_b.yy) | obj_hammer | spr_SMB3_hammer_b | Collision_obj_enemyparent, Collision_obj_rockparent | 13 | instance_create(Collision_obj_enemyparent:5) | 15/34 |
| [obj_hammerbro](objects/obj_hammerbro/obj_hammerbro.yy) | obj_deactenemyparent | spr_hammerbro | Alarm_1, Alarm_10, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Other_17, Other_25, Other_7, Step_0, Step_2 | 748 | instance_create(Alarm_3:10 ×12) | 33/55 |
| [obj_hammerbro_res](objects/obj_hammerbro_res/obj_hammerbro_res.yy) | obj_parent_resource | spr_hammerbro_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 105 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_hammersuit](objects/obj_hammersuit/obj_hammersuit.yy) | obj_powerupparent | spr_SMB3_hammersuit | Alarm_10, Collision_obj_mario, Create_0, Step_0 | 95 | instance_create(Collision_obj_mario:5 ×3), scr_snd_powerup(Collision_obj_mario:35 ×2), scr_sprite_get_constant(Collision_obj_mario:7) | 17/39 |
| [obj_hawmask](objects/obj_hawmask/obj_hawmask.yy) | - | - | Alarm_0, Alarm_1, Alarm_2, Create_0, Destroy_0, Draw_0, Other_7 | 109 | instance_create(Alarm_2:9 ×2), scr_restart(Alarm_2:7) | 20/36 |
| [obj_header](objects/obj_header/obj_header.yy) | - | spr_header_icons_activated | Alarm_0, Create_0, Destroy_0, Draw_0 | 92 | instance_create(Alarm_0:3 ×4), scr_header(Alarm_0:3 ×4), scr_language(Draw_0:12 ×4) | 17/33 |
| [obj_helmet](objects/obj_helmet/obj_helmet.yy) | - | spr_helmet | Collision_obj_banzaibill, Collision_obj_bone, Collision_obj_brohammer, Collision_obj_bulletbill, Collision_obj_bulletbull_red, Collision_obj_buzzy_ceiling, Collision_obj_cannonball, Collision_obj_clown, Collision_obj_espina, Collision_obj_holdparent, Collision_obj_mario, Collision_obj_muncher, Collision_obj_physicsparent, Collision_obj_plantfire, Collision_obj_shell_held, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_thwomp, Create_0, Draw_0, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_22, Other_23, Step_0, Step_2 | 1324 | instance_create(Collision_obj_banzaibill:6 ×24), scr_marioclimb(Draw_0:3 ×7), scr_marioduck(Other_23:79 ×2) | 43/59 |
| [obj_helmet_spiny](objects/obj_helmet_spiny/obj_helmet_spiny.yy) | obj_helmet | spr_helmet_spiny | Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_muncher, Collision_obj_physicsparent, Collision_obj_shell, Collision_obj_shell_held, Collision_obj_thwomp, Other_16, Step_0 | 169 | instance_create(Collision_obj_bossparent:8 ×6), scr_marioclimb(Other_16:20 ×2) | 23/42 |
| [obj_hen_mushroom](objects/obj_hen_mushroom/obj_hen_mushroom.yy) | obj_powerupparent | spr_SMB_hen_mushroom | Alarm_10, Collision_obj_blockparent, Collision_obj_mario, Create_0, Step_0 | 94 | instance_create(Collision_obj_mario:5 ×2), scr_snd_powerup(Collision_obj_mario:14) | 18/37 |
| [obj_hen_mushroom_res](objects/obj_hen_mushroom_res/obj_hen_mushroom_res.yy) | obj_parent_resource | spr_SMB_hen_mushroom | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 104 | instance_create(Other_10:1 ×7) | 19/38 |
| [obj_holdparent](objects/obj_holdparent/obj_holdparent.yy) | obj_physicsparent | spr_spring | Alarm_0, Alarm_2, Alarm_3, Collision_obj_blockparent, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_11, Other_12, Other_13, Other_14, Other_15, Other_40, Other_5, Step_0, Step_2 | 799 | instance_create(Collision_obj_mario:15 ×7), scr_canhold(Collision_obj_mario:9 ×2), scr_snd_kick(Collision_obj_mario:11 ×4) | 30/52 |
| [obj_hurtsolid2](objects/obj_hurtsolid2/obj_hurtsolid2.yy) | obj_solidtop | spr_linemask | Step_0 | 41 | - | 14/36 |
| [obj_ice_res](objects/obj_ice_res/obj_ice_res.yy) | obj_parent_resource_block | spr_block_ice | Step_2 | 20 | - | 14/33 |
| [obj_icebro](objects/obj_icebro/obj_icebro.yy) | obj_hammerbro | spr_icebro | Alarm_2, Alarm_3, Alarm_7, Create_0, Other_17, Other_7 | 183 | instance_create(Alarm_3:10 ×3) | 19/38 |
| [obj_icebro_res](objects/obj_icebro_res/obj_icebro_res.yy) | obj_parent_resource | spr_icebro_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 107 | instance_create(Other_10:1 ×6), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_icecoin](objects/obj_icecoin/obj_icecoin.yy) | obj_rockparent | spr_ice_coin | Collision_obj_angrysun, Collision_obj_bowser_fire, Collision_obj_cheepcheep, Collision_obj_explosion, Collision_obj_fire_clown, Collision_obj_plantfire, Collision_obj_podoboo, Collision_obj_soplete, Collision_obj_yoshifire, Create_0, Draw_0, Other_11, Step_0 | 101 | instance_create(Other_11:1 ×2), scr_snd_switchsong(Step_0:2) | 26/45 |
| [obj_icecoin_res](objects/obj_icecoin_res/obj_icecoin_res.yy) | obj_parent_resource_block | spr_ice_coin | Create_0, Other_10, Other_11, Other_14, Step_2 | 93 | instance_create(Other_10:1 ×3) | 18/37 |
| [obj_icicle](objects/obj_icicle/obj_icicle.yy) | obj_platform_parent | spr_icicle | Alarm_0, Alarm_1, Alarm_2, Collision_obj_helmet, Collision_obj_mario, Collision_obj_pinchos, Collision_obj_solidtop, Create_0, Draw_0, Other_10, Step_0 | 191 | instance_create(Alarm_1:1 ×6) | 24/43 |
| [obj_icicle2](objects/obj_icicle2/obj_icicle2.yy) | obj_icicle | spr_icicle2 | Create_0, Step_0 | 12 | - | 15/34 |
| [obj_icicle2_res](objects/obj_icicle2_res/obj_icicle2_res.yy) | obj_parent_resource | spr_icicle2_res | Create_0, Other_10, Other_11, Step_2 | 67 | instance_create(Other_10:1 ×5) | 17/36 |
| [obj_icicle_res](objects/obj_icicle_res/obj_icicle_res.yy) | obj_parent_resource | spr_icicle_res | Create_0, Other_10, Other_11, Step_2 | 67 | instance_create(Other_10:1 ×5) | 17/36 |
| [obj_icon_dead](objects/obj_icon_dead/obj_icon_dead.yy) | - | - | Create_0, Other_7 | 5 | - | 15/31 |
| [obj_iname](objects/obj_iname/obj_iname.yy) | - | spr_lg3 | Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 73 | - | 19/35 |
| [obj_iname_close](objects/obj_iname_close/obj_iname_close.yy) | - | spr_button_close | Create_0, Mouse_4 | 9 | - | 15/31 |
| [obj_iname_control](objects/obj_iname_control/obj_iname_control.yy) | - | spr_iname_bg | Create_0, Destroy_0, Draw_0 | 53 | background_create_from_surface(Create_0:9), gpu_set_blendenable(Draw_0:3 ×2), instance_create(Create_0:13 ×3), scr_language(Create_0:6), sprite_delete(Destroy_0:19), sprite_exists(Destroy_0:18 ×2) | 16/32 |
| [obj_iname_control2](objects/obj_iname_control2/obj_iname_control2.yy) | obj_iname_control | spr_iname_bg | Create_0 | 17 | background_create_from_surface(Create_0:9), instance_create(Create_0:13 ×3), scr_language(Create_0:6) | 14/33 |
| [obj_input](objects/obj_input/obj_input.yy) | - | spr_alert_setname | Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 75 | scr_language(Mouse_4:2) | 19/35 |
| [obj_input_desc](objects/obj_input_desc/obj_input_desc.yy) | - | spr_input_desc | Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 68 | scr_language(Mouse_4:2) | 19/35 |
| [obj_input_rename](objects/obj_input_rename/obj_input_rename.yy) | - | spr_alert_setname | Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 49 | scr_language(Mouse_4:2) | 19/35 |
| [obj_intro_controller](objects/obj_intro_controller/obj_intro_controller.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Create_0, Draw_0, KeyPress_13, Mouse_53, Other_4, Step_2 | 160 | instance_create(Other_4:4 ×7), scr_language(Create_0:9 ×9) | 21/37 |
| [obj_invincibility](objects/obj_invincibility/obj_invincibility.yy) | - | spr_sparkles | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Create_0, Other_5, Step_0 | 179 | instance_create(Alarm_1:3), scr_musicalscale(Collision_obj_enemyparent:5), scr_snd_kick(Collision_obj_bossparent:1 ×3), scr_snd_starman(Alarm_0:1) | 23/42 |
| [obj_jumppiranha](objects/obj_jumppiranha/obj_jumppiranha.yy) | obj_deactenemyparent | spr_jumppiranha_falll | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_14, Step_0 | 377 | instance_create(Destroy_0:3 ×12) | 23/45 |
| [obj_key](objects/obj_key/obj_key.yy) | obj_deactivation | spr_key | Collision_obj_enemyparent_held, Collision_obj_link_arrow, Collision_obj_mario, Collision_obj_shell_held, Collision_obj_snow_ball_held, Create_0, Draw_0, Other_10 | 116 | instance_create(Collision_obj_enemyparent_held:3 ×7) | 21/43 |
| [obj_key_appear](objects/obj_key_appear/obj_key_appear.yy) | - | spr_key | Alarm_0, Alarm_1, Collision_obj_doormario, Collision_obj_mario, Collision_obj_player_warp, Create_0, Other_10, Other_11, Step_0 | 144 | instance_create(Alarm_1:1 ×4) | 22/38 |
| [obj_key_fallow](objects/obj_key_fallow/obj_key_fallow.yy) | - | spr_key | Create_0, Draw_0, Step_0 | 110 | scr_marioclimb(Step_0:14) | 16/32 |
| [obj_key_res](objects/obj_key_res/obj_key_res.yy) | obj_parent_resource | spr_key | Step_2 | 20 | - | 14/33 |
| [obj_koopa](objects/obj_koopa/obj_koopa.yy) | obj_deactenemyparent | spr_koopa | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15, Other_17, Step_0 | 333 | instance_create(Destroy_0:5 ×17) | 22/44 |
| [obj_koopa_b](objects/obj_koopa_b/obj_koopa_b.yy) | obj_koopa | spr_koopa_b | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15 | 228 | instance_create(Destroy_0:5 ×12) | 20/39 |
| [obj_koopa_b_res](objects/obj_koopa_b_res/obj_koopa_b_res.yy) | obj_parent_resource | spr_koopa_b_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 75 | instance_create(Other_10:1 ×5), scr_snd_powerdown(Other_13:1) | 18/37 |
| [obj_koopa_red](objects/obj_koopa_red/obj_koopa_red.yy) | obj_deactenemyparent | spr_koopa_red | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_15, Other_17, Step_0 | 388 | instance_create(Destroy_0:5 ×13) | 23/45 |
| [obj_koopa_red_b](objects/obj_koopa_red_b/obj_koopa_red_b.yy) | obj_koopa_red | spr_koopa_red_b | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_15 | 236 | instance_create(Destroy_0:5 ×12) | 20/39 |
| [obj_koopa_red_b_res](objects/obj_koopa_red_b_res/obj_koopa_red_b_res.yy) | obj_parent_resource | spr_koopa_red_b_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 68 | instance_create(Other_10:1 ×5), scr_snd_powerdown(Other_13:1) | 18/37 |
| [obj_koopa_red_res](objects/obj_koopa_red_res/obj_koopa_red_res.yy) | obj_parent_resource | spr_koopa_red_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 60 | instance_create(Other_10:1 ×4), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_koopa_res](objects/obj_koopa_res/obj_koopa_res.yy) | obj_parent_resource | spr_koopa_res | Create_0, Other_10, Other_11, Other_13, Step_2 | 64 | instance_create(Other_10:1 ×4), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_kuribo_drybones](objects/obj_kuribo_drybones/obj_kuribo_drybones.yy) | obj_kuriboshoe | spr_kuribo_drybones | Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Create_0, Draw_0, Other_10, Other_15, Other_7, Step_2 | 591 | instance_create(Alarm_8:67 ×4), scr_mario_drybones(Step_2:35 ×5), scr_mario_drybones_goal(Step_2:254), scr_mario_drybones_jump(Step_2:19 ×3), scr_marioshoot_drybones(Step_2:14), scr_snd_break(Step_2:134 ×3) | 24/43 |
| [obj_kuriboshoe](objects/obj_kuriboshoe/obj_kuriboshoe.yy) | - | spr_kuriboshoe | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Create_0, Destroy_0, Draw_0, Other_10, Other_15, Step_2 | 439 | instance_create(Other_10:1 ×4), scr_mario_shoe(Step_2:7 ×4), scr_mario_shoe_fall(Step_2:23) | 23/42 |
| [obj_kuriboshoe2](objects/obj_kuriboshoe2/obj_kuriboshoe2.yy) | obj_kuriboshoe | spr_kuriboshoe2 | Create_0 | 14 | - | 14/33 |
| [obj_kuriboshoe_movement](objects/obj_kuriboshoe_movement/obj_kuriboshoe_movement.yy) | - | spr_square | Create_0, Step_0 | 44 | - | 15/31 |
| [obj_lakitu](objects/obj_lakitu/obj_lakitu.yy) | obj_enemyparent | spr_lakitu | Alarm_0, Alarm_1, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_7, Step_0 | 304 | instance_create(Alarm_1:3 ×9), scr_constant_get_sprite(Alarm_1:24), scr_sprite_make_object(Alarm_1:40) | 23/42 |
| [obj_lakitu_res](objects/obj_lakitu_res/obj_lakitu_res.yy) | obj_parent_resource | spr_lakitu_res | Collision_obj_parent_resource, Create_0, Draw_0, Other_10, Other_14, Step_2 | 72 | instance_create(Other_10:1 ×3), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 19/38 |
| [obj_lava_lift](objects/obj_lava_lift/obj_lava_lift.yy) | obj_platform_parent | spr_lava_lift | Alarm_0, Alarm_2, Alarm_3, Create_0, Other_0, Other_11, Step_0 | 91 | instance_create(Create_0:23 ×3) | 20/42 |
| [obj_lava_lift_part](objects/obj_lava_lift_part/obj_lava_lift_part.yy) | obj_lava_lift | spr_lava_lift | Create_0, Step_0 | 36 | - | 15/34 |
| [obj_lava_lift_res](objects/obj_lava_lift_res/obj_lava_lift_res.yy) | obj_parent_resource | spr_lava_lift_res | Create_0, Other_10, Other_11, Step_2 | 35 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_lava_water](objects/obj_lava_water/obj_lava_water.yy) | - | spr_lava | Alarm_0, Create_0, Destroy_0, Draw_0, Other_10, Step_0, Step_1, Step_2 | 356 | instance_create(Create_0:9) | 21/37 |
| [obj_lava_water_drybones](objects/obj_lava_water_drybones/obj_lava_water_drybones.yy) | - | spr_square_c | - | 0 | - | 12/28 |
| [obj_lave_draw](objects/obj_lave_draw/obj_lave_draw.yy) | - | spr_lava | Create_0, Draw_0, Step_0 | 78 | - | 16/32 |
| [obj_leafmaker](objects/obj_leafmaker/obj_leafmaker.yy) | obj_rainmaker | spr_marker_event | Create_0, Destroy_0, Other_10, Step_2 | 44 | - | 17/36 |
| [obj_levelmanager](objects/obj_levelmanager/obj_levelmanager.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Alarm_9, Create_0, Draw_0, KeyPress_13, Other_10, Other_11, Other_12, Other_13, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_21, Other_4, Other_5, Step_2 | 1431 | __background_set(Other_21:7 ×96), __view_get(Other_17:6 ×35), instance_create(Alarm_4:5 ×17), scr_cont_lives(Other_19:31), scr_music_link(Alarm_10:14 ×8), scr_pink_coins(Other_19:1 ×2), scr_snd_bowserjr_shell(Step_2:16 ×4), scr_snd_hurryup(Alarm_3:1 ×4), scr_snd_soplete(Other_5:4), scr_snd_starman(Alarm_10:12 ×19), scr_snd_switchalert(Step_2:306), scr_snd_switchsong(Alarm_10:5 ×20), scr_snd_thwomp(Alarm_11:5 ×2), string_add_zeros(Other_19:23 ×10) | 42/58 |
| [obj_lighting](objects/obj_lighting/obj_lighting.yy) | - | - | Create_0, Draw_0, Other_5, Step_0 | 288 | gpu_set_blendmode(Step_0:7 ×2) | 17/33 |
| [obj_link](objects/obj_link/obj_link.yy) | obj_powerupparent | spr_SMB_link | Alarm_0, Alarm_10, Collision_obj_mario, Create_0, Other_17, Step_0 | 149 | instance_create(Collision_obj_mario:5 ×4), outside_view(Step_0:5) | 19/41 |
| [obj_link_arrow](objects/obj_link_arrow/obj_link_arrow.yy) | - | spr_SMB_link_arrow | Alarm_0, Alarm_10, Collision_obj_block_pow_hold, Collision_obj_blockparent, Collision_obj_bullebill_base, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_link_bomb, Collision_obj_onewaygate_bottom, Collision_obj_onewaygate_left, Collision_obj_onewaygate_right, Collision_obj_physicssolid, Collision_obj_solid, Collision_obj_solidtop, Collision_obj_spike_ball, Collision_obj_spring_land, Create_0, Draw_0, Other_10, Other_11, Step_0 | 241 | instance_create(Collision_obj_enemyparent:7 ×4), scr_bg_underwater(Collision_obj_enemyparent:9), scr_snd_kick(Collision_obj_enemyparent:3 ×2) | 34/50 |
| [obj_link_arrow_anim](objects/obj_link_arrow_anim/obj_link_arrow_anim.yy) | - | spr_SMB_link_arrow_start | Create_0, Destroy_0, Draw_0, Other_7, Step_0 | 52 | instance_create(Destroy_0:12) | 18/34 |
| [obj_link_atack](objects/obj_link_atack/obj_link_atack.yy) | obj_spinner | spr_SMB_link_atack | Collision_obj_block_pow_hold, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_grrrol, Collision_obj_spike_ball, Create_0, Step_0 | 132 | instance_create(Collision_obj_enemyparent:9 ×4), scr_bg_underwater(Collision_obj_enemyparent:20) | 20/39 |
| [obj_link_bomb](objects/obj_link_bomb/obj_link_bomb.yy) | obj_holdparent | spr_SMB_bomb | Alarm_10, Alarm_4, Alarm_5, Alarm_6, Collision_obj_link_atack, Collision_obj_link_down_atack, Collision_obj_spike_ball, Create_0, Other_12, Other_13, Other_16, Step_0, Step_2 | 349 | instance_create(Alarm_6:9), scr_snd_kick(Collision_obj_link_atack:2 ×4) | 26/45 |
| [obj_link_dash_atack](objects/obj_link_dash_atack/obj_link_dash_atack.yy) | obj_spinner | spr_SMB_link_dash_atack | Collision_obj_block_pow_hold, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_spike_ball, Create_0, Draw_0, Other_10, Other_7, Step_0 | 177 | instance_create(Collision_obj_enemyparent:7 ×2), scr_bg_underwater(Collision_obj_enemyparent:9) | 22/41 |
| [obj_link_down_atack](objects/obj_link_down_atack/obj_link_down_atack.yy) | obj_spinner | spr_SMB_link_down_atack | Alarm_0, Collision_obj_block_pow_hold, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_grinder, Collision_obj_onewaygate_bottom, Collision_obj_spike_ball, Create_0, Other_10, Other_7, Step_0 | 151 | instance_create(Collision_obj_enemyparent:7 ×5), scr_bg_underwater(Collision_obj_enemyparent:9) | 24/43 |
| [obj_link_res](objects/obj_link_res/obj_link_res.yy) | obj_parent_resource | spr_SMB_link_res | Create_0, Other_10, Other_14 | 33 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_load_btn_c](objects/obj_load_btn_c/obj_load_btn_c.yy) | obj_button_close | spr_button_close | Alarm_2, Create_0, Mouse_4 | 14 | - | 16/35 |
| [obj_load_guardabot](objects/obj_load_guardabot/obj_load_guardabot.yy) | - | spr_marker_event | Create_0, Destroy_0, Other_11, Other_12, Other_13, Other_14, Other_15, Other_4 | 942 | LoadJSONFromFile(Other_11:7), __background_set(Other_11:391 ×174), instance_create(Other_11:112 ×35), scr_bg_airship(Other_12:104), scr_bg_beach(Other_12:228), scr_bg_castle(Other_12:47), scr_bg_desert(Other_12:163), scr_bg_fall(Other_12:209), scr_bg_forest(Other_12:146), scr_bg_ghost_house(Other_12:64 ×2), scr_bg_ground(Other_12:30), scr_bg_mountain(Other_12:265), scr_bg_sky(Other_12:125), scr_bg_snow(Other_12:194), scr_bg_underground(Other_12:34), scr_bg_underwater(Other_12:51), scr_create_bg_anim(Other_12:420), scr_edit_to_play(Other_11:266), scr_snd_airship(Other_12:105), scr_snd_autumn(Other_12:210), scr_snd_beach(Other_12:229), scr_snd_castle(Other_12:48), scr_snd_desert(Other_12:164), scr_snd_forest(Other_12:147), scr_snd_ghost_house(Other_12:68), scr_snd_ground(Other_12:31), scr_snd_mountain(Other_12:266), scr_snd_sky(Other_12:126), scr_snd_snow(Other_12:195), scr_snd_underground(Other_12:35), scr_snd_underwater(Other_12:52) | 21/37 |
| [obj_load_image](objects/obj_load_image/obj_load_image.yy) | - | spr_load_image | Alarm_1, Create_0, Draw_0, Step_0 | 24 | - | 17/33 |
| [obj_load_level](objects/obj_load_level/obj_load_level.yy) | - | spr_marker_event | Create_0, Other_10, Other_11, Other_12, Other_4 | 940 | LoadJSONFromFile(Other_10:6), __background_set(Other_11:1 ×160), instance_create(Other_10:96 ×11), scr_bg_airship(Other_11:129), scr_bg_beach(Other_11:284), scr_bg_castle(Other_11:57), scr_bg_desert(Other_11:203), scr_bg_fall(Other_11:260), scr_bg_forest(Other_11:155), scr_bg_ghost_house(Other_11:84 ×2), scr_bg_ground(Other_11:30), scr_bg_mountain(Other_11:327), scr_bg_sky(Other_11:181), scr_bg_snow(Other_11:240), scr_bg_underground(Other_11:39), scr_bg_underwater(Other_11:66), scr_create_bg_anim(Other_11:473), scr_language(Other_10:13), scr_snd_airship(Other_11:130), scr_snd_beach(Other_11:285), scr_snd_castle(Other_11:58), scr_snd_desert(Other_11:204), scr_snd_editor_airship(Other_11:131), scr_snd_editor_castle(Other_11:59), scr_snd_editor_desert(Other_11:205), scr_snd_editor_forest(Other_11:157 ×2), scr_snd_editor_ghost(Other_11:89), scr_snd_editor_ground(Other_11:32 ×2), scr_snd_editor_mountain(Other_11:329), scr_snd_editor_sky(Other_11:183), scr_snd_editor_snow(Other_11:242), scr_snd_editor_underground(Other_11:41), scr_snd_editor_underwater(Other_11:68), scr_snd_forest(Other_11:156), scr_snd_ghost_house(Other_11:88), scr_snd_ground(Other_11:31 ×2), scr_snd_mountain(Other_11:328), scr_snd_sky(Other_11:182), scr_snd_snow(Other_11:241), scr_snd_underground(Other_11:40), scr_snd_underwater(Other_11:67), scr_toast(Other_10:13) | 18/34 |
| [obj_login_control](objects/obj_login_control/obj_login_control.yy) | - | spr_marker_event | Create_0, Draw_0 | 17 | - | 15/31 |
| [obj_logo_c](objects/obj_logo_c/obj_logo_c.yy) | - | spr_marker_event | Create_0, Draw_0 | 18 | scr_language(Draw_0:4 ×2) | 15/31 |
| [obj_logo_game](objects/obj_logo_game/obj_logo_game.yy) | obj_panelsparent | spr_carteles | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 80 | instance_create(Mouse_4:16), scr_anim_hover(Draw_0:7) | 19/38 |
| [obj_lp](objects/obj_lp/obj_lp.yy) | obj_lun | spr_lg2 | Create_0, Draw_0, Mouse_4, Step_0 | 54 | scr_language(Mouse_4:2) | 17/36 |
| [obj_ludwig_res](objects/obj_ludwig_res/obj_ludwig_res.yy) | obj_parent_resource | spr_square | Create_0, Step_2 | 9 | - | 15/34 |
| [obj_lun](objects/obj_lun/obj_lun.yy) | - | spr_lg | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 86 | scr_language(Mouse_4:2) | 21/37 |
| [obj_magic](objects/obj_magic/obj_magic.yy) | - | spr_magic | Alarm_0, Collision_obj_helmet, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_13, Other_14, Step_0 | 504 | instance_create(Alarm_0:1 ×81), outside_view(Step_0:422) | 22/41 |
| [obj_magikoopa](objects/obj_magikoopa/obj_magikoopa.yy) | obj_enemyparent | spr_magikoopa | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Create_0, Draw_0, Other_10, Other_11, Other_7, Step_0 | 250 | instance_create(Alarm_0:24 ×7), outside_view(Alarm_0:1 ×3), tile_layer_find(Alarm_2:12 ×2) | 23/45 |
| [obj_magikoopa_res](objects/obj_magikoopa_res/obj_magikoopa_res.yy) | obj_parent_resource | spr_magikoopa_res | Step_2 | 3 | - | 14/33 |
| [obj_mario](objects/obj_mario/obj_mario.yy) | - | spr_mario_small_idle | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Alarm_9, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_18, Other_24, Other_25, Other_5, Other_7, Step_0, Step_2 | 3485 | instance_create(Alarm_10:38 ×52), scr_NSMBU_swim(Other_13:188), scr_canpull(Other_12:53 ×2), scr_jump(Other_12:152 ×6), scr_link_arrow_jump(Step_2:301 ×3), scr_link_arrow_swim(Other_13:169 ×3), scr_link_arrow_walk(Step_2:203), scr_lose_condition(Other_10:47 ×4), scr_mario_cap_fly(Other_7:3 ×4), scr_mario_cap_fly_acender(Other_12:696 ×6), scr_mario_cap_fly_acender_decender(Other_12:720 ×3), scr_mario_cap_fly_decender(Other_12:708 ×5), scr_marioclimb(Step_2:642), scr_mariodrop(Step_2:402 ×6), scr_marioduck(Step_2:748), scr_marioduckhold(Step_2:737), scr_mariohold(Step_2:628 ×2), scr_marioidle(Create_0:2 ×3), scr_mariojump(Step_2:391 ×3), scr_mariojumphold(Step_2:622), scr_mariojumpstar(Alarm_10:88 ×5), scr_mariokick(Step_2:680), scr_mariorun(Step_2:174 ×3), scr_mariorunjump(Step_2:468), scr_marioshoot(Step_2:101 ×4), scr_marioskid(Step_2:73 ×5), scr_marioswim(Other_13:175 ×5), scr_marioswim2(Step_2:264), scr_marioswim3(Step_2:280), scr_marioswim_hold_idle(Step_2:489 ×4), scr_marioswim_idle(Step_2:124 ×4), scr_marioswimhold(Step_2:317 ×7), scr_marioup(Step_2:133), scr_mariouphold(Step_2:637), scr_mariowalk(Step_2:112 ×7), scr_mariowarp(Step_2:91 ×7), scr_snd_bump(Step_0:251 ×4), scr_snd_powerdown(Other_10:61 ×4), scr_snd_skid(Other_24:3 ×6), scr_snd_spinjump(Other_12:184), scr_swim(Other_13:76 ×18) | 43/64 |
| [obj_marioU](objects/obj_marioU/obj_marioU.yy) | obj_mario | spr_NSMBU_mario_small_idle | Alarm_11, Alarm_4, Create_0, Draw_0, Other_11, Other_12, Other_13, Other_19, Step_0, Step_2 | 3262 | instance_create(Other_12:128 ×22), scr_NSMBU_acrouch(Step_2:310 ×3), scr_NSMBU_airspin1(Step_2:655 ×9), scr_NSMBU_crouch(Step_2:1391 ×2), scr_NSMBU_crouch_fall(Step_2:1371 ×2), scr_NSMBU_crouch_idle(Step_2:136 ×5), scr_NSMBU_crouch_jump(Step_2:1312 ×4), scr_NSMBU_drill_spin(Step_2:633 ×2), scr_NSMBU_flip(Step_2:283), scr_NSMBU_flip_start(Step_2:275), scr_NSMBU_ground_idle(Step_2:248 ×5), scr_NSMBU_groundpound(Step_2:699), scr_NSMBU_groundpound_canceled(Other_12:68 ×3), scr_NSMBU_groundpound_stop(Step_2:159), scr_NSMBU_hold(Step_2:1018 ×4), scr_NSMBU_hold_airspin(Step_2:1198 ×2), scr_NSMBU_hold_ground(Step_2:1018 ×3), scr_NSMBU_hold_jump(Step_2:1020 ×4), scr_NSMBU_hold_spinjump(Step_2:1020 ×3), scr_NSMBU_idle(Step_2:150 ×10), scr_NSMBU_jump1(Other_11:43 ×8), scr_NSMBU_jump2(Other_11:43 ×6), scr_NSMBU_jump3(Other_11:43 ×4), scr_NSMBU_jump_star(Step_2:811), scr_NSMBU_kick(Step_2:17), scr_NSMBU_marioclimb_start(Step_2:1261 ×3), scr_NSMBU_run(Step_2:431), scr_NSMBU_runmax(Step_2:74 ×3), scr_NSMBU_skid(Step_2:49 ×2), scr_NSMBU_skid_left(Step_2:87 ×4), scr_NSMBU_skid_right(Step_2:64 ×4), scr_NSMBU_spincrouch(Step_2:1299 ×2), scr_NSMBU_spinjump(Step_2:848 ×2), scr_NSMBU_standup(Step_2:143 ×2), scr_NSMBU_stun(Step_2:127), scr_NSMBU_swim(Other_13:152 ×5), scr_NSMBU_swim2(Step_2:245 ×3), scr_NSMBU_swim_fall(Step_2:114 ×3), scr_NSMBU_swim_hold(Step_2:1013 ×6), scr_NSMBU_triple_jump0(Step_2:742 ×2), scr_NSMBU_triple_jump1(Step_2:742 ×3), scr_NSMBU_triple_jump2(Step_2:764 ×3), scr_NSMBU_triple_jump3(Step_2:742 ×2), scr_NSMBU_walk(Step_2:329 ×4), scr_NSMBU_walkhold(Step_2:1063 ×2), scr_NSMBU_walkhome(Step_2:294 ×2), scr_NSMBU_wall_slide(Step_2:687), scr_arcon_fly(Step_2:917 ×2), scr_arcon_fly_start(Step_2:912 ×4), scr_jump(Other_12:124 ×4), scr_marioclimb(Step_2:1242 ×4), scr_marioshoot(Step_2:213 ×4), scr_snd_bump(Step_0:233 ×4), scr_snd_skid(Step_2:59 ×6), scr_snd_spinjump(Other_12:162), scr_step_sounds(Other_19:30 ×6), scr_swim(Other_13:57 ×11) | 23/47 |
| [obj_mario_editor](objects/obj_mario_editor/obj_mario_editor.yy) | - | spr_NSMBU_mario_editor | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Mouse_7, Other_10, Other_11, Other_12, Step_0, Step_1 | 376 | instance_create(Mouse_4:27 ×3), scr_NSMBU_walk(Step_0:34), scr_marioidle(Step_0:76), scr_mariowalk(Step_0:39), scr_powerup_editor(Step_0:2), scr_snd_starman(Other_11:2 ×2) | 25/41 |
| [obj_mario_intro](objects/obj_mario_intro/obj_mario_intro.yy) | - | spr_mario_intro2 | Alarm_0, Collision_obj_shell_intro, Collision_obj_thwomp_intro, Create_0, Draw_0, Step_2 | 33 | - | 19/35 |
| [obj_mario_pballon](objects/obj_mario_pballon/obj_mario_pballon.yy) | - | spr_mario_pballon | Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Other_16, Step_0, Step_2 | 456 | instance_create(Other_11:9), screen_round(Draw_0:2 ×8) | 23/39 |
| [obj_mario_temp](objects/obj_mario_temp/obj_mario_temp.yy) | - | spr_mario_small_idle | Alarm_0, Create_0, Draw_0, Other_10 | 34 | instance_create(Alarm_0:6 ×2), scr_NSMBU_idle(Create_0:2), scr_marioidle(Create_0:4) | 17/33 |
| [obj_mario_transform2](objects/obj_mario_transform2/obj_mario_transform2.yy) | - | - | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Alarm_3, Alarm_4, Create_0, Destroy_0, Draw_0, Other_10, Step_0 | 702 | __background_get(Create_0:91), __background_set(Create_0:92 ×2), background_create_from_surface(Alarm_0:7), gpu_set_blendenable(Draw_0:3 ×2), instance_create(Destroy_0:8), scr_NSMBU_idle(Create_0:46), scr_NSMBU_skid(Create_0:42), scr_NSMBU_walk(Create_0:44), scr_marioidle(Create_0:55), scr_marioskid(Create_0:51), scr_mariowalk(Create_0:53), scr_sprite_get_constant(Alarm_0:49), sprite_delete(Destroy_0:2), sprite_exists(Draw_0:1) | 24/40 |
| [obj_mariostart](objects/obj_mariostart/obj_mariostart.yy) | - | spr_mariostart | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0 | 102 | instance_create(Alarm_0:10), scr_language(Draw_0:38 ×2) | 18/37 |
| [obj_mariostart_m](objects/obj_mariostart_m/obj_mariostart_m.yy) | - | spr_SMB_mario_small_idle | Alarm_0, Alarm_1, Create_0, Draw_0, KeyPress_32, Other_10, Other_11, Other_7, Step_2 | 142 | scr_mariodrop(Other_10:6), scr_marioidle(Other_10:7), scr_mariojump(Other_10:5), string_add_zeros(Draw_0:15) | 22/38 |
| [obj_mechakoopa](objects/obj_mechakoopa/obj_mechakoopa.yy) | obj_deactenemyparent | spr_mechakoopa_green_walk | Alarm_10, Alarm_11, Create_0, Draw_0, Other_10, Other_11, Other_15, Step_0 | 82 | instance_create(Other_10:4 ×2) | 21/40 |
| [obj_mechakoopa_held](objects/obj_mechakoopa_held/obj_mechakoopa_held.yy) | obj_galoomba_hold | spr_mechakoopa_green_squashed | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Create_0, Draw_0, Other_10, Other_11, Other_7 | 138 | instance_create(Alarm_4:5 ×3) | 23/42 |
| [obj_mechakoopa_res](objects/obj_mechakoopa_res/obj_mechakoopa_res.yy) | obj_parent_resource | spr_mechakoopa_res | Create_0, Other_10, Other_11, Step_2 | 33 | instance_create(Other_11:1 ×2) | 17/36 |
| [obj_megamushroom](objects/obj_megamushroom/obj_megamushroom.yy) | obj_powerupparent | spr_SMB_megamushroom | Alarm_10, Create_0, Step_0 | 52 | - | 16/35 |
| [obj_menu_editor](objects/obj_menu_editor/obj_menu_editor.yy) | obj_parent_layout | spr_menu | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 39 | instance_create(Mouse_4:4), scr_anim_hover(Draw_0:5) | 20/39 |
| [obj_menu_editor_ext](objects/obj_menu_editor_ext/obj_menu_editor_ext.yy) | obj_parent_layout | spr_menu | Alarm_0, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 46 | instance_create(Mouse_4:4), scr_anim_hover(Draw_0:5) | 19/38 |
| [obj_menu_pausa](objects/obj_menu_pausa/obj_menu_pausa.yy) | - | spr_menu_pausa | Create_0, Destroy_0, Draw_0, KeyPress_13, Other_10, Other_11, Other_12 | 360 | background_create_from_surface(Create_0:14), gpu_set_blendenable(Draw_0:5 ×2), instance_create(Create_0:70 ×9), scr_add3points(Draw_0:52), scr_init_globals(Other_12:4), scr_language(Create_0:74 ×9), scr_music_link(Create_0:24 ×6), scr_restart(Other_11:76), scr_snd_bowserjr_shell(Create_0:56), scr_snd_clown_damage(Other_12:5), scr_snd_dead(Create_0:28 ×9), scr_snd_hurryup(Create_0:32 ×7), scr_snd_skid(Create_0:50 ×7), scr_snd_starman(Create_0:22 ×7), scr_snd_switchsong(Create_0:26 ×7), sprite_delete(Other_10:5 ×2), sprite_exists(Draw_0:3 ×3) | 20/36 |
| [obj_meteorites](objects/obj_meteorites/obj_meteorites.yy) | - | spr_NSMBU_meteorite_small | Alarm_0, Collision_obj_mario, Create_0, Other_10, Other_11, Other_14, Step_0 | 137 | instance_create(Alarm_0:1 ×6), scr_snd_stomp(Collision_obj_mario:5) | 20/36 |
| [obj_meteorites_big](objects/obj_meteorites_big/obj_meteorites_big.yy) | - | spr_NSMBU_meteorite_big | Alarm_0, Collision_obj_mario, Create_0, Other_10, Other_11, Other_12, Other_14, Step_0 | 215 | instance_create(Alarm_0:1 ×10), scr_snd_stomp(Collision_obj_mario:5) | 21/37 |
| [obj_meteorites_maker](objects/obj_meteorites_maker/obj_meteorites_maker.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Alarm_9, Create_0, Destroy_0, Other_5 | 68 | __view_get(Alarm_1:4 ×30), init_shake(Alarm_0:3), instance_create(Alarm_1:4 ×10) | 27/43 |
| [obj_mini_flag](objects/obj_mini_flag/obj_mini_flag.yy) | - | spr_SMB_mini_flag | Create_0, Step_0 | 8 | - | 15/31 |
| [obj_mini_icicle](objects/obj_mini_icicle/obj_mini_icicle.yy) | obj_icicle | spr_mini_icicle | Alarm_1, Other_10 | 45 | instance_create(Alarm_1:1 ×3) | 15/34 |
| [obj_mini_icicle2](objects/obj_mini_icicle2/obj_mini_icicle2.yy) | obj_icicle2 | spr_mini_icicle2 | - | 0 | - | 12/31 |
| [obj_mini_icicle2_res](objects/obj_mini_icicle2_res/obj_mini_icicle2_res.yy) | obj_parent_resource | spr_mini_icicle2_res | Other_10, Other_11, Step_2 | 64 | instance_create(Other_10:1 ×5) | 16/35 |
| [obj_mini_icicle_res](objects/obj_mini_icicle_res/obj_mini_icicle_res.yy) | obj_parent_resource | spr_mini_icicle_res | Other_10, Other_11, Step_2 | 64 | instance_create(Other_10:1 ×5) | 16/35 |
| [obj_modelbgo](objects/obj_modelbgo/obj_modelbgo.yy) | obj_deactivation | - | Collision_obj_mario | 11 | - | 14/33 |
| [obj_modelbgo_dec](objects/obj_modelbgo_dec/obj_modelbgo_dec.yy) | obj_modelbgo | - | - | 0 | - | 12/31 |
| [obj_modelsizable](objects/obj_modelsizable/obj_modelsizable.yy) | obj_deactivation | spr_empty | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12 | 121 | instance_create(Alarm_0:1) | 21/40 |
| [obj_modelsolid](objects/obj_modelsolid/obj_modelsolid.yy) | obj_solid | - | Alarm_0, Create_0, Destroy_0, Draw_0 | 29 | instance_create(Alarm_0:5 ×2) | 17/36 |
| [obj_modo_sonidos_control](objects/obj_modo_sonidos_control/obj_modo_sonidos_control.yy) | - | spr_expand_bg | Draw_0 | 20 | scr_language(Draw_0:5 ×5) | 14/30 |
| [obj_monty_chase](objects/obj_monty_chase/obj_monty_chase.yy) | obj_deactenemyparent | spr_montymole | Alarm_10, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_0 | 204 | instance_create(Destroy_0:5 ×7) | 20/39 |
| [obj_monty_res](objects/obj_monty_res/obj_monty_res.yy) | obj_parent_resource | spr_monty_res | Create_0, Other_10, Step_2 | 16 | instance_create(Other_10:1) | 16/35 |
| [obj_multiveggiecoin](objects/obj_multiveggiecoin/obj_multiveggiecoin.yy) | obj_physicsparent | spr_coin | Alarm_0, Alarm_1, Collision_obj_mario, Create_0, Step_0 | 36 | instance_create(Alarm_0:3 ×3) | 18/40 |
| [obj_muncher](objects/obj_muncher/obj_muncher.yy) | obj_physicssolid | spr_muncher | Alarm_0, Alarm_9, Collision_obj_shield_left, Collision_obj_shield_right, Create_0, Draw_0, Other_10, Other_13, Other_14, Other_24, Step_0, Step_1 | 384 | init_shake(Other_14:34), instance_create(Other_10:1 ×2), scr_snd_thwomp(Other_14:32 ×2) | 25/47 |
| [obj_muncher_b](objects/obj_muncher_b/obj_muncher_b.yy) | obj_muncher | spr_muncher_b | Create_0, Other_10 | 98 | instance_create(Other_10:1 ×2) | 15/34 |
| [obj_muncher_b_res](objects/obj_muncher_b_res/obj_muncher_b_res.yy) | obj_parent_resource | spr_muncher_b_deads | Create_0, Other_10, Other_13, Step_2 | 59 | instance_create(Other_10:1 ×3), scr_snd_powerdown(Other_13:1) | 17/36 |
| [obj_muncher_res](objects/obj_muncher_res/obj_muncher_res.yy) | obj_parent_resource | spr_muncher_res | Alarm_0, Create_0, Other_10, Other_13, Step_2 | 93 | instance_create(Other_10:1 ×2), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_mushroom](objects/obj_mushroom/obj_mushroom.yy) | obj_powerupparent | spr_mushroom | Alarm_0, Alarm_10, Collision_obj_blockparent, Collision_obj_mario, Create_0, Other_13, Step_0, Step_1 | 263 | instance_create(Collision_obj_blockparent:5 ×5), scr_snd_powerup(Collision_obj_mario:26 ×4) | 21/43 |
| [obj_mushroom_platform_res](objects/obj_mushroom_platform_res/obj_mushroom_platform_res.yy) | obj_parent_resource | spr_mp1 | Alarm_0, Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Other_15, Step_2 | 312 | instance_create(Mouse_4:35 ×4), scr_insideview(Mouse_4:1), scr_mushroom_platform1_sprites(Step_2:2), scr_mushroom_platform2_sprites(Step_2:4), scr_mushroom_platform3_sprites(Step_2:6) | 24/43 |
| [obj_mushroom_res](objects/obj_mushroom_res/obj_mushroom_res.yy) | obj_parent_resource | spr_SMB_mushroom | Create_0, Other_10, Other_14, Step_2 | 48 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_musicblock](objects/obj_musicblock/obj_musicblock.yy) | obj_noteblock | spr_musicblock | Alarm_1, Create_0, Draw_0, Step_0 | 155 | draw_sprite_custom_origin(Draw_0:6), instance_create(Alarm_1:6) | 17/39 |
| [obj_musicblock_res](objects/obj_musicblock_res/obj_musicblock_res.yy) | obj_parent_resource_block | spr_musicblock | Other_10, Other_11, Step_2 | 110 | instance_create(Other_10:1 ×5) | 16/35 |
| [obj_n64_or](objects/obj_n64_or/obj_n64_or.yy) | obj_parent_sound_o | spr_square | Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw, Create_0, Other_10, Step_2 | 68 | instance_create(Other_10:1) | 20/39 |
| [obj_n64_snd_res](objects/obj_n64_snd_res/obj_n64_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_13 | 5 | instance_create(Other_13:1) | 15/34 |
| [obj_next_before](objects/obj_next_before/obj_next_before.yy) | - | spr_next_before | Create_0, Draw_0, Mouse_4, Other_10, Step_0 | 142 | instance_create(Other_10:25 ×2) | 18/34 |
| [obj_night_change](objects/obj_night_change/obj_night_change.yy) | obj_parent_layout | spr_change_night | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_7, Other_10, Other_11, Other_12, Other_13 | 617 | __background_set(Other_11:2 ×159), instance_create(Other_13:8), scr_bg_airship(Other_11:116), scr_bg_beach(Other_11:252), scr_bg_castle(Other_11:53), scr_bg_desert(Other_11:181), scr_bg_fall(Other_11:231), scr_bg_forest(Other_11:139), scr_bg_ghost_house(Other_11:74 ×2), scr_bg_ground(Other_11:32), scr_bg_mountain(Other_11:292), scr_bg_sky(Other_11:162), scr_bg_snow(Other_11:214), scr_bg_underground(Other_11:38), scr_bg_underwater(Other_11:59), scr_create_bg_anim(Other_11:300), scr_snd_airship(Other_11:117), scr_snd_autumn(Other_11:232), scr_snd_beach(Other_11:253), scr_snd_castle(Other_11:54), scr_snd_desert(Other_11:182), scr_snd_editor_airship(Other_11:118), scr_snd_editor_castle(Other_11:55), scr_snd_editor_desert(Other_11:183), scr_snd_editor_forest(Other_11:141 ×2), scr_snd_editor_ghost(Other_11:79), scr_snd_editor_ground(Other_11:34 ×2), scr_snd_editor_mountain(Other_11:295), scr_snd_editor_sky(Other_11:164), scr_snd_editor_snow(Other_11:216), scr_snd_editor_underground(Other_11:40), scr_snd_editor_underwater(Other_11:61), scr_snd_forest(Other_11:140), scr_snd_ghost_house(Other_11:78), scr_snd_ground(Other_11:33), scr_snd_mountain(Other_11:294), scr_snd_sky(Other_11:163), scr_snd_snow(Other_11:215), scr_snd_underground(Other_11:39), scr_snd_underwater(Other_11:60) | 22/41 |
| [obj_ninji](objects/obj_ninji/obj_ninji.yy) | obj_deactenemyparent | spr_ninji | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 148 | - | 18/37 |
| [obj_ninji_res](objects/obj_ninji_res/obj_ninji_res.yy) | obj_parent_resource | spr_ninji | Create_0, Step_2 | 20 | - | 15/34 |
| [obj_nota_musical_or](objects/obj_nota_musical_or/obj_nota_musical_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_nota_musical_snd_res](objects/obj_nota_musical_snd_res/obj_nota_musical_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_noteblock](objects/obj_noteblock/obj_noteblock.yy) | obj_blockparent | spr_noteblock | Alarm_0, Alarm_1, Alarm_3, Alarm_4, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_11, Other_14, Other_15, Step_0 | 356 | __view_get(Other_14:2 ×3), draw_sprite_custom_origin(Draw_0:6), instance_create(Other_10:6 ×4), scr_constant_get_sprite(Other_10:17 ×2), scr_snd_sprout(Other_10:5 ×2) | 25/47 |
| [obj_noteblock_res](objects/obj_noteblock_res/obj_noteblock_res.yy) | obj_parent_resource_block | spr_noteblock | Collision_obj_parent_resource, Create_0, Draw_0, Other_10, Other_11, Other_12, Step_2 | 179 | instance_create(Other_10:1 ×5), outside_view(Draw_0:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 20/39 |
| [obj_noteblock_s](objects/obj_noteblock_s/obj_noteblock_s.yy) | obj_noteblock | spr_noteblock_s | Alarm_1, Create_0, Step_0 | 111 | instance_create(Alarm_1:33 ×2) | 16/38 |
| [obj_noteblock_s_res](objects/obj_noteblock_s_res/obj_noteblock_s_res.yy) | obj_parent_resource_block | spr_noteblock_s | Other_10, Other_11, Step_2 | 63 | instance_create(Other_10:1 ×5) | 16/35 |
| [obj_noti_load_button](objects/obj_noti_load_button/obj_noti_load_button.yy) | obj_button_parent | spr_bt_parent | Alarm_0, Create_0, Mouse_4 | 14 | - | 16/35 |
| [obj_nube](objects/obj_nube/obj_nube.yy) | obj_solidtop | spr_nube | Collision_obj_thwomp, Create_0, Step_1 | 72 | instance_create(Collision_obj_thwomp:11), scr_snd_thwomp(Collision_obj_thwomp:3) | 16/35 |
| [obj_nube_res](objects/obj_nube_res/obj_nube_res.yy) | obj_parent_resource | spr_nube | Collision_obj_parent_resource, Step_2 | 57 | - | 15/34 |
| [obj_oneway_res](objects/obj_oneway_res/obj_oneway_res.yy) | obj_parent_resource | spr_oneway_res | Alarm_1, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Step_2 | 86 | instance_create(Mouse_4:41), scr_insideview(Mouse_4:1) | 19/38 |
| [obj_onewaygate_bottom](objects/obj_onewaygate_bottom/obj_onewaygate_bottom.yy) | obj_deactivation | spr_oneway | Create_0, Draw_0, Other_10, Step_2 | 60 | scr_snd_oneway(Other_10:1 ×2) | 17/36 |
| [obj_onewaygate_left](objects/obj_onewaygate_left/obj_onewaygate_left.yy) | obj_deactivation | spr_oneway | Create_0, Draw_0, Other_10, Step_2 | 60 | scr_snd_oneway(Other_10:1 ×2) | 17/36 |
| [obj_onewaygate_right](objects/obj_onewaygate_right/obj_onewaygate_right.yy) | obj_deactivation | spr_oneway | Create_0, Draw_0, Other_10, Step_2 | 60 | scr_snd_oneway(Other_10:1 ×2) | 17/36 |
| [obj_onewaygate_top](objects/obj_onewaygate_top/obj_onewaygate_top.yy) | obj_deactivation | spr_oneway | Create_0, Destroy_0, Draw_0, Other_10, Step_2 | 81 | instance_create(Create_0:22), scr_snd_oneway(Other_10:1 ×2) | 18/37 |
| [obj_onoffblock](objects/obj_onoffblock/obj_onoffblock.yy) | obj_blockparent | spr_onoffblock_on | Alarm_1, Alarm_4, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_0, Step_1 | 211 | draw_sprite_custom_origin(Draw_0:3) | 22/44 |
| [obj_onoffblock_res](objects/obj_onoffblock_res/obj_onoffblock_res.yy) | obj_parent_resource_block | spr_onoffblock_on | Step_2 | 20 | - | 14/33 |
| [obj_onoffplatform](objects/obj_onoffplatform/obj_onoffplatform.yy) | obj_deactivation | spr_onoffplatform | Create_0, Destroy_0, Step_0 | 42 | instance_create(Step_0:4) | 16/38 |
| [obj_onoffplatform_blue](objects/obj_onoffplatform_blue/obj_onoffplatform_blue.yy) | obj_deactivation | spr_onoffplatform_blue | Create_0, Destroy_0, Step_0 | 43 | instance_create(Step_0:4) | 16/35 |
| [obj_onoffplatform_blue_res](objects/obj_onoffplatform_blue_res/obj_onoffplatform_blue_res.yy) | obj_parent_resource | spr_onoffplatform_blue | Create_0, Other_10, Other_11, Step_2 | 53 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_onoffplatform_d](objects/obj_onoffplatform_d/obj_onoffplatform_d.yy) | - | spr_onoffplatform | - | 0 | - | 12/28 |
| [obj_onoffplatform_res](objects/obj_onoffplatform_res/obj_onoffplatform_res.yy) | obj_parent_resource_block | spr_onoffplatform | Create_0, Other_10, Other_11, Step_2 | 53 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_panel_circle](objects/obj_panel_circle/obj_panel_circle.yy) | - | spr_panel_circle | Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_21, Other_22, Other_23, Step_2 | 1202 | instance_create(Other_10:7 ×99) | 31/47 |
| [obj_panel_expand](objects/obj_panel_expand/obj_panel_expand.yy) | - | spr_expand_bg | Create_0, Destroy_0, Draw_0 | 479 | instance_create(Create_0:213 ×9), scr_header(Create_0:216 ×4) | 16/32 |
| [obj_panel_left](objects/obj_panel_left/obj_panel_left.yy) | obj_parent_layout | spr_panel_left | Create_0, Destroy_0, Draw_0, Step_0 | 26 | instance_create(Create_0:1 ×8) | 17/36 |
| [obj_panel_save_load](objects/obj_panel_save_load/obj_panel_save_load.yy) | obj_panelparent | spr_panel_save_load | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0, Step_1 | 58 | instance_create(Other_7:5 ×3), scr_language(Draw_0:16) | 20/39 |
| [obj_panel_time](objects/obj_panel_time/obj_panel_time.yy) | obj_panelsparent | spr_panel_time | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 88 | instance_create(Mouse_4:16), scr_anim_hover(Draw_0:10), string_add_zeros(Draw_0:6) | 19/38 |
| [obj_panelparent](objects/obj_panelparent/obj_panelparent.yy) | - | - | Step_1 | 7 | - | 14/30 |
| [obj_panelsparent](objects/obj_panelsparent/obj_panelsparent.yy) | obj_parent_layout | - | Alarm_0, Create_0 | 4 | - | 15/34 |
| [obj_paracaidas_dead](objects/obj_paracaidas_dead/obj_paracaidas_dead.yy) | obj_deactivation | spr_paracaidas_editor | Create_0, Step_0 | 10 | - | 15/34 |
| [obj_paracaidas_go](objects/obj_paracaidas_go/obj_paracaidas_go.yy) | - | spr_paracaidas | Create_0, Step_0 | 11 | - | 15/31 |
| [obj_parcarry](objects/obj_parcarry/obj_parcarry.yy) | obj_physicsparent | - | Alarm_0, Alarm_10, Collision_obj_enemyparent, Create_0, Destroy_0, Draw_0, Other_10, Other_15, Other_7, Step_0, Step_2 | 528 | instance_create(Alarm_0:5 ×16), scr_snd_kick(Collision_obj_enemyparent:5 ×2) | 24/43 |
| [obj_parent_layout](objects/obj_parent_layout/obj_parent_layout.yy) | - | spr_sys_parent | - | 0 | - | 12/28 |
| [obj_parent_resource](objects/obj_parent_resource/obj_parent_resource.yy) | obj_parent_save | spr_sys_parent | Alarm_0, Alarm_5, Collision_obj_key_res, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_0, Mouse_1, Mouse_10, Mouse_11, Mouse_4, Mouse_7, Other_0, Other_12, Other_14, Step_1 [yy登记但无gml: Collision_(yy缺collisionObjectId).gml] | 368 | instance_create(Collision_obj_key_res:6 ×5), outside_view(Draw_0:1), scr_insideview(Mouse_0:1 ×3), scr_sprite_get_constant_res(Collision_obj_key_res:21) | 29/48 |
| [obj_parent_resource_block](objects/obj_parent_resource_block/obj_parent_resource_block.yy) | obj_parent_resource | - | - | 0 | - | 12/31 |
| [obj_parent_save](objects/obj_parent_save/obj_parent_save.yy) | - | spr_sys_parent | Create_0 | 3 | - | 14/30 |
| [obj_parent_sound_o](objects/obj_parent_sound_o/obj_parent_sound_o.yy) | - | spr_sys_parent | Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw, Create_0, Other_10, Step_2 | 34 | instance_create(Other_10:1) | 20/36 |
| [obj_parent_sounds](objects/obj_parent_sounds/obj_parent_sounds.yy) | obj_parent_resource | spr_sys_parent | Alarm_0, Collision_obj_parent_resource, Create_0, Mouse_0, Mouse_1, Mouse_10, Mouse_4, Step_2 | 134 | instance_create(Mouse_4:27) | 21/40 |
| [obj_pausa_button](objects/obj_pausa_button/obj_pausa_button.yy) | obj_button_parent | spr_bt_parent_white | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, KeyPress_82, Mouse_4 | 74 | scr_anim_hover(Draw_0:10), scr_language(Create_0:3) | 20/39 |
| [obj_pballon](objects/obj_pballon/obj_pballon.yy) | obj_powerupparent | spr_pballon | Alarm_10, Collision_obj_mario, Create_0, Step_0 | 106 | instance_create(Collision_obj_mario:13 ×3), scr_sprite_get_constant(Collision_obj_mario:15) | 17/36 |
| [obj_pblock](objects/obj_pblock/obj_pblock.yy) | obj_deactivation | spr_pblock | Create_0, Destroy_0, Other_10, Step_0 | 130 | instance_create(Other_10:19 ×5), scr_snd_switchsong(Step_0:1) | 17/36 |
| [obj_pblock2_res](objects/obj_pblock2_res/obj_pblock2_res.yy) | obj_parent_resource | spr_pblock | Create_0, Other_10, Other_11, Step_2 | 53 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_pblock_res](objects/obj_pblock_res/obj_pblock_res.yy) | obj_parent_resource_block | spr_pblock | Other_10, Other_11, Step_2 | 50 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_penguin_attack](objects/obj_penguin_attack/obj_penguin_attack.yy) | - | spr_square_b | Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Step_0 | 70 | instance_create(Collision_obj_enemyparent:7 ×2), scr_snd_kick(Collision_obj_enemyparent:3 ×4) | 17/33 |
| [obj_penguin_suit](objects/obj_penguin_suit/obj_penguin_suit.yy) | obj_powerupparent | spr_NSMBU_penguin | Alarm_10, Create_0 | 19 | - | 15/34 |
| [obj_persistent](objects/obj_persistent/obj_persistent.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Alarm_8, Alarm_9, Create_0, Draw_0, Draw_64, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_2, Other_3, Other_4, Other_5, Other_60, Other_70, Step_0 | 893 | __background_set(Alarm_4:11), background_create_from_surface(Other_10:5 ×2), gpu_set_blendenable(Draw_0:4 ×4), init_shockwave(Create_0:2), instance_create(Alarm_4:20 ×9), scr_init_globals(Create_0:109), scr_snd_switchalert(Alarm_6:1), sprite_delete(Alarm_0:15), sprite_exists(Alarm_0:14 ×2) | 43/62 |
| [obj_physicsparent](objects/obj_physicsparent/obj_physicsparent.yy) | obj_deactivation | spr_mushroom | Collision_obj_blockparent, Draw_0, Other_13, Other_14, Other_24, Step_0, Step_2 | 185 | - | 20/42 |
| [obj_physicssolid](objects/obj_physicssolid/obj_physicssolid.yy) | obj_physicsparent | spr_muncher | Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_mario, Collision_obj_powerupparent | 63 | instance_create(Collision_obj_enemyparent:11 ×3), scr_snd_kick(Collision_obj_bossparent:7 ×6) | 18/37 |
| [obj_pinchos](objects/obj_pinchos/obj_pinchos.yy) | obj_solid | spr_pinchos | Alarm_0, Create_0, Destroy_0, Draw_0 | 138 | instance_create(Alarm_0:5 ×2) | 17/36 |
| [obj_pinchos_res](objects/obj_pinchos_res/obj_pinchos_res.yy) | obj_parent_resource_block | spr_pinchos | Step_2 | 51 | - | 14/33 |
| [obj_pink_coin](objects/obj_pink_coin/obj_pink_coin.yy) | obj_deactivation | spr_pink_coin | Alarm_0, Collision_obj_enemyparent_held, Collision_obj_link_arrow, Collision_obj_mario, Collision_obj_shell_held, Collision_obj_snow_ball, Collision_obj_snow_ball_held, Create_0, Draw_0, Other_10, Other_11, Step_0 | 171 | instance_create(Alarm_0:1 ×4) | 25/44 |
| [obj_pink_coin_res](objects/obj_pink_coin_res/obj_pink_coin_res.yy) | obj_parent_resource | spr_pink_coin | Create_0, Step_2 | 20 | - | 15/34 |
| [obj_pipebase](objects/obj_pipebase/obj_pipebase.yy) | obj_solid | spr_pipebase | Create_0 | 50 | - | 14/33 |
| [obj_pipebase_res](objects/obj_pipebase_res/obj_pipebase_res.yy) | obj_parent_resource_block | spr_pipebase | Create_0, Step_2 | 52 | - | 15/34 |
| [obj_piranhaplant](objects/obj_piranhaplant/obj_piranhaplant.yy) | obj_deactenemyparent | spr_jumppiranha | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Collision_obj_mario, Create_0, Draw_0, Other_10, Step_0 | 191 | instance_create(Other_10:4 ×5) | 24/43 |
| [obj_plant_fire](objects/obj_plant_fire/obj_plant_fire.yy) | obj_enemyparent | spr_pplant_fire_down | Alarm_10, Alarm_2, Alarm_3, Alarm_4, Create_0, Destroy_0, Draw_0, Other_10, Other_7, Step_2 | 191 | instance_create(Alarm_3:10 ×5) | 23/42 |
| [obj_plant_fire_res](objects/obj_plant_fire_res/obj_plant_fire_res.yy) | obj_parent_resource | spr_plant_fire_res | Create_0, Draw_0, Other_10, Other_11, Other_14, Step_2 | 77 | instance_create(Other_10:1 ×5) | 19/38 |
| [obj_plantfire](objects/obj_plantfire/obj_plantfire.yy) | - | spr_fireball | Alarm_0, Collision_obj_bullebill_base, Collision_obj_mario, Collision_obj_muncher, Collision_obj_pinchos, Collision_obj_solid, Collision_obj_solidtop, Create_0, Other_10, Step_0 | 54 | instance_create(Alarm_0:1 ×2), outside_view(Step_0:1), scr_snd_bump(Other_10:1) | 23/42 |
| [obj_plataforma](objects/obj_plataforma/obj_plataforma.yy) | obj_platform_parent | spr_platform | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 61 | - | 18/40 |
| [obj_plataforma_blue](objects/obj_plataforma_blue/obj_plataforma_blue.yy) | obj_platform_parent | spr_platform_blue | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, Step_0 | 95 | instance_create(Alarm_2:1), outside_view(Step_0:20) | 19/41 |
| [obj_platform_blue_res](objects/obj_platform_blue_res/obj_platform_blue_res.yy) | obj_parent_resource | spr_platform_blue | Alarm_3, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Other_14, Step_2 | 203 | instance_create(Mouse_4:35 ×7), scr_insideview(Mouse_4:1) | 22/41 |
| [obj_platform_help](objects/obj_platform_help/obj_platform_help.yy) | obj_solid | spr_platform_help | Create_0, Draw_0, Step_2 | 16 | - | 16/35 |
| [obj_platform_parent](objects/obj_platform_parent/obj_platform_parent.yy) | obj_solidtop | spr_platform | Step_2 | 41 | - | 14/33 |
| [obj_platform_res](objects/obj_platform_res/obj_platform_res.yy) | obj_parent_resource | spr_platform | Alarm_3, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Step_2 | 192 | instance_create(Mouse_4:43 ×5), scr_insideview(Mouse_4:1) | 21/40 |
| [obj_play_screen](objects/obj_play_screen/obj_play_screen.yy) | - | spr_creator_play_base | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10, Other_11, Other_12, Step_2 | 93 | instance_create(Other_10:3), scr_anim_hover(Draw_0:7 ×2) | 24/40 |
| [obj_player_goal_nsmbu](objects/obj_player_goal_nsmbu/obj_player_goal_nsmbu.yy) | obj_player_goal_smb1 | spr_NSMBU_mario_small_climb_pole | Alarm_4, Alarm_5, Alarm_6, Collision_obj_flagpole, Create_0, Draw_0, Other_13, Other_23, Other_7, Step_0 | 426 | instance_create(Create_0:67 ×7), scr_NSMBU_climb_pole(Create_0:3 ×3), scr_NSMBU_goal_pole(Alarm_5:6 ×2), scr_NSMBU_jump1(Other_23:20 ×2), scr_NSMBU_jump2(Other_23:23 ×2), scr_NSMBU_jump3(Other_23:26 ×2), scr_NSMBU_standup_pole(Other_23:75 ×2), scr_NSMBU_walk(Other_23:9 ×2) | 23/42 |
| [obj_player_goal_parent](objects/obj_player_goal_parent/obj_player_goal_parent.yy) | - | spr_mario_big_idle | Create_0, Draw_0, Other_13, Other_14, Step_0 | 267 | instance_create(Create_0:50 ×9) | 18/34 |
| [obj_player_goal_smb1](objects/obj_player_goal_smb1/obj_player_goal_smb1.yy) | obj_player_goal_parent | spr_SMB_mario_small_climb | Alarm_0, Alarm_11, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Collision_obj_flagpole, Create_0, Draw_0, Other_14, Other_23, Other_40, Step_0 | 278 | instance_create(Alarm_2:9), scr_mariogoal(Create_0:4 ×2), scr_marioidle(Other_23:24), scr_mariojump(Other_23:41), scr_marioswimhold(Other_23:36), scr_mariowalk(Other_23:30) | 26/45 |
| [obj_player_goal_smb2](objects/obj_player_goal_smb2/obj_player_goal_smb2.yy) | obj_player_goal_smb3 | - | Create_0, Step_0 | 48 | scr_jump(Step_0:36) | 15/34 |
| [obj_player_goal_smb3](objects/obj_player_goal_smb3/obj_player_goal_smb3.yy) | obj_player_goal_parent | spr_SMB3_mario_small_walk | Create_0, Draw_0, Other_40, Step_0, Step_2 | 115 | scr_marioidle(Step_2:28), scr_mariojump(Step_2:18), scr_marioswimhold(Step_2:13), scr_mariowalk(Step_2:33) | 18/37 |
| [obj_player_goal_smw](objects/obj_player_goal_smw/obj_player_goal_smw.yy) | obj_player_goal_parent | spr_mario_small_idle | Alarm_2, Alarm_3, Alarm_4, Create_0, Draw_0, Other_13, Step_0, Step_2 | 270 | scr_mario_yoshi_goal(Draw_0:38), scr_mariodrop(Step_2:50), scr_marioduck(Alarm_3:1), scr_mariogoal(Step_2:15), scr_marioidle(Alarm_2:7 ×3), scr_mariojump(Step_2:52), scr_marioride(Draw_0:25 ×3), scr_marioswimhold(Step_2:44), scr_mariowalk(Step_2:35) | 21/40 |
| [obj_player_goal_smw_castle](objects/obj_player_goal_smw_castle/obj_player_goal_smw_castle.yy) | obj_player_goal_smw | spr_mario_small_walk | Alarm_2, Alarm_5, Alarm_6, Create_0, Draw_0, Other_14, Other_40, Step_0, Step_2 | 419 | scr_NSMBU_idle(Create_0:4 ×2), scr_NSMBU_jump1(Step_2:42 ×2), scr_NSMBU_jump2(Step_2:45 ×2), scr_NSMBU_jump3(Step_2:48 ×2), scr_NSMBU_walk(Step_2:33), scr_mario_yoshi_goal(Draw_0:29), scr_mariodrop(Step_2:122), scr_marioidle(Create_0:7 ×2), scr_mariojump(Step_2:124), scr_marioride(Draw_0:24 ×2), scr_mariowalk(Step_2:115) | 22/41 |
| [obj_player_trail](objects/obj_player_trail/obj_player_trail.yy) | - | - | Create_0, Draw_0 | 32 | - | 15/31 |
| [obj_player_warp](objects/obj_player_warp/obj_player_warp.yy) | - | spr_mario_small_idle | Alarm_0, Alarm_1, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Step_0, Step_2 | 415 | instance_create(Alarm_1:4 ×7), scr_NSMBU_ground_idle(Step_2:7), scr_NSMBU_hold_ground(Step_2:9), scr_NSMBU_walkpipes(Step_2:19), scr_mario_drybones(Draw_0:62 ×2), scr_mario_shoe(Draw_0:72 ×4), scr_mariohold(Step_2:31), scr_marioidle(Step_2:25), scr_marioride(Draw_0:53), scr_mariowalk(Step_2:27), scr_snd_pipes(Other_10:1 ×2) | 23/39 |
| [obj_podoboo](objects/obj_podoboo/obj_podoboo.yy) | obj_enemyparent | spr_podoboo | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Collision_obj_bobomb, Create_0, Draw_0, Other_10, Step_0 | 165 | instance_create(Alarm_2:6 ×7) | 22/44 |
| [obj_podoboo_b](objects/obj_podoboo_b/obj_podoboo_b.yy) | obj_podoboo | spr_podoboo_b | Create_0 | 36 | - | 14/33 |
| [obj_podoboo_b_res](objects/obj_podoboo_b_res/obj_podoboo_b_res.yy) | obj_parent_resource | spr_podoboo_b | Create_0, Other_10, Other_13, Other_14, Step_2 | 50 | instance_create(Other_10:1 ×3), scr_snd_powerdown(Other_13:1) | 18/37 |
| [obj_podoboo_res](objects/obj_podoboo_res/obj_podoboo_res.yy) | obj_parent_resource | spr_podoboo_res | Other_10, Other_13, Other_14, Step_2 | 23 | instance_create(Other_10:1 ×2), scr_snd_powerup(Other_13:1) | 17/36 |
| [obj_pokey](objects/obj_pokey/obj_pokey.yy) | obj_deactenemyparent | spr_pokey | Alarm_0, Alarm_10, Alarm_11, Alarm_9, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_17, Step_0, Step_1 | 292 | instance_create(Destroy_0:5 ×5) | 26/45 |
| [obj_pokey_res](objects/obj_pokey_res/obj_pokey_res.yy) | obj_parent_resource | spr_pokey | Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_13, Step_2 | 231 | instance_create(Collision_obj_parent_resource:8 ×4), outside_view(Draw_0:1), scr_insideview(Mouse_4:1) | 20/39 |
| [obj_pow_res](objects/obj_pow_res/obj_pow_res.yy) | obj_parent_resource | spr_block_pow | Step_2 | 31 | - | 14/33 |
| [obj_powerupparent](objects/obj_powerupparent/obj_powerupparent.yy) | obj_physicsparent | spr_fireflower | Alarm_10, Collision_obj_blockparent, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_13, Step_0 | 309 | instance_create(Collision_obj_blockparent:5 ×12), outside_view(Step_0:11), scr_snd_powerup(Collision_obj_mario:49 ×8), scr_sprite_get_constant(Collision_obj_mario:24) | 21/43 |
| [obj_powerupsprout](objects/obj_powerupsprout/obj_powerupsprout.yy) | - | spr_mushroom | Alarm_0, Alarm_1, Alarm_2, Create_0 | 164 | instance_create(Alarm_1:5 ×5), scr_constant_make_object(Alarm_1:10 ×3), scr_snd_sprout(Alarm_0:57) | 17/36 |
| [obj_powerupsprout_note](objects/obj_powerupsprout_note/obj_powerupsprout_note.yy) | - | spr_mushroom | Alarm_0, Alarm_1, Create_0 | 138 | instance_create(Alarm_1:20 ×4), scr_constant_make_object(Alarm_1:29 ×2), scr_snd_sprout(Alarm_0:58) | 16/35 |
| [obj_pplant_res](objects/obj_pplant_res/obj_pplant_res.yy) | obj_parent_resource | spr_pplant_res | Create_0, Draw_0, Other_10, Other_11, Other_14, Step_2 | 118 | instance_create(Other_10:1 ×5), outside_view(Draw_0:1) | 19/38 |
| [obj_profile](objects/obj_profile/obj_profile.yy) | obj_settings_button | spr_profile | Create_0, Draw_0, Mouse_10, Mouse_11 | 32 | scr_anim_hover(Draw_0:13) | 17/36 |
| [obj_propellershroom](objects/obj_propellershroom/obj_propellershroom.yy) | obj_powerupparent | spr_NSMBU_champicoptero | Alarm_10, Create_0, Step_0 | 106 | outside_view(Step_0:71) | 16/38 |
| [obj_pswitch](objects/obj_pswitch/obj_pswitch.yy) | obj_holdparent | spr_pswitch | Alarm_1, Alarm_10, Alarm_3, Collision_obj_bullebill_base, Collision_obj_clown, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_icicle, Collision_obj_link_arrow, Collision_obj_mario, Collision_obj_physicssolid, Collision_obj_superball, Create_0, Destroy_0, Draw_0, Other_11, Other_13, Other_14, Other_16, Other_17, Step_0 | 443 | instance_create(Alarm_3:3 ×9), scr_canhold(Step_0:23), scr_snd_pwarning(Other_17:6) | 34/56 |
| [obj_pswitch_press](objects/obj_pswitch_press/obj_pswitch_press.yy) | obj_physicsparent | spr_pswitch_press | Alarm_0, Alarm_1, Create_0, Destroy_0, Step_0 | 27 | instance_create(Create_0:7) | 18/37 |
| [obj_pswitch_res](objects/obj_pswitch_res/obj_pswitch_res.yy) | obj_parent_resource | spr_pswitch | Create_0, Draw_0, Other_10, Other_14, Step_0, Step_2 | 79 | instance_create(Other_10:1 ×3) | 19/38 |
| [obj_puente_res](objects/obj_puente_res/obj_puente_res.yy) | obj_parent_resource | spr_puente | Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_13, Step_2 | 310 | instance_create(Collision_obj_parent_resource:8 ×3), scr_insideview(Mouse_4:1) | 20/39 |
| [obj_puller](objects/obj_puller/obj_puller.yy) | - | - | Alarm_0, Alarm_1, Create_0, Destroy_0, Draw_0, Other_10, Step_0 | 107 | instance_create(Alarm_1:7 ×4), scr_mario_pull(Create_0:1) | 20/36 |
| [obj_qblock_res](objects/obj_qblock_res/obj_qblock_res.yy) | obj_parent_resource_block | spr_qblock | Collision_obj_parent_resource, Create_0, Draw_0, Other_12, Step_2 | 97 | outside_view(Draw_0:1), scr_sprite_get_constant_res(Collision_obj_parent_resource:6) | 18/37 |
| [obj_quicksand](objects/obj_quicksand/obj_quicksand.yy) | - | spr_quicksand | Collision_obj_mario, Create_0 | 13 | - | 15/34 |
| [obj_rails](objects/obj_rails/obj_rails.yy) | - | spr_NSMBU_rails | Create_0, Draw_0, Step_0 | 40 | - | 16/32 |
| [obj_rails_res](objects/obj_rails_res/obj_rails_res.yy) | obj_parent_resource | spr_NSMBU_rails | Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_13, Step_2 | 151 | instance_create(Mouse_4:35 ×2), scr_insideview(Mouse_4:1) | 20/39 |
| [obj_rainmaker](objects/obj_rainmaker/obj_rainmaker.yy) | - | spr_marker_event | Create_0, Destroy_0, Other_10, Step_2 | 27 | - | 17/33 |
| [obj_remolino_or](objects/obj_remolino_or/obj_remolino_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_remolino_snd_res](objects/obj_remolino_snd_res/obj_remolino_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_rename](objects/obj_rename/obj_rename.yy) | - | spr_rename | Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 73 | - | 19/35 |
| [obj_rename_button2](objects/obj_rename_button2/obj_rename_button2.yy) | obj_button_parent | spr_bt_parent | Create_0, Mouse_4 | 20 | scr_language(Mouse_4:17), scr_toast(Mouse_4:17) | 15/34 |
| [obj_rename_button3](objects/obj_rename_button3/obj_rename_button3.yy) | - | spr_bt_lg | Create_0, Mouse_10, Mouse_11, Mouse_4 | 12 | - | 17/33 |
| [obj_rename_close](objects/obj_rename_close/obj_rename_close.yy) | - | spr_button_close | Create_0, Mouse_4 | 9 | - | 15/31 |
| [obj_rename_control](objects/obj_rename_control/obj_rename_control.yy) | - | spr_panel_save | Create_0, Destroy_0, Draw_0 | 39 | background_create_from_surface(Create_0:8), gpu_set_blendenable(Draw_0:3 ×2), sprite_delete(Destroy_0:9), sprite_exists(Destroy_0:8 ×2) | 16/32 |
| [obj_rename_input](objects/obj_rename_input/obj_rename_input.yy) | - | spr_alert_setname | Alarm_0, Create_0, Destroy_0, Draw_0, Mouse_4, Other_63, Step_0 | 71 | scr_language(Mouse_4:2) | 20/36 |
| [obj_resource_empty](objects/obj_resource_empty/obj_resource_empty.yy) | obj_parent_resource | spr_cursor_square | Create_0 | 11 | - | 14/33 |
| [obj_risas_or](objects/obj_risas_or/obj_risas_or.yy) | obj_parent_sound_o | spr_square | Other_10 | 13 | instance_create(Other_10:1) | 14/33 |
| [obj_risas_snd_res](objects/obj_risas_snd_res/obj_risas_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_robot](objects/obj_robot/obj_robot.yy) | obj_parent_layout | spr_robot | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 77 | instance_create(Mouse_4:12), scr_anim_hover(Draw_0:7) | 19/38 |
| [obj_rocangrejo](objects/obj_rocangrejo/obj_rocangrejo.yy) | obj_deactenemyparent | spr_rocangrejo_idle | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, Other_10, Other_11, Other_12, Other_14, Other_7, Step_0 | 335 | instance_create(Alarm_2:5 ×11) | 24/43 |
| [obj_rocangrejo_res](objects/obj_rocangrejo_res/obj_rocangrejo_res.yy) | obj_parent_resource | spr_rocangrejo_res | Create_0, Step_2 | 10 | - | 15/34 |
| [obj_rock_res](objects/obj_rock_res/obj_rock_res.yy) | obj_parent_resource_block | spr_block_rock | Create_0, Other_14, Step_2 | 138 | instance_create(Other_14:9 ×2) | 16/35 |
| [obj_rockparent](objects/obj_rockparent/obj_rockparent.yy) | obj_solid | spr_block_rock | Alarm_0, Collision_obj_meteorites, Collision_obj_meteorites_big, Other_10, Step_0 | 251 | instance_create(Alarm_0:4 ×16), scr_snd_break(Alarm_0:2 ×2), scr_snd_kick(Other_10:7) | 18/37 |
| [obj_rocky](objects/obj_rocky/obj_rocky.yy) | obj_deactenemyparent | spr_rocky_idle | Alarm_0, Alarm_1, Alarm_2, Alarm_3, Alarm_4, Create_0, Draw_0, Other_10, Other_11, Other_12, Other_14, Other_16, Other_17, Other_7, Step_0 | 316 | instance_create(Other_10:1 ×8) | 28/47 |
| [obj_rocky_res](objects/obj_rocky_res/obj_rocky_res.yy) | obj_parent_resource | spr_rocky_res | Step_2 | 3 | - | 14/33 |
| [obj_rorock](objects/obj_rorock/obj_rorock.yy) | obj_wrench | spr_rocangrejo_rock | Alarm_2, Create_0, Draw_0, Other_10, Step_0 | 20 | instance_create(Other_10:1) | 18/37 |
| [obj_rotten_signal](objects/obj_rotten_signal/obj_rotten_signal.yy) | - | spr_rotten_signal | Create_0, Step_0 | 17 | - | 15/31 |
| [obj_score](objects/obj_score/obj_score.yy) | - | spr_SMB_points | Create_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_21, Other_22, Step_0 | 87 | - | 29/48 |
| [obj_score_flag](objects/obj_score_flag/obj_score_flag.yy) | obj_score | spr_points | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, Step_0 | 43 | - | 19/38 |
| [obj_scrollbar2](objects/obj_scrollbar2/obj_scrollbar2.yy) | - | spr_scrollbar | Create_0, Draw_0, Mouse_4, Mouse_56, Step_0 | 36 | - | 18/34 |
| [obj_scrollbar3](objects/obj_scrollbar3/obj_scrollbar3.yy) | - | spr_scrollbar | Create_0, Draw_0, Mouse_4, Mouse_56, Step_0 | 32 | - | 18/34 |
| [obj_scrollbar4](objects/obj_scrollbar4/obj_scrollbar4.yy) | - | spr_scrollbar | Create_0, Draw_0, Mouse_4, Mouse_56, Step_0 | 51 | - | 18/34 |
| [obj_selecting_fps](objects/obj_selecting_fps/obj_selecting_fps.yy) | - | spr_settings_minibutton | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 39 | scr_anim_hover(Draw_0:6) | 18/34 |
| [obj_selecting_player](objects/obj_selecting_player/obj_selecting_player.yy) | - | spr_settings_minibutton | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 64 | scr_anim_hover(Draw_0:6) | 18/34 |
| [obj_semisolid_platform1](objects/obj_semisolid_platform1/obj_semisolid_platform1.yy) | obj_parent_resource | spr_SMB_ssp1_overworld | Alarm_0, Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Other_15, Step_2 | 342 | instance_create(Mouse_4:35 ×4), scr_insideview(Mouse_4:1), scr_semisolid_platform1_sprites(Step_2:2), scr_semisolid_platform2_sprites(Step_2:4), scr_semisolid_platform3_sprites(Step_2:6) | 24/43 |
| [obj_serpentina_or](objects/obj_serpentina_or/obj_serpentina_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 14 | instance_create(Other_10:1) | 15/34 |
| [obj_serpentina_snd_res](objects/obj_serpentina_snd_res/obj_serpentina_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_settings_button](objects/obj_settings_button/obj_settings_button.yy) | - | spr_settings_button_about | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 64 | instance_create(Mouse_4:7), scr_anim_hover(Draw_0:5), scr_init_globals(Mouse_4:17) | 18/34 |
| [obj_settings_controls](objects/obj_settings_controls/obj_settings_controls.yy) | - | spr_controls_b | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Step_0 | 83 | key_to_string(Step_0:4 ×7), scr_anim_hover(Draw_0:8), set_keys(Mouse_4:4 ×7) | 19/35 |
| [obj_settings_custom](objects/obj_settings_custom/obj_settings_custom.yy) | - | spr_st_btn_controls | Create_0, Destroy_0, Draw_0, Mouse_10, Mouse_11, Mouse_4, Other_10 | 90 | instance_create(Create_0:10 ×9), scr_anim_hover(Draw_0:7), scr_language(Create_0:5) | 20/36 |
| [obj_settings_panel](objects/obj_settings_panel/obj_settings_panel.yy) | - | spr_sett_panel | Create_0, Destroy_0, Draw_0, Other_10 | 312 | instance_create(Create_0:95 ×38), scr_language(Create_0:4 ×10) | 17/33 |
| [obj_shake_mario](objects/obj_shake_mario/obj_shake_mario.yy) | - | spr_shake_mario | Create_0, Step_0 | 8 | - | 15/31 |
| [obj_shard](objects/obj_shard/obj_shard.yy) | - | spr_shard | Alarm_0, Create_0, Draw_0, Step_0 | 35 | outside_view(Step_0:1) | 17/36 |
| [obj_shell](objects/obj_shell/obj_shell.yy) | obj_enemyparent_held | spr_shell | Alarm_1, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Alarm_7, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_12, Other_17, Step_1 | 835 | instance_create(Alarm_4:14 ×41), scr_NSMBU_spinstomp(Collision_obj_mario:84), scr_canhold(Collision_obj_mario:5), scr_snd_kick(Collision_obj_mario:44 ×4), scr_snd_stomp(Collision_obj_mario:75 ×2) | 27/49 |
| [obj_shell_drybones](objects/obj_shell_drybones/obj_shell_drybones.yy) | obj_shell | spr_shell_drybones | Collision_obj_fireball, Collision_obj_mario, Create_0, Destroy_0, Other_10, Other_11, Other_12, Other_14, Other_17 | 376 | instance_create(Collision_obj_mario:50 ×10), scr_canhold(Collision_obj_mario:7), scr_snd_break(Other_10:1), scr_snd_kick(Collision_obj_mario:55 ×3) | 22/41 |
| [obj_shell_drybones_held](objects/obj_shell_drybones_held/obj_shell_drybones_held.yy) | obj_shell_held | spr_shell_drybones | Other_10, Other_11, Other_13, Other_14, Other_15 | 210 | instance_create(Other_10:18 ×5), scr_snd_break(Other_10:1) | 18/37 |
| [obj_shell_drybones_res](objects/obj_shell_drybones_res/obj_shell_drybones_res.yy) | obj_parent_resource | spr_shell_drybones_res | Other_10, Other_11, Step_2 | 24 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_shell_empty](objects/obj_shell_empty/obj_shell_empty.yy) | obj_shell | spr_shell_buzzy_empty | Collision_obj_fireball, Create_0, Destroy_0, Other_17 | 63 | instance_create(Other_17:1) | 17/36 |
| [obj_shell_held](objects/obj_shell_held/obj_shell_held.yy) | obj_enemyparent | spr_shell | Alarm_0, Alarm_1, Alarm_10, Alarm_11, Alarm_2, Collision_obj_enemyparent, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Other_15, Step_0, Step_1 | 662 | instance_create(Alarm_10:2 ×22), outside_view(Step_0:41), scr_musicalscale(Collision_obj_enemyparent:14), scr_musicalscale_SMB3(Collision_obj_enemyparent:8 ×2), scr_musicalscale_kick(Collision_obj_enemyparent:17), scr_snd_bump(Step_0:43 ×2), scr_snd_kick(Collision_obj_enemyparent:27 ×2) | 30/52 |
| [obj_shell_intro](objects/obj_shell_intro/obj_shell_intro.yy) | - | spr_SMB_shell_b | Alarm_0, Create_0, Other_0 | 8 | - | 16/32 |
| [obj_shell_trail](objects/obj_shell_trail/obj_shell_trail.yy) | - | spr_NSMBU_shell | Create_0, Draw_0, Step_0 | 24 | - | 16/35 |
| [obj_shield_left](objects/obj_shield_left/obj_shield_left.yy) | obj_onewaygate_left | spr_shield_left | Collision_obj_banzaibill, Collision_obj_bulletbill, Collision_obj_bulletbull_red, Collision_obj_cannonball, Collision_obj_lakitu, Collision_obj_wrench, Create_0, Draw_0, Other_10, Step_0, Step_2 | 55 | - | 24/43 |
| [obj_shield_right](objects/obj_shield_right/obj_shield_right.yy) | obj_onewaygate_right | spr_shield_right | Collision_obj_banzaibill, Collision_obj_bulletbill, Collision_obj_bulletbull_red, Collision_obj_cannonball, Collision_obj_lakitu, Collision_obj_wrench, Create_0, Draw_0, Other_10, Step_0, Step_2 | 55 | - | 24/43 |
| [obj_sidefade](objects/obj_sidefade/obj_sidefade.yy) | - | - | Create_0, Draw_0 | 21 | - | 15/31 |
| [obj_silbido](objects/obj_silbido/obj_silbido.yy) | - | spr_square | Create_0, Step_0 | 5 | - | 15/31 |
| [obj_skewer](objects/obj_skewer/obj_skewer.yy) | obj_solid | spr_square | Create_0, Draw_0 | 36 | - | 15/34 |
| [obj_skewer_res](objects/obj_skewer_res/obj_skewer_res.yy) | obj_parent_resource | spr_skewer_res | Alarm_1, Create_0, Draw_0, Mouse_4, Step_1 | 116 | instance_create(Mouse_4:41) | 18/37 |
| [obj_skewertrunk](objects/obj_skewertrunk/obj_skewertrunk.yy) | obj_deactivation | spr_skewertrunk | Alarm_0, Alarm_1, Alarm_2, Collision_obj_thwomp_b, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_7, Step_0, Step_2 | 668 | draw_sprite_tiled_area_ext(Draw_0:4 ×4), init_shake(Other_15:12), instance_create(Other_11:22 ×12), scr_snd_thwomp(Other_15:9 ×2) | 30/49 |
| [obj_sledgebro](objects/obj_sledgebro/obj_sledgebro.yy) | obj_deactenemyparent | spr_sledgebro | Alarm_1, Alarm_10, Alarm_2, Alarm_3, Alarm_4, Alarm_5, Alarm_6, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_13, Other_7, Step_0, Step_2 | 546 | instance_create(Alarm_4:10 ×16), scr_snd_thwomp(Step_0:110) | 29/51 |
| [obj_sledgebro_res](objects/obj_sledgebro_res/obj_sledgebro_res.yy) | obj_parent_resource | spr_sledgebro_res | Create_0, Other_10, Other_13, Step_2 | 40 | instance_create(Other_10:1 ×2), scr_snd_powerdown(Other_13:1) | 17/36 |
| [obj_slider](objects/obj_slider/obj_slider.yy) | - | spr_mario_big_slide | Alarm_0, Alarm_1, Collision_obj_enemyparent, Create_0, Destroy_0, Draw_0, Other_10, Step_0 | 178 | instance_create(Alarm_0:3 ×4), scr_jump(Step_0:77), scr_marioslide(Create_0:12 ×2), scr_musicalscale(Collision_obj_enemyparent:3) | 21/40 |
| [obj_slopeleft](objects/obj_slopeleft/obj_slopeleft.yy) | obj_slopeparent | - | - | 0 | - | 12/34 |
| [obj_slopeparent](objects/obj_slopeparent/obj_slopeparent.yy) | - | - | Create_0 | 0 | - | 14/33 |
| [obj_sloperight](objects/obj_sloperight/obj_sloperight.yy) | obj_slopeparent | - | - | 0 | - | 12/34 |
| [obj_slopes](objects/obj_slopes/obj_slopes.yy) | obj_ground | spr_ground | - | 0 | - | 12/31 |
| [obj_slopesa](objects/obj_slopesa/obj_slopesa.yy) | obj_parent_resource | spr_ground_2 | Alarm_0, Alarm_5, Alarm_6, Collision_obj_tile_trigger, Create_0, Draw_0, Mouse_0, Mouse_1, Mouse_4, Mouse_7, Other_0, Other_10, Other_12, Other_13, Other_15, Other_18, Step_2 | 0 | - | 30/49 |
| [obj_sm4j_jump](objects/obj_sm4j_jump/obj_sm4j_jump.yy) | - | spr_key_a_sm4j | Create_0, Draw_0, Mouse_0, Mouse_7 | 5 | - | 17/33 |
| [obj_smoke](objects/obj_smoke/obj_smoke.yy) | - | spr_smoke | Create_0, Draw_0, Other_7 | 10 | - | 16/35 |
| [obj_smoke_cap](objects/obj_smoke_cap/obj_smoke_cap.yy) | obj_smoke | spr_smokespin | - | 0 | - | 12/31 |
| [obj_smoke_goomba](objects/obj_smoke_goomba/obj_smoke_goomba.yy) | - | spr_smoke | Create_0, Draw_0, Other_7 | 14 | - | 16/35 |
| [obj_smoke_shoe](objects/obj_smoke_shoe/obj_smoke_shoe.yy) | - | spr_SMB3_smoke_shoe | Collision_obj_enemyparent, Collision_obj_muncher, Collision_obj_shell, Create_0, Draw_0, Other_7, Step_0 | 34 | scr_snd_kick(Collision_obj_enemyparent:3 ×6) | 20/36 |
| [obj_smoke_steps](objects/obj_smoke_steps/obj_smoke_steps.yy) | - | spr_NSMBU_smoke | Create_0, Draw_0, Other_7 | 9 | - | 16/35 |
| [obj_snow_ball](objects/obj_snow_ball/obj_snow_ball.yy) | obj_enemyparent_held | spr_snow_ball | Alarm_1, Alarm_10, Alarm_2, Alarm_6, Collision_obj_enemyparent, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_12, Other_14, Other_17, Step_2 | 353 | instance_create(Collision_obj_mario:28 ×8), scr_canhold(Collision_obj_mario:5), scr_snd_kick(Collision_obj_enemyparent:5 ×6) | 26/45 |
| [obj_snow_ball_b](objects/obj_snow_ball_b/obj_snow_ball_b.yy) | obj_snow_ball | spr_spike_ball_b | Collision_obj_mario, Create_0, Draw_0, Other_10 | 114 | instance_create(Collision_obj_mario:20 ×4), scr_snd_kick(Collision_obj_mario:25 ×2) | 17/36 |
| [obj_snow_ball_held](objects/obj_snow_ball_held/obj_snow_ball_held.yy) | obj_enemyparent | spr_spike_ball2 | Alarm_0, Alarm_2, Collision_obj_enemyparent, Collision_obj_mario, Collision_obj_snow_ball, Create_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Other_15, Step_0 | 333 | instance_create(Other_10:6 ×5), scr_snd_kick(Collision_obj_enemyparent:5 ×3) | 26/45 |
| [obj_snowball](objects/obj_snowball/obj_snowball.yy) | obj_physicsparent | spr_NSMBU_snowball | Alarm_0, Alarm_1, Collision_obj_bossparent, Collision_obj_bowser_fire, Collision_obj_enemyparent, Collision_obj_grrrol, Collision_obj_magic, Collision_obj_plantfire, Collision_obj_podoboo, Collision_obj_shell, Collision_obj_snow_ball, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Create_0, Other_10, Other_14, Step_0 | 297 | instance_create(Alarm_0:3 ×13), outside_view(Step_0:18) | 30/52 |
| [obj_snowball_bro](objects/obj_snowball_bro/obj_snowball_bro.yy) | obj_snowball | spr_NSMBU_snowball | Collision_obj_enemyparent, Collision_obj_fireball, Collision_obj_frozenmario, Collision_obj_mario, Collision_obj_snow_ball, Create_0, Other_10 | 112 | instance_create(Collision_obj_mario:5 ×4) | 20/39 |
| [obj_snowmaker](objects/obj_snowmaker/obj_snowmaker.yy) | obj_rainmaker | spr_marker_event | Create_0, Destroy_0, Other_10, Step_2 | 80 | - | 17/36 |
| [obj_solid](objects/obj_solid/obj_solid.yy) | obj_solidtop | spr_square | - | 0 | - | 12/34 |
| [obj_solid_appear](objects/obj_solid_appear/obj_solid_appear.yy) | - | - | - | 0 | - | 12/28 |
| [obj_solidhold](objects/obj_solidhold/obj_solidhold.yy) | obj_enabledsolid | spr_squaremask | Step_0 | 8 | - | 14/36 |
| [obj_solidphy](objects/obj_solidphy/obj_solidphy.yy) | obj_solidtop | spr_squaremask | - | 0 | - | 12/34 |
| [obj_solidtop](objects/obj_solidtop/obj_solidtop.yy) | - | spr_square_b | - | 0 | - | 12/31 |
| [obj_soplete](objects/obj_soplete/obj_soplete.yy) | obj_deactivation | spr_SMB_soplete_start | Alarm_0, Collision_obj_bobomb, Collision_obj_mario, Create_0, Destroy_0, Draw_0, Step_0 | 83 | instance_create(Collision_obj_bobomb:6 ×3) | 20/39 |
| [obj_soplete_global](objects/obj_soplete_global/obj_soplete_global.yy) | - | spr_SMB_soplete_start | Alarm_0, Alarm_1, Alarm_2, Create_0, Other_7 | 77 | outside_view(Alarm_0:7), scr_snd_soplete(Alarm_0:12 ×2) | 18/34 |
| [obj_soplete_invert](objects/obj_soplete_invert/obj_soplete_invert.yy) | obj_soplete | spr_SMB_soplete_start | Create_0, Step_0 | 35 | instance_create(Create_0:24 ×2) | 15/34 |
| [obj_soplete_invert_global](objects/obj_soplete_invert_global/obj_soplete_invert_global.yy) | - | spr_SMB_soplete_start | Alarm_0, Alarm_1, Alarm_2, Create_0, Other_7 | 72 | outside_view(Alarm_0:7), scr_snd_soplete(Alarm_0:12 ×2) | 18/34 |
| [obj_soplete_res](objects/obj_soplete_res/obj_soplete_res.yy) | obj_parent_resource | spr_square | Create_0, Draw_0, Mouse_4, Other_10, Other_11, Step_2 | 136 | instance_create(Mouse_4:54 ×3) | 19/38 |
| [obj_sparkles_blend](objects/obj_sparkles_blend/obj_sparkles_blend.yy) | - | spr_sparkles_blend | Create_0, Draw_0, Other_7, Step_0 | 45 | - | 17/33 |
| [obj_sparkles_coin](objects/obj_sparkles_coin/obj_sparkles_coin.yy) | obj_sparkletrail | spr_sparkles_coin | Create_0 | 18 | - | 14/33 |
| [obj_sparkletrail](objects/obj_sparkletrail/obj_sparkletrail.yy) | - | spr_sparkletrail | Create_0, Other_7 | 10 | - | 15/34 |
| [obj_spike](objects/obj_spike/obj_spike.yy) | obj_deactenemyparent | spr_spike | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_17, Other_7, Step_0, Step_2 | 466 | instance_create(Alarm_1:2 ×9) | 26/45 |
| [obj_spike_ball](objects/obj_spike_ball/obj_spike_ball.yy) | obj_physicsparent | spr_spike_ball2 | Alarm_0, Alarm_10, Alarm_11, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_invincibility, Collision_obj_mario, Collision_obj_physicsparent, Create_0, Draw_0, Other_10, Other_13, Other_14, Step_0 | 531 | instance_create(Collision_obj_mario:6 ×6), scr_snd_kick(Collision_obj_enemyparent:3 ×4), scr_snd_stomp(Collision_obj_mario:5) | 27/46 |
| [obj_spike_ball_b](objects/obj_spike_ball_b/obj_spike_ball_b.yy) | obj_spike_ball | spr_spike_ball_b | Create_0, Draw_0, Other_10, Other_13 | 184 | instance_create(Other_10:27), scr_snd_kick(Other_10:1 ×2) | 17/36 |
| [obj_spike_ball_b_res](objects/obj_spike_ball_b_res/obj_spike_ball_b_res.yy) | obj_parent_resource | spr_spike_ball_b_res | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 129 | instance_create(Other_10:1 ×5), scr_snd_powerdown(Other_13:1) | 19/38 |
| [obj_spike_ball_res](objects/obj_spike_ball_res/obj_spike_ball_res.yy) | obj_parent_resource | spr_spike_ball_res | Other_10, Other_11, Other_13, Other_14, Step_2 | 72 | instance_create(Other_10:1 ×4), scr_snd_powerup(Other_13:1) | 18/37 |
| [obj_spike_res](objects/obj_spike_res/obj_spike_res.yy) | obj_parent_resource | spr_spike_res | Create_0, Other_10, Other_11, Step_2 | 50 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_spinner](objects/obj_spinner/obj_spinner.yy) | - | spr_SMB3_mario_raccoon_attack | Collision_obj_blockparent, Collision_obj_bowser_fire, Collision_obj_bowser_fire_down, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_shell, Collision_obj_spike_ball, Collision_obj_wrench, Create_0, Destroy_0, Draw_0, Other_7, Step_0 | 170 | instance_create(Collision_obj_enemyparent:8 ×5), scr_bg_underwater(Collision_obj_enemyparent:19), scr_snd_kick(Collision_obj_enemyparent:3 ×2) | 26/45 |
| [obj_spinsmoke](objects/obj_spinsmoke/obj_spinsmoke.yy) | obj_smoke | spr_smokespin | Alarm_0, Alarm_1, Create_0, Draw_0 | 32 | - | 17/39 |
| [obj_spinthump](objects/obj_spinthump/obj_spinthump.yy) | - | spr_spinthump | Create_0, Other_7 | 10 | - | 15/34 |
| [obj_spiny](objects/obj_spiny/obj_spiny.yy) | obj_deactenemyparent | spr_spiny | Alarm_0, Alarm_1, Alarm_10, Alarm_2, Alarm_3, Create_0, Destroy_0, Draw_0, Other_10, Other_15, Other_19, Step_0 | 410 | instance_create(Alarm_1:1 ×19) | 25/47 |
| [obj_spiny_ball](objects/obj_spiny_ball/obj_spiny_ball.yy) | obj_deactenemyparent | spr_spiny_ball | Create_0, Other_24, Step_0 | 79 | instance_create(Step_0:24) | 16/35 |
| [obj_spiny_empty](objects/obj_spiny_empty/obj_spiny_empty.yy) | obj_shell_empty | spr_shell_spiny_empty | Create_0, Other_11, Other_17 | 47 | instance_create(Other_11:7 ×2), scr_snd_stomp(Other_11:5 ×2) | 16/35 |
| [obj_spiny_res](objects/obj_spiny_res/obj_spiny_res.yy) | obj_parent_resource | spr_spiny_res | Create_0, Draw_0, Other_10, Other_11, Step_2 | 65 | instance_create(Other_10:1 ×3) | 18/37 |
| [obj_spiny_shell_res](objects/obj_spiny_shell_res/obj_spiny_shell_res.yy) | obj_parent_resource | spr_spiny_shell_res | Other_10, Other_11, Step_2 | 24 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_spiny_thrown](objects/obj_spiny_thrown/obj_spiny_thrown.yy) | obj_spiny | spr_spiny_ball | Create_0, Step_0 | 49 | instance_create(Step_0:11) | 15/34 |
| [obj_splash_agua](objects/obj_splash_agua/obj_splash_agua.yy) | - | spr_splash | Create_0, Other_7 | 17 | - | 15/31 |
| [obj_splash_lava](objects/obj_splash_lava/obj_splash_lava.yy) | - | spr_splash_lava | Create_0, Other_7 | 17 | - | 15/31 |
| [obj_splash_posion](objects/obj_splash_posion/obj_splash_posion.yy) | - | spr_splash_lava_purple | Create_0, Other_7 | 17 | - | 15/31 |
| [obj_spring](objects/obj_spring/obj_spring.yy) | obj_holdparent | spr_spring | Alarm_1, Collision_obj_holdparent, Collision_obj_mario, Collision_obj_physicsparent, Collision_obj_powerupparent, Create_0, Other_7, Step_0 | 197 | outside_view(Collision_obj_holdparent:14 ×3), scr_snd_spring(Collision_obj_holdparent:16 ×8) | 21/43 |
| [obj_spring_land](objects/obj_spring_land/obj_spring_land.yy) | obj_physicsparent | spr_spring_land | Alarm_0, Alarm_9, Collision_obj_block_pow_hold, Collision_obj_buzzybeetle, Collision_obj_holdparent, Collision_obj_physicsparent, Collision_obj_shell, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_spiny, Create_0, Destroy_0, Other_11, Other_7, Step_0, Step_1, Step_2 | 436 | instance_create(Collision_obj_shell:11 ×4), outside_view(Other_11:2), scr_snd_spring(Other_11:4 ×2) | 30/49 |
| [obj_spring_land_res](objects/obj_spring_land_res/obj_spring_land_res.yy) | obj_parent_resource | spr_spring_land_res | Create_0, Other_10, Other_11, Other_14, Step_2 | 64 | instance_create(Other_10:1 ×5) | 18/37 |
| [obj_spring_res](objects/obj_spring_res/obj_spring_res.yy) | obj_parent_resource | spr_spring | Create_0, Other_10, Other_11, Other_14, Step_2 | 81 | instance_create(Other_10:1 ×5) | 18/37 |
| [obj_st_slider](objects/obj_st_slider/obj_st_slider.yy) | - | spr_st_sliderbar | Create_0, Draw_0, Other_10, Step_0 | 45 | - | 17/33 |
| [obj_star](objects/obj_star/obj_star.yy) | obj_powerupparent | spr_star | Alarm_10, Collision_obj_mario, Create_0, Step_0 | 104 | instance_create(Collision_obj_mario:3 ×2), scr_snd_powerup(Collision_obj_mario:18), scr_snd_starman(Collision_obj_mario:14) | 17/39 |
| [obj_star_res](objects/obj_star_res/obj_star_res.yy) | obj_parent_resource | spr_star_res | Create_0, Other_10, Other_14, Step_2 | 35 | instance_create(Other_10:1 ×3) | 17/36 |
| [obj_statuesmoke](objects/obj_statuesmoke/obj_statuesmoke.yy) | - | spr_statuesmoke | Create_0, Other_7 | 4 | - | 15/34 |
| [obj_stomp](objects/obj_stomp/obj_stomp.yy) | - | spr_stompmask | Collision_obj_enemyparent, Create_0, Other_7 | 24 | instance_create(Create_0:1 ×2), scr_musicalscale(Collision_obj_enemyparent:3), scr_snd_bump(Create_0:11 ×2) | 16/35 |
| [obj_stomped](objects/obj_stomped/obj_stomped.yy) | - | spr_koopa_sq | Alarm_0, Create_0, Draw_0 | 9 | - | 16/35 |
| [obj_superarcon](objects/obj_superarcon/obj_superarcon.yy) | obj_powerupparent | spr_NSMBU_superacorn | Alarm_10, Create_0, Draw_0, Step_0 | 24 | - | 17/36 |
| [obj_superball](objects/obj_superball/obj_superball.yy) | - | spr_SMB_superball | Alarm_0, Alarm_1, Collision_obj_block_pow_hold, Collision_obj_bobomb, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Create_0, Other_10, Step_0 | 200 | instance_create(Alarm_0:1 ×6), outside_view(Step_0:118), scr_snd_kick(Collision_obj_bobomb:1) | 22/41 |
| [obj_superball_trail](objects/obj_superball_trail/obj_superball_trail.yy) | - | spr_SMB_superball | Create_0, Step_0 | 9 | - | 15/34 |
| [obj_superflower](objects/obj_superflower/obj_superflower.yy) | obj_powerupparent | spr_SMB_superflower | Collision_obj_mario, Create_0, Step_0 | 55 | instance_create(Collision_obj_mario:5 ×3), scr_snd_powerup(Collision_obj_mario:37 ×2), scr_sprite_get_constant(Collision_obj_mario:7) | 16/38 |
| [obj_superflower_res](objects/obj_superflower_res/obj_superflower_res.yy) | obj_parent_resource | spr_SMB_superflower_res | Create_0, Other_10, Other_11, Other_13, Other_14, Step_2 | 104 | instance_create(Other_10:3 ×8) | 19/38 |
| [obj_tabs_condiciones](objects/obj_tabs_condiciones/obj_tabs_condiciones.yy) | - | spr_tabs_bg_condiciones | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 54 | scr_anim_hover(Draw_0:20) | 18/34 |
| [obj_thwomp](objects/obj_thwomp/obj_thwomp.yy) | obj_enemyparent | spr_thwomp | Alarm_0, Alarm_1, Alarm_10, Collision_obj_enemyparent, Create_0, Draw_0, Other_10, Other_13, Other_14, Step_0, Step_2 | 673 | init_shake(Step_0:41 ×3), instance_create(Alarm_1:76 ×11), scr_snd_kick(Collision_obj_enemyparent:3 ×2), scr_snd_thwomp(Step_0:39 ×6) | 24/46 |
| [obj_thwomp_b](objects/obj_thwomp_b/obj_thwomp_b.yy) | obj_thwomp | spr_thwomp_b | Alarm_0, Alarm_10, Create_0, Other_10, Step_0 | 390 | init_shake(Step_0:43 ×3), instance_create(Other_10:1 ×9), scr_snd_thwomp(Step_0:41 ×12) | 18/37 |
| [obj_thwomp_b_res](objects/obj_thwomp_b_res/obj_thwomp_b_res.yy) | obj_parent_resource | spr_SMW_thwomp_b_res | Create_0, Draw_0, Mouse_4, Other_10, Other_11, Other_13, Step_2 | 130 | instance_create(Mouse_4:48 ×6), scr_snd_powerdown(Other_13:1) | 20/39 |
| [obj_thwomp_intro](objects/obj_thwomp_intro/obj_thwomp_intro.yy) | - | spr_thwomp_intro_mask | Alarm_0, Alarm_1, Alarm_2, Create_0, Draw_0, Other_0 | 14 | - | 19/35 |
| [obj_thwomp_res](objects/obj_thwomp_res/obj_thwomp_res.yy) | obj_parent_resource | spr_SMW_thwomp_res | Create_0, Draw_0, Mouse_4, Step_2 | 84 | instance_create(Mouse_4:48) | 17/36 |
| [obj_tile_trigger](objects/obj_tile_trigger/obj_tile_trigger.yy) | - | spr_cursor_mask | Alarm_0, Create_0 | 4 | - | 15/31 |
| [obj_time](objects/obj_time/obj_time.yy) | obj_panelparent | spr_cronometro | Create_0, Draw_0, Mouse_4, Other_10, Other_7, Step_0, Step_1 | 69 | instance_create(Other_7:5 ×3), scr_language(Draw_0:24 ×2), string_add_zeros(Draw_0:17) | 20/39 |
| [obj_timeup](objects/obj_timeup/obj_timeup.yy) | - | spr_timeup | Alarm_0, Create_0, Draw_0, Other_40, Other_7 | 24 | - | 18/34 |
| [obj_title_controller](objects/obj_title_controller/obj_title_controller.yy) | - | spr_marker_event | Alarm_0, Alarm_1, Create_0, Draw_0, Step_2 | 77 | instance_create(Create_0:15) | 18/34 |
| [obj_title_oprime](objects/obj_title_oprime/obj_title_oprime.yy) | - | spr_title_oprime | Alarm_0, Alarm_1, Create_0, Draw_0, Mouse_4, Step_2 | 78 | instance_create(Mouse_4:8 ×4) | 19/35 |
| [obj_titlemenu_key](objects/obj_titlemenu_key/obj_titlemenu_key.yy) | - | spr_marker_event1 | Alarm_0, Create_0, Draw_0, KeyPress_1 | 124 | __background_set(KeyPress_1:85 ×2), background_create_from_surface(Create_0:8), gpu_set_blendenable(Draw_0:3 ×2), sprite_delete(KeyPress_1:81), sprite_exists(Draw_0:1) | 17/33 |
| [obj_toast](objects/obj_toast/obj_toast.yy) | - | spr_notifications_toast | Alarm_0, Create_0, Draw_0, Mouse_4, Step_0 | 60 | - | 18/34 |
| [obj_tongue](objects/obj_tongue/obj_tongue.yy) | - | spr_tongue | Alarm_0, Collision_obj_bone, Collision_obj_bowser_fire, Collision_obj_bowser_fire_down, Collision_obj_brohammer, Collision_obj_coin10, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_plantfire, Collision_obj_powerupparent, Collision_obj_pswitch, Collision_obj_spike_ball, Collision_obj_spring_land, Create_0, Draw_0, Step_2 | 372 | instance_create(Collision_obj_coin10:16 ×2) | 29/48 |
| [obj_tongue_blue](objects/obj_tongue_blue/obj_tongue_blue.yy) | - | spr_tongue | Alarm_0, Collision_obj_bone, Collision_obj_bowser_fire, Collision_obj_bowser_fire_down, Collision_obj_brohammer, Collision_obj_coin10, Collision_obj_enemyparent, Collision_obj_holdparent, Collision_obj_plantfire, Collision_obj_powerupparent, Collision_obj_pswitch, Collision_obj_spike_ball, Collision_obj_spring_land, Create_0, Draw_0, Step_2 | 372 | instance_create(Collision_obj_coin10:16 ×2) | 29/48 |
| [obj_torbellino](objects/obj_torbellino/obj_torbellino.yy) | obj_physicsparent | spr_torbellino | Alarm_0, Alarm_10, Create_0, Destroy_0, Draw_0, Other_13, Other_16, Step_0 | 125 | instance_create(Alarm_0:1) | 21/40 |
| [obj_torbellino_res](objects/obj_torbellino_res/obj_torbellino_res.yy) | obj_parent_resource | spr_torbellino | Other_10, Other_11, Step_2 | 50 | instance_create(Other_10:1 ×3) | 16/35 |
| [obj_tuberia](objects/obj_tuberia/obj_tuberia.yy) | obj_solid | spr_grid_selected_32x32 | Alarm_0, Alarm_1, Create_0, Draw_0, Step_0 | 288 | instance_create(Alarm_0:1 ×10) | 18/37 |
| [obj_tuberia_res](objects/obj_tuberia_res/obj_tuberia_res.yy) | obj_parent_resource_block | spr_grid_selected_32x32 | Alarm_1, Alarm_2, Collision_obj_parent_resource, Collision_obj_pplant_res, Create_0, Destroy_0, Draw_0, Mouse_4, Other_10, Other_11, Other_15, Other_16, Step_2 | 624 | instance_create(Alarm_1:6 ×10), scr_snd_pipes(Other_11:5 ×2), scr_snd_powerdown(Collision_obj_pplant_res:3) | 26/45 |
| [obj_ubsi_or](objects/obj_ubsi_or/obj_ubsi_or.yy) | obj_parent_sound_o | spr_square | Create_0, Other_10 | 15 | init_shake(Other_10:9), instance_create(Other_10:1) | 15/34 |
| [obj_ubsi_snd_res](objects/obj_ubsi_snd_res/obj_ubsi_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_uhh_or](objects/obj_uhh_or/obj_uhh_or.yy) | obj_parent_sound_o | spr_square | Create_0 | 5 | - | 14/33 |
| [obj_uhh_snd_res](objects/obj_uhh_snd_res/obj_uhh_snd_res.yy) | obj_parent_sounds | spr_image_sounds | Create_0, Other_10, Other_11, Other_13 | 35 | instance_create(Other_10:1 ×4) | 17/36 |
| [obj_veggiecoin](objects/obj_veggiecoin/obj_veggiecoin.yy) | - | spr_coin | Create_0, Step_0 | 79 | instance_create(Step_0:3 ×2), scr_snd_coin(Create_0:65 ×2) | 15/34 |
| [obj_ventana](objects/obj_ventana/obj_ventana.yy) | - | spr_window | Create_0, Destroy_0, Other_10, Other_11, Other_12, Other_13, Other_14, Other_15, Other_16, Other_17, Other_18, Other_19, Other_20, Other_21, Other_22, Other_23, Other_24, Step_2 | 459 | instance_create(Other_10:1 ×51) | 31/47 |
| [obj_ventana_mario](objects/obj_ventana_mario/obj_ventana_mario.yy) | - | spr_window | Create_0, Destroy_0, Other_10, Other_11, Other_12, Other_13, Step_1 | 241 | instance_create(Other_10:1 ×24) | 20/36 |
| [obj_ventana_water](objects/obj_ventana_water/obj_ventana_water.yy) | - | spr_window_water | Create_0, Destroy_0, Other_10, Step_2 | 55 | instance_create(Other_10:1 ×3) | 17/33 |
| [obj_version](objects/obj_version/obj_version.yy) | - | - | Create_0, Draw_0 | 9 | - | 15/31 |
| [obj_vine](objects/obj_vine/obj_vine.yy) | obj_climb | spr_vine | Create_0 | 21 | - | 14/36 |
| [obj_vine_green](objects/obj_vine_green/obj_vine_green.yy) | obj_climb | spr_vine_green | Create_0, Draw_0 | 45 | - | 15/37 |
| [obj_vine_res](objects/obj_vine_res/obj_vine_res.yy) | obj_parent_resource | spr_vine_green | Alarm_3, Collision_obj_parent_resource, Create_0, Draw_0, Mouse_4, Other_13, Step_2 | 197 | instance_create(Mouse_4:41 ×2), scr_insideview(Mouse_4:1) | 20/39 |
| [obj_vsync](objects/obj_vsync/obj_vsync.yy) | - | spr_settings_minibutton | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 40 | scr_anim_hover(Draw_0:6) | 18/34 |
| [obj_waddlewing](objects/obj_waddlewing/obj_waddlewing.yy) | obj_deactenemyparent | spr_waddlewing | Alarm_0, Alarm_1, Alarm_10, Create_0, Draw_0, Other_10, Other_11, Other_13, Other_14, Other_15, Other_16, Other_17, Other_18, Step_0, Step_2 | 448 | instance_create(Other_10:1 ×3) | 28/47 |
| [obj_waddlewing_res](objects/obj_waddlewing_res/obj_waddlewing_res.yy) | obj_parent_resource | spr_grid_selected_16x16 | Create_0, Draw_0, Step_2 | 56 | draw_sprite_custom_origin(Draw_0:8 ×2), outside_view(Draw_0:1) | 16/35 |
| [obj_water_level_control](objects/obj_water_level_control/obj_water_level_control.yy) | - | spr_expand_bg | Create_0, Destroy_0, Draw_0, Step_2 | 55 | instance_create(Create_0:2 ×3), scr_language(Draw_0:5 ×5) | 17/33 |
| [obj_water_move](objects/obj_water_move/obj_water_move.yy) | - | spr_water_move | Alarm_0, Create_0, Draw_0, Mouse_4, Mouse_7, Step_2 | 84 | - | 19/35 |
| [obj_water_move_limit](objects/obj_water_move_limit/obj_water_move_limit.yy) | - | spr_water_move_limit | Alarm_0, Create_0, Draw_0, Mouse_4, Step_2 | 104 | instance_create(Alarm_0:36) | 18/34 |
| [obj_window_alert](objects/obj_window_alert/obj_window_alert.yy) | - | spr_panel_save | Create_0, Destroy_0, Draw_0 | 59 | instance_create(Create_0:5 ×18), scr_language(Draw_0:4 ×2) | 16/32 |
| [obj_window_button](objects/obj_window_button/obj_window_button.yy) | - | spr_window_button | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 65 | scr_anim_hover(Draw_0:6) | 18/34 |
| [obj_window_mario_button](objects/obj_window_mario_button/obj_window_mario_button.yy) | - | spr_window_button | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 77 | scr_anim_hover(Draw_0:7), scr_snd_powerdown(Mouse_4:16 ×2), scr_snd_powerup(Mouse_4:5) | 18/34 |
| [obj_window_select](objects/obj_window_select/obj_window_select.yy) | - | spr_settings_minibutton | Create_0, Draw_0, Mouse_10, Mouse_11, Mouse_4 | 47 | scr_anim_hover(Draw_0:6) | 18/34 |
| [obj_wings_dead](objects/obj_wings_dead/obj_wings_dead.yy) | obj_deactivation | spr_wings_deads | Create_0, Draw_0, Step_0 | 60 | - | 16/35 |
| [obj_wings_dead_b](objects/obj_wings_dead_b/obj_wings_dead_b.yy) | obj_wings_dead | spr_wings_deads | Create_0, Draw_0, Step_0 | 60 | - | 16/35 |
| [obj_wrench](objects/obj_wrench/obj_wrench.yy) | - | spr_wrench | Alarm_0, Alarm_1, Collision_obj_invincibility, Collision_obj_mario, Create_0, Draw_0, Other_10, Step_0 | 109 | instance_create(Other_10:1), scr_snd_stomp(Other_10:4 ×2) | 21/40 |
| [obj_yoshi2](objects/obj_yoshi2/obj_yoshi2.yy) | - | spr_yoshi | Alarm_0, Alarm_1, Alarm_2, Alarm_4, Create_0, Destroy_0, Draw_0, Other_10, Other_11, Other_12, Other_13, Other_25, Step_2 | 665 | instance_create(Alarm_0:2 ×31), scr_mario_yoshi_atack(Other_12:5), scr_mario_yoshi_crouch(Other_12:12), scr_marioride(Other_12:19) | 26/42 |
| [obj_yoshi_abandon](objects/obj_yoshi_abandon/obj_yoshi_abandon.yy) | obj_physicsparent | spr_yoshi_wait | Alarm_0, Alarm_1, Alarm_2, Collision_obj_mario, Create_0, Draw_0, Other_10, Other_14, Step_0 | 240 | instance_create(Collision_obj_mario:17 ×5) | 22/44 |
| [obj_yoshi_blue](objects/obj_yoshi_blue/obj_yoshi_blue.yy) | obj_yoshi2 | spr_yoshi_blue | Create_0 | 11 | - | 14/33 |
| [obj_yoshi_red](objects/obj_yoshi_red/obj_yoshi_red.yy) | obj_yoshi2 | spr_yoshi_red | Create_0, Other_10 | 80 | instance_create(Other_10:11 ×8) | 15/34 |
| [obj_yoshi_runaway](objects/obj_yoshi_runaway/obj_yoshi_runaway.yy) | obj_physicsparent | spr_yoshi_runaway | Alarm_0, Collision_obj_mario, Create_0, Draw_0, Other_11, Other_13, Step_0 | 125 | instance_create(Collision_obj_mario:10 ×4) | 20/42 |
| [obj_yoshi_runaway_blue](objects/obj_yoshi_runaway_blue/obj_yoshi_runaway_blue.yy) | obj_yoshi_runaway | spr_yoshi_runaway_blue | Collision_obj_mario, Other_11 | 22 | instance_create(Collision_obj_mario:10) | 15/37 |
| [obj_yoshi_runaway_red](objects/obj_yoshi_runaway_red/obj_yoshi_runaway_red.yy) | obj_yoshi_runaway | spr_yoshi_runaway_red | Collision_obj_mario, Other_11 | 23 | instance_create(Collision_obj_mario:10) | 15/34 |
| [obj_yoshifire](objects/obj_yoshifire/obj_yoshifire.yy) | obj_physicsparent | spr_yoshifire | Alarm_0, Alarm_1, Alarm_2, Collision_obj_boomboom, Collision_obj_enemyparent, Collision_obj_enemyparent_held, Collision_obj_shell, Create_0, Draw_0, Other_10, Other_14, Other_40, Step_0, Step_2 | 147 | instance_create(Collision_obj_enemyparent:6 ×6) | 27/49 |
| [obj_yoshifire_one](objects/obj_yoshifire_one/obj_yoshifire_one.yy) | obj_yoshifire | spr_yoshifire | - | 0 | - | 12/31 |
| [obj_yoshifire_purple](objects/obj_yoshifire_purple/obj_yoshifire_purple.yy) | obj_yoshifire | spr_yoshifire_purple | - | 0 | - | 12/31 |
| [obj_zoomclose](objects/obj_zoomclose/obj_zoomclose.yy) | obj_button_close | spr_button_close | Draw_0, Mouse_4, Step_0 | 11 | - | 16/35 |

## 3. 风险标记

统计规则：对 objects/ scripts/ rooms/ extensions/ 下全部 `.gml`（共 5011 个文件，138630 行），逐行用正则匹配，匹配前已去除注释并清空字符串字面量内容。“命中数”= 匹配到的**行数**（一行内多次匹配只计 1），“涉及文件数”= 含命中的 .gml 文件数。类别总命中为各子正则的“并集行”。下面每类给出：子正则及其计数、事件级统计（来自各 object `.yy` 的 `eventList`）、按文件的完整索引（`文件(命中数): 行号…`，每文件最多列 20 个行号，超出以 `…+N` 表示，计数始终完整）、代表性片段。

### 3.1 with / other

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| with: `\bwith\s*\(` | 4563 | 1570 |
| other: `\bother\b` | 3878 | 1028 |
| **并集（本类合计）** | **7971** | **1677** |

<details><summary>按文件完整索引（1677 个文件，7971 行命中）</summary>

```
scripts/scr_edit_to_play/scr_edit_to_play.gml(526): 5,13,21,29,104,112,120,129,137,145,153,161,172,180,188,196,204,212,220,288,…+506
objects/obj_editormanager/Other_13.gml(104): 4,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,…+84
objects/obj_magic/Step_0.gml(70): 17,20,21,27,32,37,42,47,57,62,67,72,77,84,98,101,102,108,113,118,…+50
objects/obj_card_circle/Mouse_4.gml(67): 3,6,8,10,12,14,16,18,20,22,24,26,28,32,34,35,36,38,40,41,…+47
scripts/scr_play_to_edit/scr_play_to_edit.gml(66): 4,9,14,19,24,29,34,39,47,55,63,71,79,87,95,103,110,117,133,141,…+46
objects/obj_deadmario/Other_10.gml(53): 3,10,16,22,28,34,40,46,54,63,73,82,90,100,112,124,133,144,154,163,…+33
objects/obj_editormanager/Other_12.gml(48): 4,12,17,26,38,43,48,53,61,66,71,83,92,101,110,120,130,138,143,152,…+28
objects/obj_lighting/Step_0.gml(47): 14,18,23,27,33,37,42,46,51,55,60,64,69,73,78,82,89,106,111,116,…+27
objects/obj_enemyparent/Collision_obj_mario.gml(46): 1,18,20,21,24,26,29,31,32,35,39,44,46,47,51,53,59,62,63,72,…+26
scripts/scr_musicalscale/scr_musicalscale.gml(40): 10,16,22,28,34,40,46,54,72,76,80,84,88,92,96,104,117,123,129,135,…+20
objects/obj_editormanager/Other_10.gml(38): 3,12,21,32,41,50,59,67,76,85,97,108,119,130,140,152,162,172,183,193,…+18
objects/obj_mario_transform2/Other_10.gml(37): 3,12,21,32,41,50,59,67,76,85,97,108,119,129,139,151,161,171,182,192,…+17
objects/obj_bg1/Other_11.gml(35): 157,164,167,170,173,176,179,182,185,188,191,194,197,200,203,206,209,212,222,225,…+15
objects/obj_card_logo/Other_11.gml(35): 157,164,167,170,173,176,179,182,185,188,191,194,197,200,203,206,209,212,222,225,…+15
objects/obj_shell/Collision_obj_mario.gml(34): 7,8,13,24,27,28,31,35,36,42,45,67,69,73,77,81,84,90,94,105,…+14
objects/obj_creator_jugar_editar/Other_13.gml(32): 11,19,23,28,34,40,44,48,56,61,107,112,117,122,158,160,174,178,187,197,…+12
objects/obj_tuberia_res/Alarm_1.gml(30): 6,8,9,10,11,12,13,14,15,16,17,18,19,22,23,26,27,30,31,34,…+10
objects/obj_tongue/Collision_obj_enemyparent.gml(27): 1,3,19,20,21,23,26,28,30,33,35,38,40,45,50,55,60,63,65,68,…+7
objects/obj_tongue_blue/Collision_obj_enemyparent.gml(27): 1,3,19,20,21,23,26,28,30,33,35,38,40,45,50,55,60,63,65,68,…+7
objects/obj_yoshi2/Other_10.gml(23): 11,15,20,22,34,37,42,45,53,66,68,97,101,106,108,120,123,128,131,139,…+3
objects/obj_snowball/Collision_obj_enemyparent.gml(22): 2,4,8,13,14,16,17,18,19,20,21,22,27,30,33,35,38,45,48,56,…+2
objects/obj_ventana/Other_22.gml(22): 1,3,5,7,9,11,13,15,16,17,20,22,23,24,27,29,30,31,34,36,…+2
objects/obj_pink_coin/Other_11.gml(21): 3,7,8,12,13,17,18,22,23,27,28,32,33,37,38,42,43,47,48,52,…+1
objects/obj_blockparent/Alarm_2.gml(20): 5,8,14,16,22,24,30,32,150,153,154,157,160,161,164,167,168,171,174,175
objects/obj_clown_fire/Step_1.gml(20): 52,55,56,58,61,62,64,67,68,75,77,78,88,91,94,97,100,103,111,113
objects/obj_flagpole/Collision_obj_mario.gml(20): 3,5,9,11,12,17,22,24,25,33,35,36,42,44,46,47,53,55,56,61
objects/obj_flagpole/Collision_obj_marioU.gml(20): 4,6,8,11,12,14,15,23,25,26,33,35,38,39,41,42,48,50,51,56
objects/obj_helmet/Collision_obj_physicsparent.gml(20): 1,5,7,9,10,12,16,18,19,24,27,29,32,34,37,39,42,44,48,50
objects/obj_settings_panel/Create_0.gml(20): 23,31,105,109,111,115,117,121,123,127,129,137,141,143,147,149,153,155,159,161
objects/obj_spring_land/Collision_obj_physicsparent.gml(20): 1,3,5,7,9,15,17,20,21,22,25,27,29,35,37,40,41,42,43,44
objects/obj_cap/Collision_obj_mario.gml(19): 3,5,7,8,11,13,24,27,39,42,54,57,71,75,79,88,92,105,110
objects/obj_goalgate_tape/Other_10.gml(19): 4,10,22,27,34,41,48,55,62,67,70,71,76,78,80,81,82,87,92
objects/obj_SMW_bowser/Alarm_7.gml(18): 5,7,10,13,16,19,22,24,28,33,35,38,42,46,50,54,56,60
objects/obj_load_guardabot/Other_12.gml(18): 286,289,310,311,318,321,342,343,350,353,377,378,385,388,406,407,412,417
objects/obj_load_level/Other_12.gml(18): 154,157,159,161,163,165,167,169,171,173,175,177,179,181,183,185,187,189
objects/obj_settings_panel/Other_10.gml(18): 11,15,17,21,23,27,29,33,35,43,47,49,53,55,59,61,65,67
objects/obj_shell/Alarm_4.gml(18): 14,15,20,21,26,27,34,43,57,66,110,113,118,121,126,129,134,137
objects/obj_spiny/Step_0.gml(18): 3,5,6,7,54,56,86,95,97,99,117,118,124,132,134,136,154,155
objects/obj_spring_land/Collision_obj_shell.gml(18): 1,3,5,8,9,11,13,18,22,24,26,29,32,36,38,40,43,46
objects/obj_ventana/Other_16.gml(18): 1,3,4,5,8,10,11,12,15,17,18,19,22,24,25,26,29,31
objects/obj_angrysun_res/Other_14.gml(17): 150,153,155,157,159,161,163,165,167,169,171,173,175,177,179,181,183
objects/obj_night_change/Other_12.gml(17): 156,161,164,167,170,173,176,179,182,185,188,191,194,197,200,203,206
objects/obj_ventana/Other_10.gml(17): 1,3,4,5,7,9,10,11,13,15,17,19,21,23,25,27,29
objects/obj_axe_smw/Destroy_0.gml(16): 3,8,13,18,23,28,33,38,43,48,53,58,63,68,73,78
objects/obj_claw/Collision_obj_shell_held.gml(16): 6,7,8,9,12,13,14,15,18,20,25,27,40,42,45,47
objects/obj_powerupparent/Collision_obj_mario.gml(16): 3,5,7,8,11,13,17,26,27,32,35,60,66,70,82,85
objects/obj_shell_drybones/Collision_obj_mario.gml(16): 1,5,9,10,15,28,30,32,37,39,50,58,61,67,69,104
objects/obj_spike_ball/Other_13.gml(16): 7,15,25,33,45,50,57,62,67,83,88,93,109,114,119,124
objects/obj_tuberia/Alarm_1.gml(16): 2,6,8,11,19,27,35,43,51,56,57,60,61,62,64,69
objects/obj_ventana/Other_21.gml(16): 1,3,4,5,8,10,11,12,15,17,18,19,22,24,25,26
scripts/scr_create_bg_anim/scr_create_bg_anim.gml(16): 4,14,22,30,38,51,59,69,77,90,100,110,124,135,146,157
scripts/scr_musicalscale_kick/scr_musicalscale_kick.gml(16): 26,32,38,44,50,56,62,70,83,89,95,101,107,113,119,127
objects/obj_door_lock/Step_0.gml(15): 53,62,71,75,82,84,123,125,138,146,150,159,165,173,177
objects/obj_door_lock_exit/Step_0.gml(15): 53,62,71,75,82,84,123,125,138,145,149,158,164,171,175
objects/obj_load_guardabot/Other_11.gml(15): 51,247,263,269,275,294,307,323,330,337,351,355,359,379,381
objects/obj_settings_panel/Destroy_0.gml(15): 1,3,5,7,9,11,13,15,17,19,21,23,25,29,34
objects/obj_spring_land/Collision_obj_holdparent.gml(15): 1,3,7,8,12,13,15,16,19,23,24,28,29,31,32
objects/obj_window_alert/Create_0.gml(15): 7,9,11,13,15,17,19,21,23,25,27,29,31,33,35
objects/obj_yoshi2/Other_11.gml(15): 3,5,7,8,10,15,18,20,21,23,28,31,33,34,36
objects/obj_axe_smw/Alarm_0.gml(14): 1,3,5,7,9,11,13,15,17,19,21,23,25,27
objects/obj_bortice/Collision_obj_physicsparent.gml(14): 2,4,6,8,10,22,23,24,26,27,28,32,33,34
objects/obj_buzzybeetle/Step_0.gml(14): 91,93,130,139,141,143,167,168,174,182,184,186,210,211
objects/obj_kuribo_drybones/Step_2.gml(14): 20,23,25,52,57,59,62,64,66,68,70,223,257,263
objects/obj_mario/Alarm_10.gml(14): 38,39,43,44,61,62,78,79,83,84,103,105,122,123
objects/obj_mario/Other_12.gml(14): 91,192,206,262,268,517,519,528,617,619,620,644,659,672
objects/obj_mario/Step_0.gml(14): 188,202,215,224,245,259,264,269,274,279,281,301,453,482
objects/obj_marioU/Other_12.gml(14): 128,133,170,184,239,253,576,581,606,618,642,654,801,804
objects/obj_puller/Alarm_1.gml(14): 7,12,20,22,23,24,26,36,38,39,40,42,50,51
objects/obj_ventana/Other_14.gml(14): 1,3,4,5,7,9,10,11,13,15,17,19,21,23
objects/obj_ventana/Other_24.gml(14): 2,4,6,8,10,12,14,16,17,18,20,22,23,24
objects/obj_bg1/Mouse_4.gml(13): 6,18,21,45,48,72,75,83,102,105,127,131,133
objects/obj_bg_selection/Other_7.gml(13): 5,13,21,29,37,45,53,61,69,77,85,93,101
objects/obj_block/Alarm_1.gml(13): 9,12,13,19,21,22,23,24,30,32,33,34,35
objects/obj_koopa_b/Other_11.gml(13): 3,8,11,17,20,26,28,39,43,46,47,57,58
objects/obj_koopa_red/Other_11.gml(13): 3,8,11,17,20,26,28,39,43,46,47,57,58
objects/obj_koopa_red_b/Other_11.gml(13): 3,8,11,17,20,26,28,39,43,46,47,57,58
objects/obj_mario_transform2/Step_0.gml(13): 3,10,12,14,15,16,17,22,32,37,42,47,52
objects/obj_player_goal_parent/Create_0.gml(13): 1,3,46,57,65,73,81,89,97,105,110,118,126
objects/obj_spring_land/Collision_obj_block_pow_hold.gml(13): 1,3,5,8,9,13,14,18,20,23,24,28,29
objects/obj_tongue/Collision_obj_holdparent.gml(13): 1,3,10,11,12,13,14,15,24,25,26,29,31
objects/obj_tongue_blue/Collision_obj_holdparent.gml(13): 1,3,10,11,12,13,14,15,24,25,26,29,31
objects/obj_bortice/Collision_obj_mario.gml(12): 1,7,9,14,16,17,18,22,23,24,27,30
objects/obj_buzzybeetle_b/Step_0.gml(12): 91,93,130,132,134,158,159,167,169,171,195,196
objects/obj_claw/Collision_obj_enemyparent.gml(12): 2,6,9,10,11,13,14,16,24,26,29,31
objects/obj_editormanager/Alarm_1.gml(12): 7,12,37,42,64,69,97,102,121,127,140,145
objects/obj_flipblock/Step_0.gml(12): 6,15,27,30,35,40,45,54,57,62,67,72
objects/obj_galoomba/Other_11.gml(12): 5,6,10,12,27,31,35,37,38,43,46,53
objects/obj_galoomba2/Other_11.gml(12): 5,6,10,12,27,31,35,37,38,43,46,53
objects/obj_koopa/Other_11.gml(12): 3,8,11,17,20,27,38,42,45,46,56,57
objects/obj_levelmanager/Step_2.gml(12): 27,225,230,251,253,264,266,274,276,284,286,296
objects/obj_marioU/Step_0.gml(12): 162,176,189,198,227,242,247,252,257,264,384,418
objects/obj_mario_transform2/Destroy_0.gml(12): 15,21,26,48,49,50,58,59,66,72,77,80
objects/obj_player_warp/Alarm_1.gml(12): 10,14,16,19,27,35,43,51,59,66,70,75
objects/obj_rockparent/Alarm_0.gml(12): 4,7,8,11,14,15,18,21,22,25,28,29
objects/obj_shell_held/Other_11.gml(12): 5,8,12,20,25,27,28,32,34,44,50,63
objects/obj_spike_ball_b/Other_13.gml(12): 7,15,25,33,45,50,58,63,71,76,81,86
objects/obj_superball/Collision_obj_enemyparent_held.gml(12): 1,4,6,7,9,11,12,17,19,22,25,27
objects/obj_ventana/Other_17.gml(12): 1,3,4,5,8,10,11,12,15,17,18,19
objects/obj_NSMBU_bowserjr/Other_14.gml(11): 24,31,47,54,68,113,126,133,137,146,151
objects/obj_NSMBU_charginchuck/Step_0.gml(11): 11,16,125,127,128,136,138,139,147,149,150
objects/obj_SMB2_mushroom/Collision_obj_mario.gml(11): 3,5,7,8,11,13,17,30,33,41,44
objects/obj_angrysun/Collision_obj_mario.gml(11): 5,12,23,33,37,41,46,57,67,71,75
objects/obj_bortice/Collision_obj_muncher.gml(11): 2,4,9,10,11,13,14,15,19,20,21
objects/obj_charginchuck/Step_0.gml(11): 10,15,125,127,128,136,138,139,147,149,150
objects/obj_door/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,40,42
objects/obj_door_exit/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,42,45
objects/obj_door_lock/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,40,42
objects/obj_door_lock_exit/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,40,42
objects/obj_door_switch/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,40,42
objects/obj_door_switch_exit/Alarm_0.gml(11): 5,6,8,13,17,19,22,28,35,40,42
objects/obj_flipblock/Other_20.gml(11): 17,25,34,42,48,53,58,63,68,76,84
objects/obj_galoomba2_b/Other_11.gml(11): 5,6,10,12,25,27,28,33,41,56,57
objects/obj_galoomba_b/Other_11.gml(11): 5,6,10,12,25,28,29,34,42,57,58
objects/obj_lakitu/Alarm_1.gml(11): 3,10,11,29,33,34,41,50,53,55,57
objects/obj_link_dash_atack/Collision_obj_enemyparent.gml(11): 1,5,7,24,29,31,37,41,43,50,52
objects/obj_panel_circle/Other_12.gml(11): 7,21,23,44,53,60,67,74,89,96,103
objects/obj_parcarry/Alarm_0.gml(11): 5,9,10,16,19,41,43,44,54,58,59
objects/obj_parcarry/Step_0.gml(11): 9,63,65,89,91,119,120,142,143,164,166
objects/obj_pblock/Other_10.gml(11): 17,25,34,42,48,53,58,63,68,76,84
objects/obj_player_goal_nsmbu/Create_0.gml(11): 1,15,63,74,82,90,98,106,111,119,127
objects/obj_spinner/Collision_obj_enemyparent.gml(11): 1,4,6,8,10,15,17,39,44,46,48
objects/obj_spring/Collision_obj_physicsparent.gml(11): 2,4,6,8,9,10,11,15,17,18,20
objects/obj_spring_land/Collision_obj_buzzybeetle.gml(11): 1,3,5,6,7,9,12,14,15,16,18
objects/obj_spring_land/Collision_obj_spiny.gml(11): 1,3,5,6,7,9,12,14,15,16,18
objects/obj_thwomp_b/Step_0.gml(11): 49,97,109,114,120,182,187,195,257,262,268
objects/obj_tuberia/Alarm_0.gml(11): 1,4,5,6,7,8,9,10,11,12,13
objects/obj_ventana/Other_12.gml(11): 1,3,4,5,7,9,10,11,13,15,17
objects/obj_ventana/Other_18.gml(11): 1,3,4,5,7,9,10,11,13,15,17
objects/obj_ventana/Other_20.gml(11): 1,3,4,5,7,9,10,11,13,15,17
objects/obj_ventana/Other_23.gml(11): 1,3,5,7,9,10,11,13,15,16,17
objects/obj_NSMBU_bowser/Alarm_4.gml(10): 10,19,30,39,50,59,70,79,90,99
objects/obj_NSMBU_bowser/Collision_obj_mario.gml(10): 3,8,10,21,22,28,29,32,34,36
objects/obj_SMW_bowser/Collision_obj_mario.gml(10): 3,8,10,21,22,28,29,32,34,36
objects/obj_boomerangbro_res/Other_11.gml(10): 1,10,11,14,25,26,29,40,41,44
objects/obj_bortice/Collision_obj_holdparent.gml(10): 1,3,4,5,7,8,9,13,14,15
objects/obj_bossparent/Collision_obj_mario.gml(10): 3,5,7,16,20,43,44,46,50,64
objects/obj_button_save_changes/Other_10.gml(10): 64,77,90,113,143,161,181,219,226,231
objects/obj_claw/Collision_obj_mario.gml(10): 2,6,16,17,18,19,20,22,25,27
objects/obj_claw/Collision_obj_powerupparent.gml(10): 2,6,8,10,11,12,19,21,24,26
objects/obj_coin/Other_10.gml(10): 16,24,33,41,47,52,57,62,67,75
objects/obj_door_lock_res/Other_11.gml(10): 5,11,13,14,18,31,37,39,40,44
objects/obj_door_res/Other_11.gml(10): 5,11,13,14,18,31,37,39,40,44
objects/obj_door_switch_res/Other_11.gml(10): 5,11,13,14,18,31,37,39,40,44
objects/obj_enabledsolid/Other_10.gml(10): 16,24,33,41,47,52,57,62,67,75
objects/obj_enemyfrozen/Other_10.gml(10): 2,5,12,15,22,25,32,35,43,47
objects/obj_firebro_res/Other_11.gml(10): 1,10,11,14,25,26,29,40,41,44
objects/obj_fireflower_res/Other_10.gml(10): 3,5,10,11,12,17,20,21,22,23
objects/obj_frogsuit/Collision_obj_mario.gml(10): 3,5,7,8,11,13,21,24,32,35
objects/obj_frozenmario/Alarm_1.gml(10): 4,12,18,21,28,31,38,41,48,51
objects/obj_grinder/Collision_obj_mario.gml(10): 1,7,12,13,15,16,18,20,23,25
objects/obj_groundpount/Collision_obj_blockparent.gml(10): 3,13,20,22,26,40,49,63,69,76
objects/obj_hammerbro_res/Other_11.gml(10): 1,10,11,14,25,26,29,40,41,44
objects/obj_helmet/Collision_obj_espina.gml(10): 6,9,11,12,13,15,17,20,22,24
objects/obj_icebro_res/Other_11.gml(10): 1,10,11,14,25,26,29,40,41,44
objects/obj_link_atack/Collision_obj_enemyparent.gml(10): 1,5,7,9,11,16,18,35,40,42
objects/obj_load_level/Other_11.gml(10): 347,350,377,380,407,410,440,443,465,470
objects/obj_panel_circle/Other_10.gml(10): 7,13,15,22,24,31,54,61,73,85
objects/obj_shell/Other_12.gml(10): 18,21,39,42,57,60,81,84,101,102
objects/obj_shell_held/Collision_obj_enemyparent.gml(10): 1,8,11,14,17,22,25,29,31,34
objects/obj_snowball/Collision_obj_shell.gml(10): 1,2,6,11,12,13,14,15,18,24
objects/obj_superflower_res/Other_10.gml(10): 3,5,10,11,12,17,20,21,22,23
objects/obj_SMB3_bowser/Other_14.gml(9): 22,39,46,96,111,116,117,124,131
objects/obj_bowserjr/Other_14.gml(9): 25,32,52,97,110,120,136,145,150
objects/obj_bowserjr_shell/Step_0.gml(9): 24,26,27,31,40,42,43,47,56
objects/obj_button_notification_aceptar/Other_10.gml(9): 64,77,90,113,143,161,181,222,227
objects/obj_claw/Step_2.gml(9): 6,14,94,130,150,164,177,190,195
objects/obj_coin_pow/Step_0.gml(9): 6,15,17,27,36,38,48,57,59
objects/obj_egg/Other_10.gml(9): 3,5,6,16,18,20,23,25,31
objects/obj_enemyparent/Step_0.gml(9): 18,20,21,29,31,32,40,42,43
objects/obj_grrrol/Other_13.gml(9): 8,13,18,28,41,51,68,76,86
objects/obj_grrrol_b/Other_13.gml(9): 8,13,18,28,41,51,68,76,86
objects/obj_grrrol_new/Other_13.gml(9): 8,13,18,28,41,51,68,76,86
objects/obj_helmet/Collision_obj_bone.gml(9): 6,9,12,13,15,17,20,22,24
objects/obj_link_down_atack/Collision_obj_enemyparent.gml(9): 1,5,7,24,29,31,37,41,43
objects/obj_mario/Other_10.gml(9): 30,39,62,101,107,115,134,167,172
objects/obj_mario_transform2/Create_0.gml(9): 21,26,31,36,69,77,79,80,93
objects/obj_mushroom/Collision_obj_mario.gml(9): 3,5,7,8,11,13,17,30,34
objects/obj_panel_circle/Other_11.gml(9): 7,13,15,22,29,36,43,64,71
objects/obj_panel_circle/Other_13.gml(9): 7,18,22,24,39,54,62,77,84
objects/obj_panel_circle/Other_14.gml(9): 7,21,23,30,37,44,51,80,87
objects/obj_panel_circle/Other_15.gml(9): 7,21,23,30,37,50,57,65,72
objects/obj_panel_circle/Other_20.gml(9): 7,13,15,41,56,63,70,85,92
objects/obj_pballon/Collision_obj_mario.gml(9): 3,5,7,8,11,13,19,22,25
objects/obj_rocangrejo/Step_0.gml(9): 37,39,40,48,50,51,59,61,62
objects/obj_shell_held/Step_0.gml(9): 54,56,57,67,69,70,80,82,83
objects/obj_snow_ball_b/Collision_obj_mario.gml(9): 7,18,20,27,29,34,40,41,42
objects/obj_superball/Step_0.gml(9): 10,17,24,30,48,55,61,67,73
objects/obj_ventana/Other_11.gml(9): 1,3,5,7,9,11,13,15,17
objects/obj_axe_smw/Collision_obj_mario.gml(8): 6,9,11,13,14,15,16,20
objects/obj_block_hidden_res/Collision_obj_parent_resource.gml(8): 1,3,6,9,12,14,15,16
objects/obj_block_pow_hold/Step_0.gml(8): 11,38,46,57,67,92,100,170
objects/obj_block_res/Collision_obj_parent_resource.gml(8): 1,3,6,9,12,14,15,16
objects/obj_bowserjr/Other_10.gml(8): 8,14,32,34,36,39,41,47
objects/obj_bowserjr_shell/Other_10.gml(8): 13,19,40,42,44,47,49,55
objects/obj_bullebill_base/Other_11.gml(8): 4,6,20,24,25,34,39,47
objects/obj_bullebill_base/Other_12.gml(8): 4,6,20,24,25,34,39,47
objects/obj_cannon_red_res/Other_11.gml(8): 1,7,9,10,11,12,13,17
objects/obj_cannon_res/Other_11.gml(8): 1,7,9,10,11,12,13,17
objects/obj_card_rocket/Other_10.gml(8): 3,8,13,18,23,28,31,36
objects/obj_claw/Collision_obj_snow_ball_held.gml(8): 6,7,9,10,16,18,21,23
objects/obj_claw/Collision_obj_spike_ball.gml(8): 6,9,10,12,17,19,22,24
objects/obj_edit_menu/Destroy_0.gml(8): 3,6,8,10,14,21,28,30
objects/obj_egg_red_res/Other_10.gml(8): 3,6,7,9,15,17,22,23
objects/obj_egg_res/Other_10.gml(8): 3,6,7,9,15,17,22,23
objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml(8): 3,7,9,11,14,17,19,21
objects/obj_helmet/Collision_obj_spike_ball.gml(8): 1,9,12,13,14,15,17,19
objects/obj_noteblock_res/Collision_obj_parent_resource.gml(8): 1,3,6,9,12,14,15,16
objects/obj_panel_circle/Other_16.gml(8): 7,13,17,24,31,38,50,57
objects/obj_panel_circle/Other_18.gml(8): 7,14,16,24,32,40,48,56
objects/obj_panel_circle/Other_19.gml(8): 7,16,18,33,48,63,88,103
objects/obj_panel_circle/Other_21.gml(8): 7,21,23,38,46,53,60,67
objects/obj_panel_circle/Other_22.gml(8): 7,13,15,30,38,45,52,63
objects/obj_panel_expand/Destroy_0.gml(8): 1,3,5,7,9,11,13,16
objects/obj_qblock_res/Collision_obj_parent_resource.gml(8): 1,3,6,9,12,14,15,16
objects/obj_rockparent/Other_10.gml(8): 5,8,14,16,23,25,32,34
objects/obj_rocky/Step_0.gml(8): 85,87,88,89,97,99,100,101
objects/obj_shell_drybones_held/Other_13.gml(8): 7,15,27,32,37,53,58,63
objects/obj_sledgebro/Step_0.gml(8): 113,120,182,184,185,193,195,196
objects/obj_snow_ball_held/Collision_obj_mario.gml(8): 3,7,12,14,22,24,27,29
objects/obj_snow_ball_held/Other_13.gml(8): 8,16,28,36,46,51,67,72
objects/obj_snowball_bro/Collision_obj_mario.gml(8): 1,5,10,20,21,22,49,52
objects/obj_spring_land/Collision_obj_snow_ball_held.gml(8): 3,6,7,8,11,14,15,16
objects/obj_spring_land/Collision_obj_spike_ball.gml(8): 3,6,7,8,11,14,15,16
objects/obj_thwomp/Step_0.gml(8): 47,85,96,101,157,162,218,223
objects/obj_tuberia/Step_0.gml(8): 15,20,35,40,56,61,76,81
objects/obj_ventana/Other_15.gml(8): 1,3,4,5,7,9,10,11
objects/obj_yoshi_abandon/Collision_obj_mario.gml(8): 2,4,6,7,8,17,19,20
objects/obj_yoshi_runaway/Collision_obj_mario.gml(8): 1,3,5,6,7,10,12,13
objects/obj_yoshi_runaway_blue/Collision_obj_mario.gml(8): 1,3,5,6,7,10,12,13
objects/obj_yoshi_runaway_red/Collision_obj_mario.gml(8): 1,3,5,6,7,10,12,13
objects/obj_yoshifire/Collision_obj_enemyparent.gml(8): 2,4,6,7,8,9,18,20
scripts/scr_NSMBU_musicalscale_minirebote/scr_NSMBU_musicalscale_minirebote.gml(8): 9,15,21,27,33,39,45,53
scripts/scr_NSMBU_musicalscale_rebote/scr_NSMBU_musicalscale_rebote.gml(8): 9,15,21,27,33,39,45,53
scripts/scr_NSMBU_spinstomp/scr_NSMBU_spinstomp.gml(8): 9,15,21,27,33,39,45,53
scripts/scr_musicalscale_SMB/scr_musicalscale_SMB.gml(8): 9,15,21,27,33,39,45,53
scripts/scr_musicalscale_SMB3/scr_musicalscale_SMB3.gml(8): 9,15,21,27,33,39,45,53
objects/obj_NSMBU_bowser/Other_14.gml(7): 24,72,85,90,91,98,105
objects/obj_SMB_bowser/Other_14.gml(7): 30,58,72,77,78,85,92
objects/obj_SMW_bowser/Other_14.gml(7): 30,62,76,81,82,89,96
objects/obj_beachkoopa/Other_10.gml(7): 10,15,17,19,22,24,30
objects/obj_beachkoopa_b/Other_10.gml(7): 7,12,14,16,19,21,27
objects/obj_beachkoopa_red/Other_10.gml(7): 10,15,17,19,22,24,30
objects/obj_billbanzai_red_res/Other_11.gml(7): 1,7,9,10,11,12,16
objects/obj_billbanzai_res/Other_11.gml(7): 1,7,9,10,11,12,16
objects/obj_block_pow_active/Alarm_0.gml(7): 4,15,33,44,55,66,80
objects/obj_bones_yoshi/Other_10.gml(7): 1,4,6,8,11,13,15
objects/obj_bones_yoshi_one/Other_10.gml(7): 1,4,6,8,11,13,15
objects/obj_boomerangbro/Alarm_3.gml(7): 10,13,19,22,29,31,32
objects/obj_bullebill_base/Collision_obj_enemyparent.gml(7): 1,3,4,5,7,9,19
objects/obj_bumper/Collision_obj_clown.gml(7): 9,14,15,18,20,23,25
objects/obj_bumper/Collision_obj_mario.gml(7): 11,12,14,35,37,40,42
objects/obj_cap_mario/Collision_obj_enemyparent.gml(7): 3,5,7,11,13,15,20
objects/obj_card_autoavance/Mouse_4.gml(7): 3,11,22,27,32,37,42
objects/obj_card_bg/Mouse_4.gml(7): 3,11,22,27,32,37,42
objects/obj_card_condiciones/Mouse_4.gml(7): 3,11,22,27,32,37,42
objects/obj_card_logo/Mouse_4.gml(7): 304,320,323,325,327,329,331
objects/obj_claw/Collision_obj_muncher.gml(7): 3,5,9,19,21,24,26
objects/obj_claw/Collision_obj_podoboo.gml(7): 6,9,10,15,17,20,22
objects/obj_clown/Step_0.gml(7): 8,28,83,102,127,166,171
objects/obj_cooligan/Other_10.gml(7): 27,32,34,36,39,41,47
objects/obj_editormanager/Step_0.gml(7): 6,8,9,42,52,65,81
objects/obj_galoomba/Other_10.gml(7): 8,13,15,17,20,22,28
objects/obj_galoomba2/Other_10.gml(7): 8,13,15,17,20,22,28
objects/obj_galoomba2_b/Other_10.gml(7): 8,13,15,17,20,22,28
objects/obj_galoomba_b/Other_10.gml(7): 8,13,15,17,20,22,28
objects/obj_gold_explosion/Collision_obj_blockparent.gml(7): 1,3,4,7,9,18,20
objects/obj_grinder/Collision_obj_clown.gml(7): 3,8,9,12,14,17,19
objects/obj_hammersuit/Collision_obj_mario.gml(7): 3,4,5,13,16,24,27
objects/obj_helmet/Collision_obj_snow_ball_held.gml(7): 1,6,14,17,18,20,22
objects/obj_iname_control/Destroy_0.gml(7): 1,3,5,7,9,11,14
objects/obj_koopa/Other_10.gml(7): 21,26,28,30,33,35,41
objects/obj_koopa_b/Other_10.gml(7): 21,26,28,30,33,35,41
objects/obj_koopa_red/Other_10.gml(7): 21,26,28,30,33,35,41
objects/obj_koopa_red_b/Other_10.gml(7): 21,26,28,30,33,35,41
objects/obj_link_arrow/Collision_obj_enemyparent.gml(7): 1,5,7,24,28,30,32
objects/obj_logo_game/Mouse_4.gml(7): 3,11,22,27,32,37,42
objects/obj_mario/Other_13.gml(7): 32,138,203,209,278,280,281
objects/obj_menu_pausa/Create_0.gml(7): 6,8,71,77,87,94,109
objects/obj_panel_circle/Other_17.gml(7): 7,13,15,22,29,36,43
objects/obj_panel_time/Mouse_4.gml(7): 3,11,22,27,32,37,42
objects/obj_parcarry/Other_10.gml(7): 3,11,24,26,28,31,33
objects/obj_physicssolid/Collision_obj_enemyparent.gml(7): 1,3,4,5,7,9,19
objects/obj_risas_or/Other_10.gml(7): 2,4,5,7,8,9,10
objects/obj_rocangrejo/Other_10.gml(7): 8,13,15,17,20,22,28
objects/obj_settings_custom/Other_10.gml(7): 1,7,13,19,25,31,37
objects/obj_shell_drybones/Other_12.gml(7): 16,19,43,46,61,64,81
objects/obj_snow_ball/Collision_obj_mario.gml(7): 7,15,26,28,34,36,41
objects/obj_superflower/Collision_obj_mario.gml(7): 3,4,5,14,17,26,29
objects/obj_tongue/Collision_obj_spike_ball.gml(7): 6,7,8,10,11,12,13
objects/obj_tongue_blue/Collision_obj_spike_ball.gml(7): 6,7,8,10,11,12,13
objects/obj_ventana_mario/Other_10.gml(7): 1,9,17,24,32,40,48
objects/obj_waddlewing/Other_10.gml(7): 14,19,21,23,26,28,34
objects/obj_NSMBU_charginchuck/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_SMB3_bowser/Alarm_2.gml(6): 4,6,7,13,15,16
objects/obj_SMB3_bowser/Collision_obj_mario.gml(6): 3,8,10,21,22,28
objects/obj_SMB_bowser/Alarm_2.gml(6): 4,6,7,13,15,16
objects/obj_SMB_bowser/Collision_obj_mario.gml(6): 3,8,10,21,22,28
objects/obj_SMW_bowser/Alarm_2.gml(6): 4,6,7,14,16,17
objects/obj_banzaibill/Other_10.gml(6): 10,12,14,17,19,25
objects/obj_beanstalk/Collision_obj_solid.gml(6): 1,5,12,14,20,22
objects/obj_beanstalk/Collision_obj_solidtop.gml(6): 1,5,12,14,20,22
objects/obj_block_gold/Alarm_1.gml(6): 7,12,17,22,27,32
objects/obj_bobomb/Other_10.gml(6): 31,33,35,38,40,46
objects/obj_bobomb_ready/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_boo/Other_10.gml(6): 13,15,17,20,22,28
objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml(6): 1,8,11,14,17,22
objects/obj_bullebill_base/Collision_obj_powerupparent.gml(6): 1,3,4,5,7,8
objects/obj_bullebill_base_red_res/Collision_obj_parent_resource.gml(6): 1,3,14,16,19,20
objects/obj_bullebill_base_res/Collision_obj_parent_resource.gml(6): 1,3,14,16,19,20
objects/obj_bulletbill/Other_10.gml(6): 27,29,31,34,36,42
objects/obj_bulletbull_red/Other_10.gml(6): 9,11,13,16,18,24
objects/obj_buzzy_ceiling/Other_10.gml(6): 67,69,71,74,76,82
objects/obj_buzzybeetle/Other_10.gml(6): 27,29,31,34,36,42
objects/obj_buzzybeetle_b/Other_10.gml(6): 31,33,35,38,40,46
objects/obj_call_mario/Mouse_4.gml(6): 7,9,10,12,15,16
objects/obj_charginchuck/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_checkpoint/Collision_obj_mario.gml(6): 6,12,18,38,57,66
objects/obj_checkpoint/Collision_obj_shell_held.gml(6): 6,12,18,38,57,66
objects/obj_cheepcheep/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_cheepcheep2/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_claw/Collision_obj_holdparent.gml(6): 2,6,16,18,21,23
objects/obj_claw/Collision_obj_spring_land.gml(6): 2,6,12,14,17,19
objects/obj_claw/Collision_obj_yoshi_runaway.gml(6): 6,7,16,18,21,23
objects/obj_condiciones/Other_7.gml(6): 6,12,18,25,34,40
objects/obj_cursor/Mouse_56.gml(6): 12,20,28,33,39,44
objects/obj_egg/Alarm_1.gml(6): 22,25,27,37,40,42
objects/obj_egg/Collision_obj_mario.gml(6): 3,7,9,17,25,27
objects/obj_egg/Other_17.gml(6): 8,10,12,15,17,23
objects/obj_enemyparent_held/Collision_obj_enemyparent.gml(6): 1,4,7,10,13,16
objects/obj_fireball/Collision_obj_bobomb_hold.gml(6): 1,3,4,8,9,11
objects/obj_fireball/Collision_obj_enemyparent.gml(6): 1,3,8,12,14,17
objects/obj_flagpole/Other_10.gml(6): 3,11,19,27,35,43
objects/obj_flagpole/Other_11.gml(6): 3,8,13,18,23,28
objects/obj_frogsuit_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_galoomba_hold/Other_10.gml(6): 11,13,15,18,20,26
objects/obj_gb_level/Destroy_0.gml(6): 1,3,5,7,9,11
objects/obj_goomba_b_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_goomba_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_goombrat_b_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_goombrat_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_grrrol/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_grrrol_b/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_grrrol_new/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_hammerbro/Other_10.gml(6): 42,44,46,49,51,57
objects/obj_hammerbro/Step_0.gml(6): 141,143,144,152,154,155
objects/obj_hen_mushroom_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_jumppiranha/Other_10.gml(6): 25,27,29,32,34,40
objects/obj_jumppiranha/Step_0.gml(6): 31,33,34,42,44,45
objects/obj_koopa/Step_0.gml(6): 85,87,88,96,98,99
objects/obj_koopa_b_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_koopa_red_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_koopa_res/Other_11.gml(6): 1,7,9,10,11,15
objects/obj_kuriboshoe/Step_2.gml(6): 59,61,70,89,95,115
objects/obj_lakitu/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_magikoopa/Other_10.gml(6): 22,24,26,29,31,37
objects/obj_muncher/Other_10.gml(6): 32,34,36,39,41,47
objects/obj_muncher_b/Other_10.gml(6): 32,34,36,39,41,47
objects/obj_mushroom_platform_res/Other_13.gml(6): 1,3,4,5,6,7
objects/obj_physicssolid/Collision_obj_powerupparent.gml(6): 1,3,4,5,7,8
objects/obj_piranhaplant/Other_10.gml(6): 25,27,29,32,34,40
objects/obj_plant_fire/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_platform_blue_res/Other_13.gml(6): 1,3,4,5,6,7
objects/obj_platform_res/Other_13.gml(6): 1,3,4,5,6,7
objects/obj_podoboo/Other_10.gml(6): 7,9,11,14,16,22
objects/obj_pswitch/Step_0.gml(6): 16,27,33,35,47,132
objects/obj_quicksand/Collision_obj_mario.gml(6): 1,2,5,6,9,10
objects/obj_rails_res/Other_13.gml(6): 1,3,4,5,6,7
objects/obj_semisolid_platform1/Other_13.gml(6): 1,3,4,5,6,7
objects/obj_shell/Other_10.gml(6): 145,147,149,152,154,160
objects/obj_shell/Step_1.gml(6): 22,24,34,36,46,48
objects/obj_shell_held/Other_10.gml(6): 145,147,149,152,154,160
objects/obj_sledgebro/Other_10.gml(6): 23,25,27,30,32,38
objects/obj_snow_ball/Collision_obj_enemyparent.gml(6): 3,6,9,12,15,18
objects/obj_spike/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_spiny/Other_10.gml(6): 21,23,25,28,30,36
objects/obj_thwomp/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_thwomp_b/Other_10.gml(6): 8,10,12,15,17,23
objects/obj_tongue/Collision_obj_coin10.gml(6): 6,10,12,16,19,20
objects/obj_tongue/Collision_obj_powerupparent.gml(6): 6,7,8,9,12,14
objects/obj_tongue_blue/Collision_obj_coin10.gml(6): 6,10,12,16,19,20
objects/obj_tongue_blue/Collision_obj_powerupparent.gml(6): 6,7,8,9,12,14
objects/obj_tuberia_res/Other_10.gml(6): 1,3,8,15,22,29
objects/obj_ventana/Other_13.gml(6): 1,3,5,7,9,11
objects/obj_ventana_mario/Other_11.gml(6): 1,9,17,24,32,40
objects/obj_ventana_mario/Other_13.gml(6): 1,9,17,24,32,40
objects/obj_1up/Collision_obj_mario.gml(5): 8,15,20,21,44
objects/obj_SMB2_mushroom/Collision_obj_blockparent.gml(5): 1,5,20,22,26
objects/obj_block_pow_hold/Collision_obj_mario.gml(5): 3,5,9,11,17
objects/obj_blockparent/Collision_obj_meteorites.gml(5): 6,24,42,60,78
objects/obj_bobomb_hold/Other_10.gml(5): 5,7,9,12,14
objects/obj_bobomb_ready_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_bobomb_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_bowserjr/Alarm_11.gml(5): 8,26,27,37,45
objects/obj_bowserjr/Alarm_7.gml(5): 1,3,4,5,6
objects/obj_bowserjr_shell/Alarm_1.gml(5): 13,15,16,17,18
objects/obj_bowserjr_shell/Other_7.gml(5): 3,5,6,7,8
objects/obj_brohammer/Other_10.gml(5): 5,7,9,12,14
objects/obj_brohammer_yoshi/Other_10.gml(5): 4,6,8,11,13
objects/obj_bullebill_base/Collision_obj_bossparent.gml(5): 1,3,4,5,9
objects/obj_bullebill_base/Collision_obj_mario.gml(5): 1,2,3,5,6
objects/obj_bullebill_base/Other_10.gml(5): 27,29,31,34,36
objects/obj_bullebill_base_red/Other_10.gml(5): 23,25,27,30,32
objects/obj_bullebill_base_red_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_bullebill_base_red_res/Other_13.gml(5): 1,3,4,5,6
objects/obj_bullebill_base_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_bullebill_base_res/Other_13.gml(5): 1,3,4,5,6
objects/obj_button_settings_close/Mouse_4.gml(5): 7,14,19,24,27
objects/obj_button_settings_close2/Mouse_4.gml(5): 9,14,19,24,27
objects/obj_button_wings/Mouse_4.gml(5): 5,13,21,41,45
objects/obj_cannon/Alarm_0.gml(5): 12,16,20,23,25
objects/obj_cannon/Other_10.gml(5): 28,30,32,35,37
objects/obj_cannon_red/Alarm_0.gml(5): 12,16,20,23,25
objects/obj_cannon_red/Other_10.gml(5): 15,17,19,22,24
objects/obj_cannonball/Other_10.gml(5): 9,11,13,16,18
objects/obj_cannonball_red/Other_10.gml(5): 6,8,10,13,15
objects/obj_cap_res/Other_10.gml(5): 1,4,5,6,7
objects/obj_cinta_on_res/Other_13.gml(5): 1,3,4,5,6
objects/obj_cinta_res/Other_13.gml(5): 1,3,4,5,6
objects/obj_claw/Collision_obj_egg.gml(5): 6,16,18,21,23
objects/obj_claw/Collision_obj_shell_drybones_held.gml(5): 6,11,13,16,18
objects/obj_claw/Collision_obj_yoshi_abandon.gml(5): 6,16,18,21,23
objects/obj_clown/Other_10.gml(5): 7,9,11,14,16
objects/obj_cooligan/Other_25.gml(5): 27,29,31,34,36
objects/obj_crystalorb/Collision_obj_mario.gml(5): 3,15,22,31,34
objects/obj_edit_menu/Create_0.gml(5): 8,16,27,29,31
objects/obj_egg_hatch/Collision_obj_mario.gml(5): 1,3,5,6,7
objects/obj_egg_red_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_egg_red_res/Other_13.gml(5): 4,12,14,15,19
objects/obj_egg_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_enemyfrozen/Alarm_5.gml(5): 9,14,21,28,35
objects/obj_enemyfrozen/Destroy_0.gml(5): 3,8,13,15,17
objects/obj_enemyfrozen/Step_0.gml(5): 7,14,25,33,151
objects/obj_enemyparent/Other_10.gml(5): 6,8,10,13,15
objects/obj_fire_clown/Collision_obj_enemyparent.gml(5): 1,4,5,7,10
objects/obj_floruga_angry_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_floruga_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_frogsuit_res/Other_10.gml(5): 1,3,8,9,10
objects/obj_goalcard/Collision_obj_mario.gml(5): 3,5,19,26,35
objects/obj_goomba_b_res/Other_13.gml(5): 2,9,11,12,13
objects/obj_goombrat_b_res/Other_13.gml(5): 2,9,11,12,13
objects/obj_hammerbro/Alarm_3.gml(5): 10,18,27,29,30
objects/obj_helmet/Collision_obj_holdparent.gml(5): 1,5,7,9,11
objects/obj_helmet/Collision_obj_thwomp.gml(5): 1,5,10,12,15
objects/obj_hen_mushroom/Collision_obj_mario.gml(5): 3,4,5,20,24
objects/obj_hen_mushroom_res/Other_10.gml(5): 1,3,8,9,10
objects/obj_holdparent/Collision_obj_mario.gml(5): 7,15,21,23,28
objects/obj_holdparent/Other_15.gml(5): 2,4,6,9,11
objects/obj_intro_controller/Alarm_1.gml(5): 2,4,6,8,10
objects/obj_key/Other_10.gml(5): 22,24,26,29,31
objects/obj_key_appear/Other_10.gml(5): 22,24,26,29,31
objects/obj_koopa_b_res/Other_13.gml(5): 2,9,11,12,13
objects/obj_koopa_red_b_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_koopa_red_b_res/Other_13.gml(5): 2,9,11,12,13
objects/obj_link/Collision_obj_mario.gml(5): 3,4,5,27,31
objects/obj_magic/Other_10.gml(5): 6,8,10,12,14
objects/obj_mechakoopa_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_monty_chase/Other_10.gml(5): 8,10,12,15,23
objects/obj_mushroom/Collision_obj_blockparent.gml(5): 1,5,20,22,26
objects/obj_mushroom_platform_res/Other_11.gml(5): 1,10,14,16,18
objects/obj_noteblock/Other_10.gml(5): 6,15,17,18,19
objects/obj_noteblock/Other_11.gml(5): 6,16,18,20,21
objects/obj_panel_left/Destroy_0.gml(5): 1,3,5,7,9
objects/obj_parent_resource/Collision_obj_key_res.gml(5): 1,6,15,21,22
objects/obj_physicssolid/Collision_obj_bossparent.gml(5): 1,3,4,5,9
objects/obj_physicssolid/Collision_obj_mario.gml(5): 1,2,3,5,6
objects/obj_plant_fire_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_plataforma_blue/Alarm_2.gml(5): 1,3,4,5,6
objects/obj_player_warp/Step_0.gml(5): 21,23,25,31,32
objects/obj_podoboo_b_res/Other_13.gml(5): 2,9,11,12,13
objects/obj_pokey_res/Other_13.gml(5): 5,10,13,16,21
objects/obj_powerupsprout/Alarm_2.gml(5): 28,30,52,57,59
objects/obj_powerupsprout_note/Alarm_1.gml(5): 29,31,53,58,60
objects/obj_pplant_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_puente_res/Other_13.gml(5): 1,3,4,5,6
objects/obj_rails_res/Collision_obj_parent_resource.gml(5): 1,3,6,8,9
objects/obj_robot/Mouse_4.gml(5): 6,17,22,27,32
objects/obj_rockparent/Collision_obj_meteorites.gml(5): 6,23,40,57,74
objects/obj_rocky/Other_10.gml(5): 17,19,21,24,32
objects/obj_semisolid_platform1/Other_11.gml(5): 1,10,14,16,18
objects/obj_snow_ball/Other_12.gml(5): 20,23,46,49,61
objects/obj_snow_ball/Other_17.gml(5): 5,7,9,12,14
objects/obj_snow_ball_held/Other_15.gml(5): 10,12,14,17,19
objects/obj_spike/Alarm_2.gml(5): 7,9,14,19,22
objects/obj_spring/Collision_obj_holdparent.gml(5): 2,4,6,10,11
objects/obj_spring/Collision_obj_powerupparent.gml(5): 2,4,6,10,11
objects/obj_spring_land_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_spring_res/Other_11.gml(5): 1,7,9,10,14
objects/obj_superball/Collision_obj_enemyparent.gml(5): 1,3,6,8,11
objects/obj_ventana_mario/Other_12.gml(5): 1,9,17,24,32
objects/obj_window_alert/Destroy_0.gml(5): 1,3,5,7,9
objects/obj_wrench/Other_10.gml(5): 6,8,10,13,15
objects/obj_1up/Collision_obj_blockparent.gml(4): 1,16,18,22
objects/obj_NSMBU_charginchuck/Other_11.gml(4): 5,6,16,31
objects/obj_SMB_flag/Collision_obj_flagpole.gml(4): 3,6,14,17
objects/obj_ahh_or/Other_10.gml(4): 2,4,5,7
objects/obj_apariencia/Other_7.gml(4): 5,12,19,26
objects/obj_aplausos_or/Other_10.gml(4): 2,4,5,6
objects/obj_arrow_res/Mouse_4.gml(4): 27,29,30,38
objects/obj_autoavance/Other_7.gml(4): 5,13,24,35
objects/obj_banzaibill/Alarm_0.gml(4): 4,11,18,25
objects/obj_beachkoopa/Collision_obj_shell.gml(4): 1,3,5,9
objects/obj_beachkoopa_b/Collision_obj_shell.gml(4): 1,3,5,9
objects/obj_beachkoopa_red/Collision_obj_shell.gml(4): 1,3,5,9
objects/obj_beachkoopa_red_b/Collision_obj_shell.gml(4): 1,3,5,9
objects/obj_bebe_or/Other_10.gml(4): 2,4,5,6
objects/obj_big_pplant_b_res/Other_10.gml(4): 1,4,5,7
objects/obj_big_pplant_res/Other_10.gml(4): 1,4,5,7
objects/obj_billbanzai_red_res/Mouse_4.gml(4): 30,32,33,42
objects/obj_billbanzai_res/Mouse_4.gml(4): 30,32,33,42
objects/obj_block_hidden/Step_0.gml(4): 5,16,17,18
objects/obj_block_pow_active/Create_0.gml(4): 22,34,36,37
objects/obj_block_pow_hold/Other_12.gml(4): 17,20,50,53
objects/obj_blockparent/Collision_obj_meteorites_big.gml(4): 6,26,46,66
objects/obj_blockparent/Other_25.gml(4): 4,23,42,61
objects/obj_bobomb/Other_11.gml(4): 3,4,33,34
objects/obj_bobomb_hold/Other_11.gml(4): 16,18,24,29
objects/obj_bobomb_ready_res/Other_10.gml(4): 1,3,11,12
objects/obj_bobomb_res/Other_10.gml(4): 1,3,11,12
objects/obj_bocina_or/Other_10.gml(4): 2,4,5,6
objects/obj_bombilla_or/Other_10.gml(4): 2,4,5,6
objects/obj_bonybeetle/Other_11.gml(4): 3,4,9,10
objects/obj_bonybeetle_b/Other_11.gml(4): 3,4,9,10
objects/obj_bonybeetle_b_res/Other_10.gml(4): 1,4,6,7
objects/obj_bonybeetle_b_res/Other_13.gml(4): 2,9,11,12
objects/obj_bonybeetle_res/Other_10.gml(4): 1,4,5,6
objects/obj_boomboom/Other_11.gml(4): 16,20,50,57
objects/obj_boomboom_b/Other_11.gml(4): 16,20,50,57
objects/obj_boomboom_b_res/Other_10.gml(4): 1,4,5,6
objects/obj_boomerangbro_res/Other_13.gml(4): 3,5,6,11
objects/obj_bortice/Collision_obj_thwomp.gml(4): 1,3,4,5
objects/obj_bowserjr_res/Other_10.gml(4): 1,4,5,7
objects/obj_bowserjr_shell/Other_13.gml(4): 10,18,26,34
objects/obj_bullebill_base/Collision_obj_enemyparent_held.gml(4): 1,2,3,7
objects/obj_bullebill_base_red_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_bullebill_base_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_bulletbill/Alarm_1.gml(4): 5,10,19,24
objects/obj_buzzybeetle_b_res/Other_10.gml(4): 1,4,5,7
objects/obj_buzzybeetle_b_res/Other_13.gml(4): 2,9,11,12
objects/obj_buzzybeetle_res/Other_10.gml(4): 1,3,16,17
objects/obj_cannon_red_res/Mouse_4.gml(4): 51,53,54,63
objects/obj_cannon_res/Mouse_4.gml(4): 51,53,54,63
objects/obj_charginchuck/Other_11.gml(4): 10,11,21,37
objects/obj_charginchuck_res/Other_11.gml(4): 1,6,8,9
objects/obj_checkpoint_res/Collision_obj_parent_resource.gml(4): 1,3,6,7
objects/obj_checkpoint_res/Mouse_4.gml(4): 27,29,30,38
objects/obj_cheepcheep2_res/Other_11.gml(4): 1,7,8,11
objects/obj_cheepcheep_res/Other_11.gml(4): 1,7,8,11
objects/obj_chisporreo_or/Other_10.gml(4): 2,4,5,6
objects/obj_chomp_b_res/Other_10.gml(4): 1,4,5,7
objects/obj_chomp_res/Other_10.gml(4): 1,4,5,7
objects/obj_cinta_on_res/Mouse_4.gml(4): 32,34,35,44
objects/obj_cinta_on_res/Other_15.gml(4): 2,4,5,6
objects/obj_cinta_res/Mouse_4.gml(4): 32,34,35,44
objects/obj_cinta_res/Other_15.gml(4): 2,4,5,6
objects/obj_claw/Step_0.gml(4): 153,191,203,218
objects/obj_cloud_lakitu/Collision_obj_mario.gml(4): 1,3,5,8
objects/obj_cloud_lakitu/Step_0.gml(4): 8,26,91,109
objects/obj_clown/Collision_obj_mario.gml(4): 8,12,14,24
objects/obj_clown/Collision_obj_pinchos.gml(4): 9,14,19,24
objects/obj_coin_res/Other_10.gml(4): 1,3,8,9
objects/obj_deadmario/Create_0.gml(4): 12,18,40,67
objects/obj_destello_or/Other_10.gml(4): 2,4,5,6
objects/obj_door/Step_0.gml(4): 6,12,20,24
objects/obj_door_exit/Step_0.gml(4): 6,12,20,24
objects/obj_door_switch/Step_0.gml(4): 10,16,23,27
objects/obj_door_switch_exit/Step_0.gml(4): 10,16,23,27
objects/obj_drybones/Other_11.gml(4): 3,4,9,10
objects/obj_drybones/Other_7.gml(4): 3,5,7,15
objects/obj_drybones_res/Other_10.gml(4): 1,3,8,9
objects/obj_editor_screen/Other_12.gml(4): 14,19,24,29
objects/obj_egg_res/Other_13.gml(4): 5,7,8,12
objects/obj_enemyparent/Collision_obj_blockparent.gml(4): 1,9,12,17
objects/obj_enemyparent_held/Other_10.gml(4): 3,9,11,12
objects/obj_error_or/Other_10.gml(4): 2,4,5,6
objects/obj_fire_clown/Collision_obj_bobomb.gml(4): 2,3,5,7
objects/obj_firebar_res/Mouse_4.gml(4): 23,25,26,35
objects/obj_firebro/Alarm_3.gml(4): 10,15,21,22
objects/obj_firebro_res/Other_13.gml(4): 3,5,6,11
objects/obj_floruga_angry_res/Other_10.gml(4): 1,3,8,9
objects/obj_fuegos_or/Other_10.gml(4): 2,4,5,6
objects/obj_galoomba/Destroy_0.gml(4): 5,6,10,12
objects/obj_galoomba_b/Destroy_0.gml(4): 5,6,10,12
objects/obj_galoomba_hold/Alarm_1.gml(4): 9,11,12,13
objects/obj_galoomba_hold2/Alarm_1.gml(4): 9,11,12,13
objects/obj_galoomba_hold2_b/Alarm_1.gml(4): 9,11,12,13
objects/obj_galoomba_hold_b/Alarm_1.gml(4): 9,11,12,13
objects/obj_goomba_b_res/Other_10.gml(4): 1,3,9,10
objects/obj_goomba_res/Other_10.gml(4): 1,3,8,9
objects/obj_goombrat_b_res/Other_10.gml(4): 1,3,9,10
objects/obj_goombrat_res/Other_10.gml(4): 1,3,8,9
objects/obj_grrrol_b_res/Mouse_4.gml(4): 28,30,31,40
objects/obj_grrrol_b_res/Other_10.gml(4): 1,4,5,7
objects/obj_grrrol_new_res/Mouse_4.gml(4): 28,30,31,40
objects/obj_grrrol_new_res/Other_10.gml(4): 1,4,5,7
objects/obj_grrrol_res/Mouse_4.gml(4): 28,30,31,40
objects/obj_hammer/Collision_obj_enemyparent.gml(4): 1,5,7,9
objects/obj_hammerbro_res/Other_13.gml(4): 3,5,6,11
objects/obj_helmet/Collision_obj_muncher.gml(4): 1,5,8,10
objects/obj_helmet_spiny/Collision_obj_bossparent.gml(4): 1,3,8,21
objects/obj_helmet_spiny/Collision_obj_holdparent.gml(4): 1,5,7,9
objects/obj_holdparent/Destroy_0.gml(4): 3,8,10,12
objects/obj_holdparent/Other_12.gml(4): 24,27,47,50
objects/obj_hurtsolid2/Step_0.gml(4): 9,18,28,37
objects/obj_icebro/Alarm_3.gml(4): 10,15,21,22
objects/obj_icebro_res/Other_13.gml(4): 3,5,6,11
objects/obj_icicle/Other_10.gml(4): 21,29,37,44
objects/obj_invincibility/Collision_obj_enemyparent.gml(4): 1,3,5,6
objects/obj_key/Collision_obj_mario.gml(4): 9,12,20,21
objects/obj_key_appear/Other_11.gml(4): 9,12,21,22
objects/obj_koopa_b_res/Other_10.gml(4): 1,3,9,10
objects/obj_koopa_red_b_res/Other_10.gml(4): 1,3,9,10
objects/obj_koopa_red_res/Other_10.gml(4): 1,3,8,9
objects/obj_koopa_red_res/Other_13.gml(4): 2,4,5,6
objects/obj_koopa_res/Other_10.gml(4): 1,3,8,9
objects/obj_koopa_res/Other_13.gml(4): 2,4,5,6
objects/obj_kuribo_drybones/Alarm_8.gml(4): 67,69,72,74
objects/obj_lakitu_res/Collision_obj_parent_resource.gml(4): 1,3,6,7
objects/obj_lakitu_res/Other_10.gml(4): 1,4,5,6
objects/obj_link_atack/Collision_obj_grrrol.gml(4): 3,5,8,10
objects/obj_link_atack/Collision_obj_spike_ball.gml(4): 3,5,8,10
objects/obj_link_dash_atack/Collision_obj_spike_ball.gml(4): 3,5,12,14
objects/obj_link_res/Other_10.gml(4): 1,4,5,6
objects/obj_magikoopa/Step_0.gml(4): 13,17,35,39
objects/obj_mario/Other_18.gml(4): 4,9,20,31
objects/obj_marioU/Step_2.gml(4): 79,102,185,192
objects/obj_mario_editor/Mouse_4.gml(4): 12,14,15,24
objects/obj_mario_pballon/Other_13.gml(4): 8,16,26,31
objects/obj_mario_pballon/Other_14.gml(4): 9,18,44,53
objects/obj_mechakoopa_held/Other_11.gml(4): 16,18,24,29
objects/obj_meteorites/Collision_obj_mario.gml(4): 1,3,6,12
objects/obj_meteorites/Other_11.gml(4): 7,25,42,59
objects/obj_meteorites_big/Collision_obj_mario.gml(4): 1,3,6,12
objects/obj_meteorites_big/Other_11.gml(4): 7,24,41,58
objects/obj_meteorites_big/Other_12.gml(4): 7,24,41,58
objects/obj_monty_res/Other_10.gml(4): 1,4,5,6
objects/obj_muncher_b_res/Other_10.gml(4): 1,4,5,7
objects/obj_muncher_res/Other_10.gml(4): 1,4,5,7
objects/obj_mushroom_platform_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_mushroom_platform_res/Other_10.gml(4): 1,4,8,14
objects/obj_mushroom_res/Other_10.gml(4): 1,4,5,6
objects/obj_musicblock_res/Other_11.gml(4): 5,14,27,36
objects/obj_next_before/Other_10.gml(4): 23,25,52,54
objects/obj_nota_musical_or/Other_10.gml(4): 2,4,5,6
objects/obj_noteblock_res/Other_11.gml(4): 5,14,27,36
objects/obj_noteblock_s/Alarm_1.gml(4): 6,8,9,33
objects/obj_noteblock_s_res/Other_11.gml(4): 5,14,27,36
objects/obj_oneway_res/Mouse_4.gml(4): 27,29,30,38
objects/obj_parcarry/Collision_obj_enemyparent.gml(4): 3,6,13,16
objects/obj_parent_resource/Mouse_4.gml(4): 12,14,15,24
objects/obj_parent_sound_o/Other_10.gml(4): 2,4,5,6
objects/obj_parent_sounds/Mouse_4.gml(4): 12,14,15,24
objects/obj_persistent/Alarm_4.gml(4): 8,24,29,34
objects/obj_physicssolid/Collision_obj_enemyparent_held.gml(4): 1,2,3,7
objects/obj_plant_fire_res/Other_10.gml(4): 1,3,8,9
objects/obj_platform_blue_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_platform_blue_res/Other_11.gml(4): 1,7,8,11
objects/obj_platform_res/Mouse_4.gml(4): 28,30,31,40
objects/obj_platform_res/Other_11.gml(4): 1,7,8,11
objects/obj_podoboo_b_res/Other_10.gml(4): 1,4,5,6
objects/obj_podoboo_res/Other_10.gml(4): 1,4,5,6
objects/obj_podoboo_res/Other_13.gml(4): 2,4,5,6
objects/obj_pokey_res/Mouse_4.gml(4): 26,28,29,38
objects/obj_powerupparent/Step_0.gml(4): 7,15,17,18
objects/obj_pplant_res/Other_10.gml(4): 1,3,8,9
objects/obj_puente_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_rails_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_remolino_or/Other_10.gml(4): 2,4,5,6
objects/obj_rocangrejo/Alarm_2.gml(4): 5,6,10,11
objects/obj_rockparent/Collision_obj_meteorites_big.gml(4): 6,23,40,57
objects/obj_semisolid_platform1/Mouse_4.gml(4): 20,22,23,32
objects/obj_semisolid_platform1/Other_10.gml(4): 1,4,8,14
objects/obj_serpentina_or/Other_10.gml(4): 2,4,5,6
objects/obj_shell_empty/Destroy_0.gml(4): 3,8,10,12
objects/obj_skewer_res/Mouse_4.gml(4): 26,28,29,38
objects/obj_skewertrunk/Step_2.gml(4): 7,15,23,31
objects/obj_sledgebro_res/Other_10.gml(4): 1,4,5,7
objects/obj_sledgebro_res/Other_13.gml(4): 3,5,6,10
objects/obj_soplete_res/Mouse_4.gml(4): 39,41,42,51
objects/obj_spike/Destroy_0.gml(4): 3,4,10,15
objects/obj_spike_ball/Collision_obj_mario.gml(4): 1,3,6,12
objects/obj_spike_ball_b_res/Other_10.gml(4): 1,3,32,33
objects/obj_spike_ball_res/Other_10.gml(4): 1,3,32,33
objects/obj_spike_res/Other_10.gml(4): 1,3,31,32
objects/obj_spiny/Alarm_1.gml(4): 1,3,8,13
objects/obj_spiny/Alarm_2.gml(4): 1,7,13,19
objects/obj_spiny_res/Other_10.gml(4): 1,3,8,9
objects/obj_spring_land_res/Other_10.gml(4): 1,3,8,9
objects/obj_spring_res/Other_10.gml(4): 1,3,8,9
objects/obj_star_res/Other_10.gml(4): 1,4,5,6
objects/obj_thwomp/Alarm_1.gml(4): 76,78,81,83
objects/obj_thwomp_b_res/Mouse_4.gml(4): 33,35,36,45
objects/obj_thwomp_b_res/Other_13.gml(4): 2,9,11,12
objects/obj_thwomp_res/Mouse_4.gml(4): 33,35,36,45
objects/obj_tongue/Collision_obj_bowser_fire.gml(4): 7,8,10,11
objects/obj_tongue/Collision_obj_pswitch.gml(4): 6,7,8,10
objects/obj_tongue/Collision_obj_spring_land.gml(4): 6,7,8,10
objects/obj_tongue_blue/Collision_obj_bowser_fire.gml(4): 7,8,10,11
objects/obj_tongue_blue/Collision_obj_pswitch.gml(4): 6,7,8,10
objects/obj_tongue_blue/Collision_obj_spring_land.gml(4): 6,7,8,10
objects/obj_tuberia_res/Mouse_4.gml(4): 20,22,23,32
objects/obj_ubsi_or/Other_10.gml(4): 2,4,5,7
objects/obj_vine_res/Mouse_4.gml(4): 26,28,29,38
objects/obj_water_level_control/Destroy_0.gml(4): 3,8,13,18
objects/obj_water_move_limit/Alarm_0.gml(4): 9,18,29,50
objects/obj_window_mario_button/Mouse_4.gml(4): 10,11,22,25
objects/obj_window_select/Mouse_4.gml(4): 5,11,13,14
objects/obj_yoshi_red/Other_10.gml(4): 25,27,60,62
objects/obj_1up_res/Other_10.gml(3): 1,4,5
objects/obj_NSMBU_boomboom/Other_10.gml(3): 3,15,17
objects/obj_NSMBU_boomboom/Other_11.gml(3): 8,17,21
objects/obj_NSMBU_boomboom_b/Other_10.gml(3): 3,15,17
objects/obj_NSMBU_boomboom_b/Other_11.gml(3): 8,17,21
objects/obj_NSMBU_bowserjr/Other_10.gml(3): 8,14,27
objects/obj_SMB2_mushroom_res/Other_13.gml(3): 2,4,5
objects/obj_angrysun_res/Other_13.gml(3): 5,8,30
objects/obj_autoscroll/Step_0.gml(3): 16,32,46
objects/obj_axe_smw/Other_10.gml(3): 4,10,31
objects/obj_beachkoopa/Collision_obj_mario.gml(3): 3,7,9
objects/obj_beachkoopa/Other_11.gml(3): 1,3,10
objects/obj_beachkoopa_b/Other_11.gml(3): 1,4,9
objects/obj_block_hidden/Collision_obj_shell.gml(3): 1,3,12
objects/obj_block_hidden/Collision_obj_shell_held.gml(3): 1,3,12
objects/obj_block_pow_hold/Collision_obj_thwomp.gml(3): 1,3,10
objects/obj_block_pow_hold/Other_14.gml(3): 36,86,97
objects/obj_blockbumper/Collision_obj_enemyparent.gml(3): 1,3,4
objects/obj_blockparent/Collision_obj_mario.gml(3): 1,3,4
objects/obj_bobomb_ready/Other_11.gml(3): 2,4,5
objects/obj_bones_yoshi/Collision_obj_enemyparent.gml(3): 1,4,6
objects/obj_bones_yoshi_one/Collision_obj_enemyparent.gml(3): 1,4,6
objects/obj_bonybeetle_res/Other_13.gml(3): 2,4,5
objects/obj_boomboom/Other_10.gml(3): 3,15,17
objects/obj_boomerangbro_res/Other_10.gml(3): 1,4,13
objects/obj_bouncycloud/Step_0.gml(3): 39,43,44
objects/obj_brohammer_yoshi/Collision_obj_enemyparent.gml(3): 1,5,7
objects/obj_bt_close_water/Mouse_4.gml(3): 5,18,22
objects/obj_bullebill_base_red/Other_11.gml(3): 5,25,44
objects/obj_bullebill_base_red/Other_12.gml(3): 5,25,44
objects/obj_button_close/Mouse_4.gml(3): 4,17,19
objects/obj_button_close_menu/Mouse_4.gml(3): 4,10,16
objects/obj_button_ok/KeyPress_13.gml(3): 7,12,18
objects/obj_button_ok/Mouse_4.gml(3): 7,12,18
objects/obj_buzzy_ceiling/Other_11.gml(3): 5,11,12
objects/obj_buzzy_ceiling/Step_0.gml(3): 4,6,8
objects/obj_buzzy_shell_res/Other_10.gml(3): 1,4,18
objects/obj_buzzy_shell_res/Other_11.gml(3): 1,6,7
objects/obj_buzzybeetle/Destroy_0.gml(3): 3,4,7
objects/obj_buzzybeetle/Other_11.gml(3): 3,31,34
objects/obj_buzzybeetle_b/Destroy_0.gml(3): 3,6,10
objects/obj_buzzybeetle_b/Other_11.gml(3): 3,31,34
objects/obj_buzzybeetle_res/Other_11.gml(3): 1,6,7
objects/obj_buzzybeetle_res/Other_13.gml(3): 2,4,5
objects/obj_cap_mario/Collision_obj_holdparent.gml(3): 5,7,12
objects/obj_cap_mario/Collision_obj_spike_ball.gml(3): 7,9,17
objects/obj_cap_res/Other_14.gml(3): 9,13,21
objects/obj_card_item/Mouse_4.gml(3): 17,20,31
objects/obj_castle/Step_0.gml(3): 5,9,14
objects/obj_cheepcheep2_res/Other_10.gml(3): 1,3,8
objects/obj_cheepcheep_res/Other_10.gml(3): 1,3,8
objects/obj_cinta_on_res/Other_10.gml(3): 1,4,8
objects/obj_cinta_on_res/Other_11.gml(3): 1,18,22
objects/obj_cinta_res/Other_10.gml(3): 1,4,8
objects/obj_cinta_res/Other_11.gml(3): 1,18,22
objects/obj_clown/Other_14.gml(3): 32,61,87
objects/obj_clown_explotion/Collision_obj_enemyparent.gml(3): 1,4,6
objects/obj_coin/Other_12.gml(3): 4,11,14
objects/obj_coin10_res/Other_11.gml(3): 1,20,24
objects/obj_coin30_res/Other_11.gml(3): 1,20,24
objects/obj_coin50_res/Other_11.gml(3): 1,20,24
objects/obj_condiciones/Other_10.gml(3): 3,5,7
objects/obj_cursor/Other_11.gml(3): 7,15,23
objects/obj_decoracion_1/Other_13.gml(3): 1,3,4
objects/obj_decoracion_2/Other_13.gml(3): 1,3,4
objects/obj_decoracion_3/Other_13.gml(3): 1,3,4
objects/obj_decoracion_4/Other_13.gml(3): 1,3,4
objects/obj_doormario_exit/Alarm_0.gml(3): 8,11,12
objects/obj_drybones_res/Other_11.gml(3): 1,6,7
objects/obj_egg/Other_11.gml(3): 3,5,6
objects/obj_egg_hatch/Other_7.gml(3): 10,15,24
objects/obj_enemyfrozen/Other_14.gml(3): 25,65,76
objects/obj_enemyparent_held/Collision_obj_blockparent.gml(3): 1,6,8
objects/obj_erase/Other_10.gml(3): 5,10,21
objects/obj_etiquetas/Mouse_4.gml(3): 12,26,44
objects/obj_expand/Mouse_4.gml(3): 8,23,28
objects/obj_explosion/Collision_obj_enemyparent.gml(3): 1,3,4
objects/obj_explosion/Collision_obj_mario.gml(3): 1,4,11
objects/obj_fast_lava_lift/Other_11.gml(3): 6,16,26
objects/obj_firebro_res/Other_10.gml(3): 1,4,13
objects/obj_fireflower_res/Other_11.gml(3): 1,6,7
objects/obj_flagpole/Destroy_0.gml(3): 8,13,18
objects/obj_floruga/Other_10.gml(3): 7,10,11
objects/obj_floruga/Other_11.gml(3): 5,7,12
objects/obj_frozenmario/Destroy_0.gml(3): 7,9,10
objects/obj_goalcard/Other_12.gml(3): 4,10,13
objects/obj_gold_explosion/Collision_obj_enemyparent.gml(3): 1,5,7
objects/obj_gold_explosion/Collision_obj_enemyparent_held.gml(3): 1,5,7
objects/obj_golpe_gato_or/Other_10.gml(3): 2,5,6
objects/obj_goomba_res/Other_13.gml(3): 2,4,5
objects/obj_goombrat_res/Other_13.gml(3): 2,4,5
objects/obj_ground/Other_13.gml(3): 24,27,28
objects/obj_hammer_b/Collision_obj_enemyparent.gml(3): 1,5,7
objects/obj_hammerbro_res/Other_10.gml(3): 1,4,13
objects/obj_helmet/Collision_obj_banzaibill.gml(3): 6,9,11
objects/obj_helmet/Collision_obj_bulletbill.gml(3): 10,13,15
objects/obj_helmet/Collision_obj_bulletbull_red.gml(3): 10,13,15
objects/obj_helmet/Collision_obj_buzzy_ceiling.gml(3): 1,5,7
objects/obj_helmet/Collision_obj_cannonball.gml(3): 7,10,12
objects/obj_helmet/Collision_obj_clown.gml(3): 1,5,7
objects/obj_helmet/Collision_obj_shell_held.gml(3): 1,5,7
objects/obj_helmet_spiny/Collision_obj_enemyparent.gml(3): 1,5,7
objects/obj_helmet_spiny/Collision_obj_muncher.gml(3): 1,5,7
objects/obj_helmet_spiny/Collision_obj_physicsparent.gml(3): 1,6,8
objects/obj_helmet_spiny/Collision_obj_shell.gml(3): 1,5,7
objects/obj_helmet_spiny/Collision_obj_shell_held.gml(3): 1,5,7
objects/obj_helmet_spiny/Collision_obj_thwomp.gml(3): 1,5,7
objects/obj_hen_mushroom/Collision_obj_blockparent.gml(3): 1,6,8
objects/obj_holdparent/Other_14.gml(3): 35,77,88
objects/obj_icebro_res/Other_10.gml(3): 1,4,13
objects/obj_icecoin_res/Other_10.gml(3): 1,3,8
objects/obj_icicle/Collision_obj_mario.gml(3): 1,6,8
objects/obj_icicle2_res/Other_11.gml(3): 1,24,28
objects/obj_icicle_res/Other_11.gml(3): 1,24,28
objects/obj_kuriboshoe/Other_10.gml(3): 1,3,18
objects/obj_lava_lift/Other_11.gml(3): 8,20,32
objects/obj_levelmanager/Other_12.gml(3): 1,6,11
objects/obj_levelmanager/Other_4.gml(3): 30,34,51
objects/obj_levelmanager/Other_5.gml(3): 5,7,30
objects/obj_link/Step_0.gml(3): 9,11,12
objects/obj_link_arrow/Collision_obj_enemyparent_held.gml(3): 1,3,8
objects/obj_link_bomb/Collision_obj_link_atack.gml(3): 4,6,11
objects/obj_link_bomb/Collision_obj_link_down_atack.gml(3): 4,6,11
objects/obj_link_down_atack/Collision_obj_blockparent.gml(3): 1,3,6
objects/obj_link_down_atack/Collision_obj_grinder.gml(3): 1,5,7
objects/obj_marioU/Other_13.gml(3): 118,181,187
objects/obj_mario_transform2/Alarm_0.gml(3): 10,36,58
objects/obj_mechakoopa/Other_10.gml(3): 4,7,8
objects/obj_mechakoopa_held/Other_10.gml(3): 4,7,8
objects/obj_menu_pausa/Other_11.gml(3): 8,37,39
objects/obj_mini_icicle2_res/Other_11.gml(3): 1,24,28
objects/obj_mini_icicle_res/Other_11.gml(3): 1,24,28
objects/obj_musicblock/Alarm_1.gml(3): 6,11,13
objects/obj_night_change/Other_13.gml(3): 5,8,30
objects/obj_noteblock/Alarm_1.gml(3): 7,9,10
objects/obj_onewaygate_top/Step_2.gml(3): 4,6,9
objects/obj_panel_expand/Create_0.gml(3): 223,225,227
objects/obj_penguin_attack/Collision_obj_enemyparent.gml(3): 1,5,7
objects/obj_penguin_attack/Collision_obj_enemyparent_held.gml(3): 1,5,7
objects/obj_physicsparent/Other_14.gml(3): 39,80,91
objects/obj_platform_blue_res/Other_10.gml(3): 1,4,10
objects/obj_player_goal_parent/Other_14.gml(3): 22,55,66
objects/obj_player_goal_smb1/Collision_obj_flagpole.gml(3): 1,12,13
objects/obj_player_goal_smw/Create_0.gml(3): 1,23,28
objects/obj_player_goal_smw_castle/Create_0.gml(3): 1,62,75
objects/obj_podoboo/Collision_obj_bobomb.gml(3): 1,3,9
objects/obj_pswitch/Other_14.gml(3): 32,73,84
objects/obj_pswitch_res/Other_10.gml(3): 1,3,6
objects/obj_rename_control/Destroy_0.gml(3): 1,3,5
objects/obj_rocangrejo/Other_14.gml(3): 24,65,76
objects/obj_shell_drybones/Destroy_0.gml(3): 3,5,7
objects/obj_shell_drybones/Other_14.gml(3): 24,57,68
objects/obj_shell_drybones_held/Other_14.gml(3): 24,57,68
objects/obj_shell_drybones_res/Other_10.gml(3): 1,4,10
objects/obj_shell_drybones_res/Other_11.gml(3): 1,6,7
objects/obj_shell_held/Collision_obj_mario.gml(3): 1,8,13
objects/obj_shell_held/Other_14.gml(3): 30,60,71
objects/obj_skewertrunk/Other_10.gml(3): 26,33,38
objects/obj_sledgebro/Alarm_4.gml(3): 10,20,31
objects/obj_slider/Collision_obj_enemyparent.gml(3): 1,3,4
objects/obj_snow_ball/Other_14.gml(3): 25,68,79
objects/obj_soplete/Collision_obj_bobomb.gml(3): 2,4,10
objects/obj_soplete_res/Other_10.gml(3): 1,4,7
objects/obj_soplete_res/Other_11.gml(3): 1,13,17
objects/obj_spike_ball/Other_14.gml(3): 33,87,96
objects/obj_spike_ball_b_res/Other_11.gml(3): 1,6,7
objects/obj_spike_ball_b_res/Other_13.gml(3): 2,9,10
objects/obj_spike_ball_res/Other_11.gml(3): 1,6,7
objects/obj_spike_res/Other_11.gml(3): 1,6,7
objects/obj_spinner/Collision_obj_spike_ball.gml(3): 2,4,13
objects/obj_spiny_ball/Step_0.gml(3): 24,25,37
objects/obj_spiny_empty/Other_11.gml(3): 3,7,11
objects/obj_spiny_res/Other_11.gml(3): 1,6,7
objects/obj_spiny_shell_res/Other_10.gml(3): 1,4,10
objects/obj_spiny_shell_res/Other_11.gml(3): 1,6,7
objects/obj_star/Collision_obj_mario.gml(3): 3,7,15
objects/obj_stomp/Collision_obj_enemyparent.gml(3): 1,3,4
objects/obj_superflower_res/Other_11.gml(3): 1,6,7
objects/obj_title_oprime/Mouse_4.gml(3): 6,19,24
objects/obj_tongue/Collision_obj_bone.gml(3): 7,8,10
objects/obj_tongue/Collision_obj_bowser_fire_down.gml(3): 7,8,10
objects/obj_tongue/Collision_obj_brohammer.gml(3): 7,8,10
objects/obj_tongue/Collision_obj_plantfire.gml(3): 7,8,10
objects/obj_tongue_blue/Collision_obj_bone.gml(3): 7,8,10
objects/obj_tongue_blue/Collision_obj_bowser_fire_down.gml(3): 7,8,10
objects/obj_tongue_blue/Collision_obj_brohammer.gml(3): 7,8,10
objects/obj_tongue_blue/Collision_obj_plantfire.gml(3): 7,8,10
objects/obj_tuberia_res/Other_11.gml(3): 15,26,30
objects/obj_ventana/Destroy_0.gml(3): 3,8,11
objects/obj_ventana/Other_19.gml(3): 1,3,5
objects/obj_ventana_water/Other_10.gml(3): 1,6,11
objects/obj_vine_res/Other_13.gml(3): 1,4,5
objects/obj_waddlewing/Other_14.gml(3): 37,80,91
objects/obj_window_button/Mouse_4.gml(3): 7,9,14
objects/obj_yoshi_abandon/Other_14.gml(3): 32,67,78
objects/obj_yoshi_abandon/Step_0.gml(3): 44,56,68
objects/obj_yoshifire/Step_2.gml(3): 4,17,30
objects/obj_1up/Other_13.gml(2): 12,20
objects/obj_1up_res/Other_14.gml(2): 9,11
objects/obj_NSMBU_boomboom/Other_14.gml(2): 32,73
objects/obj_NSMBU_boomboom/Other_17.gml(2): 9,11
objects/obj_NSMBU_boomboom/Step_2.gml(2): 19,37
objects/obj_NSMBU_boomboom_b/Other_14.gml(2): 32,73
objects/obj_NSMBU_boomboom_b/Other_17.gml(2): 9,11
objects/obj_NSMBU_boomboom_b/Step_2.gml(2): 19,41
objects/obj_NSMBU_bowser/Other_13.gml(2): 8,16
objects/obj_NSMBU_bowserjr/Other_11.gml(2): 6,15
objects/obj_NSMBU_bowserjr/Step_0.gml(2): 65,70
objects/obj_SMB2_mushroom_res/Other_10.gml(2): 1,4
objects/obj_SMB2_mushroom_res/Other_11.gml(2): 1,10
objects/obj_SMB2_mushroom_res/Other_14.gml(2): 9,11
objects/obj_SMB3_bowser/Other_13.gml(2): 8,16
objects/obj_SMB3_bowser/Step_0.gml(2): 59,64
objects/obj_SMB_bowser/Other_13.gml(2): 8,16
objects/obj_SMB_castle/Destroy_0.gml(2): 3,8
objects/obj_SMB_flag/Alarm_1.gml(2): 1,8
objects/obj_SMW_bowser/Other_13.gml(2): 8,16
objects/obj_ahh_snd_res/Other_10.gml(2): 1,4
objects/obj_ahh_snd_res/Other_11.gml(2): 1,10
objects/obj_alert_load/Destroy_0.gml(2): 2,4
objects/obj_alert_message/Destroy_0.gml(2): 1,3
objects/obj_angrysun/Other_10.gml(2): 7,9
objects/obj_angrysun_res/Other_10.gml(2): 1,4
objects/obj_aplausos_snd_res/Other_10.gml(2): 1,4
objects/obj_aplausos_snd_res/Other_11.gml(2): 1,10
objects/obj_auh_snd_res/Other_10.gml(2): 1,4
objects/obj_auh_snd_res/Other_11.gml(2): 1,10
objects/obj_autoavance/Other_10.gml(2): 2,4
objects/obj_beachkoopa/Other_13.gml(2): 10,18
objects/obj_beachkoopa_b/Other_13.gml(2): 10,18
objects/obj_beachkoopa_red/Other_13.gml(2): 10,18
objects/obj_beachkoopa_red_b/Other_13.gml(2): 10,18
objects/obj_bebe_snd_res/Other_10.gml(2): 1,4
objects/obj_bebe_snd_res/Other_11.gml(2): 1,10
objects/obj_bg_selection/Other_10.gml(2): 3,5
objects/obj_billbanzai_red_res/Other_10.gml(2): 1,4
objects/obj_billbanzai_res/Other_10.gml(2): 1,4
objects/obj_block/Other_10.gml(2): 3,4
objects/obj_block_gold_res/Other_10.gml(2): 1,4
objects/obj_block_hidden/Collision_obj_spinner.gml(2): 1,10
objects/obj_block_multicoin/Other_10.gml(2): 1,2
objects/obj_block_pow_hold/Collision_obj_boomboom.gml(2): 1,5
objects/obj_block_pow_hold/Collision_obj_enemyparent.gml(2): 1,5
objects/obj_block_pow_hold/Other_13.gml(2): 20,28
objects/obj_block_res/Other_10.gml(2): 1,4
objects/obj_blockcoin/Step_0.gml(2): 5,17
objects/obj_blockparent/Step_0.gml(2): 8,31
objects/obj_bobomb/Destroy_0.gml(2): 5,10
objects/obj_bobomb_hold/Alarm_4.gml(2): 1,4
objects/obj_bobomb_ready/Alarm_0.gml(2): 1,4
objects/obj_bobomb_ready_res/Other_14.gml(2): 9,11
objects/obj_bocina_snd_res/Other_10.gml(2): 1,4
objects/obj_bocina_snd_res/Other_11.gml(2): 1,10
objects/obj_bombilla_snd_res/Other_10.gml(2): 1,4
objects/obj_bombilla_snd_res/Other_11.gml(2): 1,10
objects/obj_bones_yoshi/Collision_obj_shell.gml(2): 2,4
objects/obj_bones_yoshi_one/Collision_obj_shell.gml(2): 2,4
objects/obj_bonybeetle/Destroy_0.gml(2): 3,4
objects/obj_bonybeetle/Other_10.gml(2): 40,46
objects/obj_bonybeetle_b/Other_10.gml(2): 46,52
objects/obj_boo/Collision_obj_blockparent.gml(2): 1,6
objects/obj_boo/Destroy_0.gml(2): 5,10
objects/obj_boomboom/Other_17.gml(2): 7,9
objects/obj_boomboom_b_res/Other_13.gml(2): 2,4
objects/obj_bossparent/Collision_obj_enemyparent_held.gml(2): 1,23
objects/obj_bossparent/Collision_obj_icicle.gml(2): 1,21
objects/obj_bossparent/Collision_obj_link_atack.gml(2): 1,24
objects/obj_bossparent/Collision_obj_shell_held.gml(2): 1,21
objects/obj_bowserjr/Step_0.gml(2): 69,74
objects/obj_brickhelmet/Step_0.gml(2): 7,12
objects/obj_brohammer_yoshi/Collision_obj_enemyparent_held.gml(2): 3,5
objects/obj_btn_header_1/Mouse_4.gml(2): 6,8
objects/obj_btn_header_2/Mouse_4.gml(2): 6,8
objects/obj_btn_header_3/Mouse_4.gml(2): 6,8
objects/obj_btn_header_4/Mouse_4.gml(2): 6,8
objects/obj_bullebill_base/Alarm_0.gml(2): 24,57
objects/obj_bullebill_base/Other_13.gml(2): 8,16
objects/obj_bullebill_base/Other_14.gml(2): 22,62
objects/obj_bullebill_base/Step_0.gml(2): 19,24
objects/obj_bullebill_base_red/Alarm_0.gml(2): 29,67
objects/obj_bullebill_base_red/Step_0.gml(2): 23,28
objects/obj_bullebill_base_red_res/Other_10.gml(2): 1,4
objects/obj_bullebill_base_res/Other_10.gml(2): 1,4
objects/obj_button_notification_aceptar/Alarm_0.gml(2): 5,15
objects/obj_button_notification_cancelar/Mouse_4.gml(2): 6,8
objects/obj_button_save_changes/Alarm_0.gml(2): 5,16
objects/obj_button_save_load/Mouse_4.gml(2): 6,17
objects/obj_buzzy_ceiling/Other_14.gml(2): 19,52
objects/obj_buzzybeetle/Other_15.gml(2): 46,48
objects/obj_buzzybeetle_b/Other_15.gml(2): 45,47
objects/obj_cannon/Other_14.gml(2): 34,72
objects/obj_cannon/Step_0.gml(2): 14,19
objects/obj_cannon_red_res/Other_10.gml(2): 1,4
objects/obj_cannon_res/Other_10.gml(2): 1,4
objects/obj_cap_res/Other_13.gml(2): 1,15
objects/obj_card_block_sounds/Other_10.gml(2): 3,10
objects/obj_cerdito_snd_res/Other_10.gml(2): 1,4
objects/obj_cerdito_snd_res/Other_11.gml(2): 1,10
objects/obj_change_view/Mouse_4.gml(2): 3,5
objects/obj_cheepcheep/Alarm_1.gml(2): 1,16
objects/obj_cheepcheep/Collision_obj_mario.gml(2): 3,8
objects/obj_cheepcheep/Destroy_0.gml(2): 3,4
objects/obj_cheepcheep/Other_11.gml(2): 6,7
objects/obj_chisporreteo_snd_res/Other_10.gml(2): 1,4
objects/obj_chisporreteo_snd_res/Other_11.gml(2): 1,10
objects/obj_cinta_on_res/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_cinta_res/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_cloud_lakitu/Other_13.gml(2): 8,16
objects/obj_cloud_lakitu/Other_14.gml(2): 19,40
objects/obj_clown/Collision_obj_boomboom.gml(2): 7,9
objects/obj_clown/Other_13.gml(2): 8,16
objects/obj_clown_explotion/Collision_obj_blockparent.gml(2): 1,3
objects/obj_clown_fire/Alarm_4.gml(2): 3,9
objects/obj_clown_fire_res/Other_10.gml(2): 1,4
objects/obj_clown_fire_res/Other_11.gml(2): 1,10
objects/obj_clown_res/Other_10.gml(2): 1,4
objects/obj_clown_res/Other_11.gml(2): 1,10
objects/obj_coin/Destroy_0.gml(2): 3,5
objects/obj_coin/Step_2.gml(2): 6,16
objects/obj_coin10_res/Other_10.gml(2): 1,4
objects/obj_coin30_res/Other_10.gml(2): 1,4
objects/obj_coin50_res/Other_10.gml(2): 1,4
objects/obj_coin_pow/Collision_obj_mario.gml(2): 6,41
objects/obj_coin_res/Other_11.gml(2): 1,10
objects/obj_coin_res/Other_14.gml(2): 9,11
objects/obj_coinchain/Alarm_0.gml(2): 5,6
objects/obj_condiciones_button/Mouse_4.gml(2): 9,21
objects/obj_creator_jugar_editar/Alarm_3.gml(2): 3,8
objects/obj_crumblebones/Alarm_3.gml(2): 1,2
objects/obj_crumblebones/Other_10.gml(2): 40,46
objects/obj_crumblebones/Other_7.gml(2): 8,9
objects/obj_crumblebony/Alarm_3.gml(2): 1,2
objects/obj_crumblebony/Other_10.gml(2): 40,46
objects/obj_crumblebony/Step_2.gml(2): 5,6
objects/obj_crumblebony_b/Alarm_3.gml(2): 1,2
objects/obj_crumblebony_b/Other_10.gml(2): 40,46
objects/obj_crumblebony_b/Step_2.gml(2): 5,6
objects/obj_crystalorb/Destroy_0.gml(2): 3,8
objects/obj_cursor/Mouse_51.gml(2): 8,16
objects/obj_cursor/Mouse_53.gml(2): 56,64
objects/obj_curtainout/Other_10.gml(2): 8,9
objects/obj_destello_snd_res/Other_10.gml(2): 1,4
objects/obj_destello_snd_res/Other_11.gml(2): 1,10
objects/obj_donut/Alarm_0.gml(2): 5,7
objects/obj_donut/Alarm_1.gml(2): 1,6
objects/obj_donut_res/Other_14.gml(2): 9,11
objects/obj_door_lock_res/Other_10.gml(2): 1,4
objects/obj_door_res/Other_10.gml(2): 1,4
objects/obj_door_switch_res/Other_10.gml(2): 1,4
objects/obj_drybones/Destroy_0.gml(2): 3,4
objects/obj_drybones/Other_10.gml(2): 39,45
objects/obj_editormanager/Step_1.gml(2): 111,123
objects/obj_egg_red_res/Other_14.gml(2): 9,11
objects/obj_egg_res/Other_14.gml(2): 10,12
objects/obj_enabledsolid/Create_0.gml(2): 2,10
objects/obj_enemyfrozen/Other_13.gml(2): 8,16
objects/obj_enemyparent_held/Collision_obj_bossparent.gml(2): 1,6
objects/obj_enemyparent_held/Collision_obj_fireball.gml(2): 4,9
objects/obj_enemyparent_lava/Collision_obj_mario.gml(2): 1,3
objects/obj_error_snd_res/Other_10.gml(2): 1,4
objects/obj_error_snd_res/Other_11.gml(2): 1,10
objects/obj_explosion/Collision_obj_block_pow_hold.gml(2): 1,3
objects/obj_explosion/Collision_obj_blockparent.gml(2): 1,3
objects/obj_explosion/Collision_obj_onoffblock.gml(2): 1,3
objects/obj_fast_lava_lift_res/Other_10.gml(2): 1,4
objects/obj_fast_lava_lift_res/Other_11.gml(2): 1,10
objects/obj_fireball/Collision_obj_bobomb.gml(2): 2,4
objects/obj_fireball/Other_10.gml(2): 4,12
objects/obj_fireball/Other_14.gml(2): 22,66
objects/obj_fireball_bro/Other_10.gml(2): 1,9
objects/obj_fireflower_res/Other_13.gml(2): 1,15
objects/obj_fireflower_res/Other_14.gml(2): 9,11
objects/obj_flipblock/Alarm_1.gml(2): 5,6
objects/obj_flipblock_anim/Step_0.gml(2): 5,14
objects/obj_floruga/Other_13.gml(2): 7,15
objects/obj_foo/Other_10.gml(2): 14,23
objects/obj_foo/Step_0.gml(2): 12,14
objects/obj_foo_res/Other_10.gml(2): 1,4
objects/obj_foo_res/Other_11.gml(2): 1,10
objects/obj_frogsuit_res/Other_13.gml(2): 1,15
objects/obj_frogsuit_res/Other_14.gml(2): 9,11
objects/obj_fuegos_snd_res/Other_10.gml(2): 1,4
objects/obj_fuegos_snd_res/Other_11.gml(2): 1,10
objects/obj_galoomba_hold/Other_11.gml(2): 3,8
objects/obj_goalgate/Create_0.gml(2): 7,8
objects/obj_goalgate/Destroy_0.gml(2): 3,8
objects/obj_gold_explosion/Collision_obj_bossparent.gml(2): 3,5
objects/obj_gold_explosion/Collision_obj_muncher.gml(2): 3,5
objects/obj_gold_explosion/Collision_obj_snow_ball.gml(2): 3,5
objects/obj_gold_explosion/Collision_obj_spike_ball.gml(2): 3,5
objects/obj_gold_explosion/Create_0.gml(2): 8,19
objects/obj_golpe_gato_snd_res/Other_10.gml(2): 1,4
objects/obj_golpe_gato_snd_res/Other_11.gml(2): 1,10
objects/obj_goomba_b_res/Other_14.gml(2): 9,11
objects/obj_goomba_res/Other_14.gml(2): 9,11
objects/obj_goombrat_b_res/Other_14.gml(2): 9,11
objects/obj_goombrat_res/Other_14.gml(2): 9,11
objects/obj_groundpount/Alarm_0.gml(2): 1,2
objects/obj_grrrol/Collision_obj_block_pow_hold.gml(2): 1,3
objects/obj_grrrol/Collision_obj_enemyparent.gml(2): 1,4
objects/obj_grrrol_b/Collision_obj_block_pow_hold.gml(2): 1,3
objects/obj_grrrol_b/Collision_obj_enemyparent.gml(2): 1,4
objects/obj_grrrol_new/Collision_obj_block_pow_hold.gml(2): 1,3
objects/obj_grrrol_new/Collision_obj_enemyparent.gml(2): 1,4
objects/obj_hammer/Collision_obj_block_pow_hold.gml(2): 1,3
objects/obj_hammer/Collision_obj_enemyparent_held.gml(2): 3,5
objects/obj_hammer/Collision_obj_spike_ball.gml(2): 3,5
objects/obj_hammerbro/Other_11.gml(2): 5,6
objects/obj_hammerbro/Other_13.gml(2): 7,15
objects/obj_hawmask/Other_7.gml(2): 8,13
objects/obj_helmet/Collision_obj_brohammer.gml(2): 7,10
objects/obj_hen_mushroom_res/Other_13.gml(2): 1,15
objects/obj_hen_mushroom_res/Other_14.gml(2): 9,11
objects/obj_holdparent/Collision_obj_blockparent.gml(2): 1,11
objects/obj_holdparent/Other_13.gml(2): 7,15
objects/obj_holdparent/Other_40.gml(2): 3,5
objects/obj_icecoin_res/Other_11.gml(2): 1,10
objects/obj_icicle2_res/Other_10.gml(2): 1,4
objects/obj_icicle_res/Other_10.gml(2): 1,4
objects/obj_invincibility/Alarm_0.gml(2): 2,6
objects/obj_jumppiranha/Destroy_0.gml(2): 3,5
objects/obj_jumppiranha/Other_14.gml(2): 31,87
objects/obj_key/Collision_obj_enemyparent_held.gml(2): 1,3
objects/obj_koopa/Destroy_0.gml(2): 5,10
objects/obj_koopa/Other_15.gml(2): 31,33
objects/obj_koopa_b/Destroy_0.gml(2): 5,10
objects/obj_koopa_b/Other_15.gml(2): 30,32
objects/obj_koopa_red/Destroy_0.gml(2): 5,10
objects/obj_koopa_red/Other_13.gml(2): 8,16
objects/obj_koopa_red/Other_15.gml(2): 31,33
objects/obj_koopa_red_b/Destroy_0.gml(2): 5,10
objects/obj_koopa_red_b/Other_15.gml(2): 30,32
objects/obj_kuribo_drybones/Other_10.gml(2): 1,18
objects/obj_lakitu/Destroy_0.gml(2): 3,5
objects/obj_lakitu/Other_11.gml(2): 3,5
objects/obj_lakitu_res/Other_14.gml(2): 9,11
objects/obj_lava_lift_res/Other_10.gml(2): 1,4
objects/obj_lava_lift_res/Other_11.gml(2): 1,10
objects/obj_lava_water/Step_0.gml(2): 98,101
objects/obj_levelmanager/Alarm_4.gml(2): 6,8
objects/obj_levelmanager/Other_10.gml(2): 1,3
objects/obj_link_arrow/Collision_obj_blockparent.gml(2): 1,3
objects/obj_link_arrow_anim/Destroy_0.gml(2): 5,7
objects/obj_link_atack/Collision_obj_blockparent.gml(2): 1,3
objects/obj_link_bomb/Other_13.gml(2): 7,15
objects/obj_link_dash_atack/Collision_obj_blockparent.gml(2): 1,3
objects/obj_link_dash_atack/Other_10.gml(2): 8,18
objects/obj_link_down_atack/Collision_obj_spike_ball.gml(2): 3,5
objects/obj_link_res/Other_14.gml(2): 9,11
objects/obj_magic/Collision_obj_mario.gml(2): 3,5
objects/obj_magikoopa/Other_7.gml(2): 20,24
objects/obj_mario/Alarm_5.gml(2): 6,14
objects/obj_mario/Alarm_7.gml(2): 10,15
objects/obj_mario/Alarm_8.gml(2): 10,15
objects/obj_mario/Create_0.gml(2): 25,33
objects/obj_mario_pballon/Other_11.gml(2): 9,12
objects/obj_mario_temp/Alarm_0.gml(2): 6,8
objects/obj_mariostart/Alarm_1.gml(2): 3,9
objects/obj_mariostart/Destroy_0.gml(2): 1,5
objects/obj_mechakoopa/Other_11.gml(2): 1,2
objects/obj_mechakoopa_held/Alarm_4.gml(2): 5,6
objects/obj_menu_editor_ext/Mouse_4.gml(2): 8,16
objects/obj_menu_pausa/Destroy_0.gml(2): 1,3
objects/obj_menu_pausa/Other_10.gml(2): 8,48
objects/obj_meteorites/Alarm_0.gml(2): 1,2
objects/obj_meteorites_big/Alarm_0.gml(2): 1,6
objects/obj_mini_icicle/Other_10.gml(2): 21,29
objects/obj_mini_icicle2_res/Other_10.gml(2): 1,4
objects/obj_mini_icicle_res/Other_10.gml(2): 1,4
objects/obj_modelbgo/Collision_obj_mario.gml(2): 1,3
objects/obj_monty_chase/Destroy_0.gml(2): 5,10
objects/obj_monty_chase/Other_11.gml(2): 7,12
objects/obj_muncher/Other_13.gml(2): 9,17
objects/obj_muncher/Other_14.gml(2): 41,79
objects/obj_mushroom_res/Other_14.gml(2): 9,11
objects/obj_musicblock_res/Other_10.gml(2): 1,4
objects/obj_night_change/Other_11.gml(2): 307,313
objects/obj_nota_musical_snd_res/Other_10.gml(2): 1,4
objects/obj_nota_musical_snd_res/Other_11.gml(2): 1,10
objects/obj_noteblock_res/Other_10.gml(2): 1,4
objects/obj_noteblock_s_res/Other_10.gml(2): 1,4
objects/obj_nube/Collision_obj_thwomp.gml(2): 1,4
objects/obj_onoffplatform_blue_res/Other_10.gml(2): 1,4
objects/obj_onoffplatform_blue_res/Other_11.gml(2): 1,10
objects/obj_onoffplatform_res/Other_10.gml(2): 1,4
objects/obj_onoffplatform_res/Other_11.gml(2): 1,10
objects/obj_panel_circle/Other_23.gml(2): 7,13
objects/obj_panel_save_load/Other_10.gml(2): 3,5
objects/obj_parent_resource/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_pausa_button/Alarm_1.gml(2): 1,2
objects/obj_pblock2_res/Other_10.gml(2): 1,4
objects/obj_pblock2_res/Other_11.gml(2): 1,10
objects/obj_pblock_res/Other_10.gml(2): 1,4
objects/obj_pblock_res/Other_11.gml(2): 1,10
objects/obj_physicsparent/Other_13.gml(2): 7,15
objects/obj_pink_coin/Other_10.gml(2): 26,33
objects/obj_pink_coin/Step_0.gml(2): 5,9
objects/obj_plant_fire/Destroy_0.gml(2): 3,5
objects/obj_plant_fire_res/Other_14.gml(2): 9,11
objects/obj_platform_blue_res/Other_14.gml(2): 9,11
objects/obj_platform_res/Other_10.gml(2): 1,4
objects/obj_play_screen/Other_12.gml(2): 2,4
objects/obj_player_goal_nsmbu/Other_13.gml(2): 7,29
objects/obj_player_goal_parent/Other_13.gml(2): 8,16
objects/obj_player_goal_smw/Step_2.gml(2): 19,25
objects/obj_player_goal_smw_castle/Alarm_6.gml(2): 22,29
objects/obj_pokey/Destroy_0.gml(2): 5,10
objects/obj_pokey/Other_13.gml(2): 16,23
objects/obj_pokey_res/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_powerupparent/Collision_obj_blockparent.gml(2): 1,13
objects/obj_powerupparent/Destroy_0.gml(2): 3,5
objects/obj_powerupparent/Other_13.gml(2): 8,16
objects/obj_powerupsprout/Alarm_1.gml(2): 10,12
objects/obj_pplant_res/Other_14.gml(2): 9,11
objects/obj_pswitch/Collision_obj_enemyparent_held.gml(2): 1,4
objects/obj_pswitch/Collision_obj_icicle.gml(2): 1,4
objects/obj_pswitch/Collision_obj_link_arrow.gml(2): 1,4
objects/obj_pswitch/Collision_obj_superball.gml(2): 1,4
objects/obj_pswitch/Other_13.gml(2): 11,19
objects/obj_pswitch/Other_16.gml(2): 6,14
objects/obj_pswitch/Other_17.gml(2): 3,8
objects/obj_pswitch_res/Other_14.gml(2): 10,12
objects/obj_puente_res/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_remolino_snd_res/Other_10.gml(2): 1,4
objects/obj_remolino_snd_res/Other_11.gml(2): 1,10
objects/obj_risas_snd_res/Other_10.gml(2): 1,4
objects/obj_risas_snd_res/Other_11.gml(2): 1,10
objects/obj_rock_res/Other_14.gml(2): 9,11
objects/obj_rocky/Other_12.gml(2): 1,3
objects/obj_rocky/Other_14.gml(2): 23,64
objects/obj_serpentina_snd_res/Other_10.gml(2): 1,4
objects/obj_serpentina_snd_res/Other_11.gml(2): 1,10
objects/obj_shell/Other_17.gml(2): 11,13
objects/obj_shell_drybones/Other_17.gml(2): 5,7
objects/obj_shell_drybones_held/Other_15.gml(2): 7,9
objects/obj_shell_empty/Other_17.gml(2): 9,11
objects/obj_shell_held/Destroy_0.gml(2): 3,8
objects/obj_shell_held/Other_13.gml(2): 8,16
objects/obj_shell_held/Other_15.gml(2): 16,18
objects/obj_skewertrunk/Other_11.gml(2): 22,36
objects/obj_skewertrunk/Other_12.gml(2): 25,40
objects/obj_skewertrunk/Other_13.gml(2): 28,42
objects/obj_skewertrunk/Other_14.gml(2): 25,40
objects/obj_sledgebro/Destroy_0.gml(2): 5,10
objects/obj_sledgebro/Other_11.gml(2): 5,6
objects/obj_sledgebro/Other_13.gml(2): 8,16
objects/obj_slider/Alarm_0.gml(2): 3,11
objects/obj_slider/Step_0.gml(2): 29,68
objects/obj_smoke_shoe/Collision_obj_enemyparent.gml(2): 1,5
objects/obj_snow_ball_held/Collision_obj_enemyparent.gml(2): 3,6
objects/obj_snow_ball_held/Other_10.gml(2): 6,21
objects/obj_snow_ball_held/Other_11.gml(2): 5,10
objects/obj_snow_ball_held/Other_14.gml(2): 26,63
objects/obj_snowball/Collision_obj_bowser_fire.gml(2): 1,6
objects/obj_snowball/Collision_obj_plantfire.gml(2): 1,6
objects/obj_snowball/Collision_obj_podoboo.gml(2): 1,7
objects/obj_soplete_global/Alarm_0.gml(2): 5,8
objects/obj_soplete_invert_global/Alarm_0.gml(2): 5,8
objects/obj_spike/Other_11.gml(2): 5,6
objects/obj_spike_ball/Collision_obj_enemyparent.gml(2): 1,4
objects/obj_spike_ball_res/Other_13.gml(2): 2,3
objects/obj_spinner/Collision_obj_blockparent.gml(2): 1,3
objects/obj_spinner/Collision_obj_enemyparent_held.gml(2): 1,3
objects/obj_spinner/Collision_obj_shell.gml(2): 1,3
objects/obj_spiny/Destroy_0.gml(2): 3,4
objects/obj_spiny/Other_15.gml(2): 29,31
objects/obj_spiny_empty/Other_17.gml(2): 9,11
objects/obj_spiny_thrown/Step_0.gml(2): 11,12
objects/obj_spring/Collision_obj_mario.gml(2): 3,6
objects/obj_spring_land_res/Other_14.gml(2): 9,11
objects/obj_spring_res/Other_14.gml(2): 9,11
objects/obj_star_res/Other_14.gml(2): 9,11
objects/obj_stomp/Create_0.gml(2): 1,6
objects/obj_superball/Collision_obj_bobomb.gml(2): 2,4
objects/obj_superflower_res/Other_13.gml(2): 1,15
objects/obj_superflower_res/Other_14.gml(2): 9,11
objects/obj_thwomp/Collision_obj_enemyparent.gml(2): 1,5
objects/obj_thwomp/Other_13.gml(2): 28,67
objects/obj_thwomp/Other_14.gml(2): 24,63
objects/obj_thwomp_b_res/Other_10.gml(2): 1,4
objects/obj_thwomp_b_res/Other_11.gml(2): 1,10
objects/obj_time/Other_10.gml(2): 2,4
objects/obj_time/Other_7.gml(2): 5,7
objects/obj_torbellino_res/Other_10.gml(2): 1,4
objects/obj_torbellino_res/Other_11.gml(2): 1,10
objects/obj_tuberia_res/Collision_obj_parent_resource.gml(2): 1,3
objects/obj_tuberia_res/Collision_obj_pplant_res.gml(2): 1,5
objects/obj_ubsi_snd_res/Other_10.gml(2): 1,4
objects/obj_ubsi_snd_res/Other_11.gml(2): 1,10
objects/obj_uhh_snd_res/Other_10.gml(2): 1,4
objects/obj_uhh_snd_res/Other_11.gml(2): 1,10
objects/obj_ventana/Step_2.gml(2): 68,73
objects/obj_ventana_mario/Destroy_0.gml(2): 3,6
objects/obj_waddlewing/Other_13.gml(2): 7,15
objects/obj_yoshi_abandon/Other_10.gml(2): 8,10
objects/obj_yoshi_runaway/Other_13.gml(2): 7,15
objects/obj_yoshifire/Collision_obj_enemyparent_held.gml(2): 1,3
scripts/scr_lose_condition/scr_lose_condition.gml(2): 7,9
objects/obj_NSMBU_bowser/Collision_obj_blockparent.gml(1): 1
objects/obj_NSMBU_bowser/Other_10.gml(1): 3
objects/obj_NSMBU_bowser_fire/Other_10.gml(1): 1
objects/obj_NSMBU_bowser_fire_up/Other_10.gml(1): 1
objects/obj_NSMBU_flag_mario/Create_0.gml(1): 1
objects/obj_SMB3_bowser/Collision_obj_blockparent.gml(1): 1
objects/obj_SMB3_bowser/Other_10.gml(1): 3
objects/obj_SMB_bowser/Collision_obj_blockparent.gml(1): 1
objects/obj_SMB_bowser/Other_10.gml(1): 3
objects/obj_SMB_castle/Step_0.gml(1): 5
objects/obj_SMB_castle_front/Collision_obj_player_goal_nsmbu.gml(1): 1
objects/obj_SMB_castle_front/Collision_obj_player_goal_smb1.gml(1): 1
objects/obj_SMB_flag/Alarm_0.gml(1): 4
objects/obj_SMW_bowser/Collision_obj_blockparent.gml(1): 1
objects/obj_SMW_bowser/Other_10.gml(1): 3
objects/obj_alert_close/Mouse_4.gml(1): 5
objects/obj_angrysun/Alarm_0.gml(1): 3
objects/obj_angrysun/Destroy_0.gml(1): 3
objects/obj_angrysun_res/Other_11.gml(1): 1
objects/obj_anti_pblock/Destroy_0.gml(1): 3
objects/obj_anti_pblock/Step_0.gml(1): 11
objects/obj_apariencia/Other_10.gml(1): 3
objects/obj_arrow_lock/Collision_obj_parent_resource.gml(1): 3
objects/obj_axe_smw/Alarm_1.gml(1): 2
objects/obj_axe_smw/Alarm_2.gml(1): 3
objects/obj_axe_smw/Alarm_3.gml(1): 5
objects/obj_axe_smw/Step_0.gml(1): 16
objects/obj_beachkoopa/Collision_obj_blockparent.gml(1): 1
objects/obj_bl2/Mouse_4.gml(1): 9
objects/obj_block_gold_res/Other_11.gml(1): 1
objects/obj_block_pow_hold/Collision_obj_blockparent.gml(1): 1
objects/obj_block_pow_hold/Destroy_0.gml(1): 4
objects/obj_block_res/Other_11.gml(1): 1
objects/obj_blockbumper/Collision_obj_blockparent.gml(1): 1
objects/obj_blooper/Collision_obj_mario.gml(1): 3
objects/obj_boomerang/Collision_obj_mario.gml(1): 1
objects/obj_bossparent/Collision_obj_fireball.gml(1): 21
objects/obj_bossparent/Collision_obj_hammer.gml(1): 21
objects/obj_bossparent/Collision_obj_link_arrow.gml(1): 24
objects/obj_bossparent/Collision_obj_link_dash_atack.gml(1): 21
objects/obj_bossparent/Collision_obj_link_down_atack.gml(1): 21
objects/obj_bossparent/Collision_obj_snow_ball_held.gml(1): 21
objects/obj_bossparent/Collision_obj_spike_ball.gml(1): 21
objects/obj_bossparent/Collision_obj_superball.gml(1): 21
objects/obj_bossparent/Collision_obj_yoshifire.gml(1): 21
objects/obj_bowser_dead/Destroy_0.gml(1): 5
objects/obj_bowser_fire/Collision_obj_mario.gml(1): 1
objects/obj_bowser_fire/Other_10.gml(1): 1
objects/obj_bowser_fire_down/Collision_obj_blockparent.gml(1): 1
objects/obj_bowser_fire_down/Collision_obj_mario.gml(1): 3
objects/obj_bowser_fire_down/Other_10.gml(1): 1
objects/obj_bowserjr_shell/Alarm_11.gml(1): 3
objects/obj_bowserjr_shell/Collision_obj_blockparent.gml(1): 1
objects/obj_bowserjr_shell/Collision_obj_enemyparent_held.gml(1): 4
objects/obj_brohammer/Collision_obj_mario.gml(1): 1
objects/obj_bt_gb_close/Mouse_4.gml(1): 8
objects/obj_bullebill_base/Collision_obj_blockparent.gml(1): 1
objects/obj_bullebill_base/Destroy_0.gml(1): 3
objects/obj_bullebill_base_red/Destroy_0.gml(1): 3
objects/obj_button_autoavance/Mouse_4.gml(1): 6
objects/obj_button_notification_aceptar/Mouse_4.gml(1): 12
objects/obj_button_save_changes/Mouse_4.gml(1): 6
objects/obj_button_speed_water/Mouse_4.gml(1): 3
objects/obj_cap/Step_0.gml(1): 24
objects/obj_cap_mario/Collision_obj_bowser_fire.gml(1): 5
objects/obj_cap_mario/Collision_obj_bowser_fire_down.gml(1): 5
objects/obj_cap_mario/Collision_obj_wrench.gml(1): 5
objects/obj_cap_mario/Step_2.gml(1): 1
objects/obj_card_block_sounds/Mouse_4.gml(1): 4
objects/obj_card_block_sounds/Other_11.gml(1): 3
objects/obj_card_block_sounds/Other_12.gml(1): 19
objects/obj_card_bout/Mouse_4.gml(1): 7
objects/obj_card_rocket/Step_0.gml(1): 18
objects/obj_castle/Destroy_0.gml(1): 3
objects/obj_castle_front/Collision_obj_player_goal_nsmbu.gml(1): 1
objects/obj_castle_front/Collision_obj_player_goal_smb1.gml(1): 1
objects/obj_checkpoint/Other_11.gml(1): 1
objects/obj_cheepcheep/Step_0.gml(1): 90
objects/obj_cheepcheep2/Step_0.gml(1): 104
objects/obj_cloud_lakitu/Destroy_0.gml(1): 3
objects/obj_clown/Collision_obj_clown.gml(1): 7
objects/obj_clown_explotion/Collision_obj_block_ice.gml(1): 1
objects/obj_clown_explotion/Collision_obj_block_rock.gml(1): 1
objects/obj_coin/Collision_obj_blockparent.gml(1): 1
objects/obj_coin/Collision_obj_clown.gml(1): 1
objects/obj_coin/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_coin/Other_11.gml(1): 4
objects/obj_coin10/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_coin10/Other_10.gml(1): 8
objects/obj_continue_btn/Alarm_0.gml(1): 1
objects/obj_creator_jugar_editar/Alarm_0.gml(1): 12
objects/obj_creator_jugar_editar/Alarm_1.gml(1): 1
objects/obj_creator_jugar_editar/Alarm_2.gml(1): 1
objects/obj_creator_jugar_editar/Alarm_4.gml(1): 8
objects/obj_creator_jugar_editar/Alarm_5.gml(1): 2
objects/obj_creator_jugar_editar/Other_10.gml(1): 2
objects/obj_creator_jugar_editar/Other_12.gml(1): 14
objects/obj_crystalorb/Create_0.gml(1): 12
objects/obj_cursor/Mouse_57.gml(1): 5
objects/obj_curtainin/Other_10.gml(1): 12
objects/obj_deadmario/Alarm_1.gml(1): 3
objects/obj_dog/Mouse_4.gml(1): 5
objects/obj_door/Alarm_1.gml(1): 3
objects/obj_door_exit/Alarm_1.gml(1): 3
objects/obj_door_exit_res/Destroy_0.gml(1): 3
objects/obj_door_lock/Alarm_1.gml(1): 3
objects/obj_door_lock_exit/Alarm_1.gml(1): 3
objects/obj_door_lock_exit_res/Destroy_0.gml(1): 3
objects/obj_door_lock_res/Destroy_0.gml(1): 3
objects/obj_door_res/Destroy_0.gml(1): 3
objects/obj_door_switch/Alarm_1.gml(1): 3
objects/obj_door_switch_exit/Alarm_1.gml(1): 3
objects/obj_door_switch_exit_res/Destroy_0.gml(1): 3
objects/obj_door_switch_res/Destroy_0.gml(1): 3
objects/obj_editormanager/Alarm_2.gml(1): 18
objects/obj_editormanager/Create_0.gml(1): 5
objects/obj_egg_blue/Alarm_2.gml(1): 10
objects/obj_egg_red/Alarm_2.gml(1): 10
objects/obj_enabledsolid/Step_0.gml(1): 5
objects/obj_enemy_dead/Destroy_0.gml(1): 5
objects/obj_enemyparent/Create_0.gml(1): 1
objects/obj_enemyparent_held/Collision_obj_explosion.gml(1): 4
objects/obj_enemyparent_held/Collision_obj_invincibility.gml(1): 4
objects/obj_enemyparent_held/Collision_obj_shell_held.gml(1): 5
objects/obj_enemyparent_held/Step_0.gml(1): 20
objects/obj_enemyparent_held/Step_2.gml(1): 81
objects/obj_espina/Collision_obj_mario.gml(1): 1
objects/obj_explosion/Collision_obj_block_ice.gml(1): 3
objects/obj_explosion/Collision_obj_block_rock.gml(1): 3
objects/obj_fire_clown/Alarm_0.gml(1): 1
objects/obj_fire_clown/Collision_obj_boomboom.gml(1): 1
objects/obj_fire_clown/Collision_obj_onoffblock.gml(1): 1
objects/obj_fireball/Alarm_0.gml(1): 1
objects/obj_fireball/Step_0.gml(1): 7
objects/obj_fireball_bro/Collision_obj_mario.gml(1): 1
objects/obj_fireball_bro/Step_0.gml(1): 19
objects/obj_firebar/Destroy_0.gml(1): 3
objects/obj_firebar/Draw_0.gml(1): 10
objects/obj_firebar_res/Step_2.gml(1): 14
objects/obj_flagpole/Alarm_0.gml(1): 3
objects/obj_flagpole/Create_0.gml(1): 65
objects/obj_floruga/Alarm_10.gml(1): 44
objects/obj_floruga/Create_0.gml(1): 67
objects/obj_floruga/Destroy_0.gml(1): 3
objects/obj_floruga_body/Other_10.gml(1): 3
objects/obj_floruga_body/Other_11.gml(1): 3
objects/obj_galoomba_hold/Destroy_0.gml(1): 4
objects/obj_game_over/Create_0.gml(1): 4
objects/obj_getshoe/Collision_obj_mario.gml(1): 1
objects/obj_getshoe/Other_11.gml(1): 11
objects/obj_goalcard/Alarm_2.gml(1): 3
objects/obj_goalgate/Alarm_1.gml(1): 3
objects/obj_goalgate/Step_0.gml(1): 12
objects/obj_gold_explosion/Collision_obj_rockparent.gml(1): 1
objects/obj_goomba_intro/Alarm_2.gml(1): 1
objects/obj_grinder_res/Alarm_0.gml(1): 31
objects/obj_ground/Other_12.gml(1): 24
objects/obj_ground/Other_18.gml(1): 24
objects/obj_ground2/Mouse_4.gml(1): 16
objects/obj_ground3/Mouse_4.gml(1): 16
objects/obj_groundparent/Collision_obj_parent_resource.gml(1): 3
objects/obj_grrrol/Collision_obj_enemyparent_held.gml(1): 2
objects/obj_grrrol/Collision_obj_spike_ball.gml(1): 2
objects/obj_grrrol_b/Collision_obj_enemyparent_held.gml(1): 2
objects/obj_grrrol_b/Collision_obj_spike_ball.gml(1): 2
objects/obj_grrrol_b_res/Other_13.gml(1): 5
objects/obj_grrrol_new/Collision_obj_enemyparent_held.gml(1): 2
objects/obj_grrrol_new/Collision_obj_spike_ball.gml(1): 2
objects/obj_grrrol_new_res/Other_13.gml(1): 5
objects/obj_guardabot/Other_4.gml(1): 1
objects/obj_hammer/Collision_obj_brohammer.gml(1): 3
objects/obj_hammer_b/Collision_obj_rockparent.gml(1): 1
objects/obj_hammerbro/Destroy_0.gml(1): 3
objects/obj_hammerbro/Other_14.gml(1): 21
objects/obj_hawmask/Alarm_2.gml(1): 3
objects/obj_hawmask/Create_0.gml(1): 8
objects/obj_hawmask/Destroy_0.gml(1): 3
objects/obj_header/Destroy_0.gml(1): 1
objects/obj_helmet/Collision_obj_plantfire.gml(1): 1
objects/obj_helmet/Step_0.gml(1): 7
objects/obj_holdparent/Step_0.gml(1): 19
objects/obj_icecoin/Collision_obj_cheepcheep.gml(1): 1
objects/obj_icecoin/Collision_obj_plantfire.gml(1): 2
objects/obj_icecoin/Collision_obj_soplete.gml(1): 1
objects/obj_icicle/Alarm_1.gml(1): 1
objects/obj_iname/Step_0.gml(1): 19
objects/obj_iname_close/Mouse_4.gml(1): 3
objects/obj_input/Step_0.gml(1): 17
objects/obj_input_desc/Step_0.gml(1): 18
objects/obj_intro_controller/Step_2.gml(1): 18
objects/obj_invincibility/Alarm_1.gml(1): 3
objects/obj_invincibility/Alarm_2.gml(1): 5
objects/obj_invincibility/Collision_obj_bossparent.gml(1): 2
objects/obj_invincibility/Collision_obj_enemyparent_held.gml(1): 3
objects/obj_invincibility/Create_0.gml(1): 19
objects/obj_key/Collision_obj_link_arrow.gml(1): 3
objects/obj_key/Collision_obj_shell_held.gml(1): 1
objects/obj_key/Collision_obj_snow_ball_held.gml(1): 3
objects/obj_key_appear/Alarm_1.gml(1): 1
objects/obj_kuriboshoe/Destroy_0.gml(1): 4
objects/obj_lava_lift_part/Step_0.gml(1): 5
objects/obj_lava_water/Destroy_0.gml(1): 1
objects/obj_levelmanager/KeyPress_13.gml(1): 13
objects/obj_link_arrow/Collision_obj_block_pow_hold.gml(1): 1
objects/obj_link_arrow/Collision_obj_link_bomb.gml(1): 1
objects/obj_link_arrow/Collision_obj_solidtop.gml(1): 1
objects/obj_link_arrow/Other_11.gml(1): 3
objects/obj_link_atack/Collision_obj_block_pow_hold.gml(1): 1
objects/obj_link_bomb/Other_12.gml(1): 2
objects/obj_link_dash_atack/Collision_obj_block_pow_hold.gml(1): 1
objects/obj_link_down_atack/Collision_obj_block_pow_hold.gml(1): 1
objects/obj_link_down_atack/Create_0.gml(1): 8
objects/obj_load_btn_c/Mouse_4.gml(1): 4
objects/obj_load_guardabot/Other_15.gml(1): 6
objects/obj_lp/Step_0.gml(1): 19
objects/obj_lun/Step_0.gml(1): 18
objects/obj_magic/Alarm_0.gml(1): 1
objects/obj_mario/Destroy_0.gml(1): 4
objects/obj_mario/Other_11.gml(1): 23
objects/obj_mario_editor/Alarm_0.gml(1): 17
objects/obj_mario_editor/Mouse_7.gml(1): 7
objects/obj_mario_editor/Other_11.gml(1): 4
objects/obj_mario_editor/Other_12.gml(1): 39
objects/obj_mario_intro/Step_2.gml(1): 9
objects/obj_mario_pballon/Destroy_0.gml(1): 7
objects/obj_mario_pballon/Step_0.gml(1): 4
objects/obj_mario_temp/Other_10.gml(1): 3
objects/obj_mario_transform2/Alarm_1.gml(1): 5
objects/obj_mario_transform2/Alarm_2.gml(1): 5
objects/obj_mario_transform2/Alarm_3.gml(1): 5
objects/obj_mario_transform2/Alarm_4.gml(1): 5
objects/obj_mariostart_m/Alarm_0.gml(1): 1
objects/obj_mariostart_m/KeyPress_32.gml(1): 1
objects/obj_mini_icicle/Alarm_1.gml(1): 1
objects/obj_modelsizable/Destroy_0.gml(1): 3
objects/obj_modelsolid/Destroy_0.gml(1): 5
objects/obj_multiveggiecoin/Collision_obj_mario.gml(1): 5
objects/obj_muncher/Collision_obj_shield_left.gml(1): 12
objects/obj_muncher/Collision_obj_shield_right.gml(1): 12
objects/obj_muncher_b_res/Other_13.gml(1): 2
objects/obj_muncher_res/Alarm_0.gml(1): 26
objects/obj_mushroom_platform_res/Alarm_0.gml(1): 31
objects/obj_musicblock/Step_0.gml(1): 31
objects/obj_noteblock/Step_0.gml(1): 33
objects/obj_noteblock_s/Step_0.gml(1): 31
objects/obj_onewaygate_top/Destroy_0.gml(1): 1
objects/obj_onoffblock/Other_10.gml(1): 59
objects/obj_onoffblock/Step_0.gml(1): 50
objects/obj_onoffplatform/Destroy_0.gml(1): 3
objects/obj_onoffplatform/Step_0.gml(1): 11
objects/obj_onoffplatform_blue/Destroy_0.gml(1): 3
objects/obj_onoffplatform_blue/Step_0.gml(1): 11
objects/obj_panel_circle/Destroy_0.gml(1): 3
objects/obj_panel_save_load/Other_7.gml(1): 7
objects/obj_parent_resource/Alarm_0.gml(1): 36
objects/obj_parent_resource/Mouse_7.gml(1): 7
objects/obj_parent_resource/Other_14.gml(1): 9
objects/obj_parent_sounds/Alarm_0.gml(1): 31
objects/obj_pausa_button/Alarm_2.gml(1): 1
objects/obj_pblock/Destroy_0.gml(1): 3
objects/obj_pblock/Step_0.gml(1): 11
objects/obj_penguin_attack/Collision_obj_blockparent.gml(1): 1
objects/obj_persistent/Alarm_8.gml(1): 3
objects/obj_physicsparent/Collision_obj_blockparent.gml(1): 1
objects/obj_pinchos/Destroy_0.gml(1): 3
objects/obj_pink_coin/Alarm_0.gml(1): 1
objects/obj_pink_coin/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_pink_coin/Collision_obj_snow_ball.gml(1): 1
objects/obj_plantfire/Alarm_0.gml(1): 1
objects/obj_plantfire/Collision_obj_mario.gml(1): 1
objects/obj_plantfire/Collision_obj_solidtop.gml(1): 1
objects/obj_plantfire/Other_10.gml(1): 2
objects/obj_play_screen/Other_10.gml(1): 3
objects/obj_play_screen/Other_11.gml(1): 3
objects/obj_player_goal_nsmbu/Alarm_5.gml(1): 24
objects/obj_player_goal_nsmbu/Collision_obj_flagpole.gml(1): 1
objects/obj_player_goal_smb1/Alarm_2.gml(1): 5
objects/obj_player_goal_smb1/Alarm_5.gml(1): 5
objects/obj_player_goal_smb1/Create_0.gml(1): 7
objects/obj_player_goal_smb2/Step_0.gml(1): 37
objects/obj_player_goal_smw_castle/Alarm_2.gml(1): 3
objects/obj_player_goal_smw_castle/Step_0.gml(1): 26
objects/obj_pokey/Other_10.gml(1): 11
objects/obj_pokey/Other_17.gml(1): 5
objects/obj_pswitch/Collision_obj_bullebill_base.gml(1): 1
objects/obj_pswitch/Collision_obj_clown.gml(1): 1
objects/obj_pswitch/Collision_obj_enemyparent.gml(1): 2
objects/obj_pswitch/Collision_obj_physicssolid.gml(1): 1
objects/obj_pswitch/Destroy_0.gml(1): 4
objects/obj_pswitch_press/Alarm_0.gml(1): 1
objects/obj_pswitch_press/Destroy_0.gml(1): 3
objects/obj_puller/Alarm_0.gml(1): 1
objects/obj_puller/Create_0.gml(1): 10
objects/obj_puller/Destroy_0.gml(1): 1
objects/obj_puller/Step_0.gml(1): 3
objects/obj_rename/Step_0.gml(1): 19
objects/obj_rename_button3/Mouse_4.gml(1): 1
objects/obj_rename_close/Mouse_4.gml(1): 3
objects/obj_rockparent/Step_0.gml(1): 7
objects/obj_rocky/Other_17.gml(1): 17
objects/obj_selecting_player/Mouse_4.gml(1): 3
objects/obj_semisolid_platform1/Alarm_0.gml(1): 33
objects/obj_settings_button/Mouse_4.gml(1): 10
objects/obj_shell_drybones/Collision_obj_fireball.gml(1): 1
objects/obj_shell_drybones/Other_11.gml(1): 8
objects/obj_shell_empty/Collision_obj_fireball.gml(1): 1
objects/obj_shell_held/Alarm_11.gml(1): 3
objects/obj_shield_left/Collision_obj_banzaibill.gml(1): 2
objects/obj_shield_left/Collision_obj_bulletbill.gml(1): 2
objects/obj_shield_left/Collision_obj_bulletbull_red.gml(1): 2
objects/obj_shield_left/Collision_obj_cannonball.gml(1): 2
objects/obj_shield_left/Collision_obj_lakitu.gml(1): 2
objects/obj_shield_left/Collision_obj_wrench.gml(1): 2
objects/obj_shield_right/Collision_obj_banzaibill.gml(1): 2
objects/obj_shield_right/Collision_obj_bulletbill.gml(1): 2
objects/obj_shield_right/Collision_obj_bulletbull_red.gml(1): 2
objects/obj_shield_right/Collision_obj_cannonball.gml(1): 2
objects/obj_shield_right/Collision_obj_lakitu.gml(1): 2
objects/obj_shield_right/Collision_obj_wrench.gml(1): 2
objects/obj_slider/Create_0.gml(1): 2
objects/obj_slider/Destroy_0.gml(1): 1
objects/obj_smoke_shoe/Collision_obj_muncher.gml(1): 1
objects/obj_smoke_shoe/Collision_obj_shell.gml(1): 1
objects/obj_snow_ball/Other_10.gml(1): 1
objects/obj_snow_ball_b/Other_10.gml(1): 1
objects/obj_snow_ball_held/Collision_obj_snow_ball.gml(1): 3
objects/obj_snowball/Alarm_0.gml(1): 3
objects/obj_snowball/Collision_obj_magic.gml(1): 2
objects/obj_snowball/Other_10.gml(1): 3
objects/obj_snowball_bro/Collision_obj_fireball.gml(1): 1
objects/obj_snowball_bro/Collision_obj_snow_ball.gml(1): 1
objects/obj_snowball_bro/Other_10.gml(1): 5
objects/obj_soplete/Collision_obj_mario.gml(1): 3
objects/obj_soplete/Destroy_0.gml(1): 3
objects/obj_soplete_global/Alarm_2.gml(1): 8
objects/obj_spike_ball/Collision_obj_enemyparent_held.gml(1): 4
objects/obj_spike_ball/Collision_obj_physicsparent.gml(1): 1
objects/obj_spike_ball/Step_0.gml(1): 6
objects/obj_spinner/Collision_obj_bowser_fire.gml(1): 1
objects/obj_spinner/Collision_obj_bowser_fire_down.gml(1): 1
objects/obj_spinner/Collision_obj_wrench.gml(1): 1
objects/obj_spinner/Destroy_0.gml(1): 3
objects/obj_spring/Step_0.gml(1): 22
objects/obj_spring_land/Destroy_0.gml(1): 1
objects/obj_superball/Collision_obj_block_pow_hold.gml(1): 1
objects/obj_tabs_condiciones/Mouse_4.gml(1): 6
objects/obj_timeup/Create_0.gml(1): 3
objects/obj_title_controller/Create_0.gml(1): 15
objects/obj_title_controller/Step_2.gml(1): 15
objects/obj_tongue/Step_2.gml(1): 78
objects/obj_tongue_blue/Step_2.gml(1): 78
objects/obj_torbellino/Destroy_0.gml(1): 5
objects/obj_tuberia_res/Destroy_0.gml(1): 4
objects/obj_veggiecoin/Step_0.gml(1): 3
objects/obj_ventana/Create_0.gml(1): 3
objects/obj_ventana_mario/Create_0.gml(1): 6
objects/obj_ventana_mario/Step_1.gml(1): 18
objects/obj_ventana_water/Destroy_0.gml(1): 3
objects/obj_ventana_water/Step_2.gml(1): 18
objects/obj_water_move/Alarm_0.gml(1): 9
objects/obj_water_move/Mouse_4.gml(1): 11
objects/obj_water_move/Mouse_7.gml(1): 4
objects/obj_water_move_limit/Mouse_4.gml(1): 12
objects/obj_wrench/Collision_obj_mario.gml(1): 3
objects/obj_yoshi2/Destroy_0.gml(1): 3
objects/obj_yoshi2/Step_2.gml(1): 53
objects/obj_yoshi_runaway/Create_0.gml(1): 8
objects/obj_yoshifire/Collision_obj_shell.gml(1): 1
objects/obj_yoshifire/Other_10.gml(1): 1
scripts/discord_webhook/discord_webhook.gml(1): 18
scripts/outside_view_modelsizable/outside_view_modelsizable.gml(1): 8
scripts/scr_toast/scr_toast.gml(1): 2
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_1up/Collision_obj_blockparent.gml:1 | `if (other.vspeed < 0 && other.y < (other.ystart - 2) && bbox_bottom < (other.yprevious + 5) && wings == 0)` |
| objects/obj_block/Alarm_1.gml:35 | `s_sprout = other.sprout` |
| objects/obj_bullebill_base_red/Other_12.gml:25 | `with (instance_create(x_pos, y_pos, obj_coin_pow))` |
| objects/obj_cheepcheep2/Step_0.gml:104 | `with (instance_create((x - 13), (y - 6), obj_spinthump))` |
| objects/obj_door_lock/Alarm_0.gml:40 | `with (obj_doormario)` |
| objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml:3 | `if (other.held == 1)` |
| objects/obj_ground/Other_12.gml:24 | `with (itp)` |
| objects/obj_koopa_red_b/Other_11.gml:17 | `with (instance_create(x, y, obj_shell))` |
| objects/obj_mario_editor/Mouse_4.gml:14 | `xx = other.xx` |
| objects/obj_pausa_button/Alarm_1.gml:2 | `event_user(other.type)` |
| objects/obj_settings_custom/Other_10.gml:19 | `with (instance_create((camera_get_view_x(view_get_camera(0)) + 200), (camera_get_view_y(view_get_camera(0)) + 85), obj_settings_controls))` |
| objects/obj_spiny/Alarm_2.gml:13 | `with (instance_create((x - 14), (y + 23), obj_espina))` |
| objects/obj_tuberia_res/Alarm_1.gml:51 | `m_posy = (y + (16 + (other.t_size * 16)))` |
| scripts/scr_edit_to_play/scr_edit_to_play.gml:574 | `with (obj_mechakoopa_res)` |

### 3.2 alarm

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| alarm[n]: `\balarm\s*\[` | 2303 | 1086 |
| alarm_get/set: `\balarm_(get\|set)\b` | 0 | 0 |
| **并集（本类合计）** | **2303** | **1086** |

Alarm 事件（eventType=2）：782 个事件，分布于 336 个 object（路径 `objects/<object>/<事件文件>.gml`，来源 `objects/<object>/<object>.yy` 的 `eventList`）：

<details><summary>展开 object → 事件列表</summary>

```
obj_1up: Alarm_11, Alarm_10
obj_NSMBU_boomboom: Alarm_11, Alarm_10, Alarm_9, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2
obj_NSMBU_boomboom_b: Alarm_10, Alarm_7, Alarm_5, Alarm_4, Alarm_3, Alarm_2
obj_NSMBU_bowser: Alarm_11, Alarm_10, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_NSMBU_bowserjr: Alarm_9, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_NSMBU_charginchuck: Alarm_10, Alarm_1, Alarm_0
obj_NSMBU_flag_mario: Alarm_1, Alarm_0
obj_NSMBU_ninji: Alarm_1, Alarm_0
obj_SMB2_mushroom: Alarm_10, Alarm_0
obj_SMB3_bowser: Alarm_11, Alarm_10, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_SMB_bowser: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_SMB_castle: Alarm_0
obj_SMB_flag: Alarm_1, Alarm_0
obj_SMW_bowser: Alarm_11, Alarm_10, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_alert_button: Alarm_2
obj_alert_close: Alarm_2
obj_alert_condicion: Alarm_0
obj_angrysun: Alarm_0
obj_angrysun_movement: Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_arrow_big: Alarm_0
obj_arrow_res: Alarm_1
obj_autoscroll: Alarm_0
obj_axe_smw: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_banzaibill: Alarm_10, Alarm_0
obj_beachkoopa: Alarm_11, Alarm_10
obj_beachkoopa_b: Alarm_10
obj_beachkoopa_red: Alarm_10
obj_beachkoopa_red_b: Alarm_10
obj_beanstalk: Alarm_2, Alarm_1, Alarm_0
obj_bganimator: Alarm_0
obj_big_pplant: Alarm_11, Alarm_2
obj_billbanzai_red: Alarm_3, Alarm_2
obj_billbanzai_red_res: Alarm_1
obj_billbanzai_res: Alarm_1
obj_block: Alarm_1
obj_block_coinchain: Alarm_1
obj_block_gold: Alarm_1
obj_block_multicoin: Alarm_4, Alarm_1
obj_block_pow_active: Alarm_0
obj_block_pow_hold: Alarm_1
obj_blockbumper: Alarm_0
obj_blockcoin: Alarm_0
obj_blockparent: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_blooper: Alarm_1, Alarm_0
obj_bobomb: Alarm_10
obj_bobomb_hold: Alarm_4, Alarm_2, Alarm_1
obj_bobomb_ready: Alarm_10, Alarm_1, Alarm_0
obj_bones_yoshi: Alarm_2, Alarm_1
obj_bonybeetle: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_bonybeetle_b: Alarm_0
obj_boo: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_boomboom: Alarm_11, Alarm_10, Alarm_9, Alarm_4, Alarm_3, Alarm_2, Alarm_0
obj_boomboom_b: Alarm_11, Alarm_10, Alarm_9, Alarm_4, Alarm_3
obj_boomerang: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_boomerangbro: Alarm_7, Alarm_3, Alarm_2
obj_bowser_dead: Alarm_0
obj_bowser_dead_castle: Alarm_2, Alarm_1, Alarm_0
obj_bowser_fire_down: Alarm_0
obj_bowserfire_up: Alarm_0
obj_bowserjr: Alarm_11, Alarm_10, Alarm_9, Alarm_7, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_bowserjr_dead_castle: Alarm_1, Alarm_0
obj_bowserjr_shell: Alarm_11, Alarm_10, Alarm_1, Alarm_0
obj_brickhelmet: Alarm_4
obj_bt_gb_close: Alarm_0
obj_bt_gb_delete: Alarm_1, Alarm_0
obj_bt_gb_edit: Alarm_1
obj_bt_gb_play: Alarm_1, Alarm_0
obj_btn_header_1: Alarm_0
obj_btn_header_2: Alarm_0
obj_btn_header_3: Alarm_0
obj_btn_header_4: Alarm_0
obj_btn_reload: Alarm_0
obj_bullebill_base: Alarm_1, Alarm_0
obj_bullebill_base_red: Alarm_1, Alarm_0
obj_bullebill_base_red_res: Alarm_5, Alarm_3
obj_bullebill_base_res: Alarm_5, Alarm_3
obj_bulletbill: Alarm_1, Alarm_0
obj_bulletbull_red: Alarm_3, Alarm_2, Alarm_0
obj_bumper: Alarm_0
obj_button_home: Alarm_1, Alarm_0
obj_button_notification_aceptar: Alarm_0
obj_button_ok: Alarm_0
obj_button_save_changes: Alarm_0
obj_button_settings_close: Alarm_2
obj_button_settings_close2: Alarm_2
obj_button_superado: Alarm_1, Alarm_0
obj_button_time: Alarm_0
obj_buzzy_ceiling: Alarm_10
obj_buzzybeetle: Alarm_10, Alarm_0
obj_buzzybeetle_b: Alarm_10
obj_call_mario: Alarm_1, Alarm_0
obj_cannon: Alarm_1, Alarm_0
obj_cannon_red: Alarm_0
obj_cannon_res: Alarm_1
obj_cannonball: Alarm_0
obj_cap: Alarm_10, Alarm_0
obj_card_rocket: Alarm_0
obj_castle: Alarm_0
obj_castle_floor: Alarm_0
obj_chain_chomp_free: Alarm_10
obj_charginchuck: Alarm_10, Alarm_1, Alarm_0
obj_checkpoint_res: Alarm_1
obj_cheepcheep: Alarm_10, Alarm_1, Alarm_0
obj_cheepcheep2: Alarm_10, Alarm_2
obj_cinta_on_res: Alarm_5, Alarm_3
obj_cinta_res: Alarm_5, Alarm_3
obj_claw: Alarm_1, Alarm_0
obj_cloud_lakitu: Alarm_2, Alarm_1, Alarm_0
obj_clown: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_clown_fire: Alarm_4
obj_coin: Alarm_10
obj_coin_pow: Alarm_1, Alarm_0
obj_coinchain: Alarm_2, Alarm_1, Alarm_0
obj_continue_btn: Alarm_2, Alarm_0
obj_cooligan: Alarm_1, Alarm_0
obj_creator_jugar_editar: Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_crumblebones: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_crumblebony: Alarm_3, Alarm_1
obj_crumblebony_b: Alarm_3, Alarm_1
obj_cursor: Alarm_0
obj_curtainin: Alarm_0
obj_deadmario: Alarm_1, Alarm_0
obj_donut: Alarm_10, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_door: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_door_exit: Alarm_3, Alarm_1, Alarm_0
obj_door_lock: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_door_lock_exit: Alarm_4, Alarm_3, Alarm_1, Alarm_0
obj_door_lock_res: Alarm_1
obj_door_res: Alarm_1
obj_door_switch: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_door_switch_exit: Alarm_3, Alarm_1, Alarm_0
obj_door_switch_res: Alarm_1
obj_doormario_exit: Alarm_0
obj_drybones: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_editormanager: Alarm_2, Alarm_1, Alarm_0
obj_efecto_musica_bonus: Alarm_0
obj_efecto_sonido: Alarm_0
obj_egg: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_egg_blue: Alarm_2
obj_egg_hatch: Alarm_0
obj_egg_red: Alarm_2
obj_enemy_dead: Alarm_0
obj_enemy_dead_castle: Alarm_1, Alarm_0
obj_enemy_multidead: Alarm_0
obj_enemyfrozen: Alarm_7, Alarm_6, Alarm_5, Alarm_4
obj_enemyparent: Alarm_10
obj_enemyparent_lava: Alarm_0
obj_erase: Alarm_1, Alarm_0
obj_espina: Alarm_1, Alarm_0
obj_expand: Alarm_0
obj_fire_clown: Alarm_0
obj_fireball: Alarm_0
obj_firebro: Alarm_7, Alarm_3, Alarm_2
obj_fishbone: Alarm_10, Alarm_1, Alarm_0
obj_flagpole: Alarm_2, Alarm_1, Alarm_0
obj_flipblock: Alarm_1, Alarm_0
obj_floruga: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_frogsuit: Alarm_10
obj_frozenmario: Alarm_1, Alarm_0
obj_galoomba: Alarm_10, Alarm_1, Alarm_0
obj_galoomba_b: Alarm_10
obj_galoomba_hold: Alarm_2, Alarm_1
obj_galoomba_hold2: Alarm_1
obj_galoomba_hold2_b: Alarm_1
obj_galoomba_hold_b: Alarm_1
obj_game_over: Alarm_0
obj_gb_button: Alarm_0
obj_getshoe: Alarm_2, Alarm_1, Alarm_0
obj_goalcard: Alarm_3, Alarm_2, Alarm_0
obj_goalgate: Alarm_1, Alarm_0
obj_goalgate_front: Alarm_1, Alarm_0
obj_goomba_intro: Alarm_2, Alarm_1, Alarm_0
obj_grinder: Alarm_10, Alarm_0
obj_grinder_res: Alarm_0
obj_ground: Alarm_6, Alarm_5, Alarm_3, Alarm_0
obj_ground2: Alarm_1, Alarm_0
obj_ground3: Alarm_1, Alarm_0
obj_groundparent: Alarm_2
obj_groundpount: Alarm_0
obj_grrrol: Alarm_10
obj_grrrol_b: Alarm_10
obj_grrrol_new: Alarm_10
obj_guardabot: Alarm_0
obj_hammerbro: Alarm_10, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1
obj_hammersuit: Alarm_10
obj_hawmask: Alarm_2, Alarm_1, Alarm_0
obj_header: Alarm_0
obj_hen_mushroom: Alarm_10
obj_holdparent: Alarm_3, Alarm_2, Alarm_0
obj_icebro: Alarm_7, Alarm_3, Alarm_2
obj_icicle: Alarm_2, Alarm_1, Alarm_0
obj_intro_controller: Alarm_1, Alarm_0
obj_invincibility: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_jumppiranha: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_key_appear: Alarm_1, Alarm_0
obj_koopa: Alarm_10
obj_koopa_b: Alarm_10
obj_koopa_red: Alarm_10
obj_koopa_red_b: Alarm_10
obj_kuribo_drybones: Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_8
obj_kuriboshoe: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_lakitu: Alarm_2, Alarm_1, Alarm_0
obj_lava_lift: Alarm_3, Alarm_2, Alarm_0
obj_lava_water: Alarm_0
obj_levelmanager: Alarm_11, Alarm_10, Alarm_9, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_link: Alarm_10, Alarm_0
obj_link_arrow: Alarm_10, Alarm_0
obj_link_bomb: Alarm_10, Alarm_6, Alarm_5, Alarm_4
obj_link_down_atack: Alarm_0
obj_load_btn_c: Alarm_2
obj_load_image: Alarm_1
obj_lun: Alarm_1, Alarm_0
obj_magic: Alarm_0
obj_magikoopa: Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_mario: Alarm_11, Alarm_10, Alarm_9, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_marioU: Alarm_11, Alarm_4
obj_mario_editor: Alarm_0
obj_mario_intro: Alarm_0
obj_mario_temp: Alarm_0
obj_mario_transform2: Alarm_10, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_mariostart: Alarm_1, Alarm_0
obj_mariostart_m: Alarm_1, Alarm_0
obj_mechakoopa: Alarm_11, Alarm_10
obj_mechakoopa_held: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_megamushroom: Alarm_10
obj_menu_editor: Alarm_0
obj_menu_editor_ext: Alarm_0
obj_meteorites: Alarm_0
obj_meteorites_big: Alarm_0
obj_meteorites_maker: Alarm_10, Alarm_9, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_mini_icicle: Alarm_1
obj_modelsizable: Alarm_1, Alarm_0
obj_modelsolid: Alarm_0
obj_monty_chase: Alarm_10
obj_multiveggiecoin: Alarm_1, Alarm_0
obj_muncher: Alarm_9, Alarm_0
obj_muncher_res: Alarm_0
obj_mushroom: Alarm_10, Alarm_0
obj_mushroom_platform_res: Alarm_3, Alarm_0
obj_musicblock: Alarm_1
obj_ninji: Alarm_1, Alarm_0
obj_noteblock: Alarm_4, Alarm_3, Alarm_1, Alarm_0
obj_noteblock_s: Alarm_1
obj_noti_load_button: Alarm_0
obj_oneway_res: Alarm_1
obj_onoffblock: Alarm_4, Alarm_1
obj_panelsparent: Alarm_0
obj_parcarry: Alarm_10, Alarm_0
obj_parent_resource: Alarm_5, Alarm_0
obj_parent_sounds: Alarm_0
obj_pausa_button: Alarm_2, Alarm_1, Alarm_0
obj_pballon: Alarm_10
obj_penguin_suit: Alarm_10
obj_persistent: Alarm_11, Alarm_10, Alarm_9, Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0, Alarm_8
obj_pinchos: Alarm_0
obj_pink_coin: Alarm_0
obj_piranhaplant: Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_plant_fire: Alarm_10, Alarm_4, Alarm_3, Alarm_2
obj_plantfire: Alarm_0
obj_plataforma: Alarm_1, Alarm_0
obj_plataforma_blue: Alarm_2, Alarm_1, Alarm_0
obj_platform_blue_res: Alarm_3
obj_platform_res: Alarm_3
obj_play_screen: Alarm_1, Alarm_0
obj_player_goal_nsmbu: Alarm_6, Alarm_5, Alarm_4
obj_player_goal_smb1: Alarm_11, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_0
obj_player_goal_smw: Alarm_4, Alarm_3, Alarm_2
obj_player_goal_smw_castle: Alarm_6, Alarm_5, Alarm_2
obj_player_warp: Alarm_2, Alarm_1, Alarm_0
obj_podoboo: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_pokey: Alarm_11, Alarm_10, Alarm_9, Alarm_0
obj_pokey_res: Alarm_3
obj_powerupparent: Alarm_10
obj_powerupsprout: Alarm_2, Alarm_1, Alarm_0
obj_powerupsprout_note: Alarm_1, Alarm_0
obj_propellershroom: Alarm_10
obj_pswitch: Alarm_10, Alarm_3, Alarm_1
obj_pswitch_press: Alarm_1, Alarm_0
obj_puente_res: Alarm_3
obj_puller: Alarm_1, Alarm_0
obj_rails_res: Alarm_3
obj_rename_input: Alarm_0
obj_rocangrejo: Alarm_2, Alarm_1, Alarm_0
obj_rockparent: Alarm_0
obj_rocky: Alarm_4, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_rorock: Alarm_2
obj_score_flag: Alarm_2, Alarm_1, Alarm_0
obj_semisolid_platform1: Alarm_3, Alarm_0
obj_shard: Alarm_0
obj_shell: Alarm_7, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1
obj_shell_held: Alarm_11, Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_shell_intro: Alarm_0
obj_skewer_res: Alarm_1
obj_skewertrunk: Alarm_2, Alarm_1, Alarm_0
obj_sledgebro: Alarm_10, Alarm_6, Alarm_5, Alarm_4, Alarm_3, Alarm_2, Alarm_1
obj_slider: Alarm_1, Alarm_0
obj_slopesa: Alarm_6, Alarm_5, Alarm_0
obj_snow_ball: Alarm_10, Alarm_6, Alarm_2, Alarm_1
obj_snow_ball_held: Alarm_2, Alarm_0
obj_snowball: Alarm_1, Alarm_0
obj_soplete: Alarm_0
obj_soplete_global: Alarm_2, Alarm_1, Alarm_0
obj_soplete_invert_global: Alarm_2, Alarm_1, Alarm_0
obj_spike: Alarm_10, Alarm_2, Alarm_1, Alarm_0
obj_spike_ball: Alarm_11, Alarm_10, Alarm_0
obj_spinsmoke: Alarm_1, Alarm_0
obj_spiny: Alarm_10, Alarm_3, Alarm_2, Alarm_1, Alarm_0
obj_spring: Alarm_1
obj_spring_land: Alarm_9, Alarm_0
obj_star: Alarm_10
obj_stomped: Alarm_0
obj_superarcon: Alarm_10
obj_superball: Alarm_1, Alarm_0
obj_thwomp: Alarm_10, Alarm_1, Alarm_0
obj_thwomp_b: Alarm_10, Alarm_0
obj_thwomp_intro: Alarm_2, Alarm_1, Alarm_0
obj_tile_trigger: Alarm_0
obj_timeup: Alarm_0
obj_title_controller: Alarm_1, Alarm_0
obj_title_oprime: Alarm_1, Alarm_0
obj_titlemenu_key: Alarm_0
obj_toast: Alarm_0
obj_tongue: Alarm_0
obj_tongue_blue: Alarm_0
obj_torbellino: Alarm_10, Alarm_0
obj_tuberia: Alarm_1, Alarm_0
obj_tuberia_res: Alarm_2, Alarm_1
obj_vine_res: Alarm_3
obj_waddlewing: Alarm_10, Alarm_1, Alarm_0
obj_water_move: Alarm_0
obj_water_move_limit: Alarm_0
obj_wrench: Alarm_1, Alarm_0
obj_yoshi2: Alarm_4, Alarm_2, Alarm_1, Alarm_0
obj_yoshi_abandon: Alarm_2, Alarm_1, Alarm_0
obj_yoshi_runaway: Alarm_0
obj_yoshifire: Alarm_2, Alarm_1, Alarm_0
```
</details>

<details><summary>按文件完整索引（1086 个文件，2303 行命中）</summary>

```
objects/obj_deadmario/Other_10.gml(47): 19,25,31,68,94,95,105,106,107,117,118,119,138,139,158,193,213,214,225,236,…+27
objects/obj_editormanager/Other_12.gml(44): 7,19,20,28,29,30,31,39,44,55,62,76,77,86,87,95,96,104,113,114,…+24
objects/obj_editormanager/Other_10.gml(34): 26,27,36,71,91,92,103,114,125,135,146,147,157,167,177,178,188,197,198,199,…+14
objects/obj_mario_transform2/Other_10.gml(31): 26,27,36,71,91,92,103,114,124,134,145,146,156,166,176,177,187,196,197,198,…+11
objects/obj_yoshi2/Other_10.gml(17): 18,25,35,38,43,46,58,74,104,111,121,124,129,132,144,168,196
objects/obj_hammerbro/Other_25.gml(15): 18,19,24,25,30,31,37,38,43,44,49,50,58,60,63
objects/obj_axe_smw/Alarm_0.gml(14): 2,4,6,8,10,12,14,16,18,20,22,24,26,28
objects/obj_NSMBU_bowserjr/Other_11.gml(12): 17,25,29,30,31,32,33,34,35,36,37,38
objects/obj_boomboom/Alarm_3.gml(12): 8,9,10,11,12,13,19,20,21,22,27,30
objects/obj_boomboom_b/Alarm_3.gml(12): 8,9,10,11,12,13,19,20,21,22,27,30
objects/obj_creator_jugar_editar/Other_13.gml(12): 62,109,165,166,169,248,252,254,256,274,275,276
objects/obj_NSMBU_bowser/Step_2.gml(11): 11,13,15,17,19,34,49,68,81,145,151
objects/obj_bganimator/Alarm_0.gml(10): 14,19,24,30,42,47,52,58,71,77
objects/obj_donut/Step_2.gml(10): 40,41,48,49,57,58,63,67,68,95
objects/obj_hammerbro/Alarm_1.gml(10): 22,28,34,40,47,53,59,66,68,71
objects/obj_thwomp_b/Step_0.gml(10): 12,60,110,121,141,183,196,216,258,269
objects/obj_SMW_bowser/Alarm_11.gml(9): 3,10,11,12,13,14,15,16,21
objects/obj_claw/Step_2.gml(9): 10,50,107,140,147,161,196,203,213
objects/obj_NSMBU_boomboom/Other_11.gml(8): 7,41,45,46,47,48,49,50
objects/obj_NSMBU_boomboom_b/Other_11.gml(8): 7,41,45,46,47,48,49,50
objects/obj_SMW_bowser/Alarm_4.gml(8): 6,7,8,9,10,11,12,15
objects/obj_SMW_bowser/Alarm_6.gml(8): 6,7,8,9,10,11,12,15
objects/obj_boomboom/Other_11.gml(8): 25,62,72,73,74,75,76,77
objects/obj_boomboom_b/Other_11.gml(8): 25,62,72,73,74,75,76,77
objects/obj_bowserjr/Alarm_3.gml(8): 9,10,11,12,13,14,15,18
objects/obj_enemyparent_held/Step_2.gml(8): 14,25,31,32,37,38,59,121
objects/obj_holdparent/Step_2.gml(8): 14,25,31,32,37,38,59,91
objects/obj_koopa/Other_11.gml(8): 12,13,21,22,36,47,48,60
objects/obj_koopa_b/Other_11.gml(8): 12,13,21,22,37,48,49,61
objects/obj_koopa_red/Other_11.gml(8): 12,13,21,22,37,48,49,62
objects/obj_koopa_red_b/Other_11.gml(8): 12,13,21,22,37,48,49,62
objects/obj_lakitu/Alarm_1.gml(8): 17,20,48,52,63,66,72,75
objects/obj_lava_lift/Other_11.gml(8): 4,5,14,15,26,27,38,39
objects/obj_player_warp/Alarm_2.gml(8): 6,7,13,14,20,21,27,28
objects/obj_skewertrunk/Step_0.gml(8): 11,20,29,38,56,66,76,86
objects/obj_snowball/Collision_obj_enemyparent.gml(8): 24,25,40,41,50,51,58,59
objects/obj_spike_ball/Other_13.gml(8): 46,51,58,72,74,84,98,100
objects/obj_yoshi_red/Other_10.gml(8): 15,26,28,32,50,61,63,67
objects/obj_NSMBU_boomboom/Alarm_4.gml(7): 7,8,9,10,11,12,15
objects/obj_NSMBU_boomboom_b/Alarm_4.gml(7): 7,8,9,10,11,12,15
objects/obj_NSMBU_bowser/Alarm_11.gml(7): 3,10,11,12,13,14,19
objects/obj_NSMBU_bowserjr/Alarm_3.gml(7): 6,7,8,9,10,11,14
objects/obj_SMB3_bowser/Alarm_3.gml(7): 8,9,10,11,12,13,16
objects/obj_blockparent/Step_0.gml(7): 7,12,27,29,41,48,57
objects/obj_kuriboshoe/Step_2.gml(7): 73,79,81,90,96,98,111
objects/obj_mario/Other_12.gml(7): 185,303,330,455,647,662,675
objects/obj_mario/Step_0.gml(7): 260,265,270,292,308,310,382
objects/obj_sledgebro/Alarm_1.gml(7): 5,19,20,21,22,24,27
objects/obj_thwomp/Step_0.gml(7): 12,58,97,123,158,184,219
objects/obj_SMB3_bowser/Other_7.gml(6): 5,12,13,21,22,23
objects/obj_bullebill_base_red/Alarm_0.gml(6): 3,8,14,46,52,84
objects/obj_clown/Step_0.gml(6): 7,82,101,125,126,228
objects/obj_grrrol/Other_13.gml(6): 9,14,27,36,50,59
objects/obj_grrrol_b/Other_13.gml(6): 9,14,27,36,50,59
objects/obj_grrrol_new/Other_13.gml(6): 9,14,27,36,50,59
objects/obj_invincibility/Create_0.gml(6): 17,18,21,22,34,35
objects/obj_marioU/Step_0.gml(6): 243,248,253,271,273,325
objects/obj_shell_drybones_held/Other_13.gml(6): 28,42,44,54,68,70
objects/obj_shell_held/Other_11.gml(6): 35,36,41,42,57,70
objects/obj_sledgebro/Step_0.gml(6): 6,11,102,114,138,175
objects/obj_spike/Alarm_2.gml(6): 12,24,36,37,42,46
objects/obj_SMB3_bowser/Alarm_11.gml(5): 3,12,13,14,19
objects/obj_SMW_bowser/Alarm_10.gml(5): 2,3,4,5,6
objects/obj_boomerangbro/Alarm_2.gml(5): 3,21,22,31,33
objects/obj_bowserjr/Other_14.gml(5): 26,45,137,154,156
objects/obj_claw/Collision_obj_shell_held.gml(5): 21,22,28,29,39
objects/obj_door_lock/Step_0.gml(5): 52,54,158,160,180
objects/obj_door_lock_exit/Step_0.gml(5): 52,54,157,159,178
objects/obj_firebro/Alarm_2.gml(5): 3,21,22,31,33
objects/obj_ground3/Step_0.gml(5): 16,25,34,43,62
objects/obj_hammerbro/Alarm_2.gml(5): 3,21,22,31,33
objects/obj_icebro/Alarm_2.gml(5): 3,21,22,31,33
objects/obj_marioU/Other_12.gml(5): 163,598,599,634,635
objects/obj_onoffblock/Step_0.gml(5): 46,48,58,67,74
objects/obj_player_goal_smw_castle/Alarm_6.gml(5): 25,30,37,38,41
objects/obj_spike/Step_0.gml(5): 101,134,135,140,144
objects/obj_NSMBU_boomboom/Other_7.gml(4): 6,9,16,25
objects/obj_NSMBU_boomboom_b/Other_7.gml(4): 6,9,16,25
objects/obj_NSMBU_bowser/Alarm_10.gml(4): 2,3,4,5
objects/obj_NSMBU_bowserjr/Other_14.gml(4): 25,63,138,154
objects/obj_NSMBU_charginchuck/Step_0.gml(4): 12,17,98,112
objects/obj_SMB3_bowser/Alarm_10.gml(4): 5,6,7,8
objects/obj_SMW_bowser/Alarm_0.gml(4): 6,7,16,20
objects/obj_axe_smw/Step_0.gml(4): 12,13,18,19
objects/obj_bonybeetle/Step_2.gml(4): 36,37,62,63
objects/obj_bonybeetle_b/Step_2.gml(4): 36,37,62,63
objects/obj_boomerangbro/Create_0.gml(4): 49,53,58,60
objects/obj_bowserjr/Alarm_11.gml(4): 30,61,71,75
objects/obj_bullebill_base/Alarm_0.gml(4): 3,9,42,74
objects/obj_bullebill_base/Other_11.gml(4): 9,42,46,50
objects/obj_bullebill_base/Other_12.gml(4): 9,42,46,50
objects/obj_bullebill_base_red/Other_11.gml(4): 14,47,51,55
objects/obj_bullebill_base_red/Other_12.gml(4): 14,47,51,55
objects/obj_card_logo/Mouse_4.gml(4): 326,328,330,332
objects/obj_charginchuck/Step_0.gml(4): 11,16,98,112
objects/obj_cheepcheep/Step_0.gml(4): 6,48,66,157
objects/obj_cheepcheep2/Step_0.gml(4): 6,48,80,171
objects/obj_creator_jugar_editar/Other_12.gml(4): 7,15,18,20
objects/obj_crystalorb/Collision_obj_mario.gml(4): 10,25,26,32
objects/obj_deadmario/Create_0.gml(4): 21,22,85,90
objects/obj_door/Alarm_0.gml(4): 6,11,38,44
objects/obj_door_exit/Alarm_0.gml(4): 6,11,38,47
objects/obj_door_lock/Alarm_0.gml(4): 6,11,38,44
objects/obj_door_lock_exit/Alarm_0.gml(4): 6,11,38,44
objects/obj_door_switch/Alarm_0.gml(4): 6,11,38,44
objects/obj_door_switch_exit/Alarm_0.gml(4): 6,11,38,44
objects/obj_egg/Alarm_1.gml(4): 28,32,43,47
objects/obj_egg/Create_0.gml(4): 6,7,19,24
objects/obj_egg/Step_0.gml(4): 28,58,89,146
objects/obj_firebro/Create_0.gml(4): 48,52,57,59
objects/obj_floruga/Alarm_0.gml(4): 6,11,14,17
objects/obj_goalcard/Collision_obj_mario.gml(4): 13,14,29,30
objects/obj_hammerbro/Create_0.gml(4): 49,53,58,60
objects/obj_icebro/Create_0.gml(4): 49,53,58,60
objects/obj_jumppiranha/Create_0.gml(4): 42,43,44,45
objects/obj_kuribo_drybones/Step_2.gml(4): 85,163,216,229
objects/obj_levelmanager/Alarm_10.gml(4): 9,11,17,20
objects/obj_levelmanager/Alarm_2.gml(4): 6,8,10,15
objects/obj_levelmanager/Alarm_7.gml(4): 20,21,24,26
objects/obj_levelmanager/Create_0.gml(4): 51,55,57,64
objects/obj_link_bomb/Create_0.gml(4): 9,10,11,12
objects/obj_mario/Other_11.gml(4): 11,12,24,27
objects/obj_mario_transform2/Create_0.gml(4): 11,81,82,95
objects/obj_mariostart_m/Step_2.gml(4): 10,11,29,30
objects/obj_next_before/Other_10.gml(4): 21,22,50,51
objects/obj_parcarry/Alarm_0.gml(4): 7,31,47,56
objects/obj_persistent/Other_2.gml(4): 8,86,88,89
objects/obj_piranhaplant/Alarm_0.gml(4): 5,24,25,29
objects/obj_player_goal_nsmbu/Alarm_5.gml(4): 9,26,27,32
objects/obj_player_goal_smw/Create_0.gml(4): 4,5,20,24
objects/obj_podoboo/Alarm_1.gml(4): 9,12,18,22
objects/obj_pokey/Create_0.gml(4): 42,46,51,54
objects/obj_shell/Alarm_4.gml(4): 2,6,50,73
objects/obj_shell/Other_17.gml(4): 20,21,27,28
objects/obj_shell_held/Other_15.gml(4): 27,28,34,35
objects/obj_sledgebro/Alarm_3.gml(4): 3,20,21,25
objects/obj_snow_ball_held/Other_13.gml(4): 56,58,77,79
objects/obj_tuberia/Step_0.gml(4): 19,39,60,80
objects/obj_NSMBU_bowser/Alarm_0.gml(3): 6,43,47
objects/obj_NSMBU_bowserjr/Step_0.gml(3): 3,7,66
objects/obj_NSMBU_bowserjr/Step_2.gml(3): 16,18,44
objects/obj_NSMBU_charginchuck/Alarm_10.gml(3): 3,8,13
objects/obj_SMB3_bowser/Other_14.gml(3): 40,59,134
objects/obj_beachkoopa/Collision_obj_shell.gml(3): 10,11,12
objects/obj_beachkoopa_b/Collision_obj_shell.gml(3): 10,11,12
objects/obj_beachkoopa_red/Collision_obj_shell.gml(3): 10,11,12
objects/obj_beachkoopa_red_b/Collision_obj_shell.gml(3): 10,11,12
objects/obj_beanstalk/Create_0.gml(3): 24,29,30
objects/obj_billbanzai_red/Create_0.gml(3): 18,19,20
objects/obj_block_pow_hold/Other_12.gml(3): 10,39,74
objects/obj_bobomb_hold/Create_0.gml(3): 22,29,30
objects/obj_boomerang/Create_0.gml(3): 28,30,31
objects/obj_bowser_dead/Step_0.gml(3): 4,10,16
objects/obj_bowserjr/Alarm_1.gml(3): 10,17,23
objects/obj_bowserjr/Alarm_10.gml(3): 1,2,5
objects/obj_bowserjr/Alarm_2.gml(3): 18,28,33
objects/obj_bowserjr/Step_0.gml(3): 16,19,70
objects/obj_bowserjr_shell/Create_0.gml(3): 42,43,44
objects/obj_bulletbull_red/Create_0.gml(3): 34,38,39
objects/obj_button_time/Alarm_0.gml(3): 23,28,34
objects/obj_charginchuck/Alarm_10.gml(3): 2,7,12
objects/obj_cloud_lakitu/Create_0.gml(3): 20,22,23
objects/obj_cloud_lakitu/Step_0.gml(3): 7,90,108
objects/obj_clown/Alarm_0.gml(3): 6,11,15
objects/obj_coinchain/Create_0.gml(3): 5,6,7
objects/obj_creator_jugar_editar/Alarm_0.gml(3): 3,4,10
objects/obj_door/Step_0.gml(3): 5,7,27
objects/obj_door_exit/Step_0.gml(3): 5,7,27
objects/obj_door_switch/Step_0.gml(3): 9,11,30
objects/obj_door_switch_exit/Step_0.gml(3): 9,11,30
objects/obj_editormanager/Alarm_1.gml(3): 161,163,166
objects/obj_enemyfrozen/Step_0.gml(3): 44,45,46
objects/obj_fishbone/Create_0.gml(3): 13,23,26
objects/obj_floruga/Other_11.gml(3): 30,57,58
objects/obj_galoomba_hold/Alarm_2.gml(3): 3,11,12
objects/obj_goalgate_tape/Other_10.gml(3): 5,72,73
objects/obj_ground2/Step_0.gml(3): 69,79,94
objects/obj_holdparent/Alarm_0.gml(3): 35,127,173
objects/obj_holdparent/Other_12.gml(3): 18,37,65
objects/obj_icicle/Step_0.gml(3): 6,20,67
objects/obj_koopa/Other_15.gml(3): 13,22,23
objects/obj_koopa_b/Other_15.gml(3): 12,21,22
objects/obj_koopa_red/Other_15.gml(3): 12,22,23
objects/obj_koopa_red_b/Other_15.gml(3): 12,21,22
objects/obj_kuribo_drybones/Alarm_4.gml(3): 6,11,15
objects/obj_link_arrow/Create_0.gml(3): 13,15,17
objects/obj_link_bomb/Alarm_6.gml(3): 3,4,5
objects/obj_magikoopa/Alarm_2.gml(3): 4,18,21
objects/obj_magikoopa/Other_7.gml(3): 11,39,41
objects/obj_mario/Alarm_10.gml(3): 16,49,66
objects/obj_mario_transform2/Alarm_0.gml(3): 1,37,65
objects/obj_mariostart/Create_0.gml(3): 7,9,11
objects/obj_mechakoopa_held/Alarm_1.gml(3): 6,13,17
objects/obj_play_screen/Alarm_0.gml(3): 3,4,10
objects/obj_player_goal_smb1/Create_0.gml(3): 10,11,19
objects/obj_player_warp/Alarm_1.gml(3): 63,64,73
objects/obj_rockparent/Step_0.gml(3): 6,11,25
objects/obj_rocky/Step_0.gml(3): 46,55,64
objects/obj_score_flag/Create_0.gml(3): 15,18,19
objects/obj_shell/Other_12.gml(3): 13,47,104
objects/obj_shell_drybones/Other_12.gml(3): 11,51,83
objects/obj_skewertrunk/Other_11.gml(3): 42,55,68
objects/obj_skewertrunk/Other_12.gml(3): 46,58,71
objects/obj_skewertrunk/Other_13.gml(3): 48,61,74
objects/obj_skewertrunk/Other_14.gml(3): 46,58,71
objects/obj_sledgebro/Create_0.gml(3): 38,46,47
objects/obj_soplete_global/Alarm_2.gml(3): 5,9,15
objects/obj_spinner/Collision_obj_blockparent.gml(3): 6,11,18
objects/obj_title_oprime/Mouse_4.gml(3): 16,34,35
objects/obj_tongue/Collision_obj_enemyparent.gml(3): 6,12,17
objects/obj_tongue_blue/Collision_obj_enemyparent.gml(3): 6,12,17
objects/obj_tuberia/Alarm_1.gml(3): 54,59,67
objects/obj_yoshi_abandon/Create_0.gml(3): 18,19,20
objects/obj_NSMBU_boomboom/Alarm_10.gml(2): 24,25
objects/obj_NSMBU_boomboom/Alarm_11.gml(2): 16,19
objects/obj_NSMBU_boomboom_b/Alarm_10.gml(2): 24,25
objects/obj_NSMBU_bowser/Alarm_1.gml(2): 5,11
objects/obj_NSMBU_bowser/Alarm_3.gml(2): 7,15
objects/obj_NSMBU_bowser/Other_7.gml(2): 5,9
objects/obj_NSMBU_bowserjr/Alarm_0.gml(2): 22,26
objects/obj_NSMBU_bowserjr/Alarm_1.gml(2): 4,9
objects/obj_NSMBU_bowserjr/Other_7.gml(2): 5,8
objects/obj_NSMBU_charginchuck/Alarm_1.gml(2): 7,10
objects/obj_SMB2_mushroom/Alarm_0.gml(2): 6,9
objects/obj_SMB3_bowser/Alarm_0.gml(2): 7,10
objects/obj_SMB_bowser/Alarm_0.gml(2): 7,10
objects/obj_SMB_bowser/Alarm_10.gml(2): 2,3
objects/obj_SMB_flag/Other_10.gml(2): 2,4
objects/obj_SMW_bowser/Alarm_7.gml(2): 67,72
objects/obj_SMW_bowser/Other_14.gml(2): 34,99
objects/obj_angrysun_movement/Alarm_1.gml(2): 3,10
objects/obj_angrysun_movement/Other_8.gml(2): 2,4
objects/obj_arrow_res/Mouse_4.gml(2): 7,43
objects/obj_axe_smw/Alarm_2.gml(2): 6,9
objects/obj_banzaibill/Create_0.gml(2): 84,86
objects/obj_big_pplant/Create_0.gml(2): 24,25
objects/obj_big_pplant_b/Create_0.gml(2): 24,25
objects/obj_billbanzai_red_res/Mouse_4.gml(2): 7,47
objects/obj_billbanzai_res/Mouse_4.gml(2): 7,47
objects/obj_blockbumper/Collision_obj_blockparent.gml(2): 8,22
objects/obj_blooper/Step_0.gml(2): 7,17
objects/obj_bobomb_hold/Alarm_1.gml(2): 7,8
objects/obj_bobomb_ready/Create_0.gml(2): 25,29
objects/obj_bobomb_ready/Other_11.gml(2): 1,5
objects/obj_bonybeetle/Create_0.gml(2): 46,51
objects/obj_bonybeetle_b/Create_0.gml(2): 46,51
objects/obj_boo/Create_0.gml(2): 55,56
objects/obj_boomboom/Alarm_11.gml(2): 4,11
objects/obj_boomboom/Alarm_2.gml(2): 4,5
objects/obj_boomboom/Alarm_4.gml(2): 6,7
objects/obj_boomboom/Alarm_9.gml(2): 4,5
objects/obj_boomboom/Create_0.gml(2): 44,45
objects/obj_boomboom_b/Alarm_11.gml(2): 4,11
objects/obj_boomboom_b/Alarm_4.gml(2): 6,7
objects/obj_boomboom_b/Alarm_9.gml(2): 4,5
objects/obj_boomboom_b/Create_0.gml(2): 44,45
objects/obj_boomerangbro/Other_17.gml(2): 6,11
objects/obj_boomerangbro/Other_7.gml(2): 8,9
objects/obj_bowser_dead/Destroy_0.gml(2): 9,11
objects/obj_bowserjr/Alarm_0.gml(2): 15,18
objects/obj_bowserjr/Other_7.gml(2): 5,8
objects/obj_brickhelmet/Alarm_4.gml(2): 13,17
objects/obj_bullebill_base/Create_0.gml(2): 44,46
objects/obj_bullebill_base_red/Create_0.gml(2): 34,36
objects/obj_bullebill_base_red_res/Create_0.gml(2): 14,16
objects/obj_bullebill_base_red_res/Mouse_4.gml(2): 7,37
objects/obj_bullebill_base_res/Create_0.gml(2): 14,16
objects/obj_bullebill_base_res/Mouse_4.gml(2): 7,37
objects/obj_bulletbill/Alarm_1.gml(2): 13,27
objects/obj_bulletbill/Create_0.gml(2): 39,41
objects/obj_bumper/Alarm_0.gml(2): 4,9
objects/obj_button_home/Mouse_4.gml(2): 26,55
objects/obj_button_settings_close/Mouse_4.gml(2): 15,20
objects/obj_button_settings_close2/Mouse_4.gml(2): 15,20
objects/obj_button_superado/Mouse_4.gml(2): 15,31
objects/obj_buzzy_ceiling/Other_11.gml(2): 16,17
objects/obj_buzzybeetle/Create_0.gml(2): 48,49
objects/obj_buzzybeetle/Other_11.gml(2): 36,37
objects/obj_buzzybeetle/Other_15.gml(2): 35,36
objects/obj_buzzybeetle/Other_19.gml(2): 31,32
objects/obj_buzzybeetle_b/Create_0.gml(2): 49,50
objects/obj_buzzybeetle_b/Other_11.gml(2): 36,37
objects/obj_buzzybeetle_b/Other_15.gml(2): 34,35
objects/obj_buzzybeetle_b/Other_19.gml(2): 31,32
objects/obj_call_mario/Create_0.gml(2): 4,5
objects/obj_cannon/Alarm_0.gml(2): 3,27
objects/obj_cannon/Create_0.gml(2): 30,32
objects/obj_cannon_red/Alarm_0.gml(2): 3,27
objects/obj_cannon_red_res/Mouse_4.gml(2): 7,68
objects/obj_cannon_res/Mouse_4.gml(2): 7,68
objects/obj_cap/Create_0.gml(2): 13,14
objects/obj_charginchuck/Alarm_1.gml(2): 7,10
objects/obj_charginchuck/Create_0.gml(2): 59,60
objects/obj_checkpoint_res/Mouse_4.gml(2): 7,43
objects/obj_cheepcheep/Other_11.gml(2): 10,11
objects/obj_cinta_on_res/Create_0.gml(2): 18,20
objects/obj_cinta_on_res/Mouse_4.gml(2): 7,49
objects/obj_cinta_res/Create_0.gml(2): 18,20
objects/obj_cinta_res/Mouse_4.gml(2): 7,49
objects/obj_claw/Collision_obj_snow_ball_held.gml(2): 11,15
objects/obj_clown/Collision_obj_mario.gml(2): 7,23
objects/obj_clown/Collision_obj_pinchos.gml(2): 6,7
objects/obj_clown_fire/Alarm_4.gml(2): 13,16
objects/obj_coin_pow/Create_0.gml(2): 61,62
objects/obj_creator_jugar_editar/Alarm_7.gml(2): 4,7
objects/obj_creator_jugar_editar/Alarm_8.gml(2): 2,7
objects/obj_crumblebones/Alarm_1.gml(2): 14,18
objects/obj_crumblebones/Create_0.gml(2): 33,39
objects/obj_crumblebony/Alarm_1.gml(2): 13,17
objects/obj_crumblebony/Create_0.gml(2): 34,40
objects/obj_crumblebony_b/Alarm_1.gml(2): 13,17
objects/obj_crumblebony_b/Create_0.gml(2): 34,40
objects/obj_deadmario/Alarm_0.gml(2): 38,40
objects/obj_drybones/Alarm_0.gml(2): 7,8
objects/obj_drybones/Create_0.gml(2): 37,42
objects/obj_edit_menu/Destroy_0.gml(2): 29,31
objects/obj_editormanager/Create_0.gml(2): 6,54
objects/obj_egg/Other_7.gml(2): 9,11
objects/obj_enemyparent_held/Collision_obj_blockparent.gml(2): 12,14
objects/obj_enemyparent_held/Create_0.gml(2): 6,8
objects/obj_erase/Alarm_0.gml(2): 4,11
objects/obj_erase/Step_0.gml(2): 8,15
objects/obj_espina/Create_0.gml(2): 4,5
objects/obj_firebar_res/Mouse_4.gml(2): 7,40
objects/obj_firebro/Other_17.gml(2): 6,11
objects/obj_firebro/Other_7.gml(2): 8,9
objects/obj_flagpole/Alarm_1.gml(2): 7,13
objects/obj_floruga/Other_16.gml(2): 10,20
objects/obj_frozenmario/Create_0.gml(2): 25,26
objects/obj_frozenmario/Step_0.gml(2): 4,9
objects/obj_galoomba/Create_0.gml(2): 40,41
objects/obj_galoomba/Step_0.gml(2): 102,144
objects/obj_galoomba2/Create_0.gml(2): 40,41
objects/obj_galoomba2_b/Create_0.gml(2): 43,44
objects/obj_galoomba_b/Create_0.gml(2): 49,50
objects/obj_galoomba_b/Step_0.gml(2): 78,120
objects/obj_galoomba_hold/Alarm_1.gml(2): 4,5
objects/obj_galoomba_hold/Create_0.gml(2): 11,12
objects/obj_galoomba_hold2/Alarm_1.gml(2): 4,5
objects/obj_galoomba_hold2_b/Alarm_1.gml(2): 4,5
objects/obj_galoomba_hold_b/Alarm_1.gml(2): 4,5
objects/obj_getshoe/Create_0.gml(2): 15,16
objects/obj_goalcard/Alarm_3.gml(2): 7,13
objects/obj_goalgate/Alarm_0.gml(2): 7,13
objects/obj_gold_explosion/Collision_obj_blockparent.gml(2): 13,26
objects/obj_groundpount/Collision_obj_blockparent.gml(2): 18,23
objects/obj_grrrol_b_res/Mouse_4.gml(2): 7,45
objects/obj_grrrol_new_res/Mouse_4.gml(2): 7,45
objects/obj_grrrol_res/Mouse_4.gml(2): 7,45
objects/obj_hammerbro/Other_17.gml(2): 6,11
objects/obj_hammerbro/Other_7.gml(2): 8,9
objects/obj_hawmask/Alarm_1.gml(2): 3,9
objects/obj_hawmask/Other_7.gml(2): 16,17
objects/obj_icebro/Other_17.gml(2): 6,11
objects/obj_icebro/Other_7.gml(2): 8,9
objects/obj_koopa/Step_0.gml(2): 12,68
objects/obj_koopa_red/Step_0.gml(2): 12,84
objects/obj_kuribo_drybones/Alarm_5.gml(2): 5,9
objects/obj_kuribo_drybones/Alarm_8.gml(2): 77,80
objects/obj_kuriboshoe/Alarm_2.gml(2): 4,7
objects/obj_lakitu/Alarm_0.gml(2): 23,25
objects/obj_lava_lift/Alarm_0.gml(2): 2,3
objects/obj_lava_water/Step_2.gml(2): 30,41
objects/obj_levelmanager/Alarm_4.gml(2): 4,13
objects/obj_levelmanager/Alarm_8.gml(2): 4,8
objects/obj_levelmanager/Alarm_9.gml(2): 5,13
objects/obj_levelmanager/Other_4.gml(2): 20,23
objects/obj_link_arrow/Collision_obj_blockparent.gml(2): 9,16
objects/obj_link_atack/Collision_obj_blockparent.gml(2): 9,16
objects/obj_link_bomb/Alarm_4.gml(2): 16,19
objects/obj_link_bomb/Step_0.gml(2): 70,72
objects/obj_link_bomb/Step_2.gml(2): 11,24
objects/obj_link_dash_atack/Collision_obj_blockparent.gml(2): 9,16
objects/obj_lun/Create_0.gml(2): 2,11
objects/obj_mario/Create_0.gml(2): 187,190
objects/obj_mario/Other_16.gml(2): 11,14
objects/obj_marioU/Other_11.gml(2): 10,42
objects/obj_mario_editor/Mouse_4.gml(2): 7,29
objects/obj_mario_transform2/Alarm_4.gml(2): 12,14
objects/obj_mechakoopa_held/Create_0.gml(2): 32,34
objects/obj_muncher/Create_0.gml(2): 42,47
objects/obj_muncher/Step_0.gml(2): 9,28
objects/obj_muncher_b/Create_0.gml(2): 40,45
objects/obj_mushroom/Alarm_0.gml(2): 6,9
objects/obj_mushroom_platform_res/Mouse_4.gml(2): 7,37
objects/obj_musicblock/Step_0.gml(2): 11,21
objects/obj_noteblock/Step_0.gml(2): 12,23
objects/obj_noteblock_s/Step_0.gml(2): 11,21
objects/obj_oneway_res/Mouse_4.gml(2): 7,43
objects/obj_parent_resource/Create_0.gml(2): 53,55
objects/obj_parent_resource/Mouse_4.gml(2): 7,29
objects/obj_parent_sounds/Mouse_4.gml(2): 7,29
objects/obj_pausa_button/KeyPress_82.gml(2): 7,16
objects/obj_penguin_attack/Collision_obj_blockparent.gml(2): 8,22
objects/obj_piranhaplant/Alarm_2.gml(2): 17,18
objects/obj_piranhaplant/Create_0.gml(2): 41,42
objects/obj_plant_fire/Create_0.gml(2): 45,46
objects/obj_plant_fire/Other_7.gml(2): 8,17
objects/obj_plantfire/Alarm_0.gml(2): 4,6
objects/obj_plataforma_blue/Step_0.gml(2): 26,35
objects/obj_platform_blue_res/Mouse_4.gml(2): 7,37
objects/obj_platform_res/Mouse_4.gml(2): 7,45
objects/obj_play_screen/Alarm_1.gml(2): 3,10
objects/obj_player_goal_nsmbu/Create_0.gml(2): 18,19
objects/obj_player_goal_smb1/Alarm_5.gml(2): 7,8
objects/obj_podoboo/Step_0.gml(2): 23,31
objects/obj_pokey/Step_0.gml(2): 9,21
objects/obj_pokey_res/Mouse_4.gml(2): 7,43
objects/obj_powerupsprout/Alarm_0.gml(2): 65,68
objects/obj_pswitch/Other_16.gml(2): 17,21
objects/obj_pswitch_press/Create_0.gml(2): 3,4
objects/obj_puente_res/Mouse_4.gml(2): 7,37
objects/obj_puller/Create_0.gml(2): 3,4
objects/obj_rails_res/Mouse_4.gml(2): 7,37
objects/obj_rocangrejo/Other_7.gml(2): 5,8
objects/obj_rocangrejo/Step_0.gml(2): 6,9
objects/obj_rorock/Create_0.gml(2): 4,5
objects/obj_semisolid_platform1/Mouse_4.gml(2): 7,37
objects/obj_settings_panel/Create_0.gml(2): 25,33
objects/obj_settings_panel/Destroy_0.gml(2): 30,35
objects/obj_shell/Alarm_5.gml(2): 4,9
objects/obj_shell/Collision_obj_mario.gml(2): 139,224
objects/obj_shell/Create_0.gml(2): 16,17
objects/obj_shell_drybones/Collision_obj_mario.gml(2): 66,107
objects/obj_shell_held/Create_0.gml(2): 25,27
objects/obj_skewer_res/Mouse_4.gml(2): 7,43
objects/obj_skewertrunk/Other_10.gml(2): 27,39
objects/obj_sledgebro/Other_7.gml(2): 8,9
objects/obj_snow_ball/Collision_obj_mario.gml(2): 43,61
objects/obj_snow_ball/Create_0.gml(2): 36,37
objects/obj_snow_ball/Other_12.gml(2): 15,63
objects/obj_snow_ball_b/Collision_obj_mario.gml(2): 36,58
objects/obj_snow_ball_held/Other_11.gml(2): 6,11
objects/obj_snowball/Collision_obj_shell.gml(2): 20,21
objects/obj_snowball_bro/Create_0.gml(2): 20,24
objects/obj_soplete_invert_global/Alarm_2.gml(2): 5,10
objects/obj_soplete_res/Mouse_4.gml(2): 7,56
objects/obj_spike/Alarm_0.gml(2): 5,37
objects/obj_spike/Create_0.gml(2): 56,57
objects/obj_spike/Step_2.gml(2): 21,23
objects/obj_spinsmoke/Create_0.gml(2): 14,15
objects/obj_spiny/Alarm_0.gml(2): 20,25
objects/obj_spiny/Other_15.gml(2): 20,21
objects/obj_spiny/Other_19.gml(2): 20,21
objects/obj_spring_land/Collision_obj_physicsparent.gml(2): 12,32
objects/obj_spring_land/Create_0.gml(2): 34,39
objects/obj_spring_land/Step_0.gml(2): 13,26
objects/obj_star/Collision_obj_mario.gml(2): 8,16
objects/obj_superball/Create_0.gml(2): 5,6
objects/obj_thwomp/Alarm_1.gml(2): 86,89
objects/obj_thwomp_b_res/Mouse_4.gml(2): 7,50
objects/obj_thwomp_intro/Alarm_1.gml(2): 1,4
objects/obj_thwomp_res/Mouse_4.gml(2): 7,50
objects/obj_toast/Step_0.gml(2): 17,19
objects/obj_tongue/Collision_obj_holdparent.gml(2): 9,23
objects/obj_tongue/Step_2.gml(2): 35,50
objects/obj_tongue_blue/Collision_obj_holdparent.gml(2): 9,23
objects/obj_tongue_blue/Step_2.gml(2): 35,50
objects/obj_torbellino/Create_0.gml(2): 23,24
objects/obj_tuberia_res/Create_0.gml(2): 47,59
objects/obj_tuberia_res/Mouse_4.gml(2): 7,37
objects/obj_vine_res/Mouse_4.gml(2): 7,43
objects/obj_waddlewing/Create_0.gml(2): 61,62
objects/obj_wrench/Create_0.gml(2): 20,21
objects/obj_yoshi_abandon/Alarm_1.gml(2): 2,3
objects/obj_yoshi_runaway/Create_0.gml(2): 23,24
scripts/scr_edit_to_play/scr_edit_to_play.gml(2): 376,1246
objects/obj_1up/Alarm_10.gml(1): 32
objects/obj_1up/Create_0.gml(1): 65
objects/obj_NSMBU_boomboom/Alarm_2.gml(1): 5
objects/obj_NSMBU_boomboom/Alarm_5.gml(1): 7
objects/obj_NSMBU_boomboom/Alarm_7.gml(1): 7
objects/obj_NSMBU_boomboom/Create_0.gml(1): 27
objects/obj_NSMBU_boomboom_b/Alarm_2.gml(1): 5
objects/obj_NSMBU_boomboom_b/Alarm_5.gml(1): 7
objects/obj_NSMBU_boomboom_b/Alarm_7.gml(1): 7
objects/obj_NSMBU_boomboom_b/Create_0.gml(1): 27
objects/obj_NSMBU_bowser/Create_0.gml(1): 18
objects/obj_NSMBU_bowser/Other_14.gml(1): 108
objects/obj_NSMBU_bowserjr/Alarm_9.gml(1): 11
objects/obj_NSMBU_bowserjr/Create_0.gml(1): 26
objects/obj_NSMBU_bowserjr_b/Create_0.gml(1): 26
objects/obj_NSMBU_charginchuck/Alarm_0.gml(1): 1
objects/obj_NSMBU_charginchuck/Other_11.gml(1): 26
objects/obj_NSMBU_charginchuck/Other_7.gml(1): 9
objects/obj_NSMBU_flag_mario/Create_0.gml(1): 10
objects/obj_NSMBU_ninji/Alarm_0.gml(1): 28
objects/obj_NSMBU_ninji/Create_0.gml(1): 28
objects/obj_NSMBU_ninji/Step_0.gml(1): 25
objects/obj_SMB2_mushroom/Alarm_10.gml(1): 23
objects/obj_SMB2_mushroom/Create_0.gml(1): 31
objects/obj_SMB3_bowser/Alarm_2.gml(1): 20
objects/obj_SMB3_bowser/Create_0.gml(1): 15
objects/obj_SMB3_bowser/Step_0.gml(1): 60
objects/obj_SMB_bowser/Alarm_1.gml(1): 4
objects/obj_SMB_bowser/Alarm_2.gml(1): 22
objects/obj_SMB_bowser/Create_0.gml(1): 10
objects/obj_SMB_bowser/Other_14.gml(1): 95
objects/obj_SMB_castle/Step_0.gml(1): 9
objects/obj_SMB_flag/Alarm_1.gml(1): 9
objects/obj_SMB_flag/Collision_obj_flagpole.gml(1): 10
objects/obj_SMB_flag/Step_0.gml(1): 12
objects/obj_SMW_bowser/Alarm_1.gml(1): 2
objects/obj_SMW_bowser/Alarm_2.gml(1): 22
objects/obj_SMW_bowser/Alarm_3.gml(1): 2
objects/obj_SMW_bowser/Create_0.gml(1): 14
objects/obj_SMW_bowser/Other_13.gml(1): 29
objects/obj_SMW_bowser/Step_2.gml(1): 14
objects/obj_alert_button/Create_0.gml(1): 4
objects/obj_alert_close/Create_0.gml(1): 4
objects/obj_alert_condicion/Create_0.gml(1): 8
objects/obj_angrysun/Alarm_0.gml(1): 9
objects/obj_angrysun/Step_0.gml(1): 20
objects/obj_angrysun_movement/Alarm_0.gml(1): 4
objects/obj_angrysun_movement/Alarm_3.gml(1): 4
objects/obj_angrysun_movement/Alarm_4.gml(1): 5
objects/obj_angrysun_movement/Create_0.gml(1): 4
objects/obj_arrow_big/Alarm_0.gml(1): 5
objects/obj_arrow_big/Create_0.gml(1): 7
objects/obj_arrow_res/Create_0.gml(1): 7
objects/obj_autoscroll/Create_0.gml(1): 4
objects/obj_axe_smw/Alarm_1.gml(1): 5
objects/obj_axe_smw/Alarm_3.gml(1): 16
objects/obj_banzaibill/Alarm_0.gml(1): 33
objects/obj_banzaibill/Other_11.gml(1): 10
objects/obj_beachkoopa/Create_0.gml(1): 17
objects/obj_beachkoopa/Step_0.gml(1): 14
objects/obj_beachkoopa_b/Step_0.gml(1): 14
objects/obj_beanstalk/Alarm_0.gml(1): 3
objects/obj_bg1/Mouse_4.gml(1): 132
objects/obj_bganimator/Create_0.gml(1): 7
objects/obj_big_pplant/Alarm_11.gml(1): 3
objects/obj_billbanzai_red/Other_11.gml(1): 8
objects/obj_billbanzai_red_res/Create_0.gml(1): 7
objects/obj_billbanzai_res/Create_0.gml(1): 7
objects/obj_block/Create_0.gml(1): 63
objects/obj_block_coinchain/Other_11.gml(1): 3
objects/obj_block_gold/Other_10.gml(1): 18
objects/obj_block_hidden/Collision_obj_shell.gml(1): 11
objects/obj_block_hidden/Collision_obj_shell_held.gml(1): 11
objects/obj_block_hidden/Collision_obj_spinner.gml(1): 9
objects/obj_block_hidden/Step_0.gml(1): 15
objects/obj_block_multicoin/Create_0.gml(1): 62
objects/obj_block_multicoin/Other_10.gml(1): 7
objects/obj_block_multicoin/Other_11.gml(1): 3
objects/obj_block_pow_active/Create_0.gml(1): 41
objects/obj_block_pow_hold/Alarm_1.gml(1): 8
objects/obj_block_pow_hold/Step_0.gml(1): 15
objects/obj_blockbumper/Create_0.gml(1): 1
objects/obj_blockcoin/Create_0.gml(1): 67
objects/obj_blockparent/Alarm_0.gml(1): 1
objects/obj_blockparent/Alarm_3.gml(1): 1
objects/obj_blockparent/Other_11.gml(1): 3
objects/obj_blockparent/Other_12.gml(1): 3
objects/obj_blockparent/Other_13.gml(1): 4
objects/obj_blooper/Alarm_0.gml(1): 4
objects/obj_bobomb/Create_0.gml(1): 47
objects/obj_bobomb/Other_11.gml(1): 29
objects/obj_bobomb/Step_0.gml(1): 52
objects/obj_bobomb_hold/Alarm_4.gml(1): 7
objects/obj_bobomb_ready/Alarm_0.gml(1): 7
objects/obj_bonybeetle/Alarm_0.gml(1): 9
objects/obj_bonybeetle/Alarm_1.gml(1): 6
objects/obj_bonybeetle/Other_11.gml(1): 12
objects/obj_bonybeetle/Step_0.gml(1): 62
objects/obj_bonybeetle_b/Alarm_0.gml(1): 9
objects/obj_bonybeetle_b/Other_11.gml(1): 12
objects/obj_boo/Alarm_1.gml(1): 3
objects/obj_boo/Alarm_10.gml(1): 11
objects/obj_boo/Other_7.gml(1): 7
objects/obj_boo/Step_2.gml(1): 21
objects/obj_boomboom/Alarm_10.gml(1): 6
objects/obj_boomboom_b/Alarm_10.gml(1): 6
objects/obj_boomerang/Alarm_0.gml(1): 2
objects/obj_boomerang/Alarm_1.gml(1): 2
objects/obj_boomerang/Alarm_3.gml(1): 5
objects/obj_boomerangbro/Alarm_3.gml(1): 38
objects/obj_boomerangbro/Alarm_7.gml(1): 3
objects/obj_bouncycloud/Step_0.gml(1): 49
objects/obj_bowser_dead/Alarm_0.gml(1): 8
objects/obj_bowser_dead_castle/Alarm_2.gml(1): 8
objects/obj_bowser_dead_castle/Step_0.gml(1): 4
objects/obj_bowser_fire_down/Other_14.gml(1): 36
objects/obj_bowserjr/Alarm_9.gml(1): 10
objects/obj_bowserjr/Create_0.gml(1): 51
objects/obj_bowserjr/Other_11.gml(1): 12
objects/obj_bowserjr_shell/Alarm_0.gml(1): 4
objects/obj_bowserjr_shell/Alarm_1.gml(1): 26
objects/obj_bowserjr_shell/Alarm_11.gml(1): 5
objects/obj_brickhelmet/Create_0.gml(1): 60
objects/obj_bt_close_water/Mouse_4.gml(1): 19
objects/obj_bt_gb_close/Create_0.gml(1): 4
objects/obj_bt_gb_delete/Create_0.gml(1): 5
objects/obj_bt_gb_delete/Mouse_4.gml(1): 5
objects/obj_bt_gb_edit/Mouse_4.gml(1): 7
objects/obj_bt_gb_play/Create_0.gml(1): 8
objects/obj_bt_gb_play/Mouse_4.gml(1): 7
objects/obj_btn_header_1/Mouse_4.gml(1): 5
objects/obj_btn_header_2/Mouse_4.gml(1): 5
objects/obj_btn_header_3/Mouse_4.gml(1): 5
objects/obj_btn_header_4/Mouse_4.gml(1): 5
objects/obj_btn_header_parent/Create_0.gml(1): 4
objects/obj_bullebill_base_red_res/Step_2.gml(1): 56
objects/obj_bullebill_base_res/Step_2.gml(1): 67
objects/obj_bulletbill/Other_11.gml(1): 16
objects/obj_bulletbull_red/Other_11.gml(1): 8
objects/obj_bumper/Create_0.gml(1): 21
objects/obj_button_close/Mouse_4.gml(1): 20
objects/obj_button_close_menu/Mouse_4.gml(1): 11
objects/obj_button_home/Create_0.gml(1): 3
objects/obj_button_notification_aceptar/Mouse_4.gml(1): 15
objects/obj_button_notification_cancelar/Mouse_4.gml(1): 9
objects/obj_button_ok/Create_0.gml(1): 5
objects/obj_button_save_changes/Mouse_4.gml(1): 13
objects/obj_button_settings_close/Create_0.gml(1): 4
objects/obj_button_settings_close2/Create_0.gml(1): 4
objects/obj_button_superado/Create_0.gml(1): 8
objects/obj_button_time/Mouse_4.gml(1): 5
objects/obj_buzzybeetle/Step_0.gml(1): 25
objects/obj_buzzybeetle_b/Step_0.gml(1): 25
objects/obj_cannonball/Create_0.gml(1): 27
objects/obj_cannonball/Other_11.gml(1): 10
objects/obj_cannonball_red/Other_11.gml(1): 7
objects/obj_card_autoavance/Mouse_4.gml(1): 6
objects/obj_card_bg/Mouse_4.gml(1): 6
objects/obj_card_block_sounds/Create_0.gml(1): 7
objects/obj_card_circle/Mouse_4.gml(1): 121
objects/obj_card_condiciones/Mouse_4.gml(1): 6
objects/obj_card_rocket/Step_0.gml(1): 21
objects/obj_chain_chomp_free/Create_0.gml(1): 43
objects/obj_chain_chomp_free_b/Create_0.gml(1): 43
objects/obj_charginchuck/Alarm_0.gml(1): 1
objects/obj_charginchuck/Other_11.gml(1): 32
objects/obj_charginchuck/Other_7.gml(1): 5
objects/obj_checkpoint_res/Create_0.gml(1): 9
objects/obj_cheepcheep/Alarm_1.gml(1): 18
objects/obj_cheepcheep/Create_0.gml(1): 43
objects/obj_cheepcheep2/Alarm_10.gml(1): 17
objects/obj_cheepcheep2/Alarm_2.gml(1): 2
objects/obj_cinta_on_res/Step_2.gml(1): 68
objects/obj_cinta_res/Step_2.gml(1): 96
objects/obj_claw/Collision_obj_egg.gml(1): 15
objects/obj_claw/Collision_obj_enemyparent.gml(1): 23
objects/obj_claw/Collision_obj_holdparent.gml(1): 15
objects/obj_claw/Collision_obj_muncher.gml(1): 18
objects/obj_claw/Collision_obj_podoboo.gml(1): 14
objects/obj_claw/Collision_obj_powerupparent.gml(1): 18
objects/obj_claw/Collision_obj_shell_drybones_held.gml(1): 10
objects/obj_claw/Collision_obj_spike_ball.gml(1): 16
objects/obj_claw/Collision_obj_spring_land.gml(1): 11
objects/obj_claw/Collision_obj_yoshi_abandon.gml(1): 15
objects/obj_claw/Collision_obj_yoshi_runaway.gml(1): 15
objects/obj_claw/Create_0.gml(1): 31
objects/obj_claw/Step_0.gml(1): 216
objects/obj_cloud_lakitu/Alarm_0.gml(1): 5
objects/obj_clown/Alarm_2.gml(1): 8
objects/obj_clown/Alarm_3.gml(1): 4
objects/obj_clown/Create_0.gml(1): 2
objects/obj_clown/Other_13.gml(1): 25
objects/obj_clown_explotion/Collision_obj_block_ice.gml(1): 2
objects/obj_clown_explotion/Collision_obj_block_rock.gml(1): 2
objects/obj_clown_explotion/Collision_obj_blockparent.gml(1): 4
objects/obj_clown_fire/Create_0.gml(1): 40
objects/obj_coin/Create_0.gml(1): 87
objects/obj_coin10/Other_10.gml(1): 16
objects/obj_coin_pow/Alarm_0.gml(1): 5
objects/obj_coinchain/Alarm_0.gml(1): 28
objects/obj_continue_btn/Create_0.gml(1): 4
objects/obj_continue_btn/Mouse_4.gml(1): 7
objects/obj_cooligan/Alarm_0.gml(1): 12
objects/obj_cooligan/Create_0.gml(1): 88
objects/obj_creator_jugar_editar/Alarm_6.gml(1): 4
objects/obj_creator_jugar_editar/Other_10.gml(1): 4
objects/obj_creator_jugar_editar/Other_11.gml(1): 3
objects/obj_crumblebones/Alarm_0.gml(1): 2
objects/obj_crumblebones/Alarm_2.gml(1): 2
objects/obj_curtainin/Create_0.gml(1): 6
objects/obj_donut/Alarm_2.gml(1): 2
objects/obj_donut/Alarm_3.gml(1): 2
objects/obj_donut/Create_0.gml(1): 59
objects/obj_door/Create_0.gml(1): 24
objects/obj_door_lock/Alarm_3.gml(1): 3
objects/obj_door_lock/Create_0.gml(1): 38
objects/obj_door_lock/Other_7.gml(1): 6
objects/obj_door_lock_exit/Alarm_3.gml(1): 3
objects/obj_door_lock_exit/Other_7.gml(1): 6
objects/obj_door_lock_res/Create_0.gml(1): 32
objects/obj_door_res/Create_0.gml(1): 32
objects/obj_door_switch/Create_0.gml(1): 33
objects/obj_door_switch_res/Create_0.gml(1): 32
objects/obj_doormario_exit/Create_0.gml(1): 14
objects/obj_drybones/Other_11.gml(1): 12
objects/obj_drybones/Other_7.gml(1): 24
objects/obj_drybones/Step_0.gml(1): 62
objects/obj_editor_screen/Create_0.gml(1): 9
objects/obj_editormanager/Alarm_2.gml(1): 37
objects/obj_editormanager/Other_13.gml(1): 440
objects/obj_efecto_musica_bonus/Alarm_0.gml(1): 2
objects/obj_efecto_musica_bonus/Create_0.gml(1): 6
objects/obj_efecto_sonido/Create_0.gml(1): 10
objects/obj_egg/Alarm_0.gml(1): 16
objects/obj_egg/Alarm_10.gml(1): 12
objects/obj_egg/Alarm_2.gml(1): 4
objects/obj_egg_blue/Alarm_2.gml(1): 4
objects/obj_egg_hatch/Create_0.gml(1): 12
objects/obj_egg_red/Alarm_2.gml(1): 4
objects/obj_enabledsolid/Create_0.gml(1): 8
objects/obj_enemy_dead/Create_0.gml(1): 13
objects/obj_enemy_dead/Destroy_0.gml(1): 8
objects/obj_enemy_multidead/Alarm_0.gml(1): 7
objects/obj_enemy_multidead/Create_0.gml(1): 3
objects/obj_enemyfrozen/Alarm_4.gml(1): 13
objects/obj_enemyfrozen/Alarm_5.gml(1): 4
objects/obj_enemyfrozen/Alarm_6.gml(1): 3
objects/obj_enemyfrozen/Create_0.gml(1): 20
objects/obj_enemyparent_lava/Create_0.gml(1): 4
objects/obj_erase/Other_10.gml(1): 12
objects/obj_espina/Alarm_0.gml(1): 5
objects/obj_explosion/Collision_obj_block_ice.gml(1): 4
objects/obj_explosion/Collision_obj_block_rock.gml(1): 4
objects/obj_explosion/Collision_obj_blockparent.gml(1): 4
objects/obj_explosion/Create_0.gml(1): 31
objects/obj_fire_clown/Alarm_0.gml(1): 3
objects/obj_fireball/Alarm_0.gml(1): 3
objects/obj_fireball/Create_0.gml(1): 20
objects/obj_fireball_bro/Create_0.gml(1): 20
objects/obj_firebar_res/Step_2.gml(1): 10
objects/obj_firebro/Alarm_3.gml(1): 26
objects/obj_firebro/Alarm_7.gml(1): 3
objects/obj_fishbone/Alarm_0.gml(1): 4
objects/obj_fishbone/Alarm_1.gml(1): 4
objects/obj_flagpole/Create_0.gml(1): 41
objects/obj_flipblock/Alarm_0.gml(1): 1
objects/obj_flipblock/Create_0.gml(1): 116
objects/obj_flipblock/Other_11.gml(1): 3
objects/obj_flipblock/Step_0.gml(1): 22
objects/obj_floruga/Alarm_1.gml(1): 3
objects/obj_floruga/Alarm_10.gml(1): 51
objects/obj_floruga/Alarm_2.gml(1): 9
objects/obj_floruga/Create_0.gml(1): 41
objects/obj_floruga/Step_0.gml(1): 37
objects/obj_frogsuit/Create_0.gml(1): 4
objects/obj_frozenmario/Alarm_0.gml(1): 13
objects/obj_galoomba/Alarm_0.gml(1): 12
objects/obj_galoomba/Alarm_10.gml(1): 11
objects/obj_galoomba/Other_11.gml(1): 19
objects/obj_galoomba2/Other_11.gml(1): 19
objects/obj_galoomba2_b/Other_11.gml(1): 19
objects/obj_galoomba_b/Alarm_10.gml(1): 11
objects/obj_galoomba_b/Other_11.gml(1): 19
objects/obj_game_over/Create_0.gml(1): 11
objects/obj_gb_level/Destroy_0.gml(1): 12
objects/obj_getshoe/Alarm_1.gml(1): 5
objects/obj_goalcard/Alarm_0.gml(1): 3
objects/obj_goalcard/Create_0.gml(1): 2
objects/obj_goalgate_front/Alarm_0.gml(1): 2
objects/obj_goalgate_front/Alarm_1.gml(1): 5
objects/obj_gold_explosion/Collision_obj_rockparent.gml(1): 2
objects/obj_goomba_intro/Alarm_0.gml(1): 2
objects/obj_goomba_intro/Alarm_1.gml(1): 3
objects/obj_goomba_intro/Create_0.gml(1): 3
objects/obj_goomba_res/Step_2.gml(1): 17
objects/obj_grinder/Collision_obj_mario.gml(1): 10
objects/obj_grinder_res/Alarm_0.gml(1): 47
objects/obj_ground/Alarm_5.gml(1): 3
objects/obj_ground/Other_18.gml(1): 3
objects/obj_ground2/Create_0.gml(1): 20
objects/obj_ground2/Mouse_4.gml(1): 7
objects/obj_ground3/Create_0.gml(1): 19
objects/obj_ground3/Mouse_4.gml(1): 7
objects/obj_grrrol/Create_0.gml(1): 18
objects/obj_grrrol_b/Create_0.gml(1): 18
objects/obj_grrrol_new/Create_0.gml(1): 18
objects/obj_guardabot/Create_0.gml(1): 37
objects/obj_hammer_b/Collision_obj_rockparent.gml(1): 2
objects/obj_hammerbro/Alarm_3.gml(1): 35
objects/obj_hammerbro/Alarm_7.gml(1): 3
objects/obj_hammerbro/Other_11.gml(1): 8
objects/obj_hammerbro/Step_0.gml(1): 134
objects/obj_hammersuit/Create_0.gml(1): 4
objects/obj_hen_mushroom/Create_0.gml(1): 12
objects/obj_holdparent/Collision_obj_blockparent.gml(1): 9
objects/obj_holdparent/Collision_obj_mario.gml(1): 33
objects/obj_icebro/Alarm_3.gml(1): 26
objects/obj_icebro/Alarm_7.gml(1): 3
objects/obj_icecoin/Collision_obj_explosion.gml(1): 2
objects/obj_icecoin/Create_0.gml(1): 58
objects/obj_icicle/Alarm_2.gml(1): 2
objects/obj_icicle/Create_0.gml(1): 10
objects/obj_icicle2/Create_0.gml(1): 9
objects/obj_intro_controller/Alarm_1.gml(1): 11
objects/obj_intro_controller/Create_0.gml(1): 4
objects/obj_intro_controller/KeyPress_13.gml(1): 2
objects/obj_intro_controller/Mouse_53.gml(1): 2
objects/obj_intro_controller/Step_2.gml(1): 19
objects/obj_invincibility/Alarm_0.gml(1): 3
objects/obj_invincibility/Alarm_1.gml(1): 6
objects/obj_invincibility/Alarm_2.gml(1): 13
objects/obj_invincibility/Alarm_3.gml(1): 10
objects/obj_jumppiranha/Alarm_0.gml(1): 11
objects/obj_jumppiranha/Alarm_1.gml(1): 10
objects/obj_jumppiranha/Other_14.gml(1): 24
objects/obj_jumppiranha/Step_0.gml(1): 88
objects/obj_key_appear/Alarm_1.gml(1): 13
objects/obj_key_appear/Create_0.gml(1): 27
objects/obj_key_appear/Step_0.gml(1): 5
objects/obj_koopa/Alarm_10.gml(1): 15
objects/obj_koopa/Create_0.gml(1): 46
objects/obj_koopa_b/Alarm_10.gml(1): 15
objects/obj_koopa_b/Create_0.gml(1): 47
objects/obj_koopa_red/Alarm_10.gml(1): 15
objects/obj_koopa_red/Create_0.gml(1): 44
objects/obj_koopa_red_b/Alarm_10.gml(1): 15
objects/obj_koopa_red_b/Create_0.gml(1): 43
objects/obj_kuribo_drybones/Alarm_6.gml(1): 2
objects/obj_kuribo_drybones/Create_0.gml(1): 25
objects/obj_kuriboshoe/Alarm_0.gml(1): 171
objects/obj_kuriboshoe/Alarm_1.gml(1): 4
objects/obj_kuriboshoe/Create_0.gml(1): 7
objects/obj_kuriboshoe2/Create_0.gml(1): 7
objects/obj_lakitu/Alarm_2.gml(1): 11
objects/obj_lakitu/Step_0.gml(1): 68
objects/obj_lava_lift/Alarm_2.gml(1): 2
objects/obj_lava_lift/Alarm_3.gml(1): 2
objects/obj_levelmanager/Alarm_11.gml(1): 51
objects/obj_levelmanager/Alarm_5.gml(1): 2
objects/obj_levelmanager/Other_11.gml(1): 4
objects/obj_levelmanager/Other_18.gml(1): 7
objects/obj_levelmanager/Other_5.gml(1): 2
objects/obj_levelmanager/Step_2.gml(1): 304
objects/obj_link/Create_0.gml(1): 11
objects/obj_link/Other_17.gml(1): 3
objects/obj_link/Step_0.gml(1): 45
objects/obj_link_bomb/Alarm_10.gml(1): 10
objects/obj_link_bomb/Alarm_5.gml(1): 2
objects/obj_link_bomb/Collision_obj_link_atack.gml(1): 16
objects/obj_link_bomb/Collision_obj_link_down_atack.gml(1): 15
objects/obj_link_bomb/Collision_obj_spike_ball.gml(1): 1
objects/obj_link_bomb/Other_12.gml(1): 24
objects/obj_link_down_atack/Other_10.gml(1): 8
objects/obj_load_btn_c/Create_0.gml(1): 4
objects/obj_load_guardabot/Other_11.gml(1): 55
objects/obj_logo_game/Mouse_4.gml(1): 6
objects/obj_lp/Create_0.gml(1): 10
objects/obj_magic/Alarm_0.gml(1): 6
objects/obj_magic/Create_0.gml(1): 21
objects/obj_magikoopa/Alarm_0.gml(1): 30
objects/obj_magikoopa/Step_0.gml(1): 52
objects/obj_mario/Alarm_1.gml(1): 9
objects/obj_mario/Alarm_2.gml(1): 4
objects/obj_mario/Alarm_5.gml(1): 21
objects/obj_mario/Alarm_7.gml(1): 20
objects/obj_mario/Alarm_9.gml(1): 2
objects/obj_mario/Other_13.gml(1): 365
objects/obj_mario/Other_17.gml(1): 11
objects/obj_mario/Other_18.gml(1): 5
objects/obj_mario_editor/Alarm_0.gml(1): 34
objects/obj_mario_editor/Other_11.gml(1): 5
objects/obj_mario_intro/Collision_obj_thwomp_intro.gml(1): 3
objects/obj_mario_temp/Create_0.gml(1): 9
objects/obj_mario_transform2/Alarm_1.gml(1): 11
objects/obj_mario_transform2/Alarm_2.gml(1): 11
objects/obj_mario_transform2/Alarm_3.gml(1): 11
objects/obj_mario_transform2/Destroy_0.gml(1): 22
objects/obj_mariostart_m/Alarm_0.gml(1): 2
objects/obj_mariostart_m/KeyPress_32.gml(1): 2
objects/obj_mechakoopa/Alarm_10.gml(1): 8
objects/obj_mechakoopa/Alarm_11.gml(1): 8
objects/obj_mechakoopa/Create_0.gml(1): 37
objects/obj_mechakoopa_held/Alarm_0.gml(1): 2
objects/obj_mechakoopa_held/Alarm_2.gml(1): 9
objects/obj_mechakoopa_held/Alarm_4.gml(1): 2
objects/obj_mechakoopa_held/Other_7.gml(1): 2
objects/obj_megamushroom/Create_0.gml(1): 10
objects/obj_menu_editor_ext/Create_0.gml(1): 2
objects/obj_menu_pausa/Other_11.gml(1): 40
objects/obj_meteorites/Alarm_0.gml(1): 6
objects/obj_meteorites/Create_0.gml(1): 20
objects/obj_meteorites_big/Alarm_0.gml(1): 10
objects/obj_meteorites_big/Create_0.gml(1): 20
objects/obj_meteorites_maker/Alarm_0.gml(1): 4
objects/obj_meteorites_maker/Alarm_1.gml(1): 5
objects/obj_meteorites_maker/Alarm_10.gml(1): 4
objects/obj_meteorites_maker/Alarm_2.gml(1): 4
objects/obj_meteorites_maker/Alarm_3.gml(1): 4
objects/obj_meteorites_maker/Alarm_4.gml(1): 4
objects/obj_meteorites_maker/Alarm_5.gml(1): 4
objects/obj_meteorites_maker/Alarm_6.gml(1): 4
objects/obj_meteorites_maker/Alarm_7.gml(1): 4
objects/obj_meteorites_maker/Alarm_8.gml(1): 4
objects/obj_meteorites_maker/Alarm_9.gml(1): 4
objects/obj_meteorites_maker/Create_0.gml(1): 1
objects/obj_modelsizable/Create_0.gml(1): 7
objects/obj_modelsizable/Other_10.gml(1): 60
objects/obj_modelsizable/Other_11.gml(1): 31
objects/obj_modelsizable/Other_12.gml(1): 11
objects/obj_modelsolid/Create_0.gml(1): 2
objects/obj_monty_chase/Create_0.gml(1): 38
objects/obj_monty_chase/Step_0.gml(1): 80
objects/obj_multiveggiecoin/Alarm_0.gml(1): 10
objects/obj_multiveggiecoin/Alarm_1.gml(1): 2
objects/obj_multiveggiecoin/Create_0.gml(1): 4
objects/obj_muncher/Alarm_0.gml(1): 22
objects/obj_muncher/Alarm_9.gml(1): 15
objects/obj_muncher_res/Alarm_0.gml(1): 42
objects/obj_mushroom/Alarm_10.gml(1): 23
objects/obj_mushroom/Create_0.gml(1): 35
objects/obj_mushroom_platform_res/Alarm_0.gml(1): 47
objects/obj_mushroom_platform_res/Create_0.gml(1): 14
objects/obj_musicblock/Alarm_1.gml(1): 37
objects/obj_ninji/Alarm_0.gml(1): 28
objects/obj_ninji/Create_0.gml(1): 28
objects/obj_ninji/Step_0.gml(1): 25
objects/obj_noteblock/Alarm_0.gml(1): 1
objects/obj_noteblock/Alarm_1.gml(1): 36
objects/obj_noteblock/Alarm_3.gml(1): 1
objects/obj_noteblock/Other_10.gml(1): 9
objects/obj_noteblock/Other_11.gml(1): 10
objects/obj_noti_load_button/Create_0.gml(1): 3
objects/obj_nube/Collision_obj_thwomp.gml(1): 9
objects/obj_oneway_res/Create_0.gml(1): 7
objects/obj_onoffblock/Other_10.gml(1): 62
objects/obj_onoffblock/Other_11.gml(1): 3
objects/obj_panel_time/Mouse_4.gml(1): 6
objects/obj_parcarry/Create_0.gml(1): 29
objects/obj_parcarry/Step_0.gml(1): 24
objects/obj_parent_resource/Alarm_0.gml(1): 52
objects/obj_parent_sounds/Alarm_0.gml(1): 47
objects/obj_pausa_button/Create_0.gml(1): 6
objects/obj_pausa_button/Mouse_4.gml(1): 29
objects/obj_pballon/Create_0.gml(1): 28
objects/obj_persistent/Other_10.gml(1): 10
objects/obj_persistent/Other_11.gml(1): 6
objects/obj_persistent/Other_16.gml(1): 3
objects/obj_persistent/Other_4.gml(1): 30
objects/obj_persistent/Other_5.gml(1): 6
objects/obj_pinchos/Create_0.gml(1): 112
objects/obj_pink_coin/Alarm_0.gml(1): 6
objects/obj_pink_coin/Create_0.gml(1): 26
objects/obj_piranhaplant/Alarm_1.gml(1): 19
objects/obj_piranhaplant/Alarm_3.gml(1): 5
objects/obj_plant_fire/Alarm_2.gml(1): 15
objects/obj_plant_fire/Alarm_3.gml(1): 17
objects/obj_plant_fire/Alarm_4.gml(1): 6
objects/obj_plant_fire/Step_2.gml(1): 5
objects/obj_plantfire/Create_0.gml(1): 17
objects/obj_plataforma/Alarm_1.gml(1): 17
objects/obj_plataforma/Create_0.gml(1): 6
objects/obj_plataforma_blue/Create_0.gml(1): 25
objects/obj_platform_blue_res/Create_0.gml(1): 13
objects/obj_platform_res/Create_0.gml(1): 13
objects/obj_play_screen/Mouse_4.gml(1): 2
objects/obj_player_goal_nsmbu/Alarm_4.gml(1): 6
objects/obj_player_goal_nsmbu/Other_7.gml(1): 5
objects/obj_player_goal_smb1/Alarm_2.gml(1): 12
objects/obj_player_goal_smb1/Alarm_4.gml(1): 6
objects/obj_player_goal_smb1/Collision_obj_flagpole.gml(1): 14
objects/obj_player_goal_smw/Alarm_2.gml(1): 10
objects/obj_player_goal_smw_castle/Step_0.gml(1): 23
objects/obj_player_warp/Step_0.gml(1): 36
objects/obj_podoboo/Alarm_0.gml(1): 6
objects/obj_podoboo/Collision_obj_bobomb.gml(1): 10
objects/obj_podoboo/Create_0.gml(1): 36
objects/obj_podoboo_b/Create_0.gml(1): 36
objects/obj_pokey/Alarm_0.gml(1): 22
objects/obj_pokey/Alarm_11.gml(1): 8
objects/obj_pokey/Alarm_9.gml(1): 15
objects/obj_pokey_res/Create_0.gml(1): 13
objects/obj_pokey_res/Step_2.gml(1): 93
objects/obj_powerupparent/Create_0.gml(1): 26
objects/obj_powerupparent/Step_0.gml(1): 51
objects/obj_powerupsprout/Create_0.gml(1): 8
objects/obj_powerupsprout_note/Alarm_0.gml(1): 59
objects/obj_powerupsprout_note/Create_0.gml(1): 8
objects/obj_propellershroom/Alarm_10.gml(1): 5
objects/obj_propellershroom/Create_0.gml(1): 12
objects/obj_pswitch/Create_0.gml(1): 31
objects/obj_pswitch/Other_17.gml(1): 11
objects/obj_puente_res/Create_0.gml(1): 12
objects/obj_puente_res/Step_2.gml(1): 199
objects/obj_rails_res/Create_0.gml(1): 16
objects/obj_rails_res/Step_2.gml(1): 36
objects/obj_rename_input/Create_0.gml(1): 3
objects/obj_rocangrejo/Alarm_0.gml(1): 32
objects/obj_rocangrejo/Alarm_1.gml(1): 23
objects/obj_rocangrejo/Create_0.gml(1): 39
objects/obj_rocky/Alarm_0.gml(1): 4
objects/obj_rocky/Alarm_2.gml(1): 11
objects/obj_rocky/Alarm_3.gml(1): 4
objects/obj_rocky/Other_16.gml(1): 8
objects/obj_rocky/Other_7.gml(1): 6
objects/obj_score_flag/Step_0.gml(1): 7
objects/obj_semisolid_platform1/Alarm_0.gml(1): 49
objects/obj_semisolid_platform1/Create_0.gml(1): 14
objects/obj_shell_drybones/Create_0.gml(1): 4
objects/obj_shell_held/Alarm_0.gml(1): 9
objects/obj_shell_held/Alarm_11.gml(1): 5
objects/obj_shell_held/Step_0.gml(1): 47
objects/obj_shell_intro/Create_0.gml(1): 2
objects/obj_skewer_res/Create_0.gml(1): 7
objects/obj_skewertrunk/Create_0.gml(1): 51
objects/obj_sledgebro/Alarm_2.gml(1): 3
objects/obj_sledgebro/Alarm_4.gml(1): 41
objects/obj_sledgebro/Other_11.gml(1): 8
objects/obj_slider/Alarm_0.gml(1): 17
objects/obj_slider/Create_0.gml(1): 13
objects/obj_slider/Other_10.gml(1): 3
objects/obj_snow_ball_held/Other_15.gml(1): 5
objects/obj_snowball/Alarm_0.gml(1): 8
objects/obj_snowball/Create_0.gml(1): 8
objects/obj_soplete/Collision_obj_bobomb.gml(1): 11
objects/obj_soplete/Create_0.gml(1): 27
objects/obj_soplete_global/Alarm_1.gml(1): 5
objects/obj_soplete_global/Create_0.gml(1): 26
objects/obj_soplete_global/Other_7.gml(1): 9
objects/obj_soplete_invert/Create_0.gml(1): 27
objects/obj_soplete_invert_global/Alarm_1.gml(1): 5
objects/obj_soplete_invert_global/Create_0.gml(1): 26
objects/obj_soplete_invert_global/Other_7.gml(1): 9
objects/obj_spike/Other_7.gml(1): 8
objects/obj_spike_ball/Alarm_10.gml(1): 21
objects/obj_spike_ball/Alarm_11.gml(1): 5
objects/obj_spike_ball/Create_0.gml(1): 33
objects/obj_spike_ball/Step_0.gml(1): 144
objects/obj_spike_ball_b/Create_0.gml(1): 33
objects/obj_spinsmoke/Alarm_0.gml(1): 4
objects/obj_spiny/Alarm_1.gml(1): 18
objects/obj_spiny/Alarm_10.gml(1): 15
objects/obj_spiny/Alarm_2.gml(1): 25
objects/obj_spiny/Alarm_3.gml(1): 12
objects/obj_spiny/Create_0.gml(1): 39
objects/obj_spring_land/Alarm_0.gml(1): 22
objects/obj_spring_land/Alarm_9.gml(1): 15
objects/obj_star/Create_0.gml(1): 26
objects/obj_stomped/Create_0.gml(1): 4
objects/obj_superball/Alarm_1.gml(1): 2
objects/obj_thwomp/Create_0.gml(1): 45
objects/obj_thwomp_b/Create_0.gml(1): 46
objects/obj_thwomp_intro/Alarm_0.gml(1): 2
objects/obj_thwomp_intro/Alarm_2.gml(1): 2
objects/obj_thwomp_intro/Create_0.gml(1): 1
objects/obj_tile_trigger/Create_0.gml(1): 1
objects/obj_timeup/Other_7.gml(1): 6
objects/obj_title_controller/Step_2.gml(1): 23
objects/obj_title_oprime/Alarm_0.gml(1): 2
objects/obj_title_oprime/Alarm_1.gml(1): 2
objects/obj_title_oprime/Create_0.gml(1): 14
objects/obj_titlemenu_key/Create_0.gml(1): 6
objects/obj_toast/Create_0.gml(1): 3
objects/obj_tongue/Collision_obj_bone.gml(1): 5
objects/obj_tongue/Collision_obj_bowser_fire.gml(1): 5
objects/obj_tongue/Collision_obj_bowser_fire_down.gml(1): 5
objects/obj_tongue/Collision_obj_brohammer.gml(1): 5
objects/obj_tongue/Collision_obj_coin10.gml(1): 5
objects/obj_tongue/Collision_obj_plantfire.gml(1): 5
objects/obj_tongue/Collision_obj_powerupparent.gml(1): 5
objects/obj_tongue/Collision_obj_pswitch.gml(1): 5
objects/obj_tongue/Collision_obj_spike_ball.gml(1): 5
objects/obj_tongue/Collision_obj_spring_land.gml(1): 5
objects/obj_tongue_blue/Collision_obj_bone.gml(1): 5
objects/obj_tongue_blue/Collision_obj_bowser_fire.gml(1): 5
objects/obj_tongue_blue/Collision_obj_bowser_fire_down.gml(1): 5
objects/obj_tongue_blue/Collision_obj_brohammer.gml(1): 5
objects/obj_tongue_blue/Collision_obj_coin10.gml(1): 5
objects/obj_tongue_blue/Collision_obj_plantfire.gml(1): 5
objects/obj_tongue_blue/Collision_obj_powerupparent.gml(1): 5
objects/obj_tongue_blue/Collision_obj_pswitch.gml(1): 5
objects/obj_tongue_blue/Collision_obj_spike_ball.gml(1): 5
objects/obj_tongue_blue/Collision_obj_spring_land.gml(1): 5
objects/obj_tuberia_res/Step_2.gml(1): 199
objects/obj_ventana/Destroy_0.gml(1): 12
objects/obj_ventana_mario/Destroy_0.gml(1): 7
objects/obj_vine_res/Create_0.gml(1): 12
objects/obj_vsync/Mouse_4.gml(1): 10
objects/obj_waddlewing/Alarm_0.gml(1): 12
objects/obj_waddlewing/Alarm_10.gml(1): 11
objects/obj_water_move/Alarm_0.gml(1): 21
objects/obj_water_move/Mouse_4.gml(1): 13
objects/obj_water_move_limit/Alarm_0.gml(1): 54
objects/obj_water_move_limit/Mouse_4.gml(1): 14
objects/obj_wrench/Alarm_0.gml(1): 5
objects/obj_yoshi2/Alarm_1.gml(1): 2
objects/obj_yoshi2/Step_2.gml(1): 23
objects/obj_yoshi_abandon/Alarm_2.gml(1): 3
objects/obj_yoshifire/Create_0.gml(1): 6
scripts/init_shake/init_shake.gml(1): 7
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_1up/Alarm_10.gml:32 | `alarm[10] = 2` |
| objects/obj_SMB3_bowser/Create_0.gml:15 | `alarm[10] = 2` |
| objects/obj_block_hidden/Collision_obj_spinner.gml:9 | `alarm[0] = 4` |
| objects/obj_bowserjr/Alarm_10.gml:1 | `alarm[0] = 1` |
| objects/obj_card_block_sounds/Create_0.gml:7 | `alarm[0] = 120` |
| objects/obj_crystalorb/Collision_obj_mario.gml:25 | `alarm[2] = 0` |
| objects/obj_editormanager/Other_10.gml:211 | `alarm[2] = -1` |
| objects/obj_floruga/Step_0.gml:37 | `alarm[10] = 10` |
| objects/obj_holdparent/Collision_obj_mario.gml:33 | `alarm[3] = 15` |
| objects/obj_lava_lift/Other_11.gml:27 | `alarm[2] = 249` |
| objects/obj_mario_transform2/Other_10.gml:196 | `alarm[0] = -1` |
| objects/obj_plantfire/Alarm_0.gml:4 | `alarm[0] = 10` |
| objects/obj_shell_drybones_held/Other_13.gml:44 | `alarm[0] = 4` |
| objects/obj_spiny/Other_15.gml:21 | `imheld.alarm[4] = 640` |

### 3.3 碰撞函数

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| place_*: `\b(place_meeting\|place_free\|place_empty\|place_snapped)\s*\(` | 365 | 161 |
| instance_place*/position*: `\b(instance_place\|instance_place_list\|instance_position\|instance_position_list\|position_meeting\|position_empty)\s*\(` | 56 | 20 |
| collision_*: `\bcollision_(point\|rectangle\|circle\|line\|ellipse)\w*\s*\(` | 1922 | 344 |
| move_contact/outside/bounce: `\b(move_contact_solid\|move_contact_all\|move_outside_solid\|move_outside_all\|move_bounce_solid\|move_bounce_all)\s*\(` | 0 | 0 |
| 其他碰撞相关: `\b(distance_to_object\|distance_to_point\|instance_nearest\|instance_furthest\|tilemap_get_at_pixel\|tile_layer_find\|tilemap_\w+\|place_snapped\|mp_\w+\|physics_\w+)\s*\(` | 8 | 3 |
| **并集（本类合计）** | **2207** | **438** |

Collision 事件（eventType=4，文件名 Collision_<目标object>.gml）：527 个事件，分布于 179 个 object（路径 `objects/<object>/<事件文件>.gml`，来源 `objects/<object>/<object>.yy` 的 `eventList`）：

<details><summary>展开 object → 事件列表</summary>

```
obj_1up: Collision_obj_blockparent, Collision_obj_mario
obj_NSMBU_bowser: Collision_obj_blockparent, Collision_obj_mario
obj_NSMBU_flag_mario: Collision_obj_flagpole
obj_SMB2_mushroom: Collision_obj_blockparent, Collision_obj_mario
obj_SMB3_bowser: Collision_obj_blockparent, Collision_obj_mario
obj_SMB_bowser: Collision_obj_blockparent, Collision_obj_mario
obj_SMB_castle_front: Collision_obj_player_goal_smb1, Collision_obj_player_goal_nsmbu
obj_SMB_flag: Collision_obj_flagpole
obj_SMW_bowser: Collision_obj_blockparent, Collision_obj_mario
obj_angrysun: Collision_obj_mario
obj_arrow_lock: Collision_obj_parent_resource
obj_axe_smw: Collision_obj_mario
obj_banzaibill: Collision_obj_blockparent
obj_beachkoopa: Collision_obj_shell, Collision_obj_blockparent, Collision_obj_mario
obj_beachkoopa_b: Collision_obj_shell
obj_beachkoopa_red: Collision_obj_shell
obj_beachkoopa_red_b: Collision_obj_shell
obj_beanstalk: Collision_obj_solidtop, Collision_obj_solid
obj_block_hidden: Collision_obj_shell_held, Collision_obj_shell, Collision_obj_spinner
obj_block_hidden_res: Collision_obj_parent_resource
obj_block_pow_hold: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_boomboom, Collision_obj_thwomp, Collision_obj_mario
obj_block_res: Collision_obj_parent_resource
obj_blockbumper: Collision_obj_blockparent, Collision_obj_enemyparent
obj_blockparent: Collision_obj_meteorites, Collision_obj_meteorites_big, Collision_obj_mario
obj_blooper: Collision_obj_mario
obj_bones_yoshi: Collision_obj_shell, Collision_obj_enemyparent
obj_bones_yoshi_one: Collision_obj_shell, Collision_obj_enemyparent
obj_bonus_or: Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw
obj_boo: Collision_obj_blockparent
obj_boomerang: Collision_obj_mario
obj_bortice: Collision_obj_holdparent, Collision_obj_physicsparent, Collision_obj_muncher, Collision_obj_thwomp, Collision_obj_mario
obj_boss_or: Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw
obj_bossparent: Collision_obj_link_atack, Collision_obj_link_arrow, Collision_obj_link_down_atack, Collision_obj_link_dash_atack, Collision_obj_shell_held, Collision_obj_hammer, Collision_obj_superball, Collision_obj_fireball, Collision_obj_yoshifire, Collision_obj_enemyparent_held, Collision_obj_icicle, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_mario
obj_bowser_fire: Collision_obj_shield_right, Collision_obj_shield_left, Collision_obj_invincibility, Collision_obj_helmet, Collision_obj_kuribo_drybones, Collision_obj_mario
obj_bowser_fire_down: Collision_obj_invincibility, Collision_obj_helmet, Collision_obj_blockparent, Collision_obj_mario
obj_bowserjr_shell: Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_enemyparent
obj_brickhelmet: Collision_obj_mario
obj_brohammer: Collision_obj_invincibility, Collision_obj_mario
obj_brohammer_yoshi: Collision_obj_enemyparent_held, Collision_obj_enemyparent
obj_bullebill_base: Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_mario
obj_bullebill_base_red_res: Collision_obj_parent_resource
obj_bullebill_base_res: Collision_obj_parent_resource
obj_bulletbill: Collision_obj_blockparent
obj_bulletbull_red: Collision_obj_blockparent
obj_bumper: Collision_obj_clown, Collision_obj_mario
obj_cannonball: Collision_obj_blockparent
obj_cap: Collision_obj_mario
obj_cap_mario: Collision_obj_bowser_fire_down, Collision_obj_bowser_fire, Collision_obj_wrench, Collision_obj_holdparent, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_spike_ball
obj_castle_front: Collision_obj_player_goal_smb1, Collision_obj_player_goal_nsmbu
obj_checkpoint: Collision_obj_mario, Collision_obj_shell_held
obj_checkpoint_res: Collision_obj_parent_resource
obj_cheepcheep: Collision_obj_mario
obj_cinta_on_res: Collision_obj_parent_resource
obj_cinta_res: Collision_obj_parent_resource
obj_claw: Collision_obj_shell_drybones_held, Collision_obj_shell_held, Collision_obj_yoshi_abandon, Collision_obj_yoshi_runaway, Collision_obj_egg, Collision_obj_holdparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_spring_land, Collision_obj_muncher, Collision_obj_podoboo, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_mario
obj_cloud_lakitu: Collision_obj_mario
obj_clown: Collision_(yy缺collisionObjectId), Collision_obj_holdparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_pinchos, Collision_obj_boomboom, Collision_obj_mario
obj_clown_explotion: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_block_ice, Collision_obj_block_rock
obj_coin: Collision_obj_link_arrow, Collision_obj_shell_held, Collision_obj_superball, Collision_obj_clown, Collision_obj_spinner, Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_mario, Collision_obj_player_goal_parent
obj_coin10: Collision_obj_link_arrow, Collision_obj_shell_held, Collision_obj_enemyparent_held, Collision_obj_player_goal_parent, Collision_obj_mario
obj_coin_pow: Collision_obj_mario
obj_coinchain: Collision_obj_slopeparent
obj_crystalorb: Collision_obj_mario
obj_egg: Collision_obj_mario
obj_egg_hatch: Collision_obj_mario
obj_enemyparent: Collision_obj_blockparent, Collision_obj_mario
obj_enemyparent_held: Collision_obj_explosion, Collision_obj_shell_held, Collision_obj_invincibility, Collision_obj_fireball, Collision_(yy缺collisionObjectId), Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent
obj_enemyparent_lava: Collision_obj_mario
obj_espina: Collision_obj_mario
obj_explosion: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_block_ice, Collision_obj_block_rock, Collision_obj_onoffblock, Collision_obj_mario
obj_fire_clown: Collision_obj_enemyparent, Collision_obj_onoffblock, Collision_obj_boomboom, Collision_obj_bobomb
obj_fireball: Collision_obj_bobomb_hold, Collision_obj_enemyparent, Collision_obj_bobomb, Collision_obj_grrrol, Collision_obj_spike_ball
obj_fireball_bro: Collision_obj_bobomb_hold, Collision_obj_enemyparent, Collision_obj_bobomb, Collision_obj_mario
obj_flagpole: Collision_obj_marioU, Collision_obj_mario
obj_frogsuit: Collision_obj_mario
obj_getshoe: Collision_obj_mario
obj_goalcard: Collision_obj_mario
obj_goalgate_tape: Collision_obj_mario
obj_gold_explosion: Collision_obj_enemyparent_held, Collision_obj_rockparent, Collision_obj_blockparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_muncher, Collision_obj_snow_ball, Collision_obj_spike_ball
obj_gotas: Collision_obj_helmet, Collision_obj_pinchos, Collision_obj_solidtop
obj_grinder: Collision_obj_clown, Collision_obj_helmet, Collision_obj_blockparent, Collision_obj_mario
obj_ground: Collision_obj_tile_trigger
obj_groundparent: Collision_obj_parent_resource
obj_groundpount: Collision_obj_blockparent
obj_grrrol: Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_spike_ball
obj_grrrol_b: Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_spike_ball
obj_grrrol_new: Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_spike_ball
obj_hammer: Collision_obj_brohammer, Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_bowserjr_shell, Collision_obj_spike_ball
obj_hammer_b: Collision_obj_rockparent, Collision_obj_enemyparent
obj_hammersuit: Collision_obj_mario
obj_helmet: Collision_obj_brohammer, Collision_obj_shell_held, Collision_obj_cannonball, Collision_obj_bone, Collision_obj_espina, Collision_obj_plantfire, Collision_obj_clown, Collision_obj_holdparent, Collision_obj_physicsparent, Collision_obj_muncher, Collision_obj_banzaibill, Collision_obj_bulletbull_red, Collision_obj_bulletbill, Collision_obj_thwomp, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_buzzy_ceiling, Collision_obj_mario
obj_helmet_spiny: Collision_obj_shell_held, Collision_obj_shell, Collision_obj_holdparent, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_physicsparent, Collision_obj_muncher, Collision_obj_thwomp
obj_hen_mushroom: Collision_obj_blockparent, Collision_obj_mario
obj_holdparent: Collision_obj_blockparent, Collision_obj_mario
obj_icecoin: Collision_obj_explosion, Collision_obj_bowser_fire, Collision_obj_plantfire, Collision_obj_fire_clown, Collision_obj_yoshifire, Collision_obj_soplete, Collision_obj_podoboo, Collision_obj_angrysun, Collision_obj_cheepcheep
obj_icicle: Collision_obj_helmet, Collision_obj_pinchos, Collision_obj_solidtop, Collision_obj_mario
obj_invincibility: Collision_obj_enemyparent_held, Collision_obj_bossparent, Collision_obj_enemyparent
obj_key: Collision_obj_link_arrow, Collision_obj_shell_held, Collision_obj_enemyparent_held, Collision_obj_snow_ball_held, Collision_obj_mario
obj_key_appear: Collision_obj_player_warp, Collision_obj_doormario, Collision_obj_mario
obj_lakitu_res: Collision_obj_parent_resource
obj_link: Collision_obj_mario
obj_link_arrow: Collision_obj_link_bomb, Collision_obj_physicssolid, Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_onewaygate_bottom, Collision_obj_onewaygate_left, Collision_obj_onewaygate_right, Collision_obj_block_pow_hold, Collision_obj_spring_land, Collision_obj_solidtop, Collision_obj_solid, Collision_obj_bullebill_base, Collision_obj_spike_ball
obj_link_atack: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_grrrol, Collision_obj_spike_ball
obj_link_bomb: Collision_obj_link_atack, Collision_obj_link_down_atack, Collision_obj_spike_ball
obj_link_dash_atack: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_spike_ball
obj_link_down_atack: Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_onewaygate_bottom, Collision_obj_block_pow_hold, Collision_obj_grinder, Collision_obj_spike_ball
obj_magic: Collision_obj_helmet, Collision_obj_mario
obj_mario_intro: Collision_obj_shell_intro, Collision_obj_thwomp_intro
obj_meteorites: Collision_obj_mario
obj_meteorites_big: Collision_obj_mario
obj_modelbgo: Collision_obj_mario
obj_multiveggiecoin: Collision_obj_mario
obj_muncher: Collision_obj_shield_right, Collision_obj_shield_left
obj_mushroom: Collision_obj_blockparent, Collision_obj_mario
obj_mushroom_platform_res: Collision_obj_parent_resource
obj_n64_or: Collision_obj_mario, Collision_obj_player_goal_smb1, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smw
obj_noteblock: Collision_obj_mario
obj_noteblock_res: Collision_obj_parent_resource
obj_nube: Collision_obj_thwomp
obj_nube_res: Collision_obj_parent_resource
obj_oneway_res: Collision_obj_parent_resource
obj_parcarry: Collision_obj_enemyparent
obj_parent_resource: Collision_(yy缺collisionObjectId), Collision_obj_key_res
obj_parent_sound_o: Collision_obj_player_goal_smw, Collision_obj_player_goal_smb3, Collision_obj_player_goal_smb1, Collision_obj_mario
obj_parent_sounds: Collision_obj_parent_resource
obj_pballon: Collision_obj_mario
obj_penguin_attack: Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_enemyparent
obj_physicsparent: Collision_obj_blockparent
obj_physicssolid: Collision_obj_enemyparent_held, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_mario
obj_pink_coin: Collision_obj_link_arrow, Collision_obj_shell_held, Collision_obj_enemyparent_held, Collision_obj_snow_ball_held, Collision_obj_snow_ball, Collision_obj_mario
obj_piranhaplant: Collision_obj_mario
obj_plantfire: Collision_obj_pinchos, Collision_obj_muncher, Collision_obj_solidtop, Collision_obj_solid, Collision_obj_bullebill_base, Collision_obj_mario
obj_player_goal_nsmbu: Collision_obj_flagpole
obj_player_goal_smb1: Collision_obj_flagpole
obj_podoboo: Collision_obj_bobomb
obj_pokey_res: Collision_obj_parent_resource
obj_powerupparent: Collision_obj_blockparent, Collision_obj_mario
obj_pswitch: Collision_obj_link_arrow, Collision_obj_superball, Collision_obj_clown, Collision_obj_physicssolid, Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_icicle, Collision_obj_bullebill_base, Collision_obj_mario
obj_puente_res: Collision_obj_parent_resource
obj_qblock_res: Collision_obj_parent_resource
obj_quicksand: Collision_obj_mario
obj_rails_res: Collision_obj_parent_resource
obj_rockparent: Collision_obj_meteorites, Collision_obj_meteorites_big
obj_semisolid_platform1: Collision_obj_parent_resource
obj_shell: Collision_obj_mario
obj_shell_drybones: Collision_obj_fireball, Collision_obj_mario
obj_shell_empty: Collision_obj_fireball
obj_shell_held: Collision_obj_enemyparent, Collision_obj_mario
obj_shield_left: Collision_obj_wrench, Collision_obj_cannonball, Collision_obj_banzaibill, Collision_obj_bulletbull_red, Collision_obj_bulletbill, Collision_obj_lakitu
obj_shield_right: Collision_obj_wrench, Collision_obj_cannonball, Collision_obj_banzaibill, Collision_obj_bulletbull_red, Collision_obj_bulletbill, Collision_obj_lakitu
obj_skewertrunk: Collision_obj_thwomp_b
obj_slider: Collision_obj_enemyparent
obj_slopesa: Collision_obj_tile_trigger
obj_smoke_shoe: Collision_obj_shell, Collision_obj_enemyparent, Collision_obj_muncher
obj_snow_ball: Collision_obj_enemyparent, Collision_obj_mario
obj_snow_ball_b: Collision_obj_mario
obj_snow_ball_held: Collision_obj_enemyparent, Collision_obj_snow_ball, Collision_obj_mario
obj_snowball: Collision_obj_shell, Collision_obj_bowser_fire, Collision_obj_magic, Collision_obj_plantfire, Collision_obj_bossparent, Collision_obj_enemyparent, Collision_obj_podoboo, Collision_obj_grrrol, Collision_obj_snow_ball_held, Collision_obj_snow_ball, Collision_obj_spike_ball
obj_snowball_bro: Collision_obj_frozenmario, Collision_obj_fireball, Collision_obj_snow_ball, Collision_obj_mario, Collision_obj_enemyparent
obj_soplete: Collision_obj_bobomb, Collision_obj_mario
obj_spike_ball: Collision_obj_invincibility, Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_physicsparent, Collision_obj_mario
obj_spinner: Collision_obj_shell, Collision_obj_bowser_fire_down, Collision_obj_bowser_fire, Collision_obj_wrench, Collision_obj_enemyparent_held, Collision_obj_blockparent, Collision_obj_enemyparent, Collision_obj_spike_ball
obj_spring: Collision_obj_holdparent, Collision_obj_powerupparent, Collision_obj_physicsparent, Collision_obj_mario
obj_spring_land: Collision_obj_shell, Collision_obj_holdparent, Collision_obj_physicsparent, Collision_obj_block_pow_hold, Collision_obj_snow_ball_held, Collision_obj_spike_ball, Collision_obj_spiny, Collision_obj_buzzybeetle
obj_star: Collision_obj_mario
obj_stomp: Collision_obj_enemyparent
obj_superball: Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_block_pow_hold, Collision_obj_bobomb
obj_superflower: Collision_obj_mario
obj_thwomp: Collision_obj_enemyparent
obj_tongue: Collision_obj_brohammer, Collision_obj_bowser_fire_down, Collision_obj_bowser_fire, Collision_obj_bone, Collision_obj_plantfire, Collision_obj_holdparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_pswitch, Collision_obj_spring_land, Collision_obj_coin10, Collision_obj_spike_ball
obj_tongue_blue: Collision_obj_brohammer, Collision_obj_bowser_fire_down, Collision_obj_bowser_fire, Collision_obj_bone, Collision_obj_plantfire, Collision_obj_holdparent, Collision_obj_enemyparent, Collision_obj_powerupparent, Collision_obj_pswitch, Collision_obj_spring_land, Collision_obj_coin10, Collision_obj_spike_ball
obj_tuberia_res: Collision_obj_parent_resource, Collision_obj_pplant_res
obj_vine_res: Collision_obj_parent_resource
obj_wrench: Collision_obj_invincibility, Collision_obj_mario
obj_yoshi_abandon: Collision_obj_mario
obj_yoshi_runaway: Collision_obj_mario
obj_yoshi_runaway_blue: Collision_obj_mario
obj_yoshi_runaway_red: Collision_obj_mario
obj_yoshifire: Collision_obj_shell, Collision_obj_enemyparent_held, Collision_obj_enemyparent, Collision_obj_boomboom
```
</details>

<details><summary>按文件完整索引（438 个文件，2207 行命中）</summary>

```
objects/obj_marioU/Step_0.gml(54): 3,15,19,33,34,35,36,43,50,93,97,99,102,106,108,111,115,117,120,123,…+34
objects/obj_mario/Step_0.gml(53): 4,16,20,32,33,34,35,39,53,62,69,119,123,125,128,132,134,137,141,143,…+33
objects/obj_enemyparent/Step_1.gml(25): 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,48,49,50,51,52,…+5
objects/obj_block_pow_hold/Other_13.gml(24): 2,3,4,5,6,7,10,11,12,13,14,15,16,17,36,38,40,42,44,45,…+4
objects/obj_NSMBU_charginchuck/Step_0.gml(19): 5,7,8,27,29,31,33,35,37,39,41,52,54,56,58,60,62,64,66
objects/obj_charginchuck/Step_0.gml(19): 4,6,7,27,29,31,33,35,37,39,41,52,54,56,58,60,62,64,66
objects/obj_flipblock/Other_20.gml(18): 2,3,4,5,6,7,8,9,10,11,30,46,51,56,61,66,74,82
objects/obj_pblock/Other_10.gml(18): 2,3,4,5,6,7,8,9,10,11,30,46,51,56,61,66,74,82
objects/obj_beachkoopa/Other_13.gml(17): 2,3,4,6,7,28,30,32,34,36,39,41,43,45,47,50,52
objects/obj_beachkoopa_b/Other_13.gml(17): 2,3,4,6,7,28,30,32,34,36,39,41,43,45,47,50,52
objects/obj_beachkoopa_red/Other_13.gml(17): 2,3,4,6,7,28,30,32,34,36,39,41,43,45,47,50,52
objects/obj_beachkoopa_red_b/Other_13.gml(17): 2,3,4,6,7,28,30,32,34,36,39,41,43,45,47,50,52
objects/obj_grrrol/Other_13.gml(17): 2,3,4,5,62,64,65,92,94,96,98,100,102,104,106,108,110
objects/obj_grrrol_b/Other_13.gml(17): 2,3,4,5,62,64,65,92,94,96,98,100,102,104,106,108,110
objects/obj_grrrol_new/Other_13.gml(17): 2,3,4,5,62,64,65,92,94,96,98,100,102,104,106,108,110
objects/obj_pokey/Other_13.gml(17): 4,5,6,7,8,10,11,28,30,32,34,36,38,40,42,44,46
objects/obj_thwomp_b/Step_0.gml(17): 6,27,37,75,94,103,104,131,143,159,176,177,206,218,234,251,252
objects/obj_coin/Other_10.gml(16): 2,3,4,5,6,7,8,9,10,29,45,50,55,60,65,73
objects/obj_enabledsolid/Other_10.gml(16): 2,3,4,5,6,7,8,9,10,29,45,50,55,60,65,73
objects/obj_ground/Other_12.gml(16): 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
objects/obj_ground/Other_18.gml(16): 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
objects/obj_waddlewing/Other_18.gml(16): 2,3,4,5,11,12,13,14,37,38,39,40,41,42,43,44
objects/obj_NSMBU_bowser/Other_13.gml(15): 2,4,5,26,28,30,32,34,37,39,41,43,45,48,50
objects/obj_SMB3_bowser/Other_13.gml(15): 2,4,5,30,32,34,36,38,41,43,45,47,49,52,54
objects/obj_SMB_bowser/Other_13.gml(15): 2,4,5,26,28,30,32,34,37,39,41,43,45,48,50
objects/obj_SMW_bowser/Other_13.gml(15): 2,4,5,31,33,35,37,39,42,44,46,48,50,53,55
objects/obj_clown/Other_13.gml(15): 2,4,5,26,28,30,32,34,37,39,41,43,45,48,50
objects/obj_clown/Other_14.gml(15): 4,5,13,18,29,50,52,54,56,58,76,78,80,82,84
objects/obj_cursor/Mouse_50.gml(15): 9,10,11,16,17,18,20,41,42,43,44,45,46,47,48
objects/obj_floruga/Other_13.gml(15): 1,3,4,22,24,26,28,30,33,35,37,39,41,44,46
objects/obj_hammerbro/Other_13.gml(15): 1,3,4,23,25,27,29,31,34,36,38,40,42,45,47
objects/obj_koopa_red/Other_13.gml(15): 2,4,5,26,28,30,32,34,37,39,41,43,45,48,50
objects/obj_mario/Other_12.gml(15): 2,3,13,55,56,57,58,59,60,432,442,460,545,574,670
objects/obj_muncher/Other_13.gml(15): 1,2,3,5,6,26,28,30,32,35,37,39,41,44,46
objects/obj_physicsparent/Other_13.gml(15): 1,3,4,24,26,28,30,32,35,37,39,41,43,46,48
objects/obj_physicsparent/Other_14.gml(15): 3,4,13,14,15,16,17,36,67,69,71,73,75,77,86
objects/obj_player_goal_parent/Other_13.gml(15): 2,4,5,25,27,29,31,33,36,38,40,42,44,47,49
objects/obj_waddlewing/Other_13.gml(15): 1,3,4,24,26,28,30,32,35,37,39,41,43,46,48
objects/obj_cursor/Mouse_53.gml(14): 9,10,11,12,13,17,18,20,41,42,43,44,45,46
scripts/scr_auto_tile/scr_auto_tile.gml(14): 4,5,6,7,8,9,10,11,12,13,14,15,16,17
objects/obj_bullebill_base/Other_13.gml(13): 2,4,5,23,25,27,29,31,33,35,37,39,41
objects/obj_holdparent/Other_13.gml(13): 1,3,4,26,28,30,32,34,36,38,40,42,44
objects/obj_holdparent/Step_0.gml(13): 9,10,30,61,71,73,75,77,79,81,83,85,87
objects/obj_link_bomb/Other_13.gml(13): 1,3,4,30,32,34,36,38,40,42,44,46,48
objects/obj_mario/Step_2.gml(13): 359,384,396,398,416,428,442,444,462,474,584,598,751
objects/obj_mario_pballon/Other_13.gml(13): 2,4,5,22,23,35,37,39,41,43,45,47,49
objects/obj_player_goal_nsmbu/Other_13.gml(13): 2,4,15,17,19,21,24,26,40,42,44,46,48
objects/obj_powerupparent/Other_13.gml(13): 2,4,5,26,28,30,32,34,36,38,40,42,44
objects/obj_pswitch/Other_13.gml(13): 3,4,5,7,8,26,28,30,32,34,36,38,40
objects/obj_shell_held/Other_13.gml(13): 2,4,5,23,25,27,29,32,34,36,38,41,43
objects/obj_sledgebro/Other_13.gml(13): 2,4,5,27,29,31,33,35,38,40,42,44,46
objects/obj_superball/Step_0.gml(13): 2,4,5,20,21,37,39,40,41,42,43,80,113
objects/obj_torbellino/Other_13.gml(13): 1,4,6,8,10,12,15,17,19,21,23,26,28
objects/obj_yoshi_runaway/Other_13.gml(13): 1,3,4,22,24,26,28,31,33,35,37,40,42
objects/obj_block_pow_hold/Other_14.gml(12): 4,5,13,33,53,74,75,77,79,81,83,92
objects/obj_claw/Step_0.gml(12): 164,166,168,170,172,174,176,178,180,182,184,185
objects/obj_1up/Other_13.gml(11): 6,8,9,44,46,48,50,52,54,56,58
objects/obj_SMB2_mushroom/Other_13.gml(11): 3,15,17,19,21,23,25,27,29,31,33
objects/obj_drybones/Other_13.gml(11): 1,7,9,11,13,15,17,19,21,23,25
objects/obj_enemyparent_held/Step_0.gml(11): 10,11,31,62,72,74,76,78,80,82,84
objects/obj_holdparent/Other_14.gml(11): 3,4,12,32,64,66,68,70,72,74,83
objects/obj_mario/Other_13.gml(11): 2,5,6,7,36,45,112,236,353,370,381
objects/obj_mario/Other_14.gml(11): 9,10,20,21,31,44,62,100,102,127,145
objects/obj_mario_pballon/Other_14.gml(11): 2,6,15,26,28,33,35,37,39,41,50
objects/obj_mushroom/Other_13.gml(11): 3,15,17,19,21,23,25,27,29,31,33
objects/obj_player_goal_smb1/Other_14.gml(11): 4,5,6,7,8,22,24,26,29,47,49
objects/obj_rocangrejo/Other_14.gml(11): 4,5,13,21,52,54,56,58,60,62,71
objects/obj_shell_drybones/Other_14.gml(11): 3,4,5,15,21,46,48,50,52,54,63
objects/obj_shell_drybones_held/Other_14.gml(11): 3,4,5,15,21,46,48,50,52,54,63
objects/obj_snow_ball/Other_14.gml(11): 4,5,13,22,55,57,59,61,63,65,74
objects/obj_spike_ball/Other_13.gml(11): 1,3,4,21,22,39,40,41,42,105,106
objects/obj_thwomp/Other_13.gml(11): 4,5,6,18,19,25,56,58,60,62,64
objects/obj_thwomp/Step_0.gml(11): 6,27,63,82,91,113,135,152,174,196,213
objects/obj_waddlewing/Other_14.gml(11): 3,4,13,34,65,67,69,71,73,77,86
objects/obj_yoshi_abandon/Other_14.gml(11): 3,4,12,29,54,56,58,60,62,64,73
objects/obj_NSMBU_boomboom/Other_14.gml(10): 4,5,13,29,60,62,64,66,68,70
objects/obj_NSMBU_boomboom_b/Other_14.gml(10): 4,5,13,29,60,62,64,66,68,70
objects/obj_NSMBU_bowserjr/Other_14.gml(10): 3,4,12,65,100,102,104,106,108,110
objects/obj_block_pow_hold/Step_0.gml(10): 4,29,41,51,52,87,95,127,129,131
objects/obj_bossparent/Other_16.gml(10): 5,7,13,15,21,29,31,37,39,42
objects/obj_bowser_fire_down/Other_14.gml(10): 4,5,6,7,8,22,24,26,29,54
objects/obj_bowserjr/Other_14.gml(10): 4,5,13,49,84,86,88,90,92,94
objects/obj_bullebill_base/Other_24.gml(10): 2,5,6,11,12,13,15,16,17,19
objects/obj_cannon/Other_14.gml(10): 4,5,13,14,31,62,63,65,67,69
objects/obj_cannon/Other_24.gml(10): 2,5,6,11,12,13,15,16,17,19
objects/obj_enemyfrozen/Other_14.gml(10): 4,5,13,22,54,56,58,60,62,71
objects/obj_jumppiranha/Other_14.gml(10): 4,5,13,28,74,76,78,80,82,84
objects/obj_link_bomb/Step_0.gml(10): 31,39,41,43,45,47,49,51,53,55
objects/obj_muncher/Other_14.gml(10): 3,4,12,13,38,69,70,72,74,76
objects/obj_muncher/Other_24.gml(10): 1,4,5,10,11,12,14,15,16,18
objects/obj_player_goal_parent/Other_14.gml(10): 4,5,13,19,44,46,48,50,52,61
objects/obj_pswitch/Other_14.gml(10): 6,12,29,61,62,64,66,68,70,79
objects/obj_rocky/Other_14.gml(10): 4,5,13,20,51,53,55,57,59,61
objects/obj_shell_held/Other_14.gml(10): 4,5,14,25,49,51,53,55,57,66
objects/obj_snow_ball_held/Other_14.gml(10): 4,5,13,23,50,52,54,56,58,60
objects/obj_spike_ball/Other_14.gml(10): 3,4,12,30,76,78,80,82,84,93
objects/obj_torbellino/Other_16.gml(10): 5,7,10,12,15,20,22,25,27,30
objects/obj_NSMBU_bowser/Other_14.gml(9): 4,5,13,19,61,63,65,67,69
objects/obj_SMB3_bowser/Other_14.gml(9): 4,5,13,19,85,87,89,91,93
objects/obj_SMB_bowser/Other_14.gml(9): 4,5,6,7,19,25,53,55,64
objects/obj_SMW_bowser/Other_14.gml(9): 4,5,6,7,19,25,57,59,68
objects/obj_blockparent/Step_0.gml(9): 2,21,36,37,38,39,43,51,52
objects/obj_bullebill_base/Other_14.gml(9): 4,5,13,19,51,53,55,57,59
objects/obj_fireball/Other_14.gml(9): 4,5,13,19,55,57,59,61,63
objects/obj_kuribo_drybones/Step_2.gml(9): 22,56,73,132,167,178,180,186,220
objects/obj_player_goal_smw/Other_13.gml(9): 2,8,10,12,14,16,18,20,22
objects/obj_skewertrunk/Other_12.gml(9): 3,4,5,6,7,17,18,19,37
objects/obj_skewertrunk/Other_13.gml(9): 3,4,5,6,7,17,18,19,39
objects/obj_skewertrunk/Other_14.gml(9): 3,4,5,6,7,17,18,19,37
objects/obj_spike_ball_b/Other_13.gml(9): 1,3,4,21,22,39,40,67,68
objects/obj_thwomp/Other_14.gml(9): 4,5,15,21,52,54,56,58,60
objects/obj_buzzy_ceiling/Other_14.gml(8): 4,10,16,41,43,45,47,49
objects/obj_cloud_lakitu/Other_14.gml(8): 4,10,16,29,31,33,35,37
objects/obj_coin_pow/Other_14.gml(8): 3,4,12,40,42,44,46,48
objects/obj_enemyfrozen/Step_0.gml(8): 1,10,19,20,56,106,108,110
objects/obj_player_goal_smw_castle/Other_14.gml(8): 4,5,13,31,33,35,37,39
objects/obj_pswitch/Step_0.gml(8): 6,9,12,21,22,90,92,94
objects/obj_skewertrunk/Other_10.gml(8): 7,8,11,12,15,16,19,20
objects/obj_tuberia/Step_0.gml(8): 3,5,24,26,44,46,65,67
scripts/draw_sprite_autotiled/draw_sprite_autotiled.gml(8): 22,23,24,25,26,27,28,29
scripts/draw_sprite_autotiled2/draw_sprite_autotiled2.gml(8): 23,24,25,26,27,28,29,30
objects/obj_holdparent/Step_2.gml(7): 15,165,168,169,174,176,178
objects/obj_lava_water/Step_0.gml(7): 83,84,85,86,87,88,94
objects/obj_mario/Alarm_10.gml(7): 8,23,55,70,90,98,112
objects/obj_marioU/Other_12.gml(7): 1,11,50,487,509,541,837
objects/obj_platform_parent/Step_2.gml(7): 8,9,10,11,14,31,37
objects/obj_skewertrunk/Other_11.gml(7): 3,4,5,11,12,13,33
objects/obj_snow_ball_held/Other_13.gml(7): 2,4,5,22,23,24,25
objects/obj_yoshifire/Other_14.gml(7): 4,5,8,10,13,15,18
objects/obj_bowserjr_shell/Other_13.gml(6): 2,4,5,6,7,44
objects/obj_claw/Step_2.gml(6): 34,40,154,155,156,183
objects/obj_editormanager/Alarm_1.gml(6): 7,37,64,97,121,140
objects/obj_floruga/Other_12.gml(6): 3,4,5,10,11,12
objects/obj_link_bomb/Step_2.gml(6): 59,62,63,68,70,72
objects/obj_physicsparent/Other_24.gml(6): 1,4,5,10,12,14
objects/obj_rocky/Other_17.gml(6): 4,6,8,10,12,14
objects/obj_buzzybeetle/Step_0.gml(5): 60,63,66,84,86
objects/obj_buzzybeetle_b/Step_0.gml(5): 60,63,66,84,86
objects/obj_coinchain/Alarm_0.gml(5): 3,10,15,20,25
objects/obj_holdparent/Other_12.gml(5): 3,8,34,57,69
objects/obj_kuriboshoe/Step_2.gml(5): 26,67,86,92,117
objects/obj_magic/Step_0.gml(5): 10,11,12,13,14
objects/obj_marioU/Other_13.gml(5): 1,10,94,268,287
objects/obj_noteblock/Other_14.gml(5): 4,11,12,13,14
objects/obj_rockparent/Step_0.gml(5): 1,20,21,22,23
objects/obj_shell_drybones_held/Other_13.gml(5): 1,3,4,21,22
objects/obj_shell_held/Step_0.gml(5): 20,95,96,99,105
objects/obj_slider/Step_0.gml(5): 43,45,51,62,87
objects/obj_snowball/Other_14.gml(5): 3,4,12,44,46
objects/obj_SMB2_mushroom/Step_0.gml(4): 2,3,43,56
objects/obj_bullebill_base/Step_0.gml(4): 15,34,35,36
objects/obj_bullebill_base_red/Step_0.gml(4): 19,38,39,40
objects/obj_cannon_red_res/Other_24.gml(4): 1,5,9,13
objects/obj_cannon_red_res/Other_25.gml(4): 1,10,19,28
objects/obj_cannon_res/Other_24.gml(4): 1,5,9,13
objects/obj_cannon_res/Other_25.gml(4): 1,10,19,28
objects/obj_clown/Step_0.gml(4): 41,49,131,154
objects/obj_hammerbro/Alarm_1.gml(4): 16,18,43,49
objects/obj_hammerbro/Other_14.gml(4): 3,4,12,18
objects/obj_hammerbro/Step_0.gml(4): 74,75,76,84
objects/obj_hurtsolid2/Step_0.gml(4): 6,15,25,34
objects/obj_kuribo_drybones/Other_10.gml(4): 7,9,11,13
objects/obj_kuriboshoe/Other_10.gml(4): 9,11,13,15
objects/obj_link_dash_atack/Other_10.gml(4): 3,4,5,15
objects/obj_mario_pballon/Step_2.gml(4): 47,49,51,53
objects/obj_onoffblock/Step_0.gml(4): 40,53,61,62
objects/obj_player_warp/Alarm_2.gml(4): 4,11,18,25
objects/obj_pplant_res/Step_2.gml(4): 4,6,12,18
objects/obj_skewertrunk/Step_2.gml(4): 4,12,20,28
objects/obj_snow_ball/Other_12.gml(4): 4,9,36,52
objects/obj_spring/Collision_obj_physicsparent.gml(4): 8,9,10,11
objects/obj_spring_land/Step_2.gml(4): 13,19,22,27
objects/obj_beachkoopa_b/Step_0.gml(3): 19,23,39
objects/obj_block_pow_active/Alarm_0.gml(3): 19,35,57
objects/obj_block_pow_hold/Other_12.gml(3): 3,22,57
objects/obj_boo/Step_0.gml(3): 4,6,11
objects/obj_cannon/Other_11.gml(3): 1,16,31
objects/obj_cloud_lakitu/Other_13.gml(3): 2,4,5
objects/obj_cooligan/Step_1.gml(3): 35,42,48
objects/obj_door_lock/Step_0.gml(3): 37,48,154
objects/obj_door_lock_exit/Step_0.gml(3): 37,48,153
objects/obj_enemyfrozen/Other_13.gml(3): 2,4,5
objects/obj_enemyparent/Other_16.gml(3): 1,5,10
objects/obj_flipblock/Step_0.gml(3): 20,24,51
objects/obj_hammerbro/Other_25.gml(3): 13,34,40
objects/obj_jumppiranha/Step_0.gml(3): 4,8,12
objects/obj_link_bomb/Other_12.gml(3): 5,9,19
objects/obj_meteorites/Other_10.gml(3): 1,2,3
objects/obj_meteorites_big/Other_10.gml(3): 1,2,3
objects/obj_muncher/Step_0.gml(3): 3,4,6
objects/obj_pokey/Step_0.gml(3): 3,4,6
objects/obj_rocky/Step_0.gml(3): 21,22,71
objects/obj_shell/Other_12.gml(3): 3,28,48
objects/obj_shell_drybones/Other_12.gml(3): 3,32,52
objects/obj_spring_land/Collision_obj_shell.gml(3): 9,22,36
objects/obj_spring_land/Step_0.gml(3): 7,8,10
objects/obj_NSMBU_bowser/Alarm_0.gml(2): 9,35
objects/obj_arrow_res/Mouse_4.gml(2): 1,3
objects/obj_autoscroll/Step_0.gml(2): 3,7
objects/obj_beachkoopa/Step_0.gml(2): 19,23
objects/obj_bonybeetle/Step_0.gml(2): 31,36
objects/obj_boo/Other_16.gml(2): 5,10
objects/obj_boo_res/Step_2.gml(2): 31,36
objects/obj_bowserjr_shell/Other_16.gml(2): 5,10
objects/obj_bowserjr_shell/Step_2.gml(2): 14,16
objects/obj_bullebill_base/Alarm_0.gml(2): 6,39
objects/obj_bullebill_base_red/Alarm_0.gml(2): 11,49
objects/obj_buzzy_ceiling/Other_11.gml(2): 2,3
objects/obj_cannon_red_res/Mouse_4.gml(2): 1,3
objects/obj_cannon_res/Mouse_4.gml(2): 1,3
objects/obj_claw/Collision_obj_muncher.gml(2): 2,5
objects/obj_cursor/Step_1.gml(2): 3,5
objects/obj_drybones/Step_0.gml(2): 31,36
objects/obj_enemyparent/Other_12.gml(2): 1,9
objects/obj_fire_clown/Step_0.gml(2): 1,3
objects/obj_firebar_res/Mouse_4.gml(2): 1,3
objects/obj_fishbone/Other_14.gml(2): 3,5
objects/obj_flagpole/Collision_obj_marioU.gml(2): 6,33
objects/obj_floruga/Other_16.gml(2): 5,15
objects/obj_foo_fog/Step_0.gml(2): 2,3
objects/obj_ground/Alarm_5.gml(2): 1,10
objects/obj_koopa_red/Step_0.gml(2): 52,57
objects/obj_kuriboshoe/Alarm_0.gml(2): 3,43
objects/obj_lakitu/Alarm_1.gml(2): 5,43
objects/obj_magic/Other_14.gml(2): 1,3
objects/obj_magikoopa/Alarm_2.gml(2): 11,12
objects/obj_mario/Other_15.gml(2): 3,4
objects/obj_marioU/Other_19.gml(2): 25,26
objects/obj_mario_editor/Mouse_4.gml(2): 1,3
objects/obj_muncher/Collision_obj_shield_left.gml(2): 7,10
objects/obj_muncher/Collision_obj_shield_right.gml(2): 7,10
objects/obj_muncher/Create_0.gml(2): 39,41
objects/obj_muncher_b/Create_0.gml(2): 37,39
objects/obj_mushroom/Step_0.gml(2): 36,49
objects/obj_musicblock/Step_0.gml(2): 26,39
objects/obj_noteblock/Step_0.gml(2): 28,41
objects/obj_noteblock_s/Step_0.gml(2): 26,39
objects/obj_onewaygate_top/Step_2.gml(2): 6,7
objects/obj_parent_resource/Other_12.gml(2): 1,6
objects/obj_pinchos/Alarm_0.gml(2): 3,11
objects/obj_player_goal_smw_castle/Step_0.gml(2): 13,14
objects/obj_player_warp/Step_0.gml(2): 15,25
objects/obj_pokey/Create_0.gml(2): 43,45
objects/obj_powerupsprout/Alarm_2.gml(2): 17,43
objects/obj_powerupsprout_note/Alarm_1.gml(2): 18,44
objects/obj_slider/Alarm_0.gml(2): 1,9
objects/obj_solidhold/Step_0.gml(2): 2,3
objects/obj_soplete_res/Mouse_4.gml(2): 1,3
objects/obj_spike/Step_0.gml(2): 70,75
objects/obj_spiny_ball/Step_0.gml(2): 28,34
objects/obj_spring_land/Collision_obj_block_pow_hold.gml(2): 3,18
objects/obj_spring_land/Collision_obj_buzzybeetle.gml(2): 3,12
objects/obj_spring_land/Collision_obj_holdparent.gml(2): 3,19
objects/obj_spring_land/Collision_obj_physicsparent.gml(2): 5,25
objects/obj_spring_land/Collision_obj_snow_ball_held.gml(2): 3,11
objects/obj_spring_land/Collision_obj_spike_ball.gml(2): 3,11
objects/obj_spring_land/Collision_obj_spiny.gml(2): 3,12
objects/obj_spring_land/Create_0.gml(2): 31,33
objects/obj_vine_green/Draw_0.gml(2): 5,12
objects/obj_vine_res/Draw_0.gml(2): 11,18
objects/obj_waddlewing/Other_16.gml(2): 4,12
objects/obj_yoshi2/Other_10.gml(2): 177,180
objects/obj_1up/Alarm_10.gml(1): 19
objects/obj_1up/Collision_obj_blockparent.gml(1): 3
objects/obj_NSMBU_bowserjr/Alarm_0.gml(1): 10
objects/obj_NSMBU_bowserjr/Alarm_4.gml(1): 4
objects/obj_NSMBU_bowserjr/Step_0.gml(1): 60
objects/obj_SMB2_mushroom/Alarm_10.gml(1): 10
objects/obj_SMB2_mushroom/Collision_obj_blockparent.gml(1): 3
objects/obj_SMB2_mushroom/Collision_obj_mario.gml(1): 3
objects/obj_SMB3_bowser/Alarm_0.gml(1): 3
objects/obj_SMB3_bowser/Alarm_4.gml(1): 2
objects/obj_SMB3_bowser/Step_0.gml(1): 54
objects/obj_SMB_bowser/Alarm_0.gml(1): 3
objects/obj_SMW_bowser/Alarm_0.gml(1): 11
objects/obj_SMW_bowser/Alarm_5.gml(1): 1
objects/obj_arrow_lock/Step_2.gml(1): 1
objects/obj_beachkoopa/Collision_obj_shell.gml(1): 3
objects/obj_beachkoopa_b/Collision_obj_shell.gml(1): 3
objects/obj_beachkoopa_red/Collision_obj_shell.gml(1): 3
objects/obj_beachkoopa_red_b/Collision_obj_shell.gml(1): 3
objects/obj_block_hidden/Step_0.gml(1): 2
objects/obj_block_pow_hold/Alarm_1.gml(1): 2
objects/obj_blockparent/Alarm_2.gml(1): 2
objects/obj_bobomb/Other_15.gml(1): 2
objects/obj_boo/Alarm_1.gml(1): 1
objects/obj_boomerang/Step_0.gml(1): 65
objects/obj_bortice/Collision_obj_muncher.gml(1): 4
objects/obj_bortice/Collision_obj_physicsparent.gml(1): 6
objects/obj_bossparent/Other_12.gml(1): 2
objects/obj_bouncycloud/Step_0.gml(1): 30
objects/obj_bowserjr/Alarm_0.gml(1): 5
objects/obj_bowserjr/Step_0.gml(1): 64
objects/obj_bubble/Step_0.gml(1): 1
objects/obj_bullebill_base/Collision_obj_bossparent.gml(1): 5
objects/obj_bullebill_base/Collision_obj_enemyparent.gml(1): 5
objects/obj_bullebill_base/Collision_obj_enemyparent_held.gml(1): 3
objects/obj_bullebill_base/Collision_obj_mario.gml(1): 3
objects/obj_bullebill_base/Collision_obj_powerupparent.gml(1): 5
objects/obj_buzzybeetle/Other_15.gml(1): 37
objects/obj_buzzybeetle/Other_18.gml(1): 1
objects/obj_buzzybeetle_b/Other_15.gml(1): 36
objects/obj_buzzybeetle_b_res/Step_2.gml(1): 31
objects/obj_buzzybeetle_res/Step_2.gml(1): 60
objects/obj_cannon/Step_0.gml(1): 10
objects/obj_cap/Collision_obj_mario.gml(1): 3
objects/obj_cheepcheep/Step_0.gml(1): 3
objects/obj_cheepcheep2/Step_0.gml(1): 3
objects/obj_claw/Collision_obj_egg.gml(1): 2
objects/obj_claw/Collision_obj_enemyparent.gml(1): 2
objects/obj_claw/Collision_obj_holdparent.gml(1): 2
objects/obj_claw/Collision_obj_mario.gml(1): 2
objects/obj_claw/Collision_obj_powerupparent.gml(1): 2
objects/obj_claw/Collision_obj_shell_drybones_held.gml(1): 2
objects/obj_claw/Collision_obj_shell_held.gml(1): 2
objects/obj_claw/Collision_obj_snow_ball_held.gml(1): 2
objects/obj_claw/Collision_obj_spike_ball.gml(1): 2
objects/obj_claw/Collision_obj_spring_land.gml(1): 2
objects/obj_claw/Collision_obj_yoshi_abandon.gml(1): 2
objects/obj_claw/Collision_obj_yoshi_runaway.gml(1): 2
objects/obj_creation_preview/Step_1.gml(1): 17
objects/obj_cursor/Mouse_51.gml(1): 14
objects/obj_dog/Mouse_4.gml(1): 1
objects/obj_donut/Step_2.gml(1): 34
objects/obj_door/Step_0.gml(1): 1
objects/obj_door_exit/Step_0.gml(1): 1
objects/obj_door_switch/Step_0.gml(1): 5
objects/obj_door_switch_exit/Step_0.gml(1): 5
objects/obj_editormanager/Step_0.gml(1): 59
objects/obj_egg/Step_0.gml(1): 129
objects/obj_enabledsolid/Step_0.gml(1): 2
objects/obj_enemyfrozen/Alarm_7.gml(1): 3
objects/obj_enemyparent_held/Step_2.gml(1): 15
objects/obj_expand/Mouse_4.gml(1): 1
objects/obj_fireball/Create_0.gml(1): 25
objects/obj_fireball/Other_10.gml(1): 9
objects/obj_fireball/Step_0.gml(1): 4
objects/obj_fireball_b/Create_0.gml(1): 17
objects/obj_fireball_bro/Create_0.gml(1): 25
objects/obj_fireball_bro/Other_10.gml(1): 6
objects/obj_fireball_bro/Step_0.gml(1): 16
objects/obj_firebar/Draw_0.gml(1): 8
objects/obj_flagpole/Collision_obj_mario.gml(1): 7
objects/obj_flipblock_anim/Other_7.gml(1): 3
objects/obj_frogsuit/Collision_obj_mario.gml(1): 3
objects/obj_galoomba/Alarm_10.gml(1): 3
objects/obj_galoomba/Other_15.gml(1): 5
objects/obj_galoomba2/Other_15.gml(1): 7
objects/obj_galoomba2_b/Other_15.gml(1): 7
objects/obj_galoomba_b/Alarm_10.gml(1): 3
objects/obj_grinder_res/Alarm_0.gml(1): 3
objects/obj_groundpount/Step_0.gml(1): 8
objects/obj_grrrol/Other_12.gml(1): 2
objects/obj_grrrol_b/Other_12.gml(1): 2
objects/obj_grrrol_new/Other_12.gml(1): 2
objects/obj_hammersuit/Collision_obj_mario.gml(1): 3
objects/obj_helmet/Collision_obj_thwomp.gml(1): 7
objects/obj_helmet/Other_17.gml(1): 26
objects/obj_hen_mushroom/Collision_obj_blockparent.gml(1): 1
objects/obj_hen_mushroom/Collision_obj_mario.gml(1): 3
objects/obj_icicle/Collision_obj_mario.gml(1): 3
objects/obj_icicle/Step_0.gml(1): 3
objects/obj_koopa/Alarm_10.gml(1): 7
objects/obj_koopa/Other_15.gml(1): 24
objects/obj_koopa_b/Alarm_10.gml(1): 5
objects/obj_koopa_b/Other_15.gml(1): 23
objects/obj_koopa_red/Alarm_10.gml(1): 7
objects/obj_koopa_red/Other_15.gml(1): 24
objects/obj_koopa_red_b/Alarm_10.gml(1): 7
objects/obj_koopa_red_b/Other_15.gml(1): 23
objects/obj_lava_lift/Step_0.gml(1): 1
objects/obj_lava_lift_part/Step_0.gml(1): 1
objects/obj_link/Collision_obj_mario.gml(1): 3
objects/obj_link_down_atack/Other_10.gml(1): 3
objects/obj_magic/Other_13.gml(1): 1
objects/obj_magikoopa/Other_7.gml(1): 15
objects/obj_mario/Other_11.gml(1): 13
objects/obj_marioU/Other_11.gml(1): 33
objects/obj_marioU/Step_2.gml(1): 882
objects/obj_mario_editor/Step_0.gml(1): 86
objects/obj_mario_pballon/Destroy_0.gml(1): 5
objects/obj_mario_pballon/Step_0.gml(1): 2
objects/obj_mario_temp/Other_10.gml(1): 5
objects/obj_modelbgo/Collision_obj_mario.gml(1): 1
objects/obj_muncher/Alarm_9.gml(1): 5
objects/obj_muncher_res/Alarm_0.gml(1): 3
objects/obj_mushroom/Alarm_10.gml(1): 10
objects/obj_mushroom/Collision_obj_blockparent.gml(1): 3
objects/obj_mushroom/Collision_obj_mario.gml(1): 3
objects/obj_mushroom_platform_res/Alarm_0.gml(1): 3
objects/obj_musicblock/Alarm_1.gml(1): 3
objects/obj_noteblock/Alarm_1.gml(1): 4
objects/obj_noteblock_s/Alarm_1.gml(1): 3
objects/obj_parcarry/Step_2.gml(1): 33
objects/obj_parent_resource/Alarm_0.gml(1): 8
objects/obj_parent_sound_o/Step_2.gml(1): 1
objects/obj_parent_sounds/Alarm_0.gml(1): 3
objects/obj_pballon/Collision_obj_mario.gml(1): 3
objects/obj_physicsparent/Collision_obj_blockparent.gml(1): 3
objects/obj_physicssolid/Collision_obj_bossparent.gml(1): 5
objects/obj_physicssolid/Collision_obj_enemyparent.gml(1): 5
objects/obj_physicssolid/Collision_obj_enemyparent_held.gml(1): 3
objects/obj_physicssolid/Collision_obj_mario.gml(1): 3
objects/obj_physicssolid/Collision_obj_powerupparent.gml(1): 5
objects/obj_plataforma_blue/Step_0.gml(1): 30
objects/obj_platform_help/Step_2.gml(1): 3
objects/obj_player_goal_nsmbu/Other_23.gml(1): 15
objects/obj_player_goal_nsmbu/Step_0.gml(1): 54
objects/obj_player_goal_smb1/Step_0.gml(1): 56
objects/obj_pokey/Alarm_9.gml(1): 5
objects/obj_powerupparent/Collision_obj_blockparent.gml(1): 3
objects/obj_powerupparent/Collision_obj_mario.gml(1): 3
objects/obj_powerupsprout/Alarm_1.gml(1): 3
objects/obj_pswitch_res/Step_2.gml(1): 20
objects/obj_rockparent/Other_10.gml(1): 2
objects/obj_rocky/Alarm_0.gml(1): 1
objects/obj_semisolid_platform1/Alarm_0.gml(1): 5
objects/obj_shell/Other_17.gml(1): 4
objects/obj_shell_empty/Other_17.gml(1): 2
objects/obj_shell_held/Alarm_0.gml(1): 1
objects/obj_shell_held/Other_15.gml(1): 9
objects/obj_snowball/Create_0.gml(1): 9
objects/obj_snowball_bro/Create_0.gml(1): 28
objects/obj_spike_ball/Step_0.gml(1): 3
objects/obj_spiny/Other_15.gml(1): 22
objects/obj_spiny/Step_0.gml(1): 49
objects/obj_spiny_empty/Other_17.gml(1): 2
objects/obj_spiny_res/Step_2.gml(1): 15
objects/obj_spring/Collision_obj_holdparent.gml(1): 6
objects/obj_spring/Collision_obj_mario.gml(1): 3
objects/obj_spring/Collision_obj_powerupparent.gml(1): 6
objects/obj_spring_land/Alarm_9.gml(1): 5
objects/obj_superball/Create_0.gml(1): 7
objects/obj_superflower/Collision_obj_mario.gml(1): 3
objects/obj_waddlewing/Alarm_10.gml(1): 3
objects/obj_water_move/Mouse_4.gml(1): 3
scripts/scr_move_contact_object/scr_move_contact_object.gml(1): 4
scripts/tile_layer_find/tile_layer_find.gml(1): 6
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_1up/Alarm_10.gml:19 | `else if (vspeed < 0 \|\| collision_rectangle(bbox_left, (bbox_bottom - 1), bbox_right, (bbox_bottom + 1), obj_solidtop, 0, 0) \|\| collision_rectangle(bbo…` |
| objects/obj_SMB_bowser/Other_14.gml:25 | `col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1), bbox_right, (bbox_bottom + 1), obj_onewaygate_top, 0, 0)` |
| objects/obj_block_pow_hold/Step_0.gml:41 | `col_estalactita = collision_rectangle(bbox_left, (bbox_top - 6), bbox_right, bbox_top, obj_icicle, 1, 0)` |
| objects/obj_cannon/Other_14.gml:14 | `if ((collision_rectangle(bbox_left, (bbox_bottom - 1), bbox_right, (bbox_bottom + 1), obj_solidtop, 0, 0) && (!collision_rectangle(bbox_left, (bbox_bo…` |
| objects/obj_coin_pow/Other_14.gml:44 | `while (collision_rectangle(bbox_left, (bbox_top + 1), bbox_right, (bbox_top + 1), obj_physicssolid, 1, 0) && (!(place_meeting(x, y, obj_physicssolid))…` |
| objects/obj_expand/Mouse_4.gml:1 | `if (obj_levelmanager.editor == 1 && obj_editormanager.expand_open == 0 && obj_levelmanager.editor_sonidos == 0 && obj_creator_jugar_editar.image_speed…` |
| objects/obj_grrrol_new/Other_13.gml:62 | `if ((hspeed < 0 && collision_rectangle((bbox_left - 1), (bbox_top + 4), bbox_left, (bbox_bottom - 4), obj_solid, 1, 0)) \|\| (hspeed > 0 && collision_re…` |
| objects/obj_kuriboshoe/Other_10.gml:13 | `while collision_rectangle(bbox_right, (bbox_top + 4), bbox_right, (bbox_bottom - 4), obj_physicssolid, 1, 0)` |
| objects/obj_mario/Step_0.gml:352 | `else if ((!keyboard_check(global.abajo)) && (collision_rectangle(bbox_left, (bbox_top - 6), bbox_right, bbox_top, obj_solid, 1, 0) \|\| collision_rectan…` |
| objects/obj_muncher/Other_14.gml:12 | `var phy2 = collision_rectangle(bbox_left, (bbox_bottom - 1), bbox_right, (bbox_bottom + 1), obj_physicssolid, 0, 0)` |
| objects/obj_player_goal_parent/Other_13.gml:27 | `while collision_rectangle(bbox_right, (bbox_top + 4), bbox_right, (bbox_bottom - 4), obj_physicssolid, 1, 0)` |
| objects/obj_rocky/Other_14.gml:20 | `col_one_top = collision_rectangle(bbox_left, (bbox_bottom + 1), bbox_right, (bbox_bottom + 1), obj_onewaygate_top, 0, 0)` |
| objects/obj_snow_ball/Other_14.gml:57 | `while (collision_rectangle(bbox_left, (bbox_top + 1), bbox_right, (bbox_top + 1), obj_solid, 1, 0) && (!(place_meeting(x, y, obj_solid))))` |
| objects/obj_thwomp_b/Step_0.gml:103 | `ground_block = collision_rectangle(bbox_left, (bbox_bottom + 2), bbox_right, ((bbox_bottom + vspeed) + 2), obj_blockparent, 0, 0)` |

### 3.4 按帧计时

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| room_speed/game_speed/delta_time/current_time/get_timer/fps: `\b(room_speed\|game_get_speed\|game_set_speed\|delta_time\|current_time\|get_timer\|fps\|fps_real)\b` | 27 | 22 |
| image_speed/animation_end: `\b(image_speed\|animation_end)\b` | 2009 | 1028 |
| 计数器自增减(变量名含timer/time/cnt/count/wait/delay/frame/cooldown/tempo): `\b\w*(timer\|time\|cnt\|count\|wait\|delay\|frame\|cooldown\|tempo\|tiempo)\w*\s*(\+\+\|--\|[+-]=)\|(\+\+\|--)\s*\w*(timer\|time\|cnt\|count\|wait\|delay\|frame\|cooldown\|tempo\|tiempo)\w*` | 62 | 47 |
| **并集（本类合计）** | **2098** | **1065** |

<details><summary>按文件完整索引（1065 个文件，2098 行命中）</summary>

```
objects/obj_marioU/Step_2.gml(137): 23,30,50,71,94,115,121,128,147,160,189,196,218,232,238,240,246,261,266,279,…+117
objects/obj_mario/Step_2.gml(75): 13,74,88,90,95,119,125,131,141,143,148,162,168,183,185,198,204,212,226,228,…+55
objects/obj_deadmario/Other_10.gml(50): 7,14,26,32,38,44,50,56,65,77,85,93,104,116,128,137,148,156,167,176,…+30
objects/obj_editormanager/Other_10.gml(36): 7,16,25,34,45,54,61,69,80,88,100,111,123,134,142,154,166,176,187,200,…+16
objects/obj_editormanager/Other_12.gml(36): 6,13,21,32,49,56,67,73,85,94,103,112,122,132,145,160,164,174,181,190,…+16
objects/obj_mario_transform2/Other_10.gml(35): 7,16,25,34,45,54,61,69,80,88,100,111,123,133,141,153,165,175,186,199,…+15
objects/obj_cap_mario/Other_16.gml(18): 5,12,14,22,28,33,38,47,50,55,59,68,73,76,81,89,93,98
objects/obj_NSMBU_bowser/Step_2.gml(16): 20,37,52,71,82,103,113,115,117,146,154,158,165,169,176,180
objects/obj_SMW_bowser/Step_2.gml(14): 17,28,32,38,40,56,60,65,78,83,87,94,105,109
objects/obj_yoshi2/Step_2.gml(13): 48,146,160,171,177,186,192,201,215,224,229,238,247
objects/obj_player_goal_smw_castle/Step_2.gml(12): 26,29,34,54,58,77,81,102,107,111,116,125
objects/obj_NSMBU_bowserjr/Step_2.gml(11): 21,26,34,55,60,73,85,91,96,100,104
objects/obj_cap_mario/Other_17.gml(11): 6,11,14,19,29,32,37,41,50,54,59
objects/obj_kuribo_drybones/Step_2.gml(10): 76,78,115,158,160,211,213,242,250,283
objects/obj_player_goal_nsmbu/Other_23.gml(10): 11,13,32,36,55,59,68,72,86,93
objects/obj_cinta_switch/Step_0.gml(9): 32,34,37,39,70,72,75,77,81
objects/obj_foo/Step_0.gml(9): 6,33,40,57,60,63,73,75,77
scripts/scr_edit_to_play/scr_edit_to_play.gml(9): 1169,2100,2153,2156,2190,2205,2259,2262,2296
objects/obj_card_bout/Step_0.gml(8): 15,20,25,29,35,40,46,54
objects/obj_key_fallow/Step_0.gml(8): 7,11,30,38,48,52,61,65
objects/obj_shell/Alarm_3.gml(8): 6,10,14,18,22,26,30,34
objects/obj_NSMBU_charginchuck/Step_0.gml(7): 21,49,50,84,86,95,113
objects/obj_charginchuck/Step_0.gml(7): 21,49,50,84,86,95,113
objects/obj_checkpoint/Create_0.gml(7): 1,8,13,33,37,53,57
objects/obj_magikoopa/Other_7.gml(7): 6,8,19,23,33,35,46
objects/obj_marioU/Step_0.gml(7): 60,319,461,463,466,468,471
objects/obj_persistent/Draw_64.gml(7): 6,32,33,34,35,36,37
objects/obj_door_lock/Step_0.gml(6): 81,102,122,131,135,164
objects/obj_door_lock_exit/Step_0.gml(6): 81,102,122,131,135,163
objects/obj_editormanager/Alarm_1.gml(6): 18,49,76,107,130,150
objects/obj_mario/Step_0.gml(6): 81,525,527,530,532,535
objects/obj_marioU/Other_12.gml(6): 20,30,69,577,582,805
objects/obj_mario_pballon/Step_2.gml(6): 22,25,31,35,41,45
objects/obj_player_goal_smb1/Other_23.gml(6): 13,16,25,31,37,42
objects/obj_angrysun/Create_0.gml(5): 47,49,58,60,62
objects/obj_bonybeetle/Step_2.gml(5): 13,27,40,49,58
objects/obj_bonybeetle_b/Step_2.gml(5): 13,27,40,49,58
objects/obj_bowserjr/Step_2.gml(5): 8,16,27,40,46
objects/obj_cinta/Step_0.gml(5): 6,8,11,13,16
objects/obj_fireflower/Create_0.gml(5): 6,10,14,18,22
objects/obj_koopa/Create_0.gml(5): 7,13,18,24,45
objects/obj_koopa_b/Create_0.gml(5): 7,13,18,24,46
objects/obj_koopa_red/Create_0.gml(5): 7,13,17,22,43
objects/obj_koopa_red_b/Create_0.gml(5): 7,13,17,22,42
objects/obj_mario/Other_12.gml(5): 21,695,707,719,726
objects/obj_player_goal_smw/Step_2.gml(5): 16,37,39,45,53
objects/obj_player_warp/Step_2.gml(5): 10,16,18,34,38
objects/obj_angrysun/Collision_obj_mario.gml(4): 15,26,49,60
objects/obj_block_gold/Create_0.gml(4): 6,10,14,18
objects/obj_bobomb/Other_17.gml(4): 20,22,49,51
objects/obj_bowser_dead/Create_0.gml(4): 4,8,12,16
objects/obj_buzzy_ceiling/Other_10.gml(4): 14,19,33,38
objects/obj_checkpoint/Other_4.gml(4): 7,12,32,36
objects/obj_crumblebones/Create_0.gml(4): 5,9,12,16
objects/obj_crumblebony/Create_0.gml(4): 5,9,12,17
objects/obj_crumblebony_b/Create_0.gml(4): 5,9,12,17
objects/obj_explosion/Create_0.gml(4): 4,9,14,17
objects/obj_fast_lava_lift/Create_0.gml(4): 5,10,14,18
objects/obj_fast_lava_lift/Other_11.gml(4): 3,9,19,29
objects/obj_flipblock/Create_0.gml(4): 5,62,65,96
objects/obj_floruga/Alarm_0.gml(4): 19,21,29,31
objects/obj_floruga/Create_0.gml(4): 38,40,56,61
objects/obj_foo/Create_0.gml(4): 7,13,19,25
objects/obj_galoomba/Step_0.gml(4): 4,98,100,105
objects/obj_galoomba_b/Step_0.gml(4): 4,74,76,83
objects/obj_hammerbro/Step_2.gml(4): 10,16,21,26
objects/obj_jumppiranha/Create_0.gml(4): 5,10,14,19
objects/obj_lakitu/Create_0.gml(4): 7,13,19,25
objects/obj_lava_lift/Create_0.gml(4): 5,10,14,18
objects/obj_lava_lift/Other_11.gml(4): 3,11,23,35
objects/obj_lava_lift_part/Create_0.gml(4): 5,10,14,18
objects/obj_lava_water/Step_0.gml(4): 38,49,64,68
objects/obj_magikoopa/Step_0.gml(4): 12,16,34,38
objects/obj_mario_transform2/Create_0.gml(4): 67,76,88,89
objects/obj_mechakoopa_held/Create_0.gml(4): 7,12,16,21
objects/obj_muncher/Create_0.gml(4): 13,20,23,27
objects/obj_muncher_b/Create_0.gml(4): 12,19,22,26
objects/obj_musicblock/Create_0.gml(4): 5,37,42,47
objects/obj_noteblock/Create_0.gml(4): 5,64,70,76
objects/obj_piranhaplant/Create_0.gml(4): 5,10,14,19
objects/obj_player_goal_smb3/Step_2.gml(4): 14,19,29,34
objects/obj_podoboo/Create_0.gml(4): 5,9,13,17
objects/obj_podoboo_b/Create_0.gml(4): 5,9,13,17
objects/obj_pswitch/Create_0.gml(4): 6,11,16,21
objects/obj_shell/Alarm_4.gml(4): 36,45,59,68
objects/obj_shell/Other_10.gml(4): 26,31,69,74
objects/obj_shell_held/Other_10.gml(4): 26,31,69,74
objects/obj_sledgebro/Step_2.gml(4): 9,12,22,27
objects/obj_vine/Create_0.gml(4): 5,10,13,17
objects/obj_NSMBU_boomboom/Alarm_10.gml(3): 4,7,10
objects/obj_NSMBU_boomboom/Alarm_11.gml(3): 6,9,12
objects/obj_NSMBU_boomboom_b/Alarm_10.gml(3): 4,7,10
objects/obj_NSMBU_bowserjr/Other_14.gml(3): 51,58,136
objects/obj_SMB_bowser/Step_0.gml(3): 8,9,60
objects/obj_banzaibill/Create_0.gml(3): 5,13,24
objects/obj_billbanzai_res/Step_2.gml(3): 7,15,26
objects/obj_block/Alarm_1.gml(3): 43,82,122
objects/obj_block_multicoin/Alarm_1.gml(3): 8,25,45
objects/obj_bobomb/Create_0.gml(3): 46,49,51
objects/obj_bobomb_ready/Create_0.gml(3): 24,28,32
objects/obj_bonybeetle/Other_10.gml(3): 22,29,36
objects/obj_bonybeetle_b/Other_10.gml(3): 22,31,40
objects/obj_boo/Other_18.gml(3): 111,118,122
objects/obj_boomerangbro/Other_17.gml(3): 12,14,22
objects/obj_bowserjr/Step_0.gml(3): 12,49,56
objects/obj_buzzybeetle/Alarm_10.gml(3): 18,26,37
objects/obj_buzzybeetle_b/Alarm_10.gml(3): 18,26,37
objects/obj_card_rocket/Step_0.gml(3): 4,11,28
objects/obj_checkpoint/Collision_obj_mario.gml(3): 9,15,41
objects/obj_checkpoint/Collision_obj_shell_held.gml(3): 9,15,41
objects/obj_checkpoint/Other_10.gml(3): 8,14,39
objects/obj_checkpoint/Other_7.gml(3): 6,15,43
objects/obj_coin_pow/Step_0.gml(3): 19,40,61
objects/obj_crumblebones/Other_10.gml(3): 22,29,36
objects/obj_crumblebony/Other_10.gml(3): 22,29,36
objects/obj_crumblebony_b/Other_10.gml(3): 22,29,36
objects/obj_deadmario/Create_0.gml(3): 2,84,89
objects/obj_door_lock/Other_7.gml(3): 5,10,16
objects/obj_door_lock_exit/Other_7.gml(3): 5,10,16
objects/obj_drybones/Other_10.gml(3): 21,28,35
objects/obj_egg/Create_0.gml(3): 8,18,23
objects/obj_firebro/Other_17.gml(3): 12,14,22
objects/obj_flagpole/Create_0.gml(3): 4,37,77
objects/obj_galoomba/Create_0.gml(3): 34,36,39
objects/obj_galoomba2/Create_0.gml(3): 35,37,39
objects/obj_galoomba2_b/Create_0.gml(3): 38,40,42
objects/obj_galoomba_b/Create_0.gml(3): 43,45,48
objects/obj_gold_explosion/Create_0.gml(3): 2,11,22
objects/obj_hammerbro/Other_17.gml(3): 12,14,22
objects/obj_icebro/Other_17.gml(3): 12,14,22
objects/obj_koopa/Step_0.gml(3): 10,15,73
objects/obj_koopa_red/Step_0.gml(3): 10,15,89
objects/obj_kuribo_drybones/Other_7.gml(3): 3,8,32
objects/obj_lakitu/Alarm_0.gml(3): 8,12,17
objects/obj_lakitu/Alarm_1.gml(3): 16,62,71
objects/obj_marioU/Other_13.gml(3): 20,56,155
objects/obj_monty_chase/Create_0.gml(3): 33,35,37
objects/obj_parent_resource/Alarm_0.gml(3): 5,57,59
objects/obj_penguin_suit/Alarm_10.gml(3): 5,10,15
objects/obj_pink_coin/Other_10.gml(3): 35,42,44
objects/obj_shell/Step_1.gml(3): 25,37,49
objects/obj_shell_drybones/Other_10.gml(3): 21,28,35
objects/obj_shell_drybones_held/Other_10.gml(3): 21,28,35
objects/obj_shell_held/Step_0.gml(3): 58,71,84
objects/obj_sledgebro/Step_0.gml(3): 12,14,22
objects/obj_spike/Alarm_0.gml(3): 25,28,31
objects/obj_spike/Create_0.gml(3): 50,52,55
objects/obj_spike/Step_0.gml(3): 106,125,127
objects/obj_waddlewing/Step_2.gml(3): 3,7,11
objects/obj_1up/Create_0.gml(2): 1,45
objects/obj_NSMBU_boomboom/Other_7.gml(2): 4,29
objects/obj_NSMBU_boomboom/Step_2.gml(2): 20,38
objects/obj_NSMBU_boomboom_b/Other_7.gml(2): 4,29
objects/obj_NSMBU_boomboom_b/Step_2.gml(2): 21,43
objects/obj_NSMBU_charginchuck/Alarm_10.gml(2): 11,21
objects/obj_NSMBU_ninji/Step_0.gml(2): 19,40
objects/obj_SMB3_bowser/Step_0.gml(2): 50,74
objects/obj_SMB_flag/Create_0.gml(2): 4,7
objects/obj_axe_smw/Create_0.gml(2): 21,23
objects/obj_beanstalk/Create_0.gml(2): 26,28
objects/obj_block/Create_0.gml(2): 42,44
objects/obj_block_pow_active/Alarm_0.gml(2): 72,86
objects/obj_block_pow_active/Create_0.gml(2): 25,31
objects/obj_blockcoin/Create_0.gml(2): 63,65
objects/obj_blooper/Create_0.gml(2): 30,32
objects/obj_blooper/Other_10.gml(2): 14,16
objects/obj_bobomb/Other_10.gml(2): 7,15
objects/obj_bobomb_hold/Alarm_1.gml(2): 4,6
objects/obj_bobomb_hold/Create_0.gml(2): 21,25
objects/obj_bonybeetle/Create_0.gml(2): 48,50
objects/obj_bonybeetle_b/Create_0.gml(2): 48,50
objects/obj_boo/Alarm_1.gml(2): 9,11
objects/obj_boo/Create_0.gml(2): 48,50
objects/obj_boo/Step_2.gml(2): 8,15
objects/obj_boomboom/Other_10.gml(2): 10,12
objects/obj_boomerangbro/Create_0.gml(2): 52,57
objects/obj_boomerangbro/Other_7.gml(2): 7,14
objects/obj_bortice/Create_0.gml(2): 1,7
objects/obj_bortice/Other_7.gml(2): 4,9
objects/obj_bowser_dead_castle/Alarm_0.gml(2): 19,24
objects/obj_bowserjr/Alarm_1.gml(2): 8,15
objects/obj_bowserjr/Alarm_11.gml(2): 59,69
objects/obj_bowserjr/Alarm_2.gml(2): 16,26
objects/obj_bowserjr_dead_castle/Alarm_0.gml(2): 19,24
objects/obj_bowserjr_shell/Create_0.gml(2): 38,40
objects/obj_bowserjr_shell/Other_10.gml(2): 7,10
objects/obj_bullebill_base/Alarm_0.gml(2): 30,63
objects/obj_bullebill_base_red/Alarm_0.gml(2): 35,73
objects/obj_bulletbill/Create_0.gml(2): 18,20
objects/obj_bulletbull_red/Create_0.gml(2): 18,21
objects/obj_button_time/Alarm_0.gml(2): 7,16
objects/obj_buzzy_ceiling/Create_0.gml(2): 2,4
objects/obj_buzzybeetle/Create_0.gml(2): 51,53
objects/obj_buzzybeetle/Other_10.gml(2): 11,15
objects/obj_buzzybeetle_b/Create_0.gml(2): 52,54
objects/obj_card_autoavance/Mouse_4.gml(2): 1,8
objects/obj_card_bg/Mouse_4.gml(2): 1,8
objects/obj_card_block_sounds/Other_12.gml(2): 5,14
objects/obj_card_condiciones/Mouse_4.gml(2): 1,8
objects/obj_card_rocket/Mouse_4.gml(2): 1,7
objects/obj_chain_chomp_free/Create_0.gml(2): 45,47
objects/obj_chain_chomp_free/Other_10.gml(2): 4,13
objects/obj_chain_chomp_free_b/Create_0.gml(2): 45,47
objects/obj_charginchuck/Alarm_10.gml(2): 10,20
objects/obj_charginchuck/Create_0.gml(2): 56,58
objects/obj_cheepcheep/Create_0.gml(2): 40,42
objects/obj_clown/Step_0.gml(2): 182,189
objects/obj_clown_explotion/Create_0.gml(2): 4,7
objects/obj_coin/Create_0.gml(2): 80,82
objects/obj_condiciones_button/Mouse_4.gml(2): 4,16
objects/obj_cooligan/Create_0.gml(2): 82,84
objects/obj_deadmario/Alarm_0.gml(2): 26,33
objects/obj_deadmario/Step_0.gml(2): 5,9
objects/obj_door/Other_7.gml(2): 3,24
objects/obj_door_exit/Other_7.gml(2): 3,24
objects/obj_door_lock_res/Other_11.gml(2): 8,34
objects/obj_door_res/Other_11.gml(2): 8,34
objects/obj_door_switch/Other_7.gml(2): 3,9
objects/obj_door_switch_exit/Create_0.gml(2): 25,26
objects/obj_door_switch_exit/Other_7.gml(2): 3,9
objects/obj_door_switch_res/Other_11.gml(2): 8,34
objects/obj_drybones/Create_0.gml(2): 39,41
objects/obj_egg/Alarm_1.gml(2): 26,41
objects/obj_egg/Alarm_10.gml(2): 7,22
objects/obj_egg_hatch/Alarm_0.gml(2): 2,4
objects/obj_enemy_dead_castle/Alarm_0.gml(2): 5,10
objects/obj_fireball/Create_0.gml(2): 19,23
objects/obj_fireball_bro/Create_0.gml(2): 19,23
objects/obj_firebro/Create_0.gml(2): 51,56
objects/obj_firebro/Other_7.gml(2): 7,14
objects/obj_flagpole/Alarm_1.gml(2): 9,15
objects/obj_floruga_body/Create_0.gml(2): 30,32
objects/obj_frozenmario/Alarm_1.gml(2): 7,15
objects/obj_goalcard/Alarm_3.gml(2): 9,15
objects/obj_goalgate/Alarm_0.gml(2): 9,15
objects/obj_hammerbro/Create_0.gml(2): 52,57
objects/obj_hammerbro/Other_7.gml(2): 7,14
objects/obj_hawmask/Alarm_1.gml(2): 5,11
objects/obj_hawmask/Other_7.gml(2): 3,21
objects/obj_icebro/Create_0.gml(2): 52,57
objects/obj_icebro/Other_7.gml(2): 7,14
objects/obj_invincibility/Create_0.gml(2): 27,30
objects/obj_key/Create_0.gml(2): 21,23
objects/obj_kuribo_drybones/Alarm_7.gml(2): 21,23
objects/obj_lakitu/Step_0.gml(2): 7,44
objects/obj_lave_draw/Step_0.gml(2): 32,38
objects/obj_logo_game/Mouse_4.gml(2): 1,8
objects/obj_magikoopa/Create_0.gml(2): 42,44
objects/obj_mario/Other_7.gml(2): 5,23
objects/obj_mario_pballon/Other_11.gml(2): 4,13
objects/obj_mario_transform2/Step_0.gml(2): 11,23
objects/obj_mariostart_m/Create_0.gml(2): 6,11
objects/obj_mechakoopa/Create_0.gml(2): 34,36
objects/obj_mushroom/Create_0.gml(2): 20,22
objects/obj_musicblock_res/Other_11.gml(2): 8,30
objects/obj_noteblock_res/Other_11.gml(2): 8,30
objects/obj_noteblock_s_res/Other_11.gml(2): 8,30
objects/obj_onewaygate_bottom/Create_0.gml(2): 18,20
objects/obj_onewaygate_left/Create_0.gml(2): 18,20
objects/obj_onewaygate_right/Create_0.gml(2): 18,20
objects/obj_onewaygate_top/Create_0.gml(2): 18,20
objects/obj_panel_time/Mouse_4.gml(2): 1,8
objects/obj_pballon/Step_0.gml(2): 26,31
objects/obj_pink_coin/Create_0.gml(2): 23,25
objects/obj_plant_fire/Alarm_2.gml(2): 9,13
objects/obj_plant_fire/Alarm_4.gml(2): 3,5
objects/obj_plant_fire/Create_0.gml(2): 48,50
objects/obj_plant_fire/Other_7.gml(2): 4,13
objects/obj_plantfire/Create_0.gml(2): 16,20
objects/obj_player_goal_smw/Step_0.gml(2): 55,65
objects/obj_player_goal_smw_castle/Create_0.gml(2): 10,15
objects/obj_robot/Mouse_4.gml(2): 1,3
objects/obj_rocangrejo/Alarm_0.gml(2): 19,22
objects/obj_rocangrejo/Create_0.gml(2): 34,36
objects/obj_rocangrejo/Other_12.gml(2): 19,21
objects/obj_shell_held/Create_0.gml(2): 22,24
objects/obj_sledgebro/Create_0.gml(2): 40,42
objects/obj_sledgebro/Other_7.gml(2): 7,14
objects/obj_smoke_goomba/Create_0.gml(2): 4,7
objects/obj_snowball_bro/Create_0.gml(2): 23,27
objects/obj_soplete_global/Other_7.gml(2): 6,8
objects/obj_soplete_invert_global/Other_7.gml(2): 6,8
objects/obj_sparkles_blend/Create_0.gml(2): 16,26
objects/obj_sparkles_coin/Create_0.gml(2): 15,17
objects/obj_sparkletrail/Create_0.gml(2): 4,7
objects/obj_spike/Other_7.gml(2): 7,11
objects/obj_spinsmoke/Create_0.gml(2): 4,9
objects/obj_spinthump/Create_0.gml(2): 4,7
objects/obj_spiny/Alarm_3.gml(2): 4,10
objects/obj_spiny/Create_0.gml(2): 36,38
objects/obj_splash_agua/Create_0.gml(2): 12,14
objects/obj_splash_lava/Create_0.gml(2): 12,14
objects/obj_splash_posion/Create_0.gml(2): 12,14
objects/obj_spring/Collision_obj_holdparent.gml(2): 12,13
objects/obj_spring/Collision_obj_physicsparent.gml(2): 21,22
objects/obj_spring/Collision_obj_powerupparent.gml(2): 12,13
objects/obj_title_oprime/Mouse_4.gml(2): 14,32
objects/obj_torbellino/Create_0.gml(2): 18,20
objects/obj_waddlewing/Create_0.gml(2): 58,60
objects/cre_control/Create_0.gml(1): 1
objects/obj_1up/Step_0.gml(1): 34
objects/obj_NSMBU_boomboom/Alarm_2.gml(1): 3
objects/obj_NSMBU_boomboom/Alarm_3.gml(1): 3
objects/obj_NSMBU_boomboom/Alarm_4.gml(1): 4
objects/obj_NSMBU_boomboom/Alarm_5.gml(1): 2
objects/obj_NSMBU_boomboom/Alarm_7.gml(1): 2
objects/obj_NSMBU_boomboom/Create_0.gml(1): 22
objects/obj_NSMBU_boomboom/Other_10.gml(1): 10
objects/obj_NSMBU_boomboom/Other_11.gml(1): 44
objects/obj_NSMBU_boomboom/Other_14.gml(1): 24
objects/obj_NSMBU_boomboom/Other_17.gml(1): 6
objects/obj_NSMBU_boomboom_b/Alarm_2.gml(1): 3
objects/obj_NSMBU_boomboom_b/Alarm_3.gml(1): 3
objects/obj_NSMBU_boomboom_b/Alarm_4.gml(1): 4
objects/obj_NSMBU_boomboom_b/Alarm_5.gml(1): 2
objects/obj_NSMBU_boomboom_b/Alarm_7.gml(1): 2
objects/obj_NSMBU_boomboom_b/Create_0.gml(1): 22
objects/obj_NSMBU_boomboom_b/Other_10.gml(1): 10
objects/obj_NSMBU_boomboom_b/Other_11.gml(1): 44
objects/obj_NSMBU_boomboom_b/Other_14.gml(1): 24
objects/obj_NSMBU_boomboom_b/Other_17.gml(1): 6
objects/obj_NSMBU_bowser/Create_0.gml(1): 14
objects/obj_NSMBU_bowser/Step_0.gml(1): 50
objects/obj_NSMBU_bowser_fire/Create_0.gml(1): 2
objects/obj_NSMBU_bowser_fire_up/Create_0.gml(1): 1
objects/obj_NSMBU_bowserjr/Alarm_2.gml(1): 9
objects/obj_NSMBU_bowserjr/Alarm_9.gml(1): 5
objects/obj_NSMBU_bowserjr/Create_0.gml(1): 20
objects/obj_NSMBU_bowserjr/Other_10.gml(1): 4
objects/obj_NSMBU_bowserjr/Other_11.gml(1): 28
objects/obj_NSMBU_bowserjr/Step_0.gml(1): 48
objects/obj_NSMBU_bowserjr_b/Create_0.gml(1): 20
objects/obj_NSMBU_bowserjr_fire/Create_0.gml(1): 2
objects/obj_NSMBU_charginchuck/Alarm_1.gml(1): 4
objects/obj_NSMBU_charginchuck/Other_10.gml(1): 4
objects/obj_NSMBU_charginchuck/Other_11.gml(1): 23
objects/obj_NSMBU_charginchuck/Other_7.gml(1): 4
objects/obj_NSMBU_flag_mario/Create_0.gml(1): 4
objects/obj_NSMBU_ninji/Alarm_0.gml(1): 17
objects/obj_NSMBU_ninji/Create_0.gml(1): 25
objects/obj_SMB2_mushroom/Collision_obj_mario.gml(1): 20
objects/obj_SMB2_mushroom/Step_0.gml(1): 71
objects/obj_SMB2_mushroom_res/Other_11.gml(1): 4
objects/obj_SMB3_bowser/Alarm_1.gml(1): 2
objects/obj_SMB3_bowser/Alarm_11.gml(1): 10
objects/obj_SMB3_bowser/Alarm_3.gml(1): 4
objects/obj_SMB3_bowser/Alarm_5.gml(1): 2
objects/obj_SMB3_bowser/Create_0.gml(1): 9
objects/obj_SMB3_bowser/Step_2.gml(1): 3
objects/obj_SMB_bowser/Alarm_1.gml(1): 2
objects/obj_SMB_bowser/Alarm_2.gml(1): 21
objects/obj_SMB_bowser/Create_0.gml(1): 5
objects/obj_SMB_castle/Create_0.gml(1): 39
objects/obj_SMB_castle_front/Create_0.gml(1): 1
objects/obj_SMB_flag/Alarm_1.gml(1): 4
objects/obj_SMW_bowser/Create_0.gml(1): 10
objects/obj_SMW_bowser/Step_0.gml(1): 51
objects/obj_ahh_or/Other_10.gml(1): 5
objects/obj_ahh_snd_res/Other_11.gml(1): 4
objects/obj_alert_close/Create_0.gml(1): 1
objects/obj_alert_condicion/Create_0.gml(1): 1
objects/obj_angrysun/Alarm_0.gml(1): 6
objects/obj_angrysun_res/Other_11.gml(1): 4
objects/obj_anti_pblock/Create_0.gml(1): 17
objects/obj_apariencia/Create_0.gml(1): 1
objects/obj_apariencia/Mouse_4.gml(1): 1
objects/obj_apariencia/Other_10.gml(1): 2
objects/obj_apariencia/Other_7.gml(1): 3
objects/obj_apariencia/Step_1.gml(1): 1
objects/obj_aplausos_or/Other_10.gml(1): 5
objects/obj_aplausos_snd_res/Other_11.gml(1): 4
objects/obj_arrow/Create_0.gml(1): 1
objects/obj_auh_snd_res/Other_11.gml(1): 4
objects/obj_autoavance/Create_0.gml(1): 1
objects/obj_autoavance/Mouse_4.gml(1): 1
objects/obj_autoavance/Other_10.gml(1): 1
objects/obj_autoavance/Other_7.gml(1): 3
objects/obj_autoavance/Step_1.gml(1): 1
objects/obj_banzaibill/Other_10.gml(1): 5
objects/obj_banzaibill/Other_11.gml(1): 4
objects/obj_beachkoopa/Create_0.gml(1): 16
objects/obj_beachkoopa/Step_0.gml(1): 12
objects/obj_beachkoopa_b/Step_0.gml(1): 12
objects/obj_beanstalk/Collision_obj_solid.gml(1): 6
objects/obj_beanstalk/Collision_obj_solidtop.gml(1): 6
objects/obj_bebe_or/Other_10.gml(1): 5
objects/obj_bebe_snd_res/Other_11.gml(1): 4
objects/obj_bg1/Create_0.gml(1): 1
objects/obj_bg_selection/Create_0.gml(1): 1
objects/obj_bg_selection/Mouse_4.gml(1): 1
objects/obj_bg_selection/Other_10.gml(1): 2
objects/obj_bg_selection/Other_7.gml(1): 3
objects/obj_big_plant_b_dead/Create_0.gml(1): 1
objects/obj_big_plant_dead/Create_0.gml(1): 1
objects/obj_big_pplant/Create_0.gml(1): 2
objects/obj_big_pplant_b/Create_0.gml(1): 2
objects/obj_billbanzai_red/Create_0.gml(1): 1
objects/obj_billbanzai_red/Other_11.gml(1): 3
objects/obj_billbanzai_red_res/Other_11.gml(1): 4
objects/obj_billbanzai_res/Other_11.gml(1): 4
objects/obj_bl2/Create_0.gml(1): 1
objects/obj_block/Draw_0.gml(1): 2
objects/obj_block_coinchain/Create_0.gml(1): 1
objects/obj_block_gold/Draw_0.gml(1): 2
objects/obj_block_gold_res/Other_11.gml(1): 4
objects/obj_block_hidden/Create_0.gml(1): 17
objects/obj_block_multicoin/Create_0.gml(1): 45
objects/obj_block_multicoin/Draw_0.gml(1): 2
objects/obj_block_pow_hold/Create_0.gml(1): 18
objects/obj_block_res/Other_11.gml(1): 4
objects/obj_block_rock/Create_0.gml(1): 1
objects/obj_blockparent/Draw_0.gml(1): 2
objects/obj_bobomb/Step_0.gml(1): 57
objects/obj_bobomb_hold/Alarm_2.gml(1): 1
objects/obj_bobomb_hold/Alarm_4.gml(1): 5
objects/obj_bobomb_ready/Alarm_0.gml(1): 5
objects/obj_bobomb_ready_res/Other_11.gml(1): 4
objects/obj_bobomb_res/Other_11.gml(1): 4
objects/obj_bocina_or/Other_10.gml(1): 5
objects/obj_bocina_snd_res/Other_11.gml(1): 4
objects/obj_bombilla_or/Other_10.gml(1): 5
objects/obj_bombilla_snd_res/Other_11.gml(1): 4
objects/obj_bone/Create_0.gml(1): 1
objects/obj_bones_yoshi/Create_0.gml(1): 1
objects/obj_bones_yoshi_one/Create_0.gml(1): 1
objects/obj_bonus_or/Create_0.gml(1): 1
objects/obj_bonus_trail/Create_0.gml(1): 1
objects/obj_bonybeetle/Alarm_0.gml(1): 5
objects/obj_bonybeetle/Alarm_1.gml(1): 2
objects/obj_bonybeetle/Alarm_2.gml(1): 2
objects/obj_bonybeetle_b/Alarm_0.gml(1): 5
objects/obj_boo/Alarm_0.gml(1): 21
objects/obj_boo/Other_7.gml(1): 3
objects/obj_boomboom/Alarm_10.gml(1): 1
objects/obj_boomboom/Alarm_11.gml(1): 3
objects/obj_boomboom/Alarm_2.gml(1): 2
objects/obj_boomboom/Alarm_3.gml(1): 24
objects/obj_boomboom/Alarm_4.gml(1): 2
objects/obj_boomboom/Alarm_9.gml(1): 1
objects/obj_boomboom/Create_0.gml(1): 43
objects/obj_boomboom/Other_11.gml(1): 69
objects/obj_boomboom/Other_17.gml(1): 4
objects/obj_boomboom/Other_7.gml(1): 11
objects/obj_boomboom/Step_2.gml(1): 41
objects/obj_boomboom_b/Alarm_10.gml(1): 1
objects/obj_boomboom_b/Alarm_11.gml(1): 3
objects/obj_boomboom_b/Alarm_3.gml(1): 24
objects/obj_boomboom_b/Alarm_4.gml(1): 2
objects/obj_boomboom_b/Alarm_9.gml(1): 1
objects/obj_boomboom_b/Create_0.gml(1): 43
objects/obj_boomboom_b/Other_11.gml(1): 69
objects/obj_boomboom_b/Step_2.gml(1): 41
objects/obj_boomerang/Create_0.gml(1): 17
objects/obj_boomerangbro/Alarm_2.gml(1): 17
objects/obj_boomerangbro/Alarm_7.gml(1): 8
objects/obj_boomerangbro_res/Other_11.gml(1): 4
objects/obj_boss_or/Create_0.gml(1): 1
objects/obj_bossparent/Step_0.gml(1): 15
objects/obj_bouncycloud/Create_0.gml(1): 76
objects/obj_bowser_fire/Create_0.gml(1): 17
objects/obj_bowser_fire_down/Create_0.gml(1): 1
objects/obj_bowserfire_up/Create_0.gml(1): 1
objects/obj_bowserjr/Alarm_3.gml(1): 6
objects/obj_bowserjr/Alarm_9.gml(1): 4
objects/obj_bowserjr/Create_0.gml(1): 45
objects/obj_bowserjr/Other_10.gml(1): 5
objects/obj_bowserjr/Other_14.gml(1): 135
objects/obj_bowserjr/Other_7.gml(1): 6
objects/obj_bowserjr_fire/Create_0.gml(1): 1
objects/obj_bowserjr_shell/Alarm_1.gml(1): 8
objects/obj_brickhelmet/Create_0.gml(1): 44
objects/obj_bt_close_water/Create_0.gml(1): 1
objects/obj_bt_gb_close/Create_0.gml(1): 1
objects/obj_bt_gb_delete/Create_0.gml(1): 1
objects/obj_bt_gb_play/Create_0.gml(1): 1
objects/obj_bt_rename/Create_0.gml(1): 1
objects/obj_btn_header_parent/Create_0.gml(1): 1
objects/obj_btn_reload/Create_0.gml(1): 1
objects/obj_btn_settings_hd/Create_0.gml(1): 1
objects/obj_btn_social/Create_0.gml(1): 1
objects/obj_bubble/Create_0.gml(1): 1
objects/obj_bullebill_base/Create_0.gml(1): 43
objects/obj_bullebill_base/Other_10.gml(1): 3
objects/obj_bullebill_base_red/Create_0.gml(1): 33
objects/obj_bullebill_base_red_res/Other_11.gml(1): 4
objects/obj_bullebill_base_res/Other_11.gml(1): 4
objects/obj_bulletbill/Other_10.gml(1): 20
objects/obj_bulletbill/Other_11.gml(1): 4
objects/obj_bulletbull_red/Other_10.gml(1): 4
objects/obj_bulletbull_red/Other_11.gml(1): 3
objects/obj_bumper/Create_0.gml(1): 17
objects/obj_button_close/Create_0.gml(1): 1
objects/obj_button_close_menu/Create_0.gml(1): 1
objects/obj_button_creditos/Create_0.gml(1): 1
objects/obj_button_home/Create_0.gml(1): 4
objects/obj_button_meteoritos/Create_0.gml(1): 1
objects/obj_button_meteoritos/Mouse_4.gml(1): 1
objects/obj_button_notification_cancelar/Create_0.gml(1): 1
objects/obj_button_parent/Create_0.gml(1): 1
objects/obj_button_save_changes/Create_0.gml(1): 1
objects/obj_button_save_load/Create_0.gml(1): 1
objects/obj_button_sdog/Create_0.gml(1): 1
objects/obj_button_sdog/Mouse_4.gml(1): 1
objects/obj_button_settings_controls/Create_0.gml(1): 1
objects/obj_button_settings_estrella/Create_0.gml(1): 1
objects/obj_button_settings_idioma/Create_0.gml(1): 1
objects/obj_button_settings_sm4j/Create_0.gml(1): 1
objects/obj_button_settings_sombras/Create_0.gml(1): 1
objects/obj_button_sombras/Create_0.gml(1): 1
objects/obj_button_speed_water/Create_0.gml(1): 1
objects/obj_button_time/Create_0.gml(1): 1
objects/obj_button_trail/Create_0.gml(1): 1
objects/obj_button_trail/Mouse_4.gml(1): 1
objects/obj_button_wings/Create_0.gml(1): 17
objects/obj_buzzy_shell_res/Other_11.gml(1): 4
objects/obj_buzzybeetle_res/Other_11.gml(1): 4
objects/obj_cannon/Alarm_0.gml(1): 15
objects/obj_cannon/Create_0.gml(1): 33
objects/obj_cannon/Other_10.gml(1): 3
objects/obj_cannon_red/Alarm_0.gml(1): 15
objects/obj_cannon_red/Other_10.gml(1): 10
objects/obj_cannon_red_res/Other_11.gml(1): 4
objects/obj_cannon_res/Other_11.gml(1): 4
objects/obj_cannonball/Create_0.gml(1): 21
objects/obj_cannonball/Other_10.gml(1): 4
objects/obj_cannonball/Other_11.gml(1): 4
objects/obj_cannonball_red/Other_10.gml(1): 4
objects/obj_cannonball_red/Other_11.gml(1): 4
objects/obj_cap/Create_0.gml(1): 9
objects/obj_cap_mario/Create_0.gml(1): 1
objects/obj_cap_res/Other_13.gml(1): 4
objects/obj_card_autoavance/Create_0.gml(1): 3
objects/obj_card_bg/Create_0.gml(1): 3
objects/obj_card_block_sounds/Create_0.gml(1): 1
objects/obj_card_block_sounds/Mouse_4.gml(1): 1
objects/obj_card_bout/Create_0.gml(1): 1
objects/obj_card_bout/Mouse_4.gml(1): 1
objects/obj_card_circle/Create_0.gml(1): 20
objects/obj_card_condiciones/Create_0.gml(1): 5
objects/obj_card_item/Create_0.gml(1): 19
objects/obj_card_logo/Create_0.gml(1): 1
objects/obj_card_rocket/Create_0.gml(1): 4
objects/obj_castle/Alarm_0.gml(1): 1
objects/obj_castle/Create_0.gml(1): 17
objects/obj_castle/Other_7.gml(1): 1
objects/obj_castle_floor/Create_0.gml(1): 1
objects/obj_castle_front/Create_0.gml(1): 1
objects/obj_ccred/Create_0.gml(1): 1
objects/obj_cerdito_snd_res/Other_11.gml(1): 4
objects/obj_charginchuck/Alarm_1.gml(1): 4
objects/obj_charginchuck/Other_10.gml(1): 4
objects/obj_charginchuck/Other_11.gml(1): 28
objects/obj_charginchuck/Other_7.gml(1): 4
objects/obj_charginchuck_res/Other_11.gml(1): 4
objects/obj_cheepcheep/Alarm_1.gml(1): 15
objects/obj_cheepcheep2_res/Other_11.gml(1): 4
objects/obj_cheepcheep_res/Other_11.gml(1): 4
objects/obj_chisporreo_or/Other_10.gml(1): 5
objects/obj_chisporreteo_snd_res/Other_11.gml(1): 4
objects/obj_cinta/Create_0.gml(1): 58
objects/obj_cinta_on_res/Other_11.gml(1): 4
objects/obj_cinta_res/Other_11.gml(1): 4
objects/obj_cinta_switch/Create_0.gml(1): 28
objects/obj_cloud_lakitu/Create_0.gml(1): 18
objects/obj_cloud_lakitu/Step_0.gml(1): 144
objects/obj_clown/Create_0.gml(1): 1
objects/obj_clown/Other_10.gml(1): 4
objects/obj_clown_fire_res/Other_11.gml(1): 4
objects/obj_clown_res/Other_11.gml(1): 4
objects/obj_coin/Draw_0.gml(1): 2
objects/obj_coin10/Create_0.gml(1): 58
objects/obj_coin10/Draw_0.gml(1): 3
objects/obj_coin10/Other_10.gml(1): 15
objects/obj_coin10_res/Other_11.gml(1): 4
objects/obj_coin30/Create_0.gml(1): 58
objects/obj_coin30_res/Other_11.gml(1): 4
objects/obj_coin50/Create_0.gml(1): 58
objects/obj_coin50_res/Other_11.gml(1): 4
objects/obj_coin_pow/Draw_0.gml(1): 1
objects/obj_coin_res/Other_11.gml(1): 4
objects/obj_coinchain/Create_0.gml(1): 2
objects/obj_condiciones/Create_0.gml(1): 1
objects/obj_condiciones/Mouse_4.gml(1): 1
objects/obj_condiciones/Other_10.gml(1): 1
objects/obj_condiciones/Other_7.gml(1): 3
objects/obj_condiciones/Step_1.gml(1): 1
objects/obj_condiciones_button/Create_0.gml(1): 1
objects/obj_configurar_controles/Create_0.gml(1): 1
objects/obj_configurar_controles_reset/Create_0.gml(1): 1
objects/obj_cooligan_res/Create_0.gml(1): 27
objects/obj_create_account/Create_0.gml(1): 1
objects/obj_creation_preview/Create_0.gml(1): 2
objects/obj_creator_jugar_editar/Create_0.gml(1): 3
objects/obj_creator_jugar_editar/Mouse_4.gml(1): 1
objects/obj_creator_jugar_editar/Other_10.gml(1): 1
objects/obj_creator_jugar_editar/Other_11.gml(1): 1
objects/obj_creator_jugar_editar/Other_7.gml(1): 1
objects/obj_crumblebones/Alarm_1.gml(1): 7
objects/obj_crumblebones/Other_7.gml(1): 3
objects/obj_crumblebony/Alarm_1.gml(1): 6
objects/obj_crumblebony/Other_7.gml(1): 3
objects/obj_crumblebony/Step_2.gml(1): 1
objects/obj_crumblebony_b/Alarm_1.gml(1): 6
objects/obj_crumblebony_b/Other_7.gml(1): 3
objects/obj_crumblebony_b/Step_2.gml(1): 1
objects/obj_crystalorb/Create_0.gml(1): 9
objects/obj_cursor/Create_0.gml(1): 22
objects/obj_decoracion_1/Other_13.gml(1): 5
objects/obj_decoracion_2/Other_13.gml(1): 5
objects/obj_decoracion_3/Other_13.gml(1): 5
objects/obj_decoracion_4/Other_13.gml(1): 5
objects/obj_destello_or/Other_10.gml(1): 5
objects/obj_destello_snd_res/Other_11.gml(1): 4
objects/obj_detroy_enemy/Create_0.gml(1): 1
objects/obj_dog/Create_0.gml(1): 1
objects/obj_donut/Create_0.gml(1): 45
objects/obj_door/Alarm_0.gml(1): 27
objects/obj_door/Alarm_1.gml(1): 22
objects/obj_door/Create_0.gml(1): 17
objects/obj_door/Step_0.gml(1): 11
objects/obj_door_exit/Alarm_0.gml(1): 27
objects/obj_door_exit/Alarm_1.gml(1): 22
objects/obj_door_exit/Create_0.gml(1): 17
objects/obj_door_exit/Step_0.gml(1): 11
objects/obj_door_lock/Alarm_0.gml(1): 27
objects/obj_door_lock/Alarm_1.gml(1): 7
objects/obj_door_lock/Alarm_3.gml(1): 2
objects/obj_door_lock/Create_0.gml(1): 25
objects/obj_door_lock_exit/Alarm_0.gml(1): 27
objects/obj_door_lock_exit/Alarm_1.gml(1): 7
objects/obj_door_lock_exit/Alarm_3.gml(1): 2
objects/obj_door_lock_exit/Create_0.gml(1): 25
objects/obj_door_switch/Alarm_0.gml(1): 27
objects/obj_door_switch/Alarm_1.gml(1): 7
objects/obj_door_switch/Create_0.gml(1): 25
objects/obj_door_switch/Step_0.gml(1): 15
objects/obj_door_switch_exit/Alarm_0.gml(1): 27
objects/obj_door_switch_exit/Alarm_1.gml(1): 7
objects/obj_door_switch_exit/Step_0.gml(1): 15
objects/obj_doormario/Create_0.gml(1): 1
objects/obj_doormario_exit/Create_0.gml(1): 1
objects/obj_drybones/Alarm_0.gml(1): 6
objects/obj_drybones/Alarm_1.gml(1): 1
objects/obj_drybones/Alarm_2.gml(1): 1
objects/obj_drybones/Other_7.gml(1): 22
objects/obj_drybones_res/Other_11.gml(1): 4
objects/obj_edit_menu/Create_0.gml(1): 3
objects/obj_editor_screen/Create_0.gml(1): 1
objects/obj_efecto_musica/Create_0.gml(1): 1
objects/obj_efecto_musica_bonus/Create_0.gml(1): 1
objects/obj_efecto_sonido/Create_0.gml(1): 1
objects/obj_effect_link/Create_0.gml(1): 1
objects/obj_effect_touch/Create_0.gml(1): 1
objects/obj_egg/Other_7.gml(1): 6
objects/obj_egg_red_res/Create_0.gml(1): 6
objects/obj_egg_red_res/Other_11.gml(1): 4
objects/obj_egg_red_res/Other_7.gml(1): 3
objects/obj_egg_res/Create_0.gml(1): 5
objects/obj_egg_res/Other_11.gml(1): 4
objects/obj_egg_res/Other_7.gml(1): 3
objects/obj_enemy_dead/Create_0.gml(1): 10
objects/obj_enemy_dead_castle/Create_0.gml(1): 1
objects/obj_enemy_multidead/Alarm_0.gml(1): 5
objects/obj_enemy_multidead/Create_0.gml(1): 1
objects/obj_enemyfrozen/Alarm_5.gml(1): 12
objects/obj_enemyfrozen/Create_0.gml(1): 2
objects/obj_enemyparent_held/Step_0.gml(1): 31
objects/obj_enemyparent_lava/Alarm_0.gml(1): 2
objects/obj_enemyparent_lava/Create_0.gml(1): 1
objects/obj_erase/Create_0.gml(1): 5
objects/obj_erase/Other_10.gml(1): 1
objects/obj_error_or/Other_10.gml(1): 5
objects/obj_error_snd_res/Other_11.gml(1): 4
objects/obj_espina/Create_0.gml(1): 1
objects/obj_etiquetas/Create_0.gml(1): 1
objects/obj_expand/Mouse_4.gml(1): 1
objects/obj_expand_paneles_top/Mouse_4.gml(1): 1
objects/obj_expand_panels/Mouse_4.gml(1): 1
objects/obj_expand_panels_left/Mouse_4.gml(1): 1
objects/obj_fast_lava_lift_res/Other_11.gml(1): 4
objects/obj_fire_clown/Create_0.gml(1): 16
objects/obj_fireball_b/Create_0.gml(1): 16
objects/obj_firebar/Create_0.gml(1): 1
objects/obj_firebro/Alarm_2.gml(1): 17
objects/obj_firebro/Alarm_7.gml(1): 8
objects/obj_firebro_res/Other_11.gml(1): 4
objects/obj_fireflower_res/Other_11.gml(1): 4
objects/obj_fireflower_res/Other_13.gml(1): 4
objects/obj_fishbone/Create_0.gml(1): 16
objects/obj_flipblock/Draw_0.gml(1): 2
objects/obj_flipblock_anim/Create_0.gml(1): 1
objects/obj_floruga/Other_11.gml(1): 11
objects/obj_floruga_angry_res/Other_11.gml(1): 4
objects/obj_floruga_res/Other_11.gml(1): 4
objects/obj_foo/Other_10.gml(1): 7
objects/obj_foo_res/Other_11.gml(1): 4
objects/obj_frogsuit/Create_0.gml(1): 2
objects/obj_frogsuit_res/Other_11.gml(1): 4
objects/obj_frogsuit_res/Other_13.gml(1): 4
objects/obj_frozenmario/Create_0.gml(1): 1
objects/obj_fuegos_or/Other_10.gml(1): 5
objects/obj_fuegos_snd_res/Other_11.gml(1): 4
objects/obj_galoomba_hold/Create_0.gml(1): 2
objects/obj_game_over/Create_0.gml(1): 10
objects/obj_game_over/Other_7.gml(1): 1
objects/obj_getshoe/Create_0.gml(1): 1
objects/obj_goalcard/Create_0.gml(1): 1
objects/obj_goalcard_get/Create_0.gml(1): 1
objects/obj_goalgate/Create_0.gml(1): 1
objects/obj_goalgate_front/Create_0.gml(1): 1
objects/obj_goalgate_tape/Create_0.gml(1): 1
objects/obj_golpe_gato_or/Other_10.gml(1): 5
objects/obj_golpe_gato_snd_res/Other_11.gml(1): 4
objects/obj_goomba_b_res/Other_11.gml(1): 4
objects/obj_goomba_intro/Create_0.gml(1): 1
objects/obj_goomba_res/Other_11.gml(1): 4
objects/obj_goombrat_b_res/Other_11.gml(1): 4
objects/obj_goombrat_res/Other_11.gml(1): 4
objects/obj_grinder/Create_0.gml(1): 1
objects/obj_grinder_res/Alarm_0.gml(1): 51
objects/obj_ground/Other_13.gml(1): 26
objects/obj_ground2/Create_0.gml(1): 2
objects/obj_ground3/Create_0.gml(1): 2
objects/obj_grrrol/Create_0.gml(1): 1
objects/obj_grrrol_b/Create_0.gml(1): 1
objects/obj_grrrol_new/Create_0.gml(1): 1
objects/obj_hammer/Create_0.gml(1): 3
objects/obj_hammerbro/Alarm_2.gml(1): 17
objects/obj_hammerbro/Alarm_7.gml(1): 8
objects/obj_hammerbro_res/Other_11.gml(1): 4
objects/obj_hammersuit/Create_0.gml(1): 2
objects/obj_hawmask/Alarm_0.gml(1): 1
objects/obj_hawmask/Create_0.gml(1): 3
objects/obj_header/Create_0.gml(1): 1
objects/obj_helmet/Create_0.gml(1): 2
objects/obj_helmet/Other_16.gml(1): 4
objects/obj_helmet_spiny/Other_16.gml(1): 4
objects/obj_hen_mushroom/Create_0.gml(1): 1
objects/obj_hen_mushroom_res/Other_11.gml(1): 4
objects/obj_hen_mushroom_res/Other_13.gml(1): 4
objects/obj_holdparent/Create_0.gml(1): 1
objects/obj_holdparent/Step_0.gml(1): 30
objects/obj_icebro/Alarm_2.gml(1): 17
objects/obj_icebro/Alarm_7.gml(1): 8
objects/obj_icebro_res/Other_11.gml(1): 4
objects/obj_icecoin/Create_0.gml(1): 55
objects/obj_icecoin_res/Other_11.gml(1): 4
objects/obj_icicle/Create_0.gml(1): 1
objects/obj_icicle2/Create_0.gml(1): 1
objects/obj_icicle2_res/Other_11.gml(1): 4
objects/obj_icicle_res/Other_11.gml(1): 4
objects/obj_icon_dead/Create_0.gml(1): 1
objects/obj_icon_dead/Other_7.gml(1): 1
objects/obj_iname/Create_0.gml(1): 7
objects/obj_iname_close/Create_0.gml(1): 1
objects/obj_iname_control/Create_0.gml(1): 1
objects/obj_iname_control2/Create_0.gml(1): 1
objects/obj_input/Create_0.gml(1): 7
objects/obj_input_desc/Create_0.gml(1): 8
objects/obj_input_rename/Create_0.gml(1): 7
objects/obj_intro_controller/Create_0.gml(1): 1
objects/obj_jumppiranha/Alarm_0.gml(1): 7
objects/obj_jumppiranha/Other_14.gml(1): 22
objects/obj_key/Collision_obj_mario.gml(1): 11
objects/obj_key_appear/Alarm_1.gml(1): 11
objects/obj_key_appear/Create_0.gml(1): 21
objects/obj_key_appear/Other_11.gml(1): 11
objects/obj_key_fallow/Create_0.gml(1): 17
objects/obj_koopa/Alarm_10.gml(1): 4
objects/obj_koopa_b/Alarm_10.gml(1): 4
objects/obj_koopa_b_res/Other_11.gml(1): 4
objects/obj_koopa_red/Alarm_10.gml(1): 6
objects/obj_koopa_red_b/Alarm_10.gml(1): 6
objects/obj_koopa_red_b_res/Other_11.gml(1): 4
objects/obj_koopa_red_res/Other_11.gml(1): 4
objects/obj_koopa_res/Other_11.gml(1): 4
objects/obj_kuribo_drybones/Create_0.gml(1): 21
objects/obj_kuribo_drybones/Other_15.gml(1): 5
objects/obj_kuriboshoe/Create_0.gml(1): 4
objects/obj_kuriboshoe2/Create_0.gml(1): 4
objects/obj_lakitu/Alarm_2.gml(1): 7
objects/obj_lakitu/Other_7.gml(1): 8
objects/obj_lava_lift_res/Other_11.gml(1): 4
objects/obj_lava_water/Create_0.gml(1): 1
objects/obj_lava_water/Step_2.gml(1): 20
objects/obj_lave_draw/Create_0.gml(1): 1
objects/obj_levelmanager/Alarm_11.gml(1): 50
objects/obj_levelmanager/Alarm_2.gml(1): 5
objects/obj_levelmanager/Step_2.gml(1): 2
objects/obj_link/Alarm_0.gml(1): 1
objects/obj_link/Create_0.gml(1): 1
objects/obj_link/Other_17.gml(1): 1
objects/obj_link_arrow/Create_0.gml(1): 3
objects/obj_link_arrow_anim/Create_0.gml(1): 1
objects/obj_link_atack/Create_0.gml(1): 2
objects/obj_link_bomb/Alarm_10.gml(1): 6
objects/obj_link_bomb/Alarm_4.gml(1): 14
objects/obj_link_bomb/Other_13.gml(1): 26
objects/obj_link_dash_atack/Create_0.gml(1): 1
objects/obj_link_down_atack/Create_0.gml(1): 1
objects/obj_link_down_atack/Other_7.gml(1): 1
objects/obj_link_res/Create_0.gml(1): 5
objects/obj_load_btn_c/Create_0.gml(1): 1
objects/obj_load_image/Create_0.gml(1): 1
objects/obj_login_control/Create_0.gml(1): 1
objects/obj_lp/Create_0.gml(1): 7
objects/obj_lun/Create_0.gml(1): 8
objects/obj_magic/Alarm_0.gml(1): 3
objects/obj_magic/Create_0.gml(1): 19
objects/obj_magikoopa/Alarm_0.gml(1): 29
objects/obj_magikoopa/Alarm_3.gml(1): 2
objects/obj_mario/Alarm_11.gml(1): 13
objects/obj_mario/Other_13.gml(1): 57
objects/obj_marioU/Other_19.gml(1): 13
objects/obj_mario_editor/Create_0.gml(1): 3
objects/obj_mario_intro/Create_0.gml(1): 1
objects/obj_mario_pballon/Create_0.gml(1): 19
objects/obj_mario_temp/Create_0.gml(1): 5
objects/obj_mario_transform2/Destroy_0.gml(1): 59
objects/obj_mariostart_m/Other_7.gml(1): 3
objects/obj_mechakoopa/Other_10.gml(1): 10
objects/obj_mechakoopa_held/Alarm_1.gml(1): 5
objects/obj_mechakoopa_held/Alarm_2.gml(1): 5
objects/obj_mechakoopa_held/Other_10.gml(1): 10
objects/obj_mechakoopa_res/Other_11.gml(1): 4
objects/obj_menu_editor/Mouse_4.gml(1): 1
objects/obj_menu_pausa/Create_0.gml(1): 1
objects/obj_mini_icicle2_res/Other_11.gml(1): 4
objects/obj_mini_icicle_res/Other_11.gml(1): 4
objects/obj_monty_chase/Step_0.gml(1): 85
objects/obj_multiveggiecoin/Alarm_0.gml(1): 8
objects/obj_multiveggiecoin/Create_0.gml(1): 1
objects/obj_mushroom/Collision_obj_mario.gml(1): 20
objects/obj_mushroom/Step_0.gml(1): 64
objects/obj_mushroom_platform_res/Other_11.gml(1): 4
objects/obj_musicblock/Alarm_1.gml(1): 9
objects/obj_musicblock/Draw_0.gml(1): 2
objects/obj_n64_or/Create_0.gml(1): 1
objects/obj_next_before/Create_0.gml(1): 2
objects/obj_night_change/Create_0.gml(1): 2
objects/obj_ninji/Alarm_0.gml(1): 17
objects/obj_ninji/Alarm_1.gml(1): 42
objects/obj_ninji/Create_0.gml(1): 25
objects/obj_ninji/Step_0.gml(1): 19
objects/obj_ninji_res/Create_0.gml(1): 7
objects/obj_nota_musical_or/Other_10.gml(1): 5
objects/obj_nota_musical_snd_res/Other_11.gml(1): 4
objects/obj_noteblock/Draw_0.gml(1): 2
objects/obj_noteblock_s/Create_0.gml(1): 1
objects/obj_nube/Create_0.gml(1): 1
objects/obj_onoffblock/Create_0.gml(1): 17
objects/obj_onoffplatform/Create_0.gml(1): 17
objects/obj_onoffplatform_blue/Create_0.gml(1): 17
objects/obj_onoffplatform_blue_res/Other_11.gml(1): 4
objects/obj_onoffplatform_res/Other_11.gml(1): 4
objects/obj_panel_circle/Create_0.gml(1): 17
objects/obj_panel_expand/Create_0.gml(1): 1
objects/obj_panel_save_load/Create_0.gml(1): 1
objects/obj_panel_save_load/Mouse_4.gml(1): 1
objects/obj_panel_save_load/Other_10.gml(1): 2
objects/obj_panel_save_load/Other_7.gml(1): 3
objects/obj_panel_save_load/Step_1.gml(1): 1
objects/obj_panel_time/Create_0.gml(1): 5
objects/obj_panelparent/Step_1.gml(1): 1
objects/obj_paracaidas_dead/Create_0.gml(1): 1
objects/obj_paracaidas_go/Create_0.gml(1): 1
objects/obj_parcarry/Alarm_10.gml(1): 62
objects/obj_parcarry/Create_0.gml(1): 14
objects/obj_parcarry/Other_10.gml(1): 14
objects/obj_parent_resource/Collision_obj_key_res.gml(1): 8
objects/obj_parent_resource/Create_0.gml(1): 1
objects/obj_parent_save/Create_0.gml(1): 1
objects/obj_parent_sound_o/Create_0.gml(1): 1
objects/obj_parent_sound_o/Other_10.gml(1): 5
objects/obj_pballon/Create_0.gml(1): 1
objects/obj_pblock/Create_0.gml(1): 17
objects/obj_pblock2_res/Other_11.gml(1): 4
objects/obj_pblock_res/Other_11.gml(1): 4
objects/obj_penguin_suit/Create_0.gml(1): 2
objects/obj_persistent/Other_2.gml(1): 8
objects/obj_persistent/Step_0.gml(1): 4
objects/obj_pinchos/Create_0.gml(1): 1
objects/obj_pink_coin/Alarm_0.gml(1): 4
objects/obj_pink_coin/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_pink_coin/Collision_obj_link_arrow.gml(1): 1
objects/obj_pink_coin/Collision_obj_mario.gml(1): 1
objects/obj_pink_coin/Collision_obj_shell_held.gml(1): 1
objects/obj_pink_coin/Collision_obj_snow_ball.gml(1): 1
objects/obj_pink_coin/Collision_obj_snow_ball_held.gml(1): 1
objects/obj_pipebase/Create_0.gml(1): 1
objects/obj_plant_fire_res/Other_11.gml(1): 4
objects/obj_plataforma/Create_0.gml(1): 4
objects/obj_plataforma_blue/Create_0.gml(1): 20
objects/obj_plataforma_blue/Step_0.gml(1): 13
objects/obj_platform_blue_res/Other_11.gml(1): 4
objects/obj_platform_help/Create_0.gml(1): 3
objects/obj_platform_res/Other_11.gml(1): 4
objects/obj_play_screen/Create_0.gml(1): 1
objects/obj_player_goal_nsmbu/Alarm_5.gml(1): 7
objects/obj_player_goal_nsmbu/Create_0.gml(1): 4
objects/obj_player_goal_nsmbu/Other_7.gml(1): 3
objects/obj_player_goal_smb1/Collision_obj_flagpole.gml(1): 9
objects/obj_player_goal_smb1/Create_0.gml(1): 5
objects/obj_player_goal_smb2/Step_0.gml(1): 39
objects/obj_player_goal_smb3/Create_0.gml(1): 2
objects/obj_player_goal_smw/Alarm_2.gml(1): 8
objects/obj_player_goal_smw/Alarm_3.gml(1): 2
objects/obj_player_goal_smw_castle/Step_0.gml(1): 18
objects/obj_player_trail/Create_0.gml(1): 1
objects/obj_player_warp/Create_0.gml(1): 1
objects/obj_pokey/Create_0.gml(1): 41
objects/obj_pow_res/Step_2.gml(1): 16
objects/obj_powerupparent/Collision_obj_mario.gml(1): 20
objects/obj_powerupparent/Create_0.gml(1): 1
objects/obj_powerupsprout/Create_0.gml(1): 2
objects/obj_powerupsprout_note/Create_0.gml(1): 2
objects/obj_pplant_res/Other_11.gml(1): 4
objects/obj_profile/Create_0.gml(1): 2
objects/obj_propellershroom/Create_0.gml(1): 11
objects/obj_propellershroom/Step_0.gml(1): 62
objects/obj_pswitch/Other_16.gml(1): 13
objects/obj_pswitch_press/Create_0.gml(1): 1
objects/obj_puller/Create_0.gml(1): 2
objects/obj_quicksand/Create_0.gml(1): 1
objects/obj_remolino_or/Other_10.gml(1): 5
objects/obj_remolino_snd_res/Other_11.gml(1): 4
objects/obj_rename/Create_0.gml(1): 7
objects/obj_rename_button3/Create_0.gml(1): 1
objects/obj_rename_close/Create_0.gml(1): 1
objects/obj_rename_control/Create_0.gml(1): 1
objects/obj_rename_input/Create_0.gml(1): 12
objects/obj_resource_empty/Create_0.gml(1): 4
objects/obj_risas_or/Other_10.gml(1): 5
objects/obj_risas_snd_res/Other_11.gml(1): 4
objects/obj_robot/Create_0.gml(1): 1
objects/obj_rocky/Alarm_2.gml(1): 5
objects/obj_rocky/Create_0.gml(1): 16
objects/obj_rocky/Other_10.gml(1): 6
objects/obj_rocky/Other_7.gml(1): 5
objects/obj_rorock/Create_0.gml(1): 1
objects/obj_score/Create_0.gml(1): 17
objects/obj_score_flag/Create_0.gml(1): 11
objects/obj_scrollbar2/Create_0.gml(1): 1
objects/obj_scrollbar3/Create_0.gml(1): 1
objects/obj_scrollbar4/Create_0.gml(1): 1
objects/obj_selecting_fps/Create_0.gml(1): 1
objects/obj_selecting_player/Create_0.gml(1): 1
objects/obj_semisolid_platform1/Alarm_0.gml(1): 3
objects/obj_semisolid_platform1/Other_11.gml(1): 4
objects/obj_serpentina_or/Other_10.gml(1): 5
objects/obj_serpentina_snd_res/Other_11.gml(1): 4
objects/obj_settings_button/Create_0.gml(1): 1
objects/obj_settings_controls/Create_0.gml(1): 6
objects/obj_settings_custom/Create_0.gml(1): 1
objects/obj_settings_panel/Create_0.gml(1): 1
objects/obj_shake_mario/Create_0.gml(1): 1
objects/obj_shard/Create_0.gml(1): 1
objects/obj_shell_drybones_res/Other_11.gml(1): 4
objects/obj_shell_intro/Create_0.gml(1): 1
objects/obj_shell_trail/Create_0.gml(1): 1
objects/obj_skewer/Create_0.gml(1): 1
objects/obj_skewertrunk/Alarm_0.gml(1): 20
objects/obj_skewertrunk/Alarm_1.gml(1): 5
objects/obj_skewertrunk/Create_0.gml(1): 44
objects/obj_skewertrunk/Other_7.gml(1): 4
objects/obj_sledgebro/Alarm_1.gml(1): 10
objects/obj_sledgebro/Alarm_3.gml(1): 16
objects/obj_slider/Alarm_1.gml(1): 1
objects/obj_slider/Other_10.gml(1): 1
objects/obj_sm4j_jump/Create_0.gml(1): 1
objects/obj_smoke/Create_0.gml(1): 3
objects/obj_smoke_shoe/Create_0.gml(1): 1
objects/obj_smoke_steps/Create_0.gml(1): 3
objects/obj_snow_ball/Create_0.gml(1): 22
objects/obj_snow_ball/Other_10.gml(1): 15
objects/obj_snow_ball_b/Other_10.gml(1): 15
objects/obj_snow_ball_held/Create_0.gml(1): 40
objects/obj_snow_ball_held/Other_10.gml(1): 20
objects/obj_snowball/Alarm_0.gml(1): 6
objects/obj_snowball/Collision_obj_bowser_fire.gml(1): 4
objects/obj_snowball/Collision_obj_enemyparent.gml(1): 11
objects/obj_snowball/Collision_obj_plantfire.gml(1): 4
objects/obj_snowball/Collision_obj_podoboo.gml(1): 4
objects/obj_snowball/Collision_obj_shell.gml(1): 9
objects/obj_snowball/Create_0.gml(1): 6
objects/obj_snowball_bro/Collision_obj_mario.gml(1): 8
objects/obj_soplete_global/Alarm_0.gml(1): 3
objects/obj_soplete_global/Alarm_1.gml(1): 3
objects/obj_soplete_invert_global/Alarm_0.gml(1): 3
objects/obj_soplete_invert_global/Alarm_1.gml(1): 3
objects/obj_soplete_res/Other_11.gml(1): 4
objects/obj_spike_ball/Create_0.gml(1): 21
objects/obj_spike_ball_b/Create_0.gml(1): 21
objects/obj_spike_ball_b_res/Other_11.gml(1): 4
objects/obj_spike_ball_res/Other_11.gml(1): 4
objects/obj_spike_res/Other_11.gml(1): 4
objects/obj_spinner/Create_0.gml(1): 8
objects/obj_spiny/Alarm_0.gml(1): 17
objects/obj_spiny/Alarm_10.gml(1): 13
objects/obj_spiny_ball/Create_0.gml(1): 17
objects/obj_spiny_ball/Step_0.gml(1): 5
objects/obj_spiny_res/Other_11.gml(1): 4
objects/obj_spiny_res/Step_2.gml(1): 7
objects/obj_spiny_shell_res/Other_11.gml(1): 4
objects/obj_spiny_thrown/Create_0.gml(1): 17
objects/obj_spring/Collision_obj_mario.gml(1): 5
objects/obj_spring/Create_0.gml(1): 20
objects/obj_spring/Other_7.gml(1): 1
objects/obj_spring_land/Create_0.gml(1): 17
objects/obj_spring_land/Other_11.gml(1): 1
objects/obj_spring_land/Other_7.gml(1): 1
objects/obj_spring_land_res/Other_11.gml(1): 4
objects/obj_spring_res/Other_11.gml(1): 4
objects/obj_st_slider/Create_0.gml(1): 5
objects/obj_star/Create_0.gml(1): 25
objects/obj_statuesmoke/Create_0.gml(1): 1
objects/obj_stomp/Create_0.gml(1): 13
objects/obj_stomped/Create_0.gml(1): 1
objects/obj_superarcon/Create_0.gml(1): 2
objects/obj_superball/Create_0.gml(1): 2
objects/obj_superball_trail/Create_0.gml(1): 1
objects/obj_superflower/Create_0.gml(1): 2
objects/obj_superflower_res/Other_11.gml(1): 4
objects/obj_superflower_res/Other_13.gml(1): 4
objects/obj_tabs_condiciones/Create_0.gml(1): 1
objects/obj_thwomp/Create_0.gml(1): 31
objects/obj_thwomp_b/Create_0.gml(1): 31
objects/obj_thwomp_b_res/Other_11.gml(1): 4
objects/obj_time/Create_0.gml(1): 1
objects/obj_time/Mouse_4.gml(1): 1
objects/obj_time/Other_10.gml(1): 1
objects/obj_time/Other_7.gml(1): 3
objects/obj_time/Step_1.gml(1): 1
objects/obj_timeup/Create_0.gml(1): 9
objects/obj_timeup/Other_7.gml(1): 1
objects/obj_title_controller/Create_0.gml(1): 2
objects/obj_title_oprime/Create_0.gml(1): 1
objects/obj_toast/Create_0.gml(1): 1
objects/obj_torbellino_res/Other_11.gml(1): 4
objects/obj_tuberia/Create_0.gml(1): 34
objects/obj_tuberia_res/Other_11.gml(1): 18
objects/obj_ubsi_or/Other_10.gml(1): 5
objects/obj_ubsi_snd_res/Other_11.gml(1): 4
objects/obj_uhh_snd_res/Other_11.gml(1): 4
objects/obj_veggiecoin/Create_0.gml(1): 62
objects/obj_version/Create_0.gml(1): 1
objects/obj_vine_green/Create_0.gml(1): 24
objects/obj_vsync/Create_0.gml(1): 1
objects/obj_waddlewing/Other_16.gml(1): 21
objects/obj_waddlewing/Other_18.gml(1): 26
objects/obj_waddlewing_res/Create_0.gml(1): 22
objects/obj_water_level_control/Create_0.gml(1): 1
objects/obj_water_move/Create_0.gml(1): 1
objects/obj_water_move_limit/Create_0.gml(1): 1
objects/obj_window_alert/Create_0.gml(1): 1
objects/obj_window_button/Create_0.gml(1): 1
objects/obj_window_mario_button/Create_0.gml(1): 17
objects/obj_wings_dead/Create_0.gml(1): 2
objects/obj_wings_dead_b/Create_0.gml(1): 2
objects/obj_wrench/Create_0.gml(1): 19
objects/obj_yoshi_abandon/Create_0.gml(1): 9
objects/obj_yoshi_abandon/Other_10.gml(1): 7
objects/obj_yoshi_runaway/Create_0.gml(1): 4
objects/obj_yoshifire/Create_0.gml(1): 1
scripts/scr_viewculling/scr_viewculling.gml(1): 16
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/cre_control/Create_0.gml:1 | `image_speed = 0` |
| objects/obj_angrysun/Create_0.gml:49 | `image_speed = 0.1` |
| objects/obj_boo/Step_2.gml:8 | `image_speed = 0.5` |
| objects/obj_buzzybeetle_b/Create_0.gml:54 | `image_speed = 0.15` |
| objects/obj_cinta_switch/Step_0.gml:70 | `image_speed = 1` |
| objects/obj_door/Alarm_1.gml:22 | `image_speed = 0.12` |
| objects/obj_efecto_sonido/Create_0.gml:1 | `image_speed = 0` |
| objects/obj_goalcard/Alarm_3.gml:15 | `global.timer--` |
| objects/obj_kuribo_drybones/Step_2.gml:115 | `image_speed = 0` |
| objects/obj_mario/Step_2.gml:490 | `image_speed = 0.15` |
| objects/obj_marioU/Step_2.gml:1135 | `image_speed = 0.5` |
| objects/obj_onewaygate_bottom/Create_0.gml:18 | `image_speed = 0.2` |
| objects/obj_podoboo/Create_0.gml:5 | `image_speed = 0.2` |
| objects/obj_soplete_invert_global/Alarm_1.gml:3 | `image_speed = 0` |

### 3.5 自定义绘制

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| draw_*调用: `\bdraw_\w+\s*\(` | 1951 | 450 |
| gpu_set_*/blendmode: `\b(gpu_\w+\|draw_set_blend_mode\w*\|draw_set_alpha\|draw_set_colour\|draw_set_color\|draw_set_font)\b` | 233 | 81 |
| **并集（本类合计）** | **1983** | **452** |

Draw 类事件（eventType=8）按 eventNum：0(Draw): 435；64(Draw GUI): 1。

Draw 类事件：436 个事件，分布于 435 个 object（路径 `objects/<object>/<事件文件>.gml`，来源 `objects/<object>/<object>.yy` 的 `eventList`）：

<details><summary>展开 object → 事件列表</summary>

```
cre_control: Draw_0
obj_1up: Draw_0
obj_NSMBU_bowser: Draw_0
obj_NSMBU_bowser_fire: Draw_0
obj_NSMBU_bowser_fire_up: Draw_0
obj_NSMBU_bowserjr: Draw_0
obj_NSMBU_bowserjr_fire: Draw_0
obj_NSMBU_ninji: Draw_0
obj_SMB3_bowser: Draw_0
obj_SMB_bowser: Draw_0
obj_SMB_castle_front: Draw_0
obj_SMW_bowser: Draw_0
obj_alert_condicion: Draw_0
obj_alert_load: Draw_0
obj_alert_message: Draw_0
obj_angrysun: Draw_0
obj_apariencia: Draw_0
obj_arrow: Draw_0
obj_arrow_res: Draw_0
obj_autoavance: Draw_0
obj_axe_smw: Draw_0
obj_banzaibill: Draw_0
obj_beachkoopa: Draw_0
obj_beanstalk: Draw_0
obj_bg1: Draw_0
obj_bg_selection: Draw_0
obj_big_pplant: Draw_0
obj_big_pplant_b_res: Draw_0
obj_big_pplant_res: Draw_0
obj_billbanzai_red: Draw_0
obj_billbanzai_red_res: Draw_0
obj_billbanzai_res: Draw_0
obj_blend_ring: Draw_0
obj_block: Draw_0
obj_block_gold: Draw_0
obj_block_hidden: Draw_0
obj_block_hidden_res: Draw_0
obj_block_multicoin: Draw_0
obj_block_pow_hold: Draw_0
obj_block_res: Draw_0
obj_blockparent: Draw_0
obj_blooper: Draw_0
obj_bobomb: Draw_0
obj_bone: Draw_0
obj_bones_yoshi: Draw_0
obj_bones_yoshi_one: Draw_0
obj_bonus_trail: Draw_0
obj_bonybeetle: Draw_0
obj_bonybeetle_b_res: Draw_0
obj_bonybeetle_res: Draw_0
obj_boo: Draw_0
obj_boo_res: Draw_0
obj_boomboom: Draw_0
obj_boomerang: Draw_0
obj_bouncycloud: Draw_0
obj_bowser_dead: Draw_0
obj_bowser_fire: Draw_0
obj_bowser_fire_down: Draw_0
obj_bowserfire_up: Draw_0
obj_bowserjr: Draw_0
obj_bowserjr_fire: Draw_0
obj_brickhelmet: Draw_0
obj_brohammer: Draw_0
obj_brohammer_yoshi: Draw_0
obj_bt_close_water: Draw_0
obj_bt_gb_delete: Draw_0
obj_bt_gb_play: Draw_0
obj_bt_rename: Draw_0
obj_btn_header_1: Draw_0
obj_btn_header_2: Draw_0
obj_btn_header_3: Draw_0
obj_btn_header_4: Draw_0
obj_btn_header_parent: Draw_0
obj_btn_iniciar: Draw_0
obj_btn_invitado: Draw_0
obj_btn_settings_hd: Draw_0
obj_bullebill_base: Draw_0
obj_bullebill_base_red: Draw_0
obj_bullebill_base_red_res: Draw_0
obj_bullebill_base_res: Draw_0
obj_bulletbill: Draw_0
obj_bulletbull_red: Draw_0
obj_bumper: Draw_0
obj_button_autoavance: Draw_0
obj_button_creditos: Draw_0
obj_button_home: Draw_0
obj_button_meteoritos: Draw_0
obj_button_ok: Draw_0
obj_button_parent: Draw_0
obj_button_save_changes: Draw_0
obj_button_save_load: Draw_0
obj_button_sdog: Draw_0
obj_button_settings_controls: Draw_0
obj_button_settings_estrella: Draw_0
obj_button_settings_idioma: Draw_0
obj_button_settings_sm4j: Draw_0
obj_button_settings_sombras: Draw_0
obj_button_sombras: Draw_0
obj_button_speed_water: Draw_0
obj_button_superado: Draw_0
obj_button_trail: Draw_0
obj_button_wings: Draw_0
obj_buzzy_ceiling: Draw_0
obj_buzzybeetle: Draw_0
obj_buzzybeetle_b: Draw_0
obj_buzzybeetle_b_res: Draw_0
obj_buzzybeetle_res: Draw_0
obj_cannon: Draw_0
obj_cannon_red_res: Draw_0
obj_cannon_res: Draw_0
obj_cap_mario: Draw_0
obj_card_autoavance: Draw_0
obj_card_bg: Draw_0
obj_card_block_sounds: Draw_0
obj_card_bout: Draw_0
obj_card_circle: Draw_0
obj_card_condiciones: Draw_0
obj_card_item: Draw_0
obj_card_logo: Draw_0
obj_card_rocket: Draw_0
obj_castle: Draw_0
obj_chain_chomp_free: Draw_0
obj_change_view: Draw_0
obj_charginchuck: Draw_0
obj_checkpoint: Draw_0
obj_checkpoint_res: Draw_0
obj_cheepcheep: Draw_0
obj_cinta: Draw_0
obj_cinta_on_res: Draw_0
obj_cinta_res: Draw_0
obj_cinta_switch: Draw_0
obj_claw: Draw_0
obj_cloud_lakitu: Draw_0
obj_clown: Draw_0
obj_clown_fire: Draw_0
obj_clown_fire_res: Draw_0
obj_clown_res: Draw_0
obj_coin: Draw_0
obj_coin10: Draw_0
obj_coin_pow: Draw_0
obj_condiciones: Draw_0
obj_configurar_controles: Draw_0
obj_configurar_controles_reset: Draw_0
obj_cooligan: Draw_0
obj_cooligan_res: Draw_0
obj_create_account: Draw_0
obj_creation_preview: Draw_0
obj_creator_jugar_editar: Draw_0
obj_crumblebones: Draw_0
obj_crystalorb: Draw_0
obj_cursor: Draw_0
obj_curtainin: Draw_0
obj_curtainout: Draw_0
obj_deadmario: Draw_0
obj_decoracion_parent: Draw_0
obj_dog: Draw_0
obj_donut: Draw_0
obj_door: Draw_0
obj_door_exit: Draw_0
obj_door_exit_res: Draw_0
obj_door_lock: Draw_0
obj_door_lock_exit: Draw_0
obj_door_lock_exit_res: Draw_0
obj_door_lock_res: Draw_0
obj_door_res: Draw_0
obj_door_switch: Draw_0
obj_door_switch_exit: Draw_0
obj_door_switch_exit_res: Draw_0
obj_door_switch_res: Draw_0
obj_doormario: Draw_0
obj_doormario_exit: Draw_0
obj_drybones: Draw_0
obj_edit_menu: Draw_0
obj_editormanager: Draw_0
obj_efecto_musica: Draw_0
obj_efecto_musica_bonus: Draw_0
obj_efecto_sonido: Draw_0
obj_effect_link: Draw_0
obj_egg: Draw_0
obj_egg_blue: Draw_0
obj_egg_hatch: Draw_0
obj_egg_red: Draw_0
obj_enemy_dead: Draw_0
obj_enemy_dead_castle: Draw_0
obj_enemy_multidead: Draw_0
obj_enemyfrozen: Draw_0
obj_enemyparent_lava: Draw_0
obj_erase: Draw_0
obj_espina: Draw_0
obj_etiquetas: Draw_0
obj_expand: Draw_0
obj_expand_paneles_top: Draw_0
obj_expand_panels: Draw_0
obj_expand_panels_left: Draw_0
obj_explosion: Draw_0
obj_fadein: Draw_0
obj_fadeout: Draw_0
obj_fire_clown: Draw_0
obj_firebar: Draw_0
obj_firebar_res: Draw_0
obj_fishbone: Draw_0
obj_flagpole: Draw_0
obj_flipblock: Draw_0
obj_floruga: Draw_0
obj_floruga_body: Draw_0
obj_foo: Draw_0
obj_foo_fog: Draw_0
obj_frozenmario: Draw_0
obj_galoomba: Draw_0
obj_galoomba_b: Draw_0
obj_galoomba_hold: Draw_0
obj_gb_button: Draw_0
obj_gb_level: Draw_0
obj_getshoe: Draw_0
obj_goalcard: Draw_0
obj_goalgate: Draw_0
obj_goalgate_front: Draw_0
obj_goalgate_tape: Draw_0
obj_goomba_b_res: Draw_0
obj_goombrat_b_res: Draw_0
obj_grid: Draw_0
obj_grinder: Draw_0
obj_ground2: Draw_0
obj_ground3: Draw_0
obj_ground_slope: Draw_0
obj_grrrol: Draw_0
obj_grrrol_b: Draw_0
obj_grrrol_b_res: Draw_0
obj_grrrol_new: Draw_0
obj_grrrol_new_res: Draw_0
obj_grrrol_res: Draw_0
obj_guardabot: Draw_0
obj_hammerbro: Draw_0
obj_hawmask: Draw_0
obj_header: Draw_0
obj_helmet: Draw_0
obj_holdparent: Draw_0
obj_icecoin: Draw_0
obj_icicle: Draw_0
obj_iname: Draw_0
obj_iname_control: Draw_0
obj_input: Draw_0
obj_input_desc: Draw_0
obj_input_rename: Draw_0
obj_intro_controller: Draw_0
obj_jumppiranha: Draw_0
obj_key: Draw_0
obj_key_fallow: Draw_0
obj_koopa: Draw_0
obj_koopa_b: Draw_0
obj_koopa_red: Draw_0
obj_koopa_red_b: Draw_0
obj_kuribo_drybones: Draw_0
obj_kuriboshoe: Draw_0
obj_lakitu: Draw_0
obj_lakitu_res: Draw_0
obj_lava_water: Draw_0
obj_lave_draw: Draw_0
obj_levelmanager: Draw_0
obj_lighting: Draw_0
obj_link_arrow: Draw_0
obj_link_arrow_anim: Draw_0
obj_link_dash_atack: Draw_0
obj_load_image: Draw_0
obj_login_control: Draw_0
obj_logo_c: Draw_0
obj_logo_game: Draw_0
obj_lp: Draw_0
obj_lun: Draw_0
obj_magic: Draw_0
obj_magikoopa: Draw_0
obj_mario: Draw_0
obj_marioU: Draw_0
obj_mario_editor: Draw_0
obj_mario_intro: Draw_0
obj_mario_pballon: Draw_0
obj_mario_temp: Draw_0
obj_mario_transform2: Draw_0
obj_mariostart: Draw_0
obj_mariostart_m: Draw_0
obj_mechakoopa: Draw_0
obj_mechakoopa_held: Draw_0
obj_menu_editor: Draw_0
obj_menu_editor_ext: Draw_0
obj_menu_pausa: Draw_0
obj_modelsizable: Draw_0
obj_modelsolid: Draw_0
obj_modo_sonidos_control: Draw_0
obj_monty_chase: Draw_0
obj_muncher: Draw_0
obj_mushroom_platform_res: Draw_0
obj_musicblock: Draw_0
obj_next_before: Draw_0
obj_night_change: Draw_0
obj_ninji: Draw_0
obj_noteblock: Draw_0
obj_noteblock_res: Draw_0
obj_oneway_res: Draw_0
obj_onewaygate_bottom: Draw_0
obj_onewaygate_left: Draw_0
obj_onewaygate_right: Draw_0
obj_onewaygate_top: Draw_0
obj_onoffblock: Draw_0
obj_panel_circle: Draw_0
obj_panel_expand: Draw_0
obj_panel_left: Draw_0
obj_panel_save_load: Draw_0
obj_panel_time: Draw_0
obj_parcarry: Draw_0
obj_parent_resource: Draw_0
obj_pausa_button: Draw_0
obj_persistent: Draw_0, Draw_64
obj_physicsparent: Draw_0
obj_pinchos: Draw_0
obj_pink_coin: Draw_0
obj_piranhaplant: Draw_0
obj_plant_fire: Draw_0
obj_plant_fire_res: Draw_0
obj_plataforma: Draw_0
obj_plataforma_blue: Draw_0
obj_platform_blue_res: Draw_0
obj_platform_help: Draw_0
obj_platform_res: Draw_0
obj_play_screen: Draw_0
obj_player_goal_nsmbu: Draw_0
obj_player_goal_parent: Draw_0
obj_player_goal_smb1: Draw_0
obj_player_goal_smb3: Draw_0
obj_player_goal_smw: Draw_0
obj_player_goal_smw_castle: Draw_0
obj_player_trail: Draw_0
obj_player_warp: Draw_0
obj_podoboo: Draw_0
obj_pokey: Draw_0
obj_pokey_res: Draw_0
obj_powerupparent: Draw_0
obj_pplant_res: Draw_0
obj_profile: Draw_0
obj_pswitch: Draw_0
obj_pswitch_res: Draw_0
obj_puente_res: Draw_0
obj_puller: Draw_0
obj_qblock_res: Draw_0
obj_rails: Draw_0
obj_rails_res: Draw_0
obj_rename: Draw_0
obj_rename_control: Draw_0
obj_rename_input: Draw_0
obj_robot: Draw_0
obj_rocangrejo: Draw_0
obj_rocky: Draw_0
obj_rorock: Draw_0
obj_score: Draw_0
obj_score_flag: Draw_0
obj_scrollbar2: Draw_0
obj_scrollbar3: Draw_0
obj_scrollbar4: Draw_0
obj_selecting_fps: Draw_0
obj_selecting_player: Draw_0
obj_semisolid_platform1: Draw_0
obj_settings_button: Draw_0
obj_settings_controls: Draw_0
obj_settings_custom: Draw_0
obj_settings_panel: Draw_0
obj_shard: Draw_0
obj_shell: Draw_0
obj_shell_held: Draw_0
obj_shell_trail: Draw_0
obj_shield_left: Draw_0
obj_shield_right: Draw_0
obj_sidefade: Draw_0
obj_skewer: Draw_0
obj_skewer_res: Draw_0
obj_skewertrunk: Draw_0
obj_sledgebro: Draw_0
obj_slider: Draw_0
obj_slopesa: Draw_0
obj_sm4j_jump: Draw_0
obj_smoke: Draw_0
obj_smoke_goomba: Draw_0
obj_smoke_shoe: Draw_0
obj_smoke_steps: Draw_0
obj_snow_ball: Draw_0
obj_snow_ball_b: Draw_0
obj_snow_ball_held: Draw_0
obj_soplete: Draw_0
obj_soplete_res: Draw_0
obj_sparkles_blend: Draw_0
obj_spike: Draw_0
obj_spike_ball: Draw_0
obj_spike_ball_b: Draw_0
obj_spinner: Draw_0
obj_spinsmoke: Draw_0
obj_spiny: Draw_0
obj_spiny_res: Draw_0
obj_st_slider: Draw_0
obj_stomped: Draw_0
obj_superarcon: Draw_0
obj_tabs_condiciones: Draw_0
obj_thwomp: Draw_0
obj_thwomp_b_res: Draw_0
obj_thwomp_intro: Draw_0
obj_thwomp_res: Draw_0
obj_time: Draw_0
obj_timeup: Draw_0
obj_title_controller: Draw_0
obj_title_oprime: Draw_0
obj_titlemenu_key: Draw_0
obj_toast: Draw_0
obj_tongue: Draw_0
obj_tongue_blue: Draw_0
obj_torbellino: Draw_0
obj_tuberia: Draw_0
obj_tuberia_res: Draw_0
obj_version: Draw_0
obj_vine_green: Draw_0
obj_vine_res: Draw_0
obj_vsync: Draw_0
obj_waddlewing: Draw_0
obj_waddlewing_res: Draw_0
obj_water_level_control: Draw_0
obj_water_move: Draw_0
obj_water_move_limit: Draw_0
obj_window_alert: Draw_0
obj_window_button: Draw_0
obj_window_mario_button: Draw_0
obj_window_select: Draw_0
obj_wings_dead: Draw_0
obj_wings_dead_b: Draw_0
obj_wrench: Draw_0
obj_yoshi2: Draw_0
obj_yoshi_abandon: Draw_0
obj_yoshi_runaway: Draw_0
obj_yoshifire: Draw_0
obj_zoomclose: Draw_0
```
</details>

<details><summary>按文件完整索引（452 个文件，1983 行命中）</summary>

```
objects/cre_control/Draw_0.gml(117): 1,2,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,…+97
objects/obj_lighting/Step_0.gml(80): 4,5,6,7,8,9,15,16,17,19,24,25,26,28,34,35,36,38,43,44,…+60
objects/obj_menu_pausa/Draw_0.gml(30): 5,7,8,10,11,12,17,18,19,20,21,22,23,24,25,26,27,28,29,60,…+10
objects/obj_persistent/Draw_0.gml(30): 4,6,7,9,16,18,20,22,24,26,28,30,33,35,42,46,50,52,54,56,…+10
objects/obj_ground3/Draw_0.gml(25): 9,10,14,15,16,20,21,27,28,29,33,34,35,41,42,43,46,51,52,53,…+5
objects/obj_title_controller/Draw_0.gml(25): 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,…+5
objects/obj_mariostart/Draw_0.gml(23): 6,7,8,9,13,14,15,16,17,18,19,20,26,27,28,29,30,31,32,44,…+3
objects/obj_player_warp/Draw_0.gml(23): 38,42,44,49,51,53,55,62,64,65,67,72,74,75,80,82,83,90,99,113,…+3
objects/obj_doormario/Draw_0.gml(20): 38,42,44,49,51,53,60,62,63,68,70,71,76,78,79,97,101,113,115,118
objects/obj_doormario_exit/Draw_0.gml(20): 38,42,44,49,51,53,60,62,63,68,70,71,76,78,79,103,107,119,121,124
objects/obj_levelmanager/Other_19.gml(20): 5,8,11,14,18,19,22,23,25,30,31,33,35,39,41,43,44,45,47,48
objects/obj_gb_level/Draw_0.gml(19): 3,4,5,7,8,9,10,14,15,17,19,20,21,22,23,24,25,26,27
objects/obj_intro_controller/Draw_0.gml(18): 3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21
objects/obj_levelmanager/Other_20.gml(18): 2,3,4,7,8,13,14,15,16,20,22,24,25,26,27,28,30,31
objects/obj_tuberia_res/Draw_0.gml(17): 5,7,12,13,19,20,26,27,33,34,47,50,53,56,65,67,70
objects/obj_settings_panel/Draw_0.gml(16): 1,2,3,4,5,6,9,10,11,12,13,14,15,16,17,21
objects/obj_egg/Draw_0.gml(14): 5,7,9,11,15,17,19,21,24,26,28,31,33,35
objects/obj_egg_blue/Draw_0.gml(14): 5,7,9,11,15,17,19,21,24,26,28,31,33,35
objects/obj_button_save_load/Draw_0.gml(13): 6,13,14,15,16,17,20,21,22,23,24,28,29
objects/obj_login_control/Draw_0.gml(13): 1,2,3,4,5,6,7,8,9,10,11,12,13
objects/obj_persistent/Draw_64.gml(13): 2,14,16,21,23,24,25,26,27,31,33,35,37
objects/obj_condiciones/Draw_0.gml(12): 8,13,14,15,16,19,20,21,22,24,25,26
objects/obj_iname_control/Draw_0.gml(12): 3,5,6,8,9,10,11,12,13,15,16,17
objects/obj_mushroom_platform_res/Draw_0.gml(12): 4,6,15,22,24,28,29,33,34,40,42,45
objects/obj_time/Draw_0.gml(12): 10,11,12,16,17,19,20,21,22,24,25,26
objects/obj_button_home/Draw_0.gml(11): 30,38,39,40,41,45,53,54,55,56,58
objects/obj_cheepcheep/Draw_0.gml(11): 7,9,13,15,19,21,25,27,32,34,36
objects/obj_header/Draw_0.gml(11): 4,5,6,7,8,12,15,18,21,24,25
objects/obj_kuriboshoe/Draw_0.gml(11): 17,18,22,23,29,30,36,38,40,44,45
objects/obj_cannon_red_res/Draw_0.gml(10): 4,6,7,9,11,13,15,17,19,21
objects/obj_cannon_res/Draw_0.gml(10): 4,6,7,9,11,13,15,17,19,21
objects/obj_kuribo_drybones/Draw_0.gml(10): 9,12,20,23,32,35,44,46,52,54
objects/obj_rename_control/Draw_0.gml(10): 3,5,6,8,9,10,11,12,13,14
objects/obj_titlemenu_key/Draw_0.gml(10): 3,5,6,8,9,10,11,12,13,14
objects/obj_big_pplant_b_res/Draw_0.gml(9): 4,6,8,12,15,18,21,25,27
objects/obj_big_pplant_res/Draw_0.gml(9): 4,6,8,12,15,18,21,25,27
objects/obj_editormanager/Draw_0.gml(9): 5,7,8,21,22,23,24,25,27
objects/obj_egg_red/Draw_0.gml(9): 4,6,8,13,15,17,21,23,25
objects/obj_player_goal_smw_castle/Draw_0.gml(9): 21,23,24,28,29,33,34,39,43
objects/obj_pplant_res/Draw_0.gml(9): 4,6,8,12,15,18,21,25,27
objects/obj_apariencia/Draw_0.gml(8): 6,7,8,9,10,12,13,14
objects/obj_autoavance/Draw_0.gml(8): 12,13,14,15,16,18,19,20
objects/obj_bg_selection/Draw_0.gml(8): 8,9,10,11,12,14,15,16
objects/obj_button_save_changes/Draw_0.gml(8): 10,16,17,18,19,20,21,22
objects/obj_buzzybeetle_res/Draw_0.gml(8): 6,8,11,13,15,17,19,21
objects/obj_card_item/Draw_0.gml(8): 3,4,5,7,11,12,13,14
objects/obj_cinta_on_res/Draw_0.gml(8): 6,8,11,22,27,29,34,37
objects/obj_cinta_res/Draw_0.gml(8): 6,8,11,32,37,39,44,47
objects/obj_guardabot/Draw_0.gml(8): 3,4,5,6,7,8,9,10
objects/obj_helmet/Draw_0.gml(8): 9,12,14,24,27,29,41,44
objects/obj_mario_editor/Draw_0.gml(8): 2,4,8,10,13,20,22,25
objects/obj_panel_save_load/Draw_0.gml(8): 10,11,12,13,14,16,17,18
objects/obj_platform_blue_res/Draw_0.gml(8): 4,6,9,10,20,25,27,30
objects/obj_player_goal_smw/Draw_0.gml(8): 24,25,29,45,46,50,57,61
objects/obj_pokey_res/Draw_0.gml(8): 4,6,13,18,20,23,24,28
objects/obj_skewertrunk/Draw_0.gml(8): 4,5,8,9,12,13,16,17
objects/obj_spiny_res/Draw_0.gml(8): 6,8,11,13,15,17,19,21
objects/obj_tuberia/Draw_0.gml(8): 4,7,10,13,24,27,30,33
objects/obj_vine_res/Draw_0.gml(8): 4,6,25,30,32,35,36,40
objects/obj_water_level_control/Draw_0.gml(8): 2,15,19,22,23,24,25,26
scripts/draw_text_lang/draw_text_lang.gml(8): 8,18,19,21,23,25,26,27
objects/obj_alert_condicion/Draw_0.gml(7): 1,2,3,4,5,8,9
objects/obj_alert_message/Draw_0.gml(7): 1,2,3,4,5,6,7
objects/obj_bonybeetle_b_res/Draw_0.gml(7): 6,8,11,13,14,16,18
objects/obj_bonybeetle_res/Draw_0.gml(7): 6,8,11,13,14,16,18
objects/obj_boo_res/Draw_0.gml(7): 4,6,8,10,12,14,16
objects/obj_bt_gb_play/Draw_0.gml(7): 1,2,3,4,5,6,7
objects/obj_bullebill_base_red_res/Draw_0.gml(7): 4,6,15,20,22,25,27
objects/obj_bullebill_base_res/Draw_0.gml(7): 4,6,15,20,22,25,27
objects/obj_button_autoavance/Draw_0.gml(7): 1,2,3,4,5,6,7
objects/obj_buzzybeetle_b_res/Draw_0.gml(7): 4,6,8,10,12,14,16
objects/obj_cannon/Draw_0.gml(7): 2,4,6,8,10,12,14
objects/obj_firebar_res/Draw_0.gml(7): 5,7,8,13,19,20,23
objects/obj_lakitu_res/Draw_0.gml(7): 20,22,23,25,26,28,30
objects/obj_modelsizable/Other_11.gml(7): 9,16,18,22,23,27,28
objects/obj_modo_sonidos_control/Draw_0.gml(7): 2,14,15,16,17,18,20
objects/obj_platform_res/Draw_0.gml(7): 4,6,15,20,22,27,30
objects/obj_profile/Draw_0.gml(7): 1,2,3,4,5,7,9
objects/obj_pswitch_res/Draw_0.gml(7): 6,8,11,13,15,17,19
objects/obj_rails_res/Draw_0.gml(7): 4,6,14,19,21,24,27
objects/obj_rename_input/Draw_0.gml(7): 1,2,3,4,5,6,8
objects/obj_thwomp_b_res/Draw_0.gml(7): 4,6,8,9,11,13,15
objects/obj_thwomp_res/Draw_0.gml(7): 4,6,8,9,11,13,15
objects/obj_boo/Draw_0.gml(6): 4,7,13,14,17,19
objects/obj_bt_rename/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_btn_invitado/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_button_ok/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_button_parent/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_button_superado/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_checkpoint_res/Draw_0.gml(6): 4,6,7,9,11,13
objects/obj_clown_fire_res/Draw_0.gml(6): 4,6,8,9,11,13
objects/obj_clown_res/Draw_0.gml(6): 4,6,8,9,11,13
objects/obj_etiquetas/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_galoomba/Draw_0.gml(6): 1,7,10,13,16,22
objects/obj_galoomba_b/Draw_0.gml(6): 1,7,10,13,16,22
objects/obj_goalcard/Draw_0.gml(6): 1,2,5,7,11,13
objects/obj_goomba_b_res/Draw_0.gml(6): 4,6,8,9,11,13
objects/obj_goombrat_b_res/Draw_0.gml(6): 4,6,8,9,11,13
objects/obj_jumppiranha/Draw_0.gml(6): 4,7,10,13,22,25
objects/obj_logo_c/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_mario/Draw_0.gml(6): 6,9,15,17,22,33
objects/obj_marioU/Draw_0.gml(6): 5,8,14,16,21,32
objects/obj_parent_resource/Draw_0.gml(6): 4,6,8,9,11,13
objects/obj_pausa_button/Draw_0.gml(6): 1,2,3,4,5,6
objects/obj_plant_fire_res/Draw_0.gml(6): 4,6,8,10,11,13
objects/obj_player_trail/Draw_0.gml(6): 4,8,9,13,15,18
objects/obj_puente_res/Draw_0.gml(6): 4,6,15,20,22,25
objects/obj_semisolid_platform1/Draw_0.gml(6): 4,6,38,68,70,73
objects/obj_st_slider/Draw_0.gml(6): 2,3,4,5,6,8
objects/obj_tabs_condiciones/Draw_0.gml(6): 16,22,23,24,25,26
objects/obj_tongue/Draw_0.gml(6): 2,3,4,5,6,7
objects/obj_tongue_blue/Draw_0.gml(6): 2,3,4,5,6,7
objects/obj_alert_load/Draw_0.gml(5): 1,2,3,4,5
objects/obj_arrow_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_billbanzai_red_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_billbanzai_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_block_hidden_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_block_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_configurar_controles/Draw_0.gml(5): 1,2,3,4,6
objects/obj_cooligan_res/Draw_0.gml(5): 4,6,8,11,14
objects/obj_frozenmario/Draw_0.gml(5): 1,7,8,10,11
objects/obj_goalgate_front/Draw_0.gml(5): 2,4,8,11,12
objects/obj_grrrol_b_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_grrrol_new_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_grrrol_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_input_desc/Draw_0.gml(5): 1,2,3,4,5
objects/obj_mariostart_m/Draw_0.gml(5): 5,12,13,14,15
objects/obj_night_change/Draw_0.gml(5): 2,6,7,8,9
objects/obj_noteblock_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_oneway_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_powerupparent/Draw_0.gml(5): 1,5,7,12,14
objects/obj_qblock_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_shell_trail/Draw_0.gml(5): 5,7,10,12,15
objects/obj_skewer_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_soplete_res/Draw_0.gml(5): 4,6,7,9,11
objects/obj_spinsmoke/Draw_0.gml(5): 1,4,5,6,7
objects/obj_toast/Draw_0.gml(5): 1,2,3,4,5
objects/obj_waddlewing/Draw_0.gml(5): 1,7,10,13,16
objects/obj_waddlewing_res/Draw_0.gml(5): 4,6,8,11,14
objects/obj_window_alert/Draw_0.gml(5): 1,2,3,4,5
objects/obj_1up/Draw_0.gml(4): 3,7,9,12
objects/obj_NSMBU_bowserjr/Draw_0.gml(4): 3,5,9,11
objects/obj_angrysun/Draw_0.gml(4): 2,4,6,8
objects/obj_axe_smw/Draw_0.gml(4): 2,4,5,7
objects/obj_bobomb/Draw_0.gml(4): 1,5,7,10
objects/obj_bowserjr/Draw_0.gml(4): 3,5,9,11
objects/obj_btn_settings_hd/Draw_0.gml(4): 1,2,3,4
objects/obj_button_settings_controls/Draw_0.gml(4): 1,2,3,4
objects/obj_button_settings_estrella/Draw_0.gml(4): 1,2,3,4
objects/obj_button_settings_idioma/Draw_0.gml(4): 1,2,3,4
objects/obj_button_settings_sm4j/Draw_0.gml(4): 1,2,3,4
objects/obj_button_settings_sombras/Draw_0.gml(4): 1,2,3,4
objects/obj_button_sombras/Draw_0.gml(4): 1,2,3,4
objects/obj_buzzybeetle/Draw_0.gml(4): 2,4,6,8
objects/obj_buzzybeetle_b/Draw_0.gml(4): 2,4,6,8
objects/obj_card_rocket/Draw_0.gml(4): 1,3,5,7
objects/obj_coin/Draw_0.gml(4): 6,10,12,15
objects/obj_curtainin/Step_0.gml(4): 7,8,9,10
objects/obj_curtainout/Step_0.gml(4): 7,8,9,10
objects/obj_floruga/Draw_0.gml(4): 1,3,7,9
objects/obj_gb_button/Draw_0.gml(4): 1,2,3,5
objects/obj_ground2/Draw_0.gml(4): 16,35,39,41
objects/obj_iname/Draw_0.gml(4): 2,3,4,12
objects/obj_input/Draw_0.gml(4): 1,2,3,4
objects/obj_input_rename/Draw_0.gml(4): 1,2,3,4
objects/obj_lakitu/Draw_0.gml(4): 3,4,6,7
objects/obj_lava_water/Draw_0.gml(4): 16,20,36,41
objects/obj_lp/Draw_0.gml(4): 1,2,7,8
objects/obj_lun/Draw_0.gml(4): 1,2,3,11
objects/obj_mario_pballon/Draw_0.gml(4): 2,4,9,11
objects/obj_monty_chase/Draw_0.gml(4): 1,3,7,9
objects/obj_panel_time/Draw_0.gml(4): 1,3,5,6
objects/obj_parcarry/Draw_0.gml(4): 2,4,6,8
objects/obj_play_screen/Draw_0.gml(4): 3,4,12,13
objects/obj_rename/Draw_0.gml(4): 2,3,4,12
objects/obj_score/Draw_0.gml(4): 3,5,9,11
objects/obj_settings_controls/Draw_0.gml(4): 1,2,3,4
objects/obj_shell/Draw_0.gml(4): 4,6,9,11
objects/obj_shell_held/Draw_0.gml(4): 4,6,9,11
objects/obj_sledgebro/Draw_0.gml(4): 2,3,7,9
objects/obj_version/Draw_0.gml(4): 1,2,3,4
scripts/scr_anim_hover/scr_anim_hover.gml(4): 6,7,8,9
scripts/scr_anim_hover2/scr_anim_hover2.gml(4): 6,7,8,9
objects/obj_blend_ring/Draw_0.gml(3): 4,7,9
objects/obj_bonus_trail/Draw_0.gml(3): 1,2,3
objects/obj_bonybeetle/Draw_0.gml(3): 2,3,5
objects/obj_button_wings/Draw_0.gml(3): 1,2,3
objects/obj_cap_mario/Draw_0.gml(3): 3,7,12
objects/obj_card_circle/Draw_0.gml(3): 2,3,5
objects/obj_claw/Draw_0.gml(3): 4,6,8
objects/obj_curtainin/Draw_0.gml(3): 1,3,5
objects/obj_curtainout/Draw_0.gml(3): 1,2,3
objects/obj_donut/Draw_0.gml(3): 1,5,7
objects/obj_drybones/Draw_0.gml(3): 2,3,5
objects/obj_efecto_musica_bonus/Draw_0.gml(3): 1,2,3
objects/obj_enemyfrozen/Draw_0.gml(3): 1,2,3
objects/obj_fadein/Draw_0.gml(3): 3,4,5
objects/obj_hammerbro/Draw_0.gml(3): 2,3,10
objects/obj_koopa/Draw_0.gml(3): 2,3,5
objects/obj_koopa_b/Draw_0.gml(3): 2,3,5
objects/obj_koopa_red/Draw_0.gml(3): 2,3,5
objects/obj_koopa_red_b/Draw_0.gml(3): 2,3,5
objects/obj_mario_transform2/Draw_0.gml(3): 3,5,6
objects/obj_plataforma_blue/Draw_0.gml(3): 3,4,14
objects/obj_pswitch/Draw_0.gml(3): 4,8,10
objects/obj_settings_custom/Draw_0.gml(3): 1,2,3
objects/obj_spike/Draw_0.gml(3): 2,4,11
objects/obj_spinner/Draw_0.gml(3): 4,6,10
objects/obj_spiny/Draw_0.gml(3): 2,4,6
objects/obj_superarcon/Draw_0.gml(3): 1,3,5
objects/obj_window_mario_button/Draw_0.gml(3): 1,2,3
objects/obj_yoshi2/Draw_0.gml(3): 7,11,19
scripts/draw_circle_colour_precise/draw_circle_colour_precise.gml(3): 1,2,3
scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml(3): 13,18,27
objects/obj_NSMBU_bowser/Draw_0.gml(2): 2,4
objects/obj_SMB3_bowser/Draw_0.gml(2): 2,4
objects/obj_SMB_bowser/Draw_0.gml(2): 2,4
objects/obj_SMW_bowser/Draw_0.gml(2): 2,4
objects/obj_banzaibill/Draw_0.gml(2): 2,3
objects/obj_beanstalk/Draw_0.gml(2): 2,4
objects/obj_bg1/Draw_0.gml(2): 1,2
objects/obj_billbanzai_red/Draw_0.gml(2): 2,3
objects/obj_block_hidden/Draw_0.gml(2): 1,3
objects/obj_bones_yoshi_one/Draw_0.gml(2): 1,2
objects/obj_boomboom/Draw_0.gml(2): 7,9
objects/obj_brickhelmet/Draw_0.gml(2): 1,7
objects/obj_bullebill_base/Draw_0.gml(2): 9,12
objects/obj_bullebill_base_red/Draw_0.gml(2): 9,12
objects/obj_bulletbill/Draw_0.gml(2): 2,3
objects/obj_bulletbull_red/Draw_0.gml(2): 2,3
objects/obj_bumper/Draw_0.gml(2): 2,4
objects/obj_card_autoavance/Draw_0.gml(2): 2,3
objects/obj_card_bg/Draw_0.gml(2): 2,3
objects/obj_card_condiciones/Draw_0.gml(2): 1,3
objects/obj_card_logo/Draw_0.gml(2): 1,2
objects/obj_castle/Draw_0.gml(2): 1,2
objects/obj_chain_chomp_free/Draw_0.gml(2): 2,3
objects/obj_charginchuck/Draw_0.gml(2): 1,3
objects/obj_cloud_lakitu/Draw_0.gml(2): 2,4
objects/obj_clown_fire/Draw_0.gml(2): 5,7
objects/obj_coin10/Draw_0.gml(2): 7,10
objects/obj_creator_jugar_editar/Draw_0.gml(2): 3,4
objects/obj_crystalorb/Draw_0.gml(2): 2,3
objects/obj_door_lock/Draw_0.gml(2): 2,4
objects/obj_door_lock_exit/Draw_0.gml(2): 2,4
objects/obj_edit_menu/Draw_0.gml(2): 1,2
objects/obj_efecto_sonido/Draw_0.gml(2): 2,4
objects/obj_explosion/Draw_0.gml(2): 2,4
objects/obj_firebar/Draw_0.gml(2): 2,7
objects/obj_goalgate/Draw_0.gml(2): 2,4
objects/obj_goalgate_tape/Draw_0.gml(2): 4,7
objects/obj_grinder/Draw_0.gml(2): 1,3
objects/obj_ground_slope/Draw_0.gml(2): 2,4
objects/obj_hawmask/Draw_0.gml(2): 1,2
objects/obj_link_arrow_anim/Draw_0.gml(2): 3,7
objects/obj_link_dash_atack/Draw_0.gml(2): 3,7
objects/obj_load_image/Draw_0.gml(2): 2,3
objects/obj_logo_game/Draw_0.gml(2): 2,3
objects/obj_magic/Draw_0.gml(2): 2,3
objects/obj_next_before/Draw_0.gml(2): 6,9
objects/obj_panel_circle/Draw_0.gml(2): 1,3
objects/obj_player_goal_nsmbu/Draw_0.gml(2): 5,9
objects/obj_player_goal_smb1/Draw_0.gml(2): 1,5
objects/obj_player_goal_smb3/Draw_0.gml(2): 3,7
objects/obj_robot/Draw_0.gml(2): 2,3
objects/obj_scrollbar2/Draw_0.gml(2): 1,2
objects/obj_scrollbar3/Draw_0.gml(2): 1,2
objects/obj_scrollbar4/Draw_0.gml(2): 1,2
objects/obj_selecting_fps/Draw_0.gml(2): 1,2
objects/obj_selecting_player/Draw_0.gml(2): 1,2
objects/obj_sidefade/Draw_0.gml(2): 2,9
objects/obj_skewer/Draw_0.gml(2): 1,2
objects/obj_snow_ball/Draw_0.gml(2): 1,3
objects/obj_snow_ball_b/Draw_0.gml(2): 1,3
objects/obj_soplete/Draw_0.gml(2): 2,3
objects/obj_spike_ball/Draw_0.gml(2): 1,3
objects/obj_spike_ball_b/Draw_0.gml(2): 1,3
objects/obj_title_oprime/Draw_0.gml(2): 2,5
objects/obj_version/Create_0.gml(2): 3,4
objects/obj_vsync/Draw_0.gml(2): 1,2
objects/obj_water_move/Draw_0.gml(2): 1,2
objects/obj_water_move_limit/Draw_0.gml(2): 4,6
objects/obj_window_button/Draw_0.gml(2): 1,2
objects/obj_window_select/Draw_0.gml(2): 1,2
objects/obj_yoshi2/Other_12.gml(2): 24,28
objects/obj_yoshi_abandon/Draw_0.gml(2): 2,4
objects/obj_yoshi_runaway/Draw_0.gml(2): 2,4
scripts/draw_background/draw_background.gml(2): 6,8
scripts/draw_background_ext/draw_background_ext.gml(2): 11,13
scripts/draw_enable_alphablend/draw_enable_alphablend.gml(2): 3,4
scripts/draw_set_blend_mode/draw_set_blend_mode.gml(2): 3,4
scripts/draw_sprite_autotiled/draw_sprite_autotiled.gml(2): 8,180
scripts/draw_sprite_autotiled2/draw_sprite_autotiled2.gml(2): 8,181
scripts/draw_sprite_tiled_area_ext/draw_sprite_tiled_area_ext.gml(2): 12,63
objects/obj_NSMBU_bowser_fire/Draw_0.gml(1): 1
objects/obj_NSMBU_bowser_fire_up/Draw_0.gml(1): 1
objects/obj_NSMBU_bowserjr_fire/Draw_0.gml(1): 1
objects/obj_NSMBU_ninji/Draw_0.gml(1): 1
objects/obj_SMB_castle_front/Draw_0.gml(1): 1
objects/obj_arrow/Draw_0.gml(1): 1
objects/obj_beachkoopa/Draw_0.gml(1): 1
objects/obj_big_pplant/Draw_0.gml(1): 1
objects/obj_block/Draw_0.gml(1): 6
objects/obj_block_gold/Draw_0.gml(1): 6
objects/obj_block_multicoin/Draw_0.gml(1): 7
objects/obj_block_pow_hold/Draw_0.gml(1): 2
objects/obj_blockparent/Draw_0.gml(1): 7
objects/obj_blooper/Draw_0.gml(1): 1
objects/obj_bone/Draw_0.gml(1): 1
objects/obj_bones_yoshi/Draw_0.gml(1): 1
objects/obj_boomerang/Draw_0.gml(1): 1
objects/obj_bouncycloud/Draw_0.gml(1): 1
objects/obj_bowser_dead/Draw_0.gml(1): 1
objects/obj_bowser_fire/Draw_0.gml(1): 1
objects/obj_bowser_fire_down/Draw_0.gml(1): 1
objects/obj_bowserfire_up/Draw_0.gml(1): 1
objects/obj_bowserjr_fire/Draw_0.gml(1): 1
objects/obj_brohammer/Draw_0.gml(1): 1
objects/obj_brohammer_yoshi/Draw_0.gml(1): 1
objects/obj_bt_close_water/Draw_0.gml(1): 1
objects/obj_bt_gb_delete/Draw_0.gml(1): 1
objects/obj_btn_header_1/Draw_0.gml(1): 1
objects/obj_btn_header_2/Draw_0.gml(1): 1
objects/obj_btn_header_3/Draw_0.gml(1): 1
objects/obj_btn_header_4/Draw_0.gml(1): 1
objects/obj_btn_header_parent/Draw_0.gml(1): 1
objects/obj_btn_iniciar/Draw_0.gml(1): 1
objects/obj_button_creditos/Draw_0.gml(1): 1
objects/obj_button_meteoritos/Draw_0.gml(1): 1
objects/obj_button_sdog/Draw_0.gml(1): 1
objects/obj_button_speed_water/Draw_0.gml(1): 1
objects/obj_button_trail/Draw_0.gml(1): 1
objects/obj_buzzy_ceiling/Draw_0.gml(1): 1
objects/obj_card_block_sounds/Draw_0.gml(1): 1
objects/obj_card_bout/Draw_0.gml(1): 1
objects/obj_change_view/Draw_0.gml(1): 1
objects/obj_checkpoint/Draw_0.gml(1): 1
objects/obj_cinta/Draw_0.gml(1): 9
objects/obj_cinta_switch/Draw_0.gml(1): 9
objects/obj_clown/Draw_0.gml(1): 1
objects/obj_coin_pow/Draw_0.gml(1): 5
objects/obj_configurar_controles_reset/Draw_0.gml(1): 1
objects/obj_cooligan/Draw_0.gml(1): 1
objects/obj_creation_preview/Draw_0.gml(1): 1
objects/obj_crumblebones/Draw_0.gml(1): 1
objects/obj_cursor/Draw_0.gml(1): 1
objects/obj_deadmario/Draw_0.gml(1): 1
objects/obj_decoracion_parent/Draw_0.gml(1): 1
objects/obj_dog/Draw_0.gml(1): 1
objects/obj_door/Draw_0.gml(1): 1
objects/obj_door_exit/Draw_0.gml(1): 1
objects/obj_door_exit_res/Draw_0.gml(1): 3
objects/obj_door_lock_exit_res/Draw_0.gml(1): 3
objects/obj_door_lock_res/Draw_0.gml(1): 3
objects/obj_door_res/Draw_0.gml(1): 3
objects/obj_door_switch/Draw_0.gml(1): 1
objects/obj_door_switch_exit/Draw_0.gml(1): 1
objects/obj_door_switch_exit_res/Draw_0.gml(1): 3
objects/obj_door_switch_res/Draw_0.gml(1): 3
objects/obj_efecto_musica/Draw_0.gml(1): 1
objects/obj_effect_link/Draw_0.gml(1): 2
objects/obj_egg_hatch/Draw_0.gml(1): 1
objects/obj_enemy_dead/Draw_0.gml(1): 1
objects/obj_enemy_dead_castle/Draw_0.gml(1): 1
objects/obj_enemy_multidead/Draw_0.gml(1): 1
objects/obj_enemyparent_lava/Draw_0.gml(1): 1
objects/obj_erase/Draw_0.gml(1): 1
objects/obj_espina/Draw_0.gml(1): 1
objects/obj_expand/Draw_0.gml(1): 1
objects/obj_expand_paneles_top/Draw_0.gml(1): 6
objects/obj_expand_panels/Draw_0.gml(1): 6
objects/obj_expand_panels_left/Draw_0.gml(1): 6
objects/obj_fire_clown/Draw_0.gml(1): 1
objects/obj_fishbone/Draw_0.gml(1): 2
objects/obj_flagpole/Draw_0.gml(1): 1
objects/obj_flipblock/Draw_0.gml(1): 7
objects/obj_floruga_body/Draw_0.gml(1): 1
objects/obj_foo/Draw_0.gml(1): 1
objects/obj_foo_fog/Draw_0.gml(1): 1
objects/obj_galoomba_hold/Draw_0.gml(1): 1
objects/obj_getshoe/Draw_0.gml(1): 1
objects/obj_grid/Draw_0.gml(1): 30
objects/obj_grrrol/Draw_0.gml(1): 1
objects/obj_grrrol_b/Draw_0.gml(1): 1
objects/obj_grrrol_new/Draw_0.gml(1): 1
objects/obj_holdparent/Draw_0.gml(1): 1
objects/obj_icecoin/Draw_0.gml(1): 6
objects/obj_icicle/Draw_0.gml(1): 1
objects/obj_key/Draw_0.gml(1): 1
objects/obj_key_fallow/Draw_0.gml(1): 4
objects/obj_lave_draw/Draw_0.gml(1): 6
objects/obj_lighting/Create_0.gml(1): 3
objects/obj_lighting/Draw_0.gml(1): 4
objects/obj_link_arrow/Draw_0.gml(1): 1
objects/obj_magikoopa/Draw_0.gml(1): 1
objects/obj_mario_intro/Draw_0.gml(1): 1
objects/obj_mario_temp/Draw_0.gml(1): 1
objects/obj_mechakoopa/Draw_0.gml(1): 1
objects/obj_mechakoopa_held/Draw_0.gml(1): 1
objects/obj_menu_editor/Draw_0.gml(1): 1
objects/obj_menu_editor_ext/Draw_0.gml(1): 1
objects/obj_modelsizable/Other_10.gml(1): 32
objects/obj_modelsizable/Other_12.gml(1): 9
objects/obj_modelsolid/Draw_0.gml(1): 2
objects/obj_muncher/Draw_0.gml(1): 2
objects/obj_musicblock/Draw_0.gml(1): 6
objects/obj_ninji/Draw_0.gml(1): 1
objects/obj_noteblock/Draw_0.gml(1): 6
objects/obj_onewaygate_bottom/Draw_0.gml(1): 1
objects/obj_onewaygate_left/Draw_0.gml(1): 1
objects/obj_onewaygate_right/Draw_0.gml(1): 1
objects/obj_onewaygate_top/Draw_0.gml(1): 1
objects/obj_onoffblock/Draw_0.gml(1): 3
objects/obj_panel_expand/Draw_0.gml(1): 1
objects/obj_panel_left/Draw_0.gml(1): 1
objects/obj_physicsparent/Draw_0.gml(1): 1
objects/obj_pinchos/Draw_0.gml(1): 3
objects/obj_pink_coin/Draw_0.gml(1): 1
objects/obj_piranhaplant/Draw_0.gml(1): 1
objects/obj_plant_fire/Draw_0.gml(1): 1
objects/obj_plataforma/Draw_0.gml(1): 9
objects/obj_platform_help/Draw_0.gml(1): 2
objects/obj_player_goal_parent/Draw_0.gml(1): 1
objects/obj_podoboo/Draw_0.gml(1): 1
objects/obj_pokey/Draw_0.gml(1): 1
objects/obj_puller/Draw_0.gml(1): 2
objects/obj_rails/Draw_0.gml(1): 17
objects/obj_rocangrejo/Draw_0.gml(1): 1
objects/obj_rocky/Draw_0.gml(1): 1
objects/obj_rorock/Draw_0.gml(1): 1
objects/obj_score_flag/Draw_0.gml(1): 1
objects/obj_settings_button/Draw_0.gml(1): 1
objects/obj_shard/Draw_0.gml(1): 1
objects/obj_smoke/Draw_0.gml(1): 1
objects/obj_smoke_goomba/Draw_0.gml(1): 1
objects/obj_smoke_shoe/Draw_0.gml(1): 1
objects/obj_smoke_steps/Draw_0.gml(1): 1
objects/obj_snow_ball_held/Draw_0.gml(1): 1
objects/obj_sparkles_blend/Draw_0.gml(1): 3
objects/obj_stomped/Draw_0.gml(1): 1
objects/obj_thwomp/Draw_0.gml(1): 1
objects/obj_thwomp_intro/Draw_0.gml(1): 1
objects/obj_timeup/Draw_0.gml(1): 1
objects/obj_torbellino/Draw_0.gml(1): 1
objects/obj_vine_green/Draw_0.gml(1): 19
objects/obj_wings_dead/Draw_0.gml(1): 1
objects/obj_wings_dead_b/Draw_0.gml(1): 1
objects/obj_wrench/Draw_0.gml(1): 1
objects/obj_yoshifire/Draw_0.gml(1): 1
objects/obj_zoomclose/Draw_0.gml(1): 1
scripts/__init_global/__init_global.gml(1): 6
scripts/init_shockwave/init_shockwave.gml(1): 2
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/cre_control/Draw_0.gml:1 | `draw_set_font(global.font_google)` |
| objects/obj_alert_condicion/Draw_0.gml:4 | `draw_set_color(c_white)` |
| objects/obj_boo/Draw_0.gml:7 | `draw_sprite_ext(sprite_index, image_index, round(x), y, direct, 1, 0, c_white, 1)` |
| objects/obj_button_settings_controls/Draw_0.gml:4 | `draw_text((x + 25), (y + 1), string_hash_to_newline(text))` |
| objects/obj_cinta_on_res/Draw_0.gml:29 | `draw_sprite_ext(spr_move_puentes, 0, (x + ((16 * size_x) - 16)), y, 1, 1, 0, c_white, 1)` |
| objects/obj_doormario_exit/Draw_0.gml:121 | `draw_sprite_ext(sprite_index, 0, round(x), (y + 1), direct, 1, 0, c_white, image_alpha)` |
| objects/obj_gb_level/Draw_0.gml:23 | `draw_sprite(spr_date_time_bg, 0, (camera_get_view_x(view_get_camera(0)) + 44), (camera_get_view_y(view_get_camera(0)) + 146));` |
| objects/obj_input_desc/Draw_0.gml:3 | `draw_set_color(c_title)` |
| objects/obj_lighting/Step_0.gml:45 | `draw_set_alpha(1)` |
| objects/obj_mariostart/Draw_0.gml:27 | `draw_sprite_ext(spr_pausaicons, 3,(camera_get_view_x(view_get_camera(0)) + 290) , (camera_get_view_y(view_get_camera(0)) + 71), 1.5, 1.5, image_angle,…` |
| objects/obj_persistent/Draw_0.gml:7 | `gpu_set_blendenable(1)` |
| objects/obj_powerupparent/Draw_0.gml:12 | `draw_sprite_ext(spr_paracaidas, global.apariencia, x, (y - 16), 1, 1, image_angle, c_white, 1)` |
| objects/obj_skewer_res/Draw_0.gml:11 | `draw_sprite_ext(grid_selected, 0, x, y, 1, 1, 0, c_white, 1)` |
| objects/obj_toast/Draw_0.gml:5 | `draw_text(((camera_get_view_x(view_get_camera(0)) + xx) + 30), (((camera_get_view_y(view_get_camera(0)) + yy) + 6) - anim), string_hash_to_newline((te…` |

### 3.6 surface / shader

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| surface_*: `\bsurface_\w+` | 29 | 12 |
| shader_*: `\bshader_\w+` | 56 | 21 |
| application_surface: `\bapplication_surface\w*` | 13 | 13 |
| **并集（本类合计）** | **97** | **43** |

<details><summary>按文件完整索引（43 个文件，97 行命中）</summary>

```
objects/obj_persistent/Draw_64.gml(9): 5,8,9,10,11,12,13,14,15
objects/obj_lighting/Step_0.gml(6): 1,3,266,270,271,273
objects/obj_player_goal_smw/Draw_0.gml(6): 28,30,49,51,60,62
scripts/init_shockwave/init_shockwave.gml(6): 3,5,8,11,13,15
objects/obj_curtainin/Step_0.gml(4): 2,3,6,11
objects/obj_curtainout/Step_0.gml(4): 2,3,6,11
objects/obj_lighting/Create_0.gml(3): 1,2,4
objects/obj_brickhelmet/Draw_0.gml(2): 6,8
objects/obj_cap_mario/Draw_0.gml(2): 6,8
objects/obj_curtainin/CleanUp_0.gml(2): 4,5
objects/obj_curtainout/CleanUp_0.gml(2): 4,5
objects/obj_curtainout/Create_0.gml(2): 2,4
objects/obj_helmet/Draw_0.gml(2): 17,30
objects/obj_kuribo_drybones/Draw_0.gml(2): 27,36
objects/obj_kuriboshoe/Draw_0.gml(2): 21,24
objects/obj_lighting/Draw_0.gml(2): 1,2
objects/obj_lighting/Other_5.gml(2): 1,2
objects/obj_link_arrow_anim/Draw_0.gml(2): 6,8
objects/obj_link_dash_atack/Draw_0.gml(2): 6,8
objects/obj_mario/Draw_0.gml(2): 13,19
objects/obj_marioU/Draw_0.gml(2): 12,18
objects/obj_mario_editor/Draw_0.gml(2): 16,26
objects/obj_mario_pballon/Draw_0.gml(2): 7,12
objects/obj_player_goal_nsmbu/Draw_0.gml(2): 8,10
objects/obj_player_goal_smb1/Draw_0.gml(2): 4,6
objects/obj_player_goal_smb3/Draw_0.gml(2): 6,8
objects/obj_player_goal_smw_castle/Draw_0.gml(2): 42,44
objects/obj_player_warp/Draw_0.gml(2): 121,123
objects/obj_spinner/Draw_0.gml(2): 9,11
objects/obj_yoshi2/Other_12.gml(2): 27,29
objects/obj_curtainin/Create_0.gml(1): 2
objects/obj_curtainin/Draw_0.gml(1): 2
objects/obj_fadein/Create_0.gml(1): 2
objects/obj_iname_control/Create_0.gml(1): 9
objects/obj_iname_control2/Create_0.gml(1): 9
objects/obj_mario_transform2/Alarm_0.gml(1): 7
objects/obj_menu_pausa/Create_0.gml(1): 14
objects/obj_persistent/Create_0.gml(1): 159
objects/obj_persistent/Other_10.gml(1): 5
objects/obj_persistent/Other_11.gml(1): 5
objects/obj_persistent/Other_5.gml(1): 5
objects/obj_rename_control/Create_0.gml(1): 8
objects/obj_titlemenu_key/Create_0.gml(1): 8
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_brickhelmet/Draw_0.gml:6 | `shader_set(sha_blendreplace)` |
| objects/obj_curtainin/Create_0.gml:2 | `surf = surface_create(camera_get_view_width(view_get_camera(0)), camera_get_view_height(view_get_camera(0)))` |
| objects/obj_curtainout/CleanUp_0.gml:5 | `surface_free(surf);` |
| objects/obj_fadein/Create_0.gml:2 | `back = background_create_from_surface(application_surface, 0, 0, room_width, room_height, 0, 0)` |
| objects/obj_kuriboshoe/Draw_0.gml:21 | `shader_set(sha_blendreplace)` |
| objects/obj_lighting/Other_5.gml:1 | `if surface_exists(surf)` |
| objects/obj_lighting/Step_0.gml:273 | `surface_reset_target()` |
| objects/obj_marioU/Draw_0.gml:12 | `shader_set(sha_blendreplace)` |
| objects/obj_menu_pausa/Create_0.gml:14 | `back = background_create_from_surface(application_surface, 0, 0, (global.gw * sx), (global.gh * sx), false, false)` |
| objects/obj_persistent/Draw_64.gml:12 | `shader_set_uniform_f(uni_shock_refraction, var_shock_refraction)` |
| objects/obj_player_goal_nsmbu/Draw_0.gml:8 | `shader_set(sha_blendreplace)` |
| objects/obj_player_goal_smw/Draw_0.gml:30 | `shader_reset()` |
| objects/obj_player_warp/Draw_0.gml:121 | `shader_set(sha_blendreplace)` |
| objects/obj_yoshi2/Other_12.gml:29 | `shader_reset()` |

### 3.7 global

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| global.*: `\bglobal\.\w+` | 9266 | 2037 |
| globalvar: `\bglobalvar\b` | 0 | 0 |
| **并集（本类合计）** | **9266** | **2037** |

<details><summary>按文件完整索引（2037 个文件，9266 行命中）</summary>

```
scripts/__global_object_depths/__global_object_depths.gml(1594): 8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,…+1574
scripts/scr_init_globals/scr_init_globals.gml(149): 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,…+129
objects/obj_persistent/Create_0.gml(110): 6,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,…+90
objects/obj_mario/Other_12.gml(77): 3,13,39,41,53,85,96,98,103,107,111,113,118,123,125,139,157,162,167,186,…+57
objects/obj_load_guardabot/Other_11.gml(72): 3,5,7,32,34,35,37,38,39,40,41,42,43,44,45,46,47,48,56,60,…+52
objects/obj_mario/Step_2.gml(71): 2,8,18,39,46,71,79,106,122,171,177,182,183,185,213,242,254,255,257,265,…+51
objects/obj_levelmanager/Step_2.gml(65): 2,3,7,20,30,31,34,35,37,158,220,222,239,241,243,248,250,261,263,271,…+45
scripts/scr_edit_to_play/scr_edit_to_play.gml(55): 226,230,232,239,243,245,249,253,255,259,263,265,272,276,280,743,887,1070,1087,1104,…+35
objects/obj_marioU/Other_12.gml(54): 1,11,50,62,76,87,101,108,113,141,146,148,153,164,166,174,176,189,203,210,…+34
objects/obj_persistent/Step_0.gml(42): 1,3,11,16,21,26,31,36,41,46,49,51,53,55,57,59,61,63,65,67,…+22
objects/obj_load_level/Other_10.gml(41): 2,4,6,10,21,22,23,24,25,26,27,28,29,30,31,38,39,40,61,62,…+21
objects/obj_deadmario/Create_0.gml(38): 4,5,8,9,38,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,…+18
objects/obj_mario/Other_13.gml(38): 3,29,36,45,62,65,69,80,97,108,128,134,159,167,185,191,199,213,218,232,…+18
scripts/scr_marioclimb/scr_marioclimb.gml(38): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+18
scripts/scr_tiles_ground/scr_tiles_ground.gml(37): 2,4,17,29,39,49,51,54,62,68,76,86,92,98,104,110,120,122,131,147,…+17
objects/obj_creator_jugar_editar/Other_13.gml(36): 2,3,37,53,55,59,64,67,69,78,79,85,94,98,100,102,104,126,131,155,…+16
scripts/scr_mariodrop/scr_mariodrop.gml(36): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+16
scripts/scr_marioduck/scr_marioduck.gml(36): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+16
scripts/scr_mariohold/scr_mariohold.gml(36): 2,4,6,15,17,26,28,37,39,49,51,53,70,72,89,91,108,110,128,130,…+16
scripts/scr_mariojump/scr_mariojump.gml(36): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+16
scripts/scr_marioswim/scr_marioswim.gml(36): 2,4,6,27,29,51,53,74,76,98,100,102,119,121,138,140,157,159,177,179,…+16
objects/obj_mario/Step_0.gml(35): 2,16,62,70,262,267,297,327,330,340,345,350,352,359,365,373,378,381,386,392,…+15
scripts/scr_tiles_ground_start/scr_tiles_ground_start.gml(35): 2,4,25,35,45,47,50,58,64,78,84,90,96,102,112,114,123,139,149,159,…+15
objects/obj_checkpoint/Other_11.gml(33): 2,3,5,6,8,10,11,13,15,16,18,20,21,23,25,26,28,30,31,33,…+13
objects/obj_marioU/Step_2.gml(33): 34,38,47,62,85,134,161,204,222,296,312,346,374,459,516,539,553,566,602,639,…+13
objects/obj_persistent/Other_2.gml(32): 28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,…+12
objects/obj_player_goal_parent/Create_0.gml(31): 14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,…+11
objects/obj_menu_pausa/Other_11.gml(30): 1,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,…+10
objects/obj_load_guardabot/Other_12.gml(29): 9,12,38,55,57,71,73,108,129,150,167,169,198,213,232,234,273,275,277,282,…+9
scripts/scr_mario_drybones/scr_mario_drybones.gml(29): 3,5,7,28,30,51,53,74,76,98,100,102,119,121,138,140,157,159,177,179,…+9
scripts/scr_marioidle/scr_marioidle.gml(29): 3,5,7,28,30,51,53,74,76,98,100,102,119,121,138,140,157,159,177,179,…+9
scripts/scr_reset_variables/scr_reset_variables.gml(29): 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,…+9
objects/obj_continue_btn/Alarm_0.gml(28): 7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,…+8
objects/obj_button_notification_aceptar/Other_10.gml(27): 3,4,8,9,37,38,39,40,41,43,44,51,54,55,56,57,58,59,60,213,…+7
objects/obj_checkpoint/Create_0.gml(27): 2,4,9,14,17,44,65,66,67,68,69,70,71,72,73,74,75,76,77,78,…+7
scripts/scr_mario_swim_idle/scr_mario_swim_idle.gml(27): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+7
scripts/scr_mariokick/scr_mariokick.gml(27): 2,4,6,15,17,26,28,37,39,49,51,53,70,72,89,91,108,110,128,130,…+7
scripts/scr_marioskid/scr_marioskid.gml(27): 3,5,7,26,28,47,49,68,70,90,92,94,109,111,126,128,143,145,161,163,…+7
scripts/scr_marioswimhold/scr_marioswimhold.gml(27): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+7
scripts/scr_mariowalk/scr_mariowalk.gml(27): 2,4,6,27,29,50,52,73,75,97,99,101,118,120,137,139,156,158,176,178,…+7
objects/obj_enemyparent_held/Step_2.gml(26): 7,43,60,65,75,87,92,94,99,103,105,114,129,130,134,136,141,151,155,157,…+6
objects/obj_gb_level/Create_0.gml(26): 47,49,53,54,55,56,57,58,65,66,67,68,69,71,72,74,75,126,127,128,…+6
objects/obj_load_level/Other_11.gml(26): 9,12,48,75,77,96,98,138,164,190,212,214,249,269,293,295,343,352,373,382,…+6
objects/obj_marioU/Step_0.gml(26): 15,50,245,250,297,299,308,315,324,329,341,353,371,373,389,391,392,393,394,398,…+6
objects/obj_player_goal_smw_castle/Create_0.gml(26): 3,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,…+6
objects/obj_angrysun_res/Other_14.gml(25): 1,10,19,24,29,34,39,45,49,52,56,59,67,76,85,94,103,108,113,121,…+5
objects/obj_marioU/Other_13.gml(25): 10,29,36,65,71,86,91,108,114,144,163,169,177,191,196,218,223,225,230,269,…+5
objects/obj_player_goal_nsmbu/Create_0.gml(25): 37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,…+5
objects/obj_button_save_changes/Other_10.gml(24): 3,4,8,9,37,38,39,40,41,43,44,51,54,55,56,57,58,59,60,213,…+4
objects/obj_load_level/Other_12.gml(24): 1,12,23,28,33,38,43,49,53,56,60,63,71,80,89,99,109,114,119,127,…+4
scripts/scr_semisolid_platform2_sprites/scr_semisolid_platform2_sprites.gml(24): 2,4,11,18,29,40,48,50,61,78,84,92,94,105,124,132,134,137,146,151,…+4
objects/obj_holdparent/Step_2.gml(23): 7,43,60,65,67,72,76,78,84,99,100,104,106,111,121,125,127,132,142,146,…+3
scripts/scr_semisolid_platform1_sprites/scr_semisolid_platform1_sprites.gml(23): 2,4,15,34,41,43,54,71,77,85,87,98,117,124,126,129,138,143,150,157,…+3
scripts/scr_semisolid_platform3_sprites/scr_semisolid_platform3_sprites.gml(23): 2,4,15,34,42,44,55,72,78,86,88,99,118,125,127,130,139,144,151,158,…+3
objects/obj_brickhelmet/Other_18.gml(22): 3,8,15,30,42,49,56,68,73,88,100,107,119,127,145,152,157,162,174,194,…+2
scripts/scr_mushroom_platform2_sprites/scr_mushroom_platform2_sprites.gml(22): 2,4,7,24,33,35,37,40,61,64,88,90,93,104,113,115,118,129,138,140,…+2
objects/obj_levelmanager/Other_19.gml(21): 2,5,8,11,14,20,22,23,24,30,31,33,34,37,38,39,41,44,45,46,…+1
objects/obj_persistent/Other_4.gml(21): 3,4,5,6,7,8,11,12,16,17,18,19,20,24,25,26,27,33,34,35,…+1
objects/obj_puente_res/Step_2.gml(21): 1,3,6,24,34,36,39,54,60,70,72,75,96,107,109,112,118,124,130,148,…+1
objects/obj_persistent/Other_17.gml(20): 7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45
objects/obj_titlemenu_key/KeyPress_1.gml(20): 11,14,17,20,23,26,29,32,35,47,49,53,55,58,61,64,67,70,73,76
scripts/scr_create_bg_anim/scr_create_bg_anim.gml(20): 7,10,12,20,28,36,47,49,57,67,75,86,88,98,108,120,122,133,144,155
scripts/scr_mario_drybones_jump/scr_mario_drybones_jump.gml(20): 3,5,7,24,26,43,45,62,64,82,84,86,99,101,114,116,129,131,145,147
objects/obj_angrysun_res/Other_11.gml(19): 7,8,10,19,23,54,75,77,93,95,132,155,178,197,199,230,247,268,270
objects/obj_cursor/Mouse_50.gml(19): 13,14,15,21,22,23,24,25,26,27,28,29,30,31,32,34,39,40,58
objects/obj_cursor/Mouse_53.gml(19): 14,15,16,22,23,24,25,26,27,28,29,30,31,32,33,34,35,40,49
objects/obj_kuribo_drybones/Step_2.gml(19): 5,17,28,41,49,75,79,93,98,103,132,138,141,157,167,173,191,194,210
objects/obj_levelmanager/Other_4.gml(19): 3,5,6,8,9,10,11,12,13,14,17,19,22,26,32,36,41,43,49
objects/obj_nube/Create_0.gml(19): 2,5,7,9,11,13,18,21,23,25,27,32,35,40,43,45,47,49,51
objects/obj_nube_res/Step_2.gml(19): 1,4,6,8,10,12,17,20,22,24,26,31,34,39,42,44,46,48,50
objects/obj_pinchos_res/Step_2.gml(19): 1,3,5,7,9,11,13,18,20,22,24,26,28,30,35,37,42,44,46
scripts/scr_mushroom_platform3_sprites/scr_mushroom_platform3_sprites.gml(19): 2,4,7,28,30,32,35,54,57,79,81,84,99,101,104,119,121,123,146
objects/obj_block_multicoin/Alarm_1.gml(18): 5,9,11,13,15,17,22,26,28,30,31,35,40,42,46,48,50,51
objects/obj_block_multicoin/Create_0.gml(18): 1,3,5,7,9,11,16,18,20,22,23,29,34,36,38,40,56,58
objects/obj_brickhelmet/Other_19.gml(18): 3,8,15,30,42,49,56,68,73,88,100,112,120,138,145,150,155,167
objects/obj_brickhelmet/Other_20.gml(18): 3,8,15,30,42,49,56,68,73,88,100,112,120,138,145,150,155,167
objects/obj_card_logo/Mouse_4.gml(18): 12,16,46,67,69,85,87,124,147,170,189,191,222,239,260,262,301,303
objects/obj_ground3/Draw_0.gml(18): 4,7,12,25,39,49,57,59,61,63,65,67,69,71,73,75,77,82
objects/obj_helmet/Other_18.gml(18): 3,8,15,30,42,49,56,68,73,88,100,112,120,138,145,150,155,167
objects/obj_helmet/Other_19.gml(18): 3,8,15,30,42,49,56,68,73,88,100,112,120,138,145,150,155,167
objects/obj_helmet/Other_20.gml(18): 3,8,15,30,42,49,56,68,73,88,100,112,120,138,145,150,155,167
objects/obj_levelmanager/Other_21.gml(18): 1,15,17,19,29,39,49,51,73,81,94,108,122,136,149,163,174,180
scripts/scr_mario_shoe/scr_mario_shoe.gml(18): 3,5,7,28,30,51,53,74,76,98,100,102,119,121,138,140,157,159
scripts/scr_marioduckhold/scr_marioduckhold.gml(18): 2,4,6,13,15,22,24,31,33,41,43,45,60,62,77,79,94,96
scripts/scr_mariorun/scr_mariorun.gml(18): 2,4,6,23,25,42,44,61,63,81,83,85,100,102,117,119,134,136
scripts/scr_mariorunjump/scr_mariorunjump.gml(18): 2,4,6,21,23,38,40,55,57,73,75,77,92,94,109,111,126,128
scripts/scr_marioslide/scr_marioslide.gml(18): 2,4,6,19,21,34,36,49,51,65,67,69,82,84,97,99,112,114
objects/obj_block_res/Step_2.gml(17): 3,6,8,10,12,17,19,21,23,24,32,38,43,45,47,48,56
objects/obj_blockparent/Collision_obj_meteorites_big.gml(17): 1,8,12,16,20,28,32,36,40,48,52,56,60,68,72,76,80
objects/obj_flagpole/Create_0.gml(17): 1,5,7,9,11,13,15,17,19,21,23,25,30,45,52,57,67
objects/obj_mario/Other_14.gml(17): 4,7,18,29,33,38,40,52,72,75,84,87,98,107,117,120,135
objects/obj_persistent/Draw_0.gml(17): 9,13,15,19,23,27,32,39,41,43,47,49,53,57,66,70,74
scripts/scr_mariogoal/scr_mariogoal.gml(17): 2,4,6,25,27,46,48,67,69,89,91,106,108,123,125,140,142
scripts/scr_marioshoot/scr_marioshoot.gml(17): 2,4,7,13,19,25,33,35,38,44,50,56,64,66,79,83,88
objects/obj_block/Create_0.gml(16): 1,4,6,8,10,12,18,20,22,24,30,32,34,41,57,59
objects/obj_claw/Step_2.gml(16): 4,25,27,34,40,46,55,57,62,67,69,81,103,113,118,143
objects/obj_levelmanager/Other_20.gml(16): 2,5,8,13,14,16,18,19,20,22,24,26,27,28,29,30
objects/obj_menu_pausa/Draw_0.gml(16): 2,12,13,28,30,33,41,42,43,44,45,46,51,53,56,57
objects/obj_night_change/Other_11.gml(16): 10,14,44,65,67,83,85,122,145,168,187,189,220,237,258,260
objects/obj_qblock_res/Step_2.gml(16): 3,5,7,9,11,13,18,20,22,24,26,33,39,41,43,45
scripts/scr_marioshoot_drybones/scr_marioshoot_drybones.gml(16): 3,5,8,14,20,26,34,36,39,45,51,57,65,67,80,82
objects/obj_bg1/Other_10.gml(15): 12,48,75,77,96,98,138,164,190,212,214,248,268,292,294
objects/obj_brickhelmet/Other_23.gml(15): 5,10,12,20,25,27,29,34,39,47,52,57,65,72,77
objects/obj_helmet/Other_23.gml(15): 5,10,12,20,25,27,29,34,39,47,52,57,65,72,77
objects/obj_mario/Other_10.gml(15): 5,7,36,42,53,71,73,90,92,98,123,126,128,131,137
scripts/scr_mushroom_platform1_sprites/scr_mushroom_platform1_sprites.gml(15): 2,4,7,24,33,35,37,58,82,84,87,104,106,108,133
objects/obj_SMB_castle/Create_0.gml(14): 1,4,6,8,10,12,14,16,18,20,22,24,29,34
objects/obj_SMB_castle_front/Create_0.gml(14): 2,5,7,9,11,13,15,17,19,21,23,25,30,35
objects/obj_donut/Create_0.gml(14): 1,6,8,10,12,14,19,24,26,28,33,39,53,55
objects/obj_mario_editor/Step_0.gml(14): 2,3,4,28,30,45,47,51,82,109,113,115,119,121
objects/obj_block/Alarm_1.gml(13): 7,39,44,47,56,70,83,86,101,107,123,135,141
objects/obj_doormario/Draw_0.gml(13): 1,4,33,35,55,59,67,75,87,92,96,100,110
objects/obj_doormario_exit/Draw_0.gml(13): 1,4,33,35,55,59,67,75,87,95,102,106,116
objects/obj_helmet/Other_16.gml(13): 1,8,10,12,16,21,25,27,38,51,57,69,75
objects/obj_pinchos/Create_0.gml(13): 2,5,8,23,29,40,43,61,67,78,82,91,99
objects/obj_shell/Collision_obj_mario.gml(13): 8,10,24,31,42,67,71,83,90,96,116,119,136
scripts/scr_constant_get_sprite/scr_constant_get_sprite.gml(13): 2,39,102,125,160,225,248,285,368,405,488,525,584
objects/obj_coin_pow/Step_0.gml(12): 2,4,8,10,23,25,29,31,44,46,50,52
objects/obj_decoracion_4/Step_2.gml(12): 3,5,11,16,21,26,33,36,42,48,54,61
objects/obj_donut_res/Step_2.gml(12): 1,4,6,8,10,12,17,20,22,24,29,34
objects/obj_door_lock/Step_0.gml(12): 37,40,48,57,59,66,68,77,86,105,127,154
objects/obj_door_lock_exit/Step_0.gml(12): 37,40,48,57,59,66,68,77,86,105,127,153
objects/obj_enemyparent/Collision_obj_mario.gml(12): 18,24,35,53,100,113,130,174,176,186,189,195
objects/obj_flipblock/Create_0.gml(12): 1,6,9,18,35,47,53,69,81,87,110,112
objects/obj_lava_water/Other_10.gml(12): 1,4,7,26,29,47,50,68,71,89,92,104
objects/obj_lave_draw/Create_0.gml(12): 2,4,6,8,11,13,15,17,20,22,24,26
objects/obj_lave_draw/Step_0.gml(12): 1,3,5,7,10,12,14,16,19,21,23,25
objects/obj_load_guardabot/Other_13.gml(12): 1,5,7,14,18,20,24,28,30,34,38,40
objects/obj_mariostart/Draw_0.gml(12): 1,2,3,4,5,8,10,22,24,32,34,36
objects/obj_night_change/Other_12.gml(12): 2,5,46,56,67,87,107,131,143,148,150,152
objects/obj_panel_expand/Create_0.gml(12): 28,31,65,79,91,105,122,168,183,195,200,202
objects/obj_player_warp/Draw_0.gml(12): 1,4,33,35,57,61,71,79,89,93,109,119
objects/obj_tuberia/Step_0.gml(12): 3,17,18,24,37,38,44,58,59,65,78,79
objects/obj_bg1/Other_11.gml(11): 1,4,49,59,70,90,119,137,139,150,155
objects/obj_cap/Collision_obj_mario.gml(11): 3,5,15,17,32,47,65,67,84,101,107
objects/obj_card_logo/Other_11.gml(11): 1,4,49,59,70,90,112,137,139,150,155
objects/obj_clown/Step_0.gml(11): 3,41,49,66,72,78,85,97,104,119,121
objects/obj_cursor/Mouse_56.gml(11): 2,10,12,16,17,19,24,31,32,42,43
objects/obj_decoracion_2/Step_2.gml(11): 3,5,11,16,23,26,32,38,44,50,57
objects/obj_decoracion_3/Step_2.gml(11): 3,5,11,16,23,26,32,38,44,50,57
objects/obj_etiquetas/Mouse_4.gml(11): 5,8,10,19,22,24,38,39,40,41,42
objects/obj_rock_res/Step_2.gml(11): 1,5,8,38,41,53,67,74,80,86,92
scripts/scr_mariowarp/scr_mariowarp.gml(11): 2,4,17,19,21,36,38,53,55,70,72
objects/obj_block_pow_hold/Step_0.gml(10): 7,62,64,79,145,147,151,153,157,159
objects/obj_block_rock/Create_0.gml(10): 2,6,9,38,41,53,73,92,104,129
objects/obj_decoracion_1/Step_2.gml(10): 3,5,11,16,23,26,32,38,44,54
objects/obj_donut/Other_10.gml(10): 1,3,5,7,9,11,16,18,20,22
objects/obj_editormanager/Create_0.gml(10): 8,29,30,31,32,33,34,35,36,37
objects/obj_hawmask/Create_0.gml(10): 1,10,14,16,18,20,22,24,26,28
objects/obj_mario/Alarm_10.gml(10): 2,6,19,32,36,51,68,88,96,110
objects/obj_meteorites/Other_11.gml(10): 1,3,9,19,27,37,44,54,61,71
objects/obj_meteorites_big/Other_11.gml(10): 1,3,9,19,26,36,43,53,60,70
objects/obj_meteorites_big/Other_12.gml(10): 1,3,9,19,26,36,43,53,60,70
objects/obj_persistent/Other_12.gml(10): 2,4,5,6,7,9,11,12,13,14
objects/obj_yoshi_abandon/Step_0.gml(10): 42,46,48,54,58,60,66,70,72,80
scripts/scr_mariodead/scr_mariodead.gml(10): 2,4,17,19,32,34,47,49,66,68
objects/obj_bumper/Collision_obj_mario.gml(9): 3,5,7,16,18,23,28,34,39
objects/obj_button_settings_idioma/Mouse_4.gml(9): 3,4,5,6,7,8,9,10,12
objects/obj_buzzybeetle/Step_0.gml(9): 30,45,126,128,132,134,172,176,178
objects/obj_card_block_sounds/Other_10.gml(9): 15,28,41,54,67,80,93,106,119
objects/obj_checkpoint/Collision_obj_mario.gml(9): 3,20,45,46,47,48,50,51,55
objects/obj_checkpoint/Collision_obj_shell_held.gml(9): 3,20,45,46,47,48,50,51,55
objects/obj_checkpoint/Other_10.gml(9): 1,3,5,9,11,15,17,19,36
objects/obj_frozenmario/Alarm_1.gml(9): 2,22,25,32,35,42,45,52,55
objects/obj_hammerbro/Step_0.gml(9): 2,20,81,89,100,137,139,148,150
objects/obj_rockparent/Collision_obj_meteorites.gml(9): 1,8,18,25,35,42,52,59,69
objects/obj_rockparent/Collision_obj_meteorites_big.gml(9): 1,8,18,25,35,42,52,59,69
objects/obj_sledgebro/Step_0.gml(9): 1,27,45,122,137,178,180,189,191
objects/obj_spike_ball/Step_0.gml(9): 9,13,38,40,101,104,107,110,112
objects/obj_spiny/Step_0.gml(9): 1,15,82,84,88,90,122,126,128
objects/obj_yoshifire/Step_2.gml(9): 1,6,8,14,19,21,27,32,34
scripts/scr_load/scr_load.gml(9): 3,5,7,9,11,13,15,17,18
scripts/scr_snd_editor_mountain/scr_snd_editor_mountain.gml(9): 2,5,9,14,18,23,27,32,36
objects/obj_angrysun/Create_0.gml(8): 2,4,21,23,40,46,57,59
objects/obj_bg1/Mouse_4.gml(8): 9,23,41,50,68,77,98,107
objects/obj_bowser_dead/Step_0.gml(8): 1,3,7,9,13,15,19,39
objects/obj_cheepcheep/Step_0.gml(8): 1,41,61,69,88,115,133,153
objects/obj_cheepcheep2/Step_0.gml(8): 1,41,75,83,102,129,147,167
objects/obj_cinta_res/Step_2.gml(8): 1,3,10,22,24,31,43,50
objects/obj_coin/Create_0.gml(8): 1,4,16,25,37,49,58,79
objects/obj_cooligan/Create_0.gml(8): 3,11,34,37,41,48,51,81
objects/obj_enemyfrozen/Other_10.gml(8): 6,9,16,19,26,29,36,39
objects/obj_flagpole/Alarm_1.gml(8): 1,2,5,9,11,15,19,33
objects/obj_gb_level/Draw_0.gml(8): 4,6,8,14,16,19,20,24
objects/obj_goalcard/Alarm_3.gml(8): 1,2,5,9,11,15,19,30
objects/obj_goalgate/Alarm_0.gml(8): 1,2,5,9,11,15,19,31
objects/obj_guardabot/Create_0.gml(8): 4,5,6,7,20,22,24,29
objects/obj_helmet/Step_2.gml(8): 3,5,7,9,11,13,57,80
objects/obj_helmet_spiny/Other_16.gml(8): 1,8,10,12,18,22,38,49
objects/obj_holdparent/Step_0.gml(8): 3,14,16,98,100,109,111,122
objects/obj_levelmanager/Other_5.gml(8): 2,21,23,24,25,26,27,28
objects/obj_parcarry/Step_2.gml(8): 9,30,33,44,48,53,60,65
objects/obj_persistent/Other_13.gml(8): 2,7,8,9,16,17,18,21
objects/obj_powerupparent/Collision_obj_mario.gml(8): 3,5,15,24,28,54,78,100
objects/obj_pswitch/Step_0.gml(8): 42,44,58,108,110,114,116,140
objects/obj_rocangrejo/Step_0.gml(8): 3,27,33,35,44,46,55,57
objects/obj_shell_drybones/Collision_obj_mario.gml(8): 5,10,12,28,37,41,53,63
objects/obj_thwomp/Alarm_1.gml(8): 8,10,13,27,29,43,45,61
scripts/scr_mario_drybones_goal/scr_mario_drybones_goal.gml(8): 3,5,18,20,33,35,48,50
scripts/scr_mario_pull/scr_mario_pull.gml(8): 2,4,11,13,20,22,29,31
scripts/scr_mario_yoshi_atack/scr_mario_yoshi_atack.gml(8): 3,5,20,22,37,39,54,56
scripts/scr_mario_yoshi_crouch/scr_mario_yoshi_crouch.gml(8): 3,5,20,22,37,39,54,56
scripts/scr_mario_yoshi_goal/scr_mario_yoshi_goal.gml(8): 3,5,18,20,33,35,48,50
scripts/scr_mariojumpstar/scr_mariojumpstar.gml(8): 3,5,18,20,33,35,48,50
scripts/scr_marioride/scr_marioride.gml(8): 2,4,19,21,36,38,53,55
scripts/scr_marioup/scr_marioup.gml(8): 2,4,19,21,36,38,53,55
scripts/scr_mariouphold/scr_mariouphold.gml(8): 2,4,19,21,36,38,53,55
objects/obj_banzaibill/Create_0.gml(7): 1,6,14,25,49,58,85
objects/obj_blockcoin/Create_0.gml(7): 1,4,16,28,40,61,62
objects/obj_boo/Other_18.gml(7): 32,44,59,71,84,97,106
objects/obj_brickhelmet/Step_2.gml(7): 3,9,11,13,15,17,66
objects/obj_brohammer/Step_0.gml(7): 3,5,13,30,32,36,38
objects/obj_bullebill_base/Step_0.gml(7): 3,39,41,44,46,50,52
objects/obj_bullebill_base_red/Step_0.gml(7): 3,43,45,48,50,54,56
objects/obj_cinta/Create_0.gml(7): 2,4,10,23,25,31,44
objects/obj_cinta_switch/Step_0.gml(7): 3,5,11,17,43,49,55
objects/obj_cloud_lakitu/Step_0.gml(7): 3,39,47,64,70,85,103
objects/obj_coin10_res/Step_2.gml(7): 1,4,16,24,35,47,55
objects/obj_coin30_res/Step_2.gml(7): 1,4,16,24,35,47,55
objects/obj_coin50_res/Step_2.gml(7): 1,4,16,24,35,47,55
objects/obj_coin_pow/Collision_obj_mario.gml(7): 5,8,14,32,35,38,43
objects/obj_coin_res/Step_2.gml(7): 1,4,16,25,36,48,57
objects/obj_condiciones/Draw_0.gml(7): 2,4,11,13,14,16,19
objects/obj_cooligan/Step_1.gml(7): 3,11,51,59,72,79,87
objects/obj_deadmario/Alarm_1.gml(7): 8,10,11,12,13,15,16
objects/obj_enemyparent/Step_0.gml(7): 1,14,16,25,27,36,38
objects/obj_enemyparent_held/Step_0.gml(7): 4,15,17,95,97,106,108
objects/obj_ground2/Step_0.gml(7): 2,4,7,19,31,40,50
objects/obj_kuribo_drybones/Alarm_8.gml(7): 7,9,22,24,37,39,54
objects/obj_mario/Draw_0.gml(7): 4,10,14,23,25,29,33
objects/obj_mario_pballon/Step_0.gml(7): 7,48,52,53,54,55,63
objects/obj_noteblock/Create_0.gml(7): 1,8,11,26,37,40,55
objects/obj_noteblock_res/Step_2.gml(7): 3,7,10,25,36,39,54
objects/obj_panel_circle/Other_10.gml(7): 34,64,66,68,76,78,80
objects/obj_persistent/Other_14.gml(7): 6,7,8,9,11,12,13
objects/obj_settings_controls/Step_0.gml(7): 4,8,12,15,19,23,27
objects/obj_shell_held/Step_0.gml(7): 2,50,52,63,65,76,78
objects/obj_snowmaker/Create_0.gml(7): 5,8,17,26,35,45,55
objects/obj_title_controller/Draw_0.gml(7): 13,16,18,21,24,25,26
objects/obj_ventana_mario/Other_10.gml(7): 6,14,21,29,37,45,53
objects/obj_yoshi2/Create_0.gml(7): 1,6,33,35,36,37,38
objects/obj_yoshi_runaway/Step_0.gml(7): 7,9,13,15,19,21,27
scripts/scr_pink_coins/scr_pink_coins.gml(7): 3,4,30,31,57,58,85
scripts/scr_restart/scr_restart.gml(7): 3,5,6,7,8,9,10
scripts/scr_save/scr_save.gml(7): 4,6,8,10,12,16,18
objects/obj_NSMBU_charginchuck/Step_0.gml(6): 121,123,132,134,143,145
objects/obj_angrysun_res/Other_13.gml(6): 2,3,9,26,27,28
objects/obj_arrow_res/Mouse_4.gml(6): 1,3,5,34,37,42
objects/obj_billbanzai_red_res/Mouse_4.gml(6): 1,3,5,37,41,46
objects/obj_billbanzai_res/Mouse_4.gml(6): 1,3,5,37,41,46
objects/obj_billbanzai_res/Step_2.gml(6): 3,8,16,27,51,60
objects/obj_block_hidden_res/Step_2.gml(6): 3,19,28,30,39,45
objects/obj_block_pow_hold/Other_12.gml(6): 1,13,28,45,59,66
objects/obj_bouncycloud/Create_0.gml(6): 1,4,22,34,52,64
objects/obj_bouncycloud_res/Step_2.gml(6): 3,6,24,35,53,64
objects/obj_bowserjr/Other_14.gml(6): 106,113,115,122,141,153
objects/obj_bullebill_base/Alarm_0.gml(6): 12,27,34,45,60,68
objects/obj_bullebill_base_red/Alarm_0.gml(6): 17,32,39,55,70,78
objects/obj_bullebill_base_red_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_bullebill_base_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_buzzybeetle_b/Step_0.gml(6): 30,45,126,128,163,165
objects/obj_cannon_red_res/Mouse_4.gml(6): 1,3,5,58,62,67
objects/obj_cannon_res/Mouse_4.gml(6): 1,3,5,58,62,67
objects/obj_card_bout/Step_0.gml(6): 9,12,32,55,58,70
objects/obj_charginchuck/Step_0.gml(6): 121,123,132,134,143,145
objects/obj_checkpoint/Other_7.gml(6): 1,7,10,16,19,38
objects/obj_checkpoint_res/Mouse_4.gml(6): 1,3,5,34,37,42
objects/obj_cheepcheep/Draw_0.gml(6): 3,6,12,18,24,34
objects/obj_cinta_on_res/Mouse_4.gml(6): 1,3,5,39,43,48
objects/obj_cinta_res/Mouse_4.gml(6): 1,3,5,39,43,48
objects/obj_clown_fire/Step_1.gml(6): 3,5,17,19,48,84
objects/obj_editormanager/Step_0.gml(6): 31,35,37,45,47,63
objects/obj_enemy_dead/Step_0.gml(6): 7,9,13,15,19,58
objects/obj_firebar_res/Mouse_4.gml(6): 1,3,5,30,34,39
objects/obj_grrrol_b_res/Mouse_4.gml(6): 1,3,5,35,39,44
objects/obj_grrrol_new_res/Mouse_4.gml(6): 1,3,5,35,39,44
objects/obj_grrrol_res/Mouse_4.gml(6): 1,3,5,35,39,44
objects/obj_hawmask/Alarm_1.gml(6): 1,5,7,11,15,26
objects/obj_helmet/Draw_0.gml(6): 3,5,15,18,20,37
objects/obj_jumppiranha/Step_0.gml(6): 23,27,29,38,40,53
objects/obj_koopa/Step_0.gml(6): 17,30,81,83,92,94
objects/obj_mario_transform2/Alarm_0.gml(6): 7,14,25,43,48,51
objects/obj_mushroom_platform_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_night_change/Other_13.gml(6): 2,3,9,26,27,28
objects/obj_oneway_res/Mouse_4.gml(6): 1,3,5,34,37,42
objects/obj_onoffblock/Other_10.gml(6): 1,19,21,22,41,42
objects/obj_panel_circle/Other_19.gml(6): 10,20,35,50,65,90
objects/obj_parent_resource/Mouse_4.gml(6): 1,3,5,19,23,28
objects/obj_parent_sounds/Mouse_4.gml(6): 1,3,5,19,23,28
objects/obj_platform_blue_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_platform_res/Mouse_4.gml(6): 1,3,5,35,39,44
objects/obj_player_warp/Step_0.gml(6): 4,17,25,27,33,35
objects/obj_pokey_res/Mouse_4.gml(6): 1,3,5,33,37,42
objects/obj_puente_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_rails_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_semisolid_platform1/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_settings_button/Mouse_4.gml(6): 24,28,29,30,31,32
objects/obj_shell/Step_1.gml(6): 18,20,30,32,42,44
objects/obj_skewer_res/Mouse_4.gml(6): 1,3,5,33,37,42
objects/obj_soplete_res/Mouse_4.gml(6): 1,3,5,46,50,55
objects/obj_thwomp_b_res/Mouse_4.gml(6): 1,3,5,40,44,49
objects/obj_thwomp_res/Mouse_4.gml(6): 1,3,5,40,44,49
objects/obj_tuberia_res/Draw_0.gml(6): 6,12,19,26,33,69
objects/obj_tuberia_res/Mouse_4.gml(6): 1,3,5,27,31,36
objects/obj_veggiecoin/Create_0.gml(6): 1,4,16,28,40,61
objects/obj_ventana_mario/Other_11.gml(6): 6,14,21,29,37,45
objects/obj_ventana_mario/Other_13.gml(6): 6,14,21,29,37,45
objects/obj_vine_res/Mouse_4.gml(6): 1,3,5,33,37,42
objects/obj_water_level_control/Draw_0.gml(6): 4,6,8,10,14,22
objects/obj_water_move_limit/Alarm_0.gml(6): 7,8,16,17,67,68
scripts/__init_action/__init_action.gml(6): 3,4,5,6,10,11
scripts/scr_bg_airship/scr_bg_airship.gml(6): 2,5,11,17,23,29
scripts/scr_bg_beach/scr_bg_beach.gml(6): 2,5,10,15,20,25
scripts/scr_bg_castle/scr_bg_castle.gml(6): 2,5,11,17,23,29
scripts/scr_bg_desert/scr_bg_desert.gml(6): 2,5,11,17,23,29
scripts/scr_bg_fall/scr_bg_fall.gml(6): 2,5,10,15,20,25
scripts/scr_bg_forest/scr_bg_forest.gml(6): 2,5,11,17,23,29
scripts/scr_bg_ground/scr_bg_ground.gml(6): 2,5,10,15,20,25
scripts/scr_bg_mountain/scr_bg_mountain.gml(6): 2,5,11,17,23,30
scripts/scr_bg_sky/scr_bg_sky.gml(6): 2,5,11,17,23,29
scripts/scr_bg_snow/scr_bg_snow.gml(6): 2,5,11,17,23,29
scripts/scr_bg_underground/scr_bg_underground.gml(6): 2,5,10,15,20,25
scripts/scr_bg_underwater/scr_bg_underwater.gml(6): 2,5,10,15,20,25
scripts/scr_constant_make_object/scr_constant_make_object.gml(6): 4,19,34,49,64,86
scripts/scr_powerup_editor/scr_powerup_editor.gml(6): 11,24,38,52,66,80
scripts/scr_viewculling/scr_viewculling.gml(6): 5,7,8,9,13,16
objects/obj_SMB2_mushroom/Collision_obj_mario.gml(5): 3,5,15,24,26
objects/obj_angrysun_res/Step_2.gml(5): 1,4,10,16,22
objects/obj_autoavance/Draw_0.gml(5): 2,4,6,8,13
objects/obj_blockparent/Collision_obj_meteorites.gml(5): 1,8,26,44,62
objects/obj_bossparent/Collision_obj_mario.gml(5): 7,9,22,33,52
objects/obj_bowserjr_shell/Step_0.gml(5): 5,20,22,36,38
objects/obj_bulletbill/Create_0.gml(5): 1,17,21,23,40
objects/obj_checkpoint/Other_4.gml(5): 1,3,8,13,16
objects/obj_coin10/Create_0.gml(5): 1,4,16,27,39
objects/obj_coin30/Create_0.gml(5): 1,4,16,27,39
objects/obj_coin50/Create_0.gml(5): 1,4,16,27,39
objects/obj_coin_pow/Create_0.gml(5): 1,4,16,27,39
objects/obj_editormanager/Draw_0.gml(5): 11,13,15,17,22
objects/obj_editormanager/Other_12.gml(5): 74,159,161,238,312
objects/obj_egg/Draw_0.gml(5): 1,11,21,28,35
objects/obj_egg_blue/Draw_0.gml(5): 1,11,21,28,35
objects/obj_enemyfrozen/Step_0.gml(5): 30,48,119,124,129
objects/obj_fireball/Other_14.gml(5): 32,34,36,40,42
objects/obj_foo/Step_0.gml(5): 3,30,46,54,72
objects/obj_galoomba2_b/Other_11.gml(5): 3,23,31,39,42
objects/obj_galoomba_b/Other_11.gml(5): 3,23,32,40,43
objects/obj_grrrol/Step_0.gml(5): 1,8,61,64,66
objects/obj_grrrol_b/Step_0.gml(5): 1,8,61,64,66
objects/obj_grrrol_new/Step_0.gml(5): 1,8,61,64,66
objects/obj_icecoin_res/Step_2.gml(5): 1,7,10,25,34
objects/obj_icicle/Other_10.gml(5): 1,25,33,41,48
objects/obj_lava_water/Draw_0.gml(5): 6,20,21,23,28
objects/obj_lava_water/Step_0.gml(5): 10,19,36,47,62
objects/obj_load_guardabot/Other_15.gml(5): 1,2,3,4,14
objects/obj_logo_c/Create_0.gml(5): 6,7,8,9,10
objects/obj_marioU/Draw_0.gml(5): 9,22,24,28,32
objects/obj_mario_editor/Draw_0.gml(5): 1,3,5,14,17
objects/obj_mario_editor/Mouse_4.gml(5): 1,5,19,23,28
objects/obj_mariostart_m/Draw_0.gml(5): 1,6,8,12,15
objects/obj_modo_sonidos_control/Draw_0.gml(5): 4,6,8,10,15
objects/obj_mushroom/Collision_obj_mario.gml(5): 3,5,15,24,38
objects/obj_panel_circle/Other_13.gml(5): 9,26,41,64,86
objects/obj_parent_resource/Alarm_0.gml(5): 3,51,56,86,87
objects/obj_persistent/Alarm_10.gml(5): 1,2,3,4,6
objects/obj_pink_coin/Other_10.gml(5): 1,2,6,31,41
objects/obj_pipebase/Create_0.gml(5): 2,8,20,26,32
objects/obj_pipebase_res/Step_2.gml(5): 1,7,19,25,31
objects/obj_player_goal_smw/Step_0.gml(5): 1,6,8,10,29
objects/obj_pokey/Create_0.gml(5): 1,4,10,16,22
objects/obj_pokey_res/Step_2.gml(5): 1,4,10,16,22
objects/obj_pow_res/Step_2.gml(5): 3,17,19,21,23
objects/obj_rocky/Step_0.gml(5): 73,81,83,93,95
objects/obj_settings_panel/Create_0.gml(5): 3,9,14,39,67
objects/obj_sledgebro/Alarm_4.gml(5): 1,12,22,33,40
objects/obj_slider/Step_0.gml(5): 1,17,19,26,75
objects/obj_snow_ball/Collision_obj_mario.gml(5): 15,17,31,38,48
objects/obj_snow_ball_b/Collision_obj_mario.gml(5): 7,9,23,31,45
objects/obj_spike_ball_b_res/Step_2.gml(5): 3,5,22,24,43
objects/obj_time/Draw_0.gml(5): 2,4,6,12,19
objects/obj_title_oprime/Create_0.gml(5): 3,5,7,9,11
objects/obj_ventana_mario/Other_12.gml(5): 6,14,21,29,37
scripts/scr_bg_ghost_house/scr_bg_ghost_house.gml(5): 2,5,11,17,23
scripts/scr_jump/scr_jump.gml(5): 2,4,23,25,27
scripts/scr_language/scr_language.gml(5): 4,211,418,625,832
scripts/scr_snd_airship/scr_snd_airship.gml(5): 2,5,11,17,23
scripts/scr_snd_autumn/scr_snd_autumn.gml(5): 2,5,11,17,23
scripts/scr_snd_beach/scr_snd_beach.gml(5): 2,5,11,17,23
scripts/scr_snd_castle/scr_snd_castle.gml(5): 3,6,12,18,24
scripts/scr_snd_desert/scr_snd_desert.gml(5): 2,5,11,17,23
scripts/scr_snd_forest/scr_snd_forest.gml(5): 3,6,12,18,24
scripts/scr_snd_ghost_house/scr_snd_ghost_house.gml(5): 2,5,11,17,23
scripts/scr_snd_ground/scr_snd_ground.gml(5): 3,6,12,18,24
scripts/scr_snd_mountain/scr_snd_mountain.gml(5): 2,5,11,17,23
scripts/scr_snd_pink_coins/scr_snd_pink_coins.gml(5): 3,4,23,24,44
scripts/scr_snd_sky/scr_snd_sky.gml(5): 2,5,11,17,23
scripts/scr_snd_snow/scr_snd_snow.gml(5): 2,5,11,17,23
scripts/scr_snd_underground/scr_snd_underground.gml(5): 2,5,11,17,23
scripts/scr_snd_underwater/scr_snd_underwater.gml(5): 2,5,11,17,23
scripts/scr_snd_volcano/scr_snd_volcano.gml(5): 2,5,11,17,23
scripts/scr_sprite_get_constant/scr_sprite_get_constant.gml(5): 2,119,238,347,460
scripts/scr_sprite_get_constant_res/scr_sprite_get_constant_res.gml(5): 3,116,233,346,462
scripts/scr_sprite_make_object/scr_sprite_make_object.gml(5): 2,113,222,321,423
scripts/scr_sprite_make_object_rieles/scr_sprite_make_object_rieles.gml(5): 2,113,222,321,423
objects/obj_NSMBU_bowserjr/Other_14.gml(4): 33,122,129,142
objects/obj_SMB2_mushroom_res/Step_2.gml(4): 3,9,13,17
objects/obj_autoavance/Other_7.gml(4): 7,18,29,40
objects/obj_axe_smw/Draw_0.gml(4): 1,4,5,7
objects/obj_big_pplant_b_res/Draw_0.gml(4): 5,8,25,26
objects/obj_big_pplant_res/Draw_0.gml(4): 5,8,25,26
objects/obj_blockparent/Other_25.gml(4): 6,25,44,63
objects/obj_bobomb/Other_17.gml(4): 3,19,26,48
objects/obj_bonybeetle_b/Other_10.gml(4): 3,26,35,44
objects/obj_bonybeetle_b_res/Draw_0.gml(4): 10,13,16,17
objects/obj_bonybeetle_res/Draw_0.gml(4): 10,13,16,17
objects/obj_boo_res/Draw_0.gml(4): 5,8,14,15
objects/obj_brickhelmet/Create_0.gml(4): 2,5,17,29
objects/obj_bt_gb_close/Mouse_4.gml(4): 4,5,6,7
objects/obj_bumper/Collision_obj_clown.gml(4): 3,5,17,22
objects/obj_button_home/Mouse_4.gml(4): 19,20,29,41
objects/obj_button_settings_sm4j/Mouse_4.gml(4): 3,5,7,11
objects/obj_button_sombras/Mouse_4.gml(4): 3,4,7,8
objects/obj_buzzybeetle_b_res/Draw_0.gml(4): 5,8,14,15
objects/obj_buzzybeetle_res/Draw_0.gml(4): 10,13,19,20
objects/obj_cinta_on_res/Step_2.gml(4): 1,8,15,22
objects/obj_cloud_lakitu/Step_2.gml(4): 5,21,28,39
objects/obj_clown_fire_res/Draw_0.gml(4): 5,8,11,12
objects/obj_clown_res/Draw_0.gml(4): 5,8,11,12
objects/obj_condiciones/Other_10.gml(4): 10,12,13,14
objects/obj_condiciones_button/Mouse_4.gml(4): 4,5,16,17
objects/obj_cursor/Other_11.gml(4): 1,5,13,23
objects/obj_cursor/Step_1.gml(4): 9,11,14,16
objects/obj_egg/Step_0.gml(4): 1,12,73,94
objects/obj_egg_red/Draw_0.gml(4): 1,10,19,25
objects/obj_explosion/Create_0.gml(4): 1,6,11,20
objects/obj_fast_lava_lift/Other_11.gml(4): 2,8,18,28
objects/obj_frogsuit/Collision_obj_mario.gml(4): 3,5,15,17
objects/obj_galoomba/Step_0.gml(4): 5,9,60,97
objects/obj_galoomba_b/Step_0.gml(4): 5,9,48,73
objects/obj_gb_button/Mouse_4.gml(4): 4,6,7,12
objects/obj_goomba_b_res/Draw_0.gml(4): 5,8,11,12
objects/obj_goombrat_b_res/Draw_0.gml(4): 5,8,11,12
objects/obj_ground2/Mouse_4.gml(4): 1,3,5,18
objects/obj_ground3/Mouse_4.gml(4): 1,3,5,18
objects/obj_groundpount/Collision_obj_blockparent.gml(4): 9,24,38,43
objects/obj_icecoin/Create_0.gml(4): 1,10,13,28
objects/obj_jumppiranha/Other_14.gml(4): 19,47,60,97
objects/obj_key/Collision_obj_mario.gml(4): 3,5,14,15
objects/obj_key_appear/Other_11.gml(4): 1,5,15,16
objects/obj_kuriboshoe/Step_2.gml(4): 13,21,48,104
objects/obj_lakitu_res/Draw_0.gml(4): 3,21,25,29
objects/obj_lava_lift/Other_11.gml(4): 2,10,22,34
objects/obj_levelmanager/Alarm_2.gml(4): 3,5,7,9
objects/obj_link/Collision_obj_mario.gml(4): 3,15,17,23
objects/obj_mario/Alarm_11.gml(4): 4,6,8,10
objects/obj_menu_pausa/Other_12.gml(4): 1,2,3,21
objects/obj_musicblock/Create_0.gml(4): 1,7,10,25
objects/obj_musicblock_res/Step_2.gml(4): 3,7,10,25
objects/obj_ninji_res/Step_2.gml(4): 4,6,8,10
objects/obj_noteblock_s/Alarm_1.gml(4): 17,19,21,31
objects/obj_panel_circle/Other_12.gml(4): 9,25,76,105
objects/obj_panel_save_load/Draw_0.gml(4): 2,4,6,11
objects/obj_parent_resource/Draw_0.gml(4): 5,8,11,12
objects/obj_pausa_button/Mouse_4.gml(4): 11,19,23,24
objects/obj_pink_coin/Create_0.gml(4): 1,3,6,22
objects/obj_plant_fire_res/Draw_0.gml(4): 5,8,10,12
objects/obj_platform_blue_res/Draw_0.gml(4): 5,9,10,29
objects/obj_player_goal_nsmbu/Step_0.gml(4): 1,5,17,56
objects/obj_player_goal_smb1/Step_0.gml(4): 1,17,27,58
objects/obj_player_goal_smw/Draw_0.gml(4): 1,26,47,58
objects/obj_podoboo/Step_0.gml(4): 26,32,34,42
objects/obj_pokey/Step_0.gml(4): 53,55,59,61
objects/obj_powerupparent/Step_0.gml(4): 1,5,13,58
objects/obj_pplant_res/Draw_0.gml(4): 5,8,25,26
objects/obj_score/Other_17.gml(4): 2,7,9,10
objects/obj_selecting_fps/Mouse_4.gml(4): 5,6,8,9
objects/obj_settings_panel/Draw_0.gml(4): 1,7,16,19
objects/obj_shell_drybones/Other_12.gml(4): 1,13,25,38
objects/obj_snow_ball/Other_12.gml(4): 2,17,29,41
objects/obj_snowball/Other_14.gml(4): 20,22,27,32
objects/obj_spike/Step_0.gml(4): 3,48,124,128
objects/obj_spike_ball_res/Step_2.gml(4): 3,6,10,14
objects/obj_spiny_res/Draw_0.gml(4): 10,13,19,20
objects/obj_thwomp_b_res/Draw_0.gml(4): 5,8,11,12
objects/obj_thwomp_res/Draw_0.gml(4): 5,8,11,12
objects/obj_tongue/Collision_obj_coin10.gml(4): 11,13,15,18
objects/obj_tongue_blue/Collision_obj_coin10.gml(4): 11,13,15,18
objects/obj_vsync/Mouse_4.gml(4): 5,6,8,11
objects/obj_water_move/Alarm_0.gml(4): 7,8,40,41
objects/obj_water_move/Mouse_4.gml(4): 1,3,5,10
objects/obj_water_move_limit/Mouse_4.gml(4): 1,3,5,11
objects/obj_yoshi2/Step_2.gml(4): 1,3,10,16
scripts/scr_mariojumphold/scr_mariojumphold.gml(4): 2,4,16,18
scripts/scr_musicalscale/scr_musicalscale.gml(4): 3,60,110,167
objects/cre_control/Create_0.gml(3): 12,13,14
objects/obj_1up/Create_0.gml(3): 2,6,26
objects/obj_1up/Draw_0.gml(3): 3,6,12
objects/obj_1up_res/Step_2.gml(3): 3,6,10
objects/obj_bg_selection/Draw_0.gml(3): 2,4,10
objects/obj_block_hidden/Step_0.gml(3): 7,9,11
objects/obj_blockparent/Alarm_2.gml(3): 12,20,40
objects/obj_bobomb/Create_0.gml(3): 1,5,48
objects/obj_bobomb/Step_0.gml(3): 5,65,70
objects/obj_bonus_or/Other_10.gml(3): 2,3,4
objects/obj_boo/Create_0.gml(3): 3,18,47
objects/obj_boo_res/Step_2.gml(3): 6,10,22
objects/obj_boss_or/Other_10.gml(3): 3,4,5
objects/obj_bouncycloud/Step_0.gml(3): 1,34,52
objects/obj_bowser_dead_castle/Step_0.gml(3): 1,3,22
objects/obj_bowserjr/Alarm_11.gml(3): 10,56,66
objects/obj_bowserjr_shell/Create_0.gml(3): 1,37,41
objects/obj_btn_settings_hd/Mouse_4.gml(3): 3,6,12
objects/obj_bullebill_base/Other_10.gml(3): 4,20,22
objects/obj_button_meteoritos/Create_0.gml(3): 2,3,4
objects/obj_button_meteoritos/Mouse_4.gml(3): 5,6,8
objects/obj_button_meteoritos/Step_2.gml(3): 1,2,3
objects/obj_button_notification_aceptar/Mouse_4.gml(3): 3,8,14
objects/obj_button_save_changes/Mouse_4.gml(3): 1,9,11
objects/obj_button_save_load/Draw_0.gml(3): 2,13,20
objects/obj_button_sdog/Mouse_4.gml(3): 3,6,11
objects/obj_button_settings_controls/Mouse_4.gml(3): 3,5,10
objects/obj_button_settings_estrella/Mouse_4.gml(3): 5,7,12
objects/obj_button_trail/Mouse_4.gml(3): 3,6,11
objects/obj_buzzy_shell_res/Step_2.gml(3): 4,16,25
objects/obj_buzzybeetle/Alarm_10.gml(3): 3,10,14
objects/obj_buzzybeetle/Create_0.gml(3): 1,5,50
objects/obj_buzzybeetle_b/Alarm_10.gml(3): 3,10,14
objects/obj_buzzybeetle_b/Create_0.gml(3): 1,5,51
objects/obj_cannon/Alarm_0.gml(3): 8,10,22
objects/obj_cannon_red/Alarm_0.gml(3): 8,10,22
objects/obj_cannon_red/Other_10.gml(3): 3,5,7
objects/obj_chain_chomp_free/Create_0.gml(3): 1,5,44
objects/obj_chain_chomp_free_b/Create_0.gml(3): 1,5,44
objects/obj_cinta_switch/Create_0.gml(3): 2,8,14
objects/obj_claw/Collision_obj_mario.gml(3): 2,7,9
objects/obj_clown/Other_14.gml(3): 21,72,97
objects/obj_clown/Step_2.gml(3): 6,13,24
objects/obj_coin10/Other_12.gml(3): 4,7,10
objects/obj_condiciones/Other_7.gml(3): 29,37,43
objects/obj_configurar_controles_reset/Mouse_4.gml(3): 1,2,4
objects/obj_cooligan_res/Draw_0.gml(3): 5,7,13
objects/obj_crystalorb/Collision_obj_mario.gml(3): 1,13,28
objects/obj_cursor/Create_0.gml(3): 3,36,37
objects/obj_cursor/Mouse_51.gml(3): 3,6,13
objects/obj_cursor/Mouse_57.gml(3): 3,8,13
objects/obj_cursor/Other_10.gml(3): 1,11,26
objects/obj_deadmario/Alarm_0.gml(3): 1,37,41
objects/obj_doormario/Create_0.gml(3): 2,4,36
objects/obj_editormanager/Alarm_1.gml(3): 53,80,160
objects/obj_egg/Other_11.gml(3): 1,9,22
objects/obj_egg_red_res/Other_13.gml(3): 1,8,11
objects/obj_enemy_dead_castle/Step_0.gml(3): 1,3,22
objects/obj_erase/Other_10.gml(3): 7,9,20
objects/obj_firebar_res/Draw_0.gml(3): 6,13,22
objects/obj_firebar_res/Step_2.gml(3): 1,8,10
objects/obj_flagpole/Step_2.gml(3): 1,3,8
objects/obj_floruga/Create_0.gml(3): 1,37,54
objects/obj_floruga/Other_11.gml(3): 10,17,38
objects/obj_frozenmario/Draw_0.gml(3): 2,6,9
objects/obj_galoomba/Other_11.gml(3): 3,24,51
objects/obj_galoomba2/Other_11.gml(3): 3,24,51
objects/obj_galoomba_b/Create_0.gml(3): 1,20,42
objects/obj_goalcard/Collision_obj_mario.gml(3): 1,17,32
objects/obj_grinder_res/Alarm_0.gml(3): 46,78,79
objects/obj_ground/Mouse_0.gml(3): 1,3,5
objects/obj_hammer/Step_0.gml(3): 1,19,24
objects/obj_hammersuit/Collision_obj_mario.gml(3): 3,7,9
objects/obj_hen_mushroom/Collision_obj_mario.gml(3): 3,11,13
objects/obj_holdparent/Other_12.gml(3): 1,21,42
objects/obj_icicle2_res/Other_11.gml(3): 9,13,17
objects/obj_icicle_res/Other_11.gml(3): 9,13,17
objects/obj_invincibility/Create_0.gml(3): 4,24,31
objects/obj_key_appear/Alarm_1.gml(3): 3,5,7
objects/obj_kuribo_drybones/Alarm_7.gml(3): 1,4,20
objects/obj_kuribo_drybones/Create_0.gml(3): 1,4,20
objects/obj_kuriboshoe/Draw_0.gml(3): 4,19,34
objects/obj_lakitu/Alarm_1.gml(3): 14,60,69
objects/obj_lakitu/Step_0.gml(3): 1,5,39
objects/obj_lava_water/Step_2.gml(3): 5,24,35
objects/obj_levelmanager/Alarm_7.gml(3): 3,18,23
objects/obj_levelmanager/KeyPress_13.gml(3): 5,9,11
objects/obj_link/Step_0.gml(3): 1,7,52
objects/obj_link_bomb/Step_0.gml(3): 3,69,71
objects/obj_link_bomb/Step_2.gml(3): 12,32,54
objects/obj_load_guardabot/Other_4.gml(3): 1,3,4
objects/obj_lun/Alarm_1.gml(3): 2,4,5
objects/obj_magic/Create_0.gml(3): 1,25,30
objects/obj_magikoopa/Other_7.gml(3): 5,32,38
objects/obj_magikoopa/Step_0.gml(3): 5,26,49
objects/obj_mario/Create_0.gml(3): 5,23,31
objects/obj_mario/Other_11.gml(3): 4,15,21
objects/obj_marioU/Other_19.gml(3): 16,27,34
objects/obj_mario_editor/Alarm_0.gml(3): 32,48,49
objects/obj_mario_editor/Mouse_7.gml(3): 3,4,6
objects/obj_mario_transform2/Destroy_0.gml(3): 5,10,70
objects/obj_menu_pausa/Create_0.gml(3): 14,68,101
objects/obj_mini_icicle/Other_10.gml(3): 1,25,33
objects/obj_mini_icicle2_res/Other_11.gml(3): 9,13,17
objects/obj_mini_icicle_res/Other_11.gml(3): 9,13,17
objects/obj_muncher_res/Alarm_0.gml(3): 41,64,65
objects/obj_mushroom_platform_res/Alarm_0.gml(3): 46,73,74
objects/obj_musicblock/Alarm_1.gml(3): 22,24,26
objects/obj_night_change/Other_10.gml(3): 2,3,5
objects/obj_ninji/Create_0.gml(3): 31,33,35
objects/obj_noteblock/Alarm_1.gml(3): 15,17,19
objects/obj_onoffblock/Step_0.gml(3): 2,4,23
objects/obj_panel_circle/Other_14.gml(3): 9,53,54
objects/obj_panel_circle/Other_20.gml(3): 17,43,72
objects/obj_parcarry/Step_0.gml(3): 3,17,22
objects/obj_parent_resource/Mouse_0.gml(3): 1,3,5
objects/obj_parent_resource/Mouse_7.gml(3): 3,4,6
objects/obj_parent_sounds/Alarm_0.gml(3): 46,75,76
objects/obj_parent_sounds/Mouse_0.gml(3): 1,3,5
objects/obj_pballon/Collision_obj_mario.gml(3): 3,5,15
objects/obj_persistent/Draw_64.gml(3): 14,29,31
objects/obj_persistent/Other_11.gml(3): 3,4,5
objects/obj_persistent/Other_5.gml(3): 2,3,5
objects/obj_player_goal_smb1/Other_23.gml(3): 1,3,5
objects/obj_player_goal_smb3/Step_0.gml(3): 1,7,31
objects/obj_player_goal_smb3/Step_2.gml(3): 1,3,5
objects/obj_player_goal_smw/Step_2.gml(3): 1,3,5
objects/obj_player_goal_smw_castle/Alarm_6.gml(3): 3,6,32
objects/obj_player_goal_smw_castle/Draw_0.gml(3): 1,37,40
objects/obj_player_goal_smw_castle/Step_2.gml(3): 1,17,88
objects/obj_powerupparent/Draw_0.gml(3): 4,12,14
objects/obj_profile/Draw_0.gml(3): 2,4,6
objects/obj_pswitch_res/Draw_0.gml(3): 10,17,18
objects/obj_rails_res/Draw_0.gml(3): 5,23,27
objects/obj_rocky/Other_10.gml(3): 3,11,13
objects/obj_semisolid_platform1/Alarm_0.gml(3): 48,77,78
objects/obj_shell/Other_12.gml(3): 1,15,34
objects/obj_skewertrunk/Create_0.gml(3): 1,17,25
objects/obj_skewertrunk/Other_11.gml(3): 20,48,60
objects/obj_skewertrunk/Other_12.gml(3): 23,51,63
objects/obj_skewertrunk/Other_13.gml(3): 26,54,66
objects/obj_skewertrunk/Other_14.gml(3): 23,51,63
objects/obj_snow_ball_held/Collision_obj_mario.gml(3): 3,5,12
objects/obj_spike/Alarm_0.gml(3): 12,16,22
objects/obj_spike/Alarm_2.gml(3): 5,10,30
objects/obj_spinner/Create_0.gml(3): 1,3,5
objects/obj_spring/Collision_obj_mario.gml(3): 24,26,31
objects/obj_spring/Step_0.gml(3): 7,9,29
objects/obj_superflower/Collision_obj_mario.gml(3): 3,7,9
objects/obj_thwomp/Step_0.gml(3): 2,6,45
objects/obj_thwomp_b/Step_0.gml(3): 2,6,47
objects/obj_timeup/Create_0.gml(3): 1,10,12
objects/obj_tuberia_res/Create_0.gml(3): 3,7,36
objects/obj_version/Draw_0.gml(3): 1,3,4
objects/obj_waddlewing/Step_2.gml(3): 1,17,20
objects/obj_waddlewing_res/Draw_0.gml(3): 5,7,13
scripts/discord_init_dll/discord_init_dll.gml(3): 3,4,5
scripts/draw_text_lang/draw_text_lang.gml(3): 20,22,24
scripts/scr_canhold/scr_canhold.gml(3): 2,8,17
scripts/scr_lose_condition/scr_lose_condition.gml(3): 2,4,6
scripts/scr_snd_dead/scr_snd_dead.gml(3): 2,5,7
objects/obj_1up/Alarm_10.gml(2): 10,21
objects/obj_NSMBU_bowser/Collision_obj_mario.gml(2): 3,31
objects/obj_NSMBU_bowser/Other_14.gml(2): 81,94
objects/obj_SMB2_mushroom/Alarm_0.gml(2): 5,8
objects/obj_SMB2_mushroom/Collision_obj_blockparent.gml(2): 7,14
objects/obj_SMB2_mushroom/Other_13.gml(2): 1,7
objects/obj_SMB2_mushroom/Step_0.gml(2): 11,39
objects/obj_SMB3_bowser/Other_14.gml(2): 107,120
objects/obj_SMB_bowser/Other_14.gml(2): 68,81
objects/obj_SMB_flag/Step_0.gml(2): 3,23
objects/obj_SMW_bowser/Collision_obj_mario.gml(2): 3,31
objects/obj_SMW_bowser/Other_14.gml(2): 72,85
objects/obj_alert_button/Mouse_4.gml(2): 6,7
objects/obj_alert_condicion/Draw_0.gml(2): 2,3
objects/obj_angrysun_movement/Alarm_3.gml(2): 6,8
objects/obj_apariencia/Draw_0.gml(2): 2,8
objects/obj_arrow_big/Create_0.gml(2): 1,3
objects/obj_arrow_res/Draw_0.gml(2): 5,10
objects/obj_axe_smw/Create_0.gml(2): 1,20
objects/obj_beanstalk/Create_0.gml(2): 1,25
objects/obj_billbanzai_red_res/Draw_0.gml(2): 5,10
objects/obj_billbanzai_red_res/Other_11.gml(2): 6,21
objects/obj_billbanzai_res/Draw_0.gml(2): 5,10
objects/obj_block_hidden/Collision_obj_shell.gml(2): 5,7
objects/obj_block_hidden/Collision_obj_shell_held.gml(2): 5,7
objects/obj_block_hidden/Collision_obj_spinner.gml(2): 3,5
objects/obj_block_hidden_res/Draw_0.gml(2): 5,10
objects/obj_block_pow_active/Create_0.gml(2): 1,32
objects/obj_block_res/Draw_0.gml(2): 5,10
objects/obj_blockcoin/Step_0.gml(2): 10,22
objects/obj_blooper/Create_0.gml(2): 1,29
objects/obj_blooper/Other_10.gml(2): 4,13
objects/obj_blooper/Step_2.gml(2): 3,16
objects/obj_bobomb_hold/Alarm_1.gml(2): 3,12
objects/obj_bobomb_hold/Create_0.gml(2): 2,18
objects/obj_bobomb_hold/Other_11.gml(2): 16,20
objects/obj_bobomb_hold/Step_0.gml(2): 2,7
objects/obj_bobomb_ready/Alarm_10.gml(2): 1,14
objects/obj_bobomb_ready/Create_0.gml(2): 2,18
objects/obj_bobomb_ready_res/Other_11.gml(2): 6,19
objects/obj_bobomb_res/Step_2.gml(2): 4,8
objects/obj_bonybeetle/Create_0.gml(2): 1,47
objects/obj_bonybeetle_b/Create_0.gml(2): 1,47
objects/obj_boo/Alarm_0.gml(2): 1,18
objects/obj_boo/Alarm_10.gml(2): 3,8
objects/obj_boo/Draw_0.gml(2): 10,12
objects/obj_boo/Step_2.gml(2): 5,16
objects/obj_boomerangbro/Alarm_2.gml(2): 13,30
objects/obj_boomerangbro/Alarm_3.gml(2): 1,37
objects/obj_boomerangbro/Create_0.gml(2): 1,50
objects/obj_bowser_dead/Destroy_0.gml(2): 1,8
objects/obj_bowser_dead_castle/Alarm_0.gml(2): 1,17
objects/obj_bowser_fire/Step_0.gml(2): 13,38
objects/obj_bowserjr/Alarm_1.gml(2): 5,12
objects/obj_bowserjr/Alarm_2.gml(2): 13,23
objects/obj_bowserjr_dead_castle/Alarm_0.gml(2): 1,17
objects/obj_bowserjr_res/Step_2.gml(2): 3,4
objects/obj_bowserjr_shell/Other_10.gml(2): 4,22
objects/obj_brickhelmet/Other_16.gml(2): 1,4
objects/obj_brohammer/Create_0.gml(2): 1,17
objects/obj_bt_gb_delete/Alarm_1.gml(2): 1,2
objects/obj_bullebill_base/Create_0.gml(2): 4,9
objects/obj_bullebill_base_red_res/Draw_0.gml(2): 5,24
objects/obj_bullebill_base_red_res/Other_11.gml(2): 6,19
objects/obj_bullebill_base_res/Draw_0.gml(2): 5,24
objects/obj_bullebill_base_res/Step_2.gml(2): 2,6
objects/obj_bulletbill/Other_10.gml(2): 4,21
objects/obj_bulletbill/Other_11.gml(2): 5,7
objects/obj_bulletbull_red/Create_0.gml(2): 1,17
objects/obj_button_autoavance/Mouse_4.gml(2): 1,5
objects/obj_button_home/Draw_0.gml(2): 38,53
objects/obj_button_notification_aceptar/Alarm_0.gml(2): 7,17
objects/obj_button_save_changes/Alarm_0.gml(2): 7,15
objects/obj_button_save_changes/Draw_0.gml(2): 6,16
objects/obj_button_sombras/Create_0.gml(2): 7,10
objects/obj_button_sombras/Step_0.gml(2): 1,4
objects/obj_buzzybeetle/Other_10.gml(2): 3,7
objects/obj_buzzybeetle/Other_11.gml(2): 5,9
objects/obj_buzzybeetle/Other_15.gml(2): 6,10
objects/obj_buzzybeetle/Other_19.gml(2): 2,6
objects/obj_buzzybeetle_b/Other_10.gml(2): 3,7
objects/obj_buzzybeetle_b/Other_11.gml(2): 5,9
objects/obj_buzzybeetle_b/Other_15.gml(2): 6,10
objects/obj_buzzybeetle_b/Other_19.gml(2): 2,6
objects/obj_buzzybeetle_b_res/Step_2.gml(2): 4,8
objects/obj_buzzybeetle_res/Step_2.gml(2): 4,8
objects/obj_cannon/Create_0.gml(2): 2,6
objects/obj_cannon/Other_10.gml(2): 4,20
objects/obj_cannon_red_res/Draw_0.gml(2): 5,20
objects/obj_cannon_red_res/Other_11.gml(2): 6,22
objects/obj_cannon_res/Draw_0.gml(2): 5,20
objects/obj_cannon_res/Step_2.gml(2): 3,7
objects/obj_cannonball/Create_0.gml(2): 1,17
objects/obj_cap/Step_0.gml(2): 3,22
objects/obj_cap_mario/Other_10.gml(2): 7,23
objects/obj_cap_mario/Other_14.gml(2): 7,21
objects/obj_card_bg/Step_0.gml(2): 3,42
objects/obj_card_condiciones/Draw_0.gml(2): 2,3
objects/obj_card_item/Mouse_4.gml(2): 23,33
objects/obj_card_item/Step_0.gml(2): 10,38
objects/obj_charginchuck/Create_0.gml(2): 1,55
objects/obj_checkpoint_res/Draw_0.gml(2): 5,10
objects/obj_cheepcheep/Create_0.gml(2): 2,39
objects/obj_cheepcheep2_res/Step_2.gml(2): 3,4
objects/obj_cheepcheep_res/Step_2.gml(2): 3,4
objects/obj_chomp_b_res/Step_2.gml(2): 3,7
objects/obj_chomp_res/Step_2.gml(2): 3,7
objects/obj_cinta_on_res/Draw_0.gml(2): 10,36
objects/obj_cinta_on_res/Other_11.gml(2): 8,13
objects/obj_cinta_res/Draw_0.gml(2): 10,46
objects/obj_cinta_res/Other_11.gml(2): 8,13
objects/obj_clown/Collision_obj_mario.gml(2): 12,16
objects/obj_clown_fire/Alarm_4.gml(2): 5,7
objects/obj_clown_fire/Create_0.gml(2): 2,31
objects/obj_coin/Collision_obj_mario.gml(2): 1,2
objects/obj_coin/Draw_0.gml(2): 9,15
objects/obj_coin/Other_11.gml(2): 3,9
objects/obj_coin10_res/Other_11.gml(2): 9,13
objects/obj_coin30_res/Other_11.gml(2): 9,13
objects/obj_coin50_res/Other_11.gml(2): 9,13
objects/obj_cooligan/Other_10.gml(2): 5,11
objects/obj_cooligan/Other_25.gml(2): 5,11
objects/obj_cooligan_res/Create_0.gml(2): 5,10
objects/obj_cooligan_res/Step_2.gml(2): 4,9
objects/obj_creation_preview/Step_1.gml(2): 12,13
objects/obj_creator_jugar_editar/Create_0.gml(2): 4,12
objects/obj_creator_jugar_editar/Mouse_4.gml(2): 1,3
objects/obj_creator_jugar_editar/Other_12.gml(2): 5,11
objects/obj_crumblebones/Create_0.gml(2): 1,29
objects/obj_crumblebony/Create_0.gml(2): 1,30
objects/obj_crumblebony_b/Create_0.gml(2): 1,30
objects/obj_door_lock_res/Other_11.gml(2): 10,36
objects/obj_door_res/Other_11.gml(2): 10,36
objects/obj_door_switch_res/Other_11.gml(2): 10,36
objects/obj_drybones/Create_0.gml(2): 1,38
objects/obj_editormanager/Step_1.gml(2): 1,110
objects/obj_egg/Alarm_0.gml(2): 1,13
objects/obj_egg/Alarm_1.gml(2): 1,46
objects/obj_egg/Alarm_10.gml(2): 1,21
objects/obj_egg/Alarm_2.gml(2): 1,8
objects/obj_egg/Create_0.gml(2): 1,15
objects/obj_egg/Other_10.gml(2): 1,13
objects/obj_egg_blue/Alarm_2.gml(2): 1,6
objects/obj_egg_red/Alarm_2.gml(2): 1,6
objects/obj_egg_red_res/Other_10.gml(2): 1,8
objects/obj_egg_res/Other_10.gml(2): 1,8
objects/obj_egg_res/Other_13.gml(2): 1,4
objects/obj_enemyfrozen/Create_0.gml(2): 3,6
objects/obj_fire_clown/Create_0.gml(2): 2,15
objects/obj_fireball/Create_0.gml(2): 1,17
objects/obj_fireball_bro/Create_0.gml(2): 1,17
objects/obj_firebar/Draw_0.gml(2): 2,7
objects/obj_firebro/Alarm_2.gml(2): 13,30
objects/obj_firebro/Alarm_3.gml(2): 1,25
objects/obj_firebro/Create_0.gml(2): 1,49
objects/obj_flipblock/Step_0.gml(2): 24,51
objects/obj_floruga/Alarm_0.gml(2): 18,28
objects/obj_floruga/Alarm_10.gml(2): 5,23
objects/obj_floruga/Other_10.gml(2): 13,32
objects/obj_floruga_body/Create_0.gml(2): 1,29
objects/obj_foo/Create_0.gml(2): 1,29
objects/obj_frogsuit/Step_0.gml(2): 4,33
objects/obj_frozenmario/Create_0.gml(2): 2,9
objects/obj_frozenmario/Step_0.gml(2): 1,6
objects/obj_galoomba/Create_0.gml(2): 1,33
objects/obj_galoomba/Draw_0.gml(2): 4,22
objects/obj_galoomba/Step_2.gml(2): 8,13
objects/obj_galoomba2/Create_0.gml(2): 1,36
objects/obj_galoomba2/Other_15.gml(2): 2,4
objects/obj_galoomba2_b/Create_0.gml(2): 1,39
objects/obj_galoomba2_b/Other_15.gml(2): 2,4
objects/obj_galoomba_b/Draw_0.gml(2): 4,22
objects/obj_goalgate/Step_0.gml(2): 8,17
objects/obj_goomba_b_res/Step_2.gml(2): 3,4
objects/obj_goomba_res/Step_2.gml(2): 3,4
objects/obj_goombrat_b_res/Step_2.gml(2): 3,4
objects/obj_goombrat_res/Step_2.gml(2): 3,4
objects/obj_grid/Draw_0.gml(2): 3,18
objects/obj_grinder/Collision_obj_clown.gml(2): 11,16
objects/obj_ground/Mouse_4.gml(2): 1,3
objects/obj_grrrol_b_res/Draw_0.gml(2): 5,8
objects/obj_grrrol_new_res/Draw_0.gml(2): 5,8
objects/obj_grrrol_res/Draw_0.gml(2): 5,8
objects/obj_hammerbro/Alarm_1.gml(2): 14,65
objects/obj_hammerbro/Alarm_10.gml(2): 7,12
objects/obj_hammerbro/Alarm_2.gml(2): 13,30
objects/obj_hammerbro/Alarm_3.gml(2): 1,34
objects/obj_hammerbro/Create_0.gml(2): 1,50
objects/obj_hammerbro/Draw_0.gml(2): 2,6
objects/obj_hammerbro/Other_10.gml(2): 4,20
objects/obj_hammerbro/Step_2.gml(2): 1,13
objects/obj_hammersuit/Step_0.gml(2): 4,33
objects/obj_helmet/Other_15.gml(2): 8,10
objects/obj_icebro/Alarm_2.gml(2): 13,30
objects/obj_icebro/Alarm_3.gml(2): 1,25
objects/obj_icebro/Create_0.gml(2): 1,50
objects/obj_jumppiranha/Draw_0.gml(2): 18,25
objects/obj_key/Create_0.gml(2): 1,20
objects/obj_koopa/Alarm_10.gml(2): 9,16
objects/obj_koopa_b/Alarm_10.gml(2): 7,11
objects/obj_koopa_b_res/Step_2.gml(2): 3,4
objects/obj_koopa_red/Alarm_10.gml(2): 9,26
objects/obj_koopa_red/Other_11.gml(2): 5,60
objects/obj_koopa_red_b/Alarm_10.gml(2): 9,26
objects/obj_koopa_red_b/Other_11.gml(2): 5,60
objects/obj_koopa_red_b_res/Step_2.gml(2): 3,4
objects/obj_koopa_red_res/Step_2.gml(2): 3,4
objects/obj_koopa_res/Step_2.gml(2): 3,4
objects/obj_kuribo_drybones/Draw_0.gml(2): 3,25
objects/obj_kuribo_drybones/Other_7.gml(2): 13,16
objects/obj_kuriboshoe/Create_0.gml(2): 1,3
objects/obj_kuriboshoe/Other_15.gml(2): 6,11
objects/obj_kuriboshoe2/Create_0.gml(2): 1,3
objects/obj_lakitu/Alarm_0.gml(2): 1,22
objects/obj_link_arrow/Step_0.gml(2): 1,33
objects/obj_load_guardabot/Destroy_0.gml(2): 1,2
objects/obj_magikoopa/Alarm_0.gml(2): 3,28
objects/obj_magikoopa/Create_0.gml(2): 1,41
objects/obj_mario/Alarm_7.gml(2): 4,13
objects/obj_mario/Alarm_8.gml(2): 4,13
objects/obj_marioU/Other_11.gml(2): 3,35
objects/obj_mario_pballon/Destroy_0.gml(2): 5,9
objects/obj_mario_pballon/Step_2.gml(2): 1,21
objects/obj_mariostart/Alarm_0.gml(2): 2,6
objects/obj_mariostart_m/Alarm_1.gml(2): 1,5
objects/obj_mechakoopa/Create_0.gml(2): 1,33
objects/obj_mechakoopa_held/Create_0.gml(2): 2,31
objects/obj_mechakoopa_held/Other_11.gml(2): 16,20
objects/obj_menu_editor/Mouse_4.gml(2): 1,10
objects/obj_monty_chase/Create_0.gml(2): 1,34
objects/obj_monty_chase/Step_0.gml(2): 4,46
objects/obj_muncher/Create_0.gml(2): 2,6
objects/obj_muncher/Other_10.gml(2): 4,8
objects/obj_muncher_b/Create_0.gml(2): 1,5
objects/obj_muncher_b/Other_10.gml(2): 4,8
objects/obj_muncher_b_res/Step_2.gml(2): 4,8
objects/obj_muncher_res/Step_2.gml(2): 3,7
objects/obj_mushroom/Alarm_0.gml(2): 5,8
objects/obj_mushroom/Collision_obj_blockparent.gml(2): 7,14
objects/obj_mushroom/Create_0.gml(2): 1,19
objects/obj_mushroom/Other_13.gml(2): 1,7
objects/obj_mushroom/Step_0.gml(2): 4,32
objects/obj_mushroom_platform_res/Draw_0.gml(2): 5,44
objects/obj_musicblock_res/Other_11.gml(2): 10,32
objects/obj_n64_or/Other_10.gml(2): 4,5
objects/obj_next_before/Step_0.gml(2): 1,5
objects/obj_noteblock/Other_14.gml(2): 20,23
objects/obj_noteblock_res/Draw_0.gml(2): 5,10
objects/obj_noteblock_res/Other_11.gml(2): 10,32
objects/obj_noteblock_s/Create_0.gml(2): 2,3
objects/obj_noteblock_s_res/Other_11.gml(2): 10,32
objects/obj_oneway_res/Draw_0.gml(2): 5,10
objects/obj_onewaygate_bottom/Create_0.gml(2): 1,17
objects/obj_onewaygate_left/Create_0.gml(2): 1,17
objects/obj_onewaygate_right/Create_0.gml(2): 1,17
objects/obj_onewaygate_top/Create_0.gml(2): 1,17
objects/obj_panel_circle/Other_15.gml(2): 9,39
objects/obj_panel_circle/Other_16.gml(2): 41,59
objects/obj_panel_circle/Other_21.gml(2): 9,25
objects/obj_panel_circle/Other_22.gml(2): 17,55
objects/obj_panel_time/Draw_0.gml(2): 3,5
objects/obj_parcarry/Alarm_10.gml(2): 40,53
objects/obj_parcarry/Create_0.gml(2): 2,7
objects/obj_pausa_button/KeyPress_82.gml(2): 1,10
objects/obj_plant_fire/Alarm_3.gml(2): 4,16
objects/obj_plant_fire/Create_0.gml(2): 1,47
objects/obj_plant_fire/Step_2.gml(2): 1,28
objects/obj_plantfire/Create_0.gml(2): 1,14
objects/obj_platform_res/Draw_0.gml(2): 5,29
objects/obj_play_screen/Draw_0.gml(2): 4,13
objects/obj_player_goal_smb1/Collision_obj_flagpole.gml(2): 3,5
objects/obj_player_goal_smb3/Draw_0.gml(2): 1,4
objects/obj_player_goal_smw_castle/Step_0.gml(2): 3,37
objects/obj_player_warp/Other_11.gml(2): 2,3
objects/obj_podoboo/Alarm_2.gml(2): 3,5
objects/obj_pokey_res/Draw_0.gml(2): 5,27
objects/obj_powerupsprout/Alarm_0.gml(2): 35,36
objects/obj_pswitch/Other_16.gml(2): 3,12
objects/obj_puente_res/Draw_0.gml(2): 5,24
objects/obj_qblock_res/Draw_0.gml(2): 5,10
objects/obj_rename_input/Draw_0.gml(2): 2,5
objects/obj_rocangrejo/Alarm_0.gml(2): 1,18
objects/obj_rocangrejo/Create_0.gml(2): 1,33
objects/obj_rocangrejo/Other_12.gml(2): 1,18
objects/obj_rockparent/Other_10.gml(2): 12,21
objects/obj_rocky/Alarm_2.gml(2): 1,10
objects/obj_rotten_signal/Create_0.gml(2): 1,3
objects/obj_score_flag/Create_0.gml(2): 1,14
objects/obj_semisolid_platform1/Draw_0.gml(2): 5,72
objects/obj_shell_drybones_held/Other_13.gml(2): 25,51
objects/obj_shell_empty/Create_0.gml(2): 4,8
objects/obj_shell_held/Collision_obj_mario.gml(2): 1,8
objects/obj_shell_held/Create_0.gml(2): 21,26
objects/obj_skewer/Create_0.gml(2): 2,6
objects/obj_skewer_res/Draw_0.gml(2): 5,10
objects/obj_skewer_res/Step_1.gml(2): 3,7
objects/obj_sledgebro/Alarm_10.gml(2): 7,12
objects/obj_sledgebro/Create_0.gml(2): 1,39
objects/obj_sledgebro/Step_2.gml(2): 1,8
objects/obj_smoke_goomba/Create_0.gml(2): 1,3
objects/obj_snowball_bro/Collision_obj_mario.gml(2): 24,50
objects/obj_snowball_bro/Create_0.gml(2): 1,21
objects/obj_soplete_res/Draw_0.gml(2): 5,10
objects/obj_sparkles_blend/Create_0.gml(2): 1,14
objects/obj_sparkles_coin/Create_0.gml(2): 1,14
objects/obj_spike/Create_0.gml(2): 1,49
objects/obj_spike/Draw_0.gml(2): 4,7
objects/obj_spike/Other_10.gml(2): 5,26
objects/obj_spike/Other_17.gml(2): 1,5
objects/obj_spike/Step_2.gml(2): 2,22
objects/obj_spike_ball/Alarm_10.gml(2): 3,5
objects/obj_spike_ball/Create_0.gml(2): 1,5
objects/obj_spike_ball/Other_13.gml(2): 55,81
objects/obj_spike_ball_b/Create_0.gml(2): 1,5
objects/obj_spike_ball_b_res/Other_10.gml(2): 5,20
objects/obj_spike_ball_res/Other_10.gml(2): 5,20
objects/obj_spike_res/Other_10.gml(2): 5,20
objects/obj_spinner/Draw_0.gml(2): 3,7
objects/obj_spiny/Alarm_10.gml(2): 4,12
objects/obj_spiny/Alarm_3.gml(2): 1,9
objects/obj_spiny/Create_0.gml(2): 1,35
objects/obj_spiny_res/Step_2.gml(2): 6,12
objects/obj_splash_agua/Create_0.gml(2): 1,11
objects/obj_splash_lava/Create_0.gml(2): 1,11
objects/obj_splash_posion/Create_0.gml(2): 1,11
objects/obj_spring/Collision_obj_physicsparent.gml(2): 15,17
objects/obj_spring_land/Collision_obj_block_pow_hold.gml(2): 6,21
objects/obj_spring_land/Collision_obj_holdparent.gml(2): 5,21
objects/obj_spring_land/Collision_obj_snow_ball_held.gml(2): 5,13
objects/obj_spring_land/Collision_obj_spike_ball.gml(2): 5,13
objects/obj_star/Step_0.gml(2): 4,33
objects/obj_titlemenu_key/Draw_0.gml(2): 9,12
objects/obj_tongue/Collision_obj_enemyparent.gml(2): 26,28
objects/obj_tongue_blue/Collision_obj_enemyparent.gml(2): 26,28
objects/obj_torbellino/Create_0.gml(2): 1,17
objects/obj_tuberia/Create_0.gml(2): 2,6
objects/obj_tuberia_res/Step_2.gml(2): 2,6
objects/obj_ventana_mario/Create_0.gml(2): 1,9
objects/obj_vine_res/Draw_0.gml(2): 5,39
objects/obj_waddlewing/Create_0.gml(2): 1,57
objects/obj_waddlewing/Other_10.gml(2): 4,6
objects/obj_water_move/Mouse_7.gml(2): 2,3
objects/obj_window_alert/Destroy_0.gml(2): 11,12
objects/obj_window_mario_button/Mouse_4.gml(2): 7,17
objects/obj_yoshi_abandon/Create_0.gml(2): 1,16
objects/obj_yoshi_red/Other_10.gml(2): 4,39
scripts/object_get_depth/object_get_depth.gml(2): 8,9
scripts/scr_NSMBU_ground_idle/scr_NSMBU_ground_idle.gml(2): 6,14
scripts/scr_NSMBU_idle/scr_NSMBU_idle.gml(2): 8,27
scripts/scr_NSMBU_kick/scr_NSMBU_kick.gml(2): 4,12
scripts/scr_NSMBU_walk/scr_NSMBU_walk.gml(2): 5,13
scripts/scr_musicalscale_kick/scr_musicalscale_kick.gml(2): 3,19
scripts/scr_return/scr_return.gml(2): 2,6
scripts/scr_snd_fireball/scr_snd_fireball.gml(2): 2,5
scripts/scr_snd_pink_coin5/scr_snd_pink_coin5.gml(2): 3,5
scripts/scr_snd_powerdown/scr_snd_powerdown.gml(2): 2,7
objects/cre_control/Draw_0.gml(1): 1
objects/obj_1up/Alarm_11.gml(1): 3
objects/obj_1up/Collision_obj_blockparent.gml(1): 10
objects/obj_1up/Collision_obj_mario.gml(1): 28
objects/obj_NSMBU_boomboom/Other_14.gml(1): 82
objects/obj_NSMBU_boomboom_b/Other_14.gml(1): 82
objects/obj_NSMBU_bowser/Collision_obj_blockparent.gml(1): 3
objects/obj_NSMBU_ninji/Alarm_0.gml(1): 21
objects/obj_SMB2_mushroom/Alarm_10.gml(1): 12
objects/obj_SMB2_mushroom/Create_0.gml(1): 1
objects/obj_SMB2_mushroom_res/Other_11.gml(1): 6
objects/obj_SMB3_bowser/Collision_obj_blockparent.gml(1): 3
objects/obj_SMB3_bowser/Collision_obj_mario.gml(1): 3
objects/obj_SMB_bowser/Collision_obj_blockparent.gml(1): 3
objects/obj_SMB_bowser/Collision_obj_mario.gml(1): 3
objects/obj_SMB_castle/Step_0.gml(1): 7
objects/obj_SMB_flag/Alarm_0.gml(1): 2
objects/obj_SMB_flag/Alarm_1.gml(1): 6
objects/obj_SMB_flag/Collision_obj_flagpole.gml(1): 1
objects/obj_SMB_flag/Create_0.gml(1): 1
objects/obj_SMB_flag/Other_10.gml(1): 1
objects/obj_SMW_bowser/Collision_obj_blockparent.gml(1): 3
objects/obj_ahh_snd_res/Other_11.gml(1): 6
objects/obj_alert_condicion/Create_0.gml(1): 3
objects/obj_alert_load/Draw_0.gml(1): 3
objects/obj_alert_message/Draw_0.gml(1): 3
objects/obj_angrysun/Step_0.gml(1): 17
objects/obj_angrysun_res/Other_10.gml(1): 7
objects/obj_anti_pblock/Create_0.gml(1): 1
objects/obj_aplausos_snd_res/Other_11.gml(1): 6
objects/obj_arrow/Create_0.gml(1): 2
objects/obj_arrow_res/Step_2.gml(1): 1
objects/obj_auh_snd_res/Other_11.gml(1): 6
objects/obj_autoavance/Create_0.gml(1): 2
objects/obj_axe_smw/Alarm_3.gml(1): 10
objects/obj_axe_smw/Alarm_4.gml(1): 1
objects/obj_axe_smw/Collision_obj_mario.gml(1): 1
objects/obj_axe_smw/Step_0.gml(1): 6
objects/obj_banzaibill/Alarm_10.gml(1): 2
objects/obj_banzaibill/Draw_0.gml(1): 1
objects/obj_banzaibill/Step_0.gml(1): 1
objects/obj_bebe_snd_res/Other_11.gml(1): 6
objects/obj_bg_selection/Other_7.gml(1): 104
objects/obj_bganimator/Alarm_0.gml(1): 5
objects/obj_billbanzai_red/Create_0.gml(1): 2
objects/obj_billbanzai_red/Draw_0.gml(1): 1
objects/obj_billbanzai_red/Step_0.gml(1): 16
objects/obj_billbanzai_red_res/Other_10.gml(1): 5
objects/obj_billbanzai_red_res/Step_2.gml(1): 2
objects/obj_billbanzai_res/Other_10.gml(1): 5
objects/obj_billbanzai_res/Other_11.gml(1): 6
objects/obj_bl2/Mouse_4.gml(1): 5
objects/obj_block_gold/Create_0.gml(1): 1
objects/obj_block_gold_res/Step_2.gml(1): 3
objects/obj_block_hidden/Create_0.gml(1): 1
objects/obj_block_ice/Create_0.gml(1): 1
objects/obj_block_pow_hold/Create_0.gml(1): 2
objects/obj_blockbumper/Collision_obj_blockparent.gml(1): 5
objects/obj_blockparent/Create_0.gml(1): 12
objects/obj_blockparent/Step_0.gml(1): 5
objects/obj_blooper/Collision_obj_mario.gml(1): 1
objects/obj_blooper_res/Step_2.gml(1): 2
objects/obj_bobomb/Alarm_10.gml(1): 4
objects/obj_bobomb/Draw_0.gml(1): 10
objects/obj_bobomb/Other_10.gml(1): 3
objects/obj_bobomb/Other_11.gml(1): 7
objects/obj_bobomb_hold/Alarm_2.gml(1): 2
objects/obj_bobomb_hold/Destroy_0.gml(1): 2
objects/obj_bobomb_hold/Other_10.gml(1): 4
objects/obj_bobomb_ready/Alarm_1.gml(1): 1
objects/obj_bobomb_ready/Destroy_0.gml(1): 2
objects/obj_bobomb_ready/Other_10.gml(1): 4
objects/obj_bobomb_ready_res/Other_10.gml(1): 4
objects/obj_bobomb_ready_res/Step_2.gml(1): 2
objects/obj_bobomb_res/Other_10.gml(1): 4
objects/obj_bobomb_res/Other_11.gml(1): 6
objects/obj_bocina_snd_res/Other_11.gml(1): 6
objects/obj_bombilla_or/Create_0.gml(1): 3
objects/obj_bombilla_or/Step_0.gml(1): 1
objects/obj_bombilla_snd_res/Other_11.gml(1): 6
objects/obj_bone/Step_0.gml(1): 11
objects/obj_bones_yoshi/Step_0.gml(1): 1
objects/obj_bones_yoshi_one/Step_0.gml(1): 1
objects/obj_bonus_or/Collision_obj_mario.gml(1): 1
objects/obj_bonybeetle/Alarm_0.gml(1): 2
objects/obj_bonybeetle/Draw_0.gml(1): 2
objects/obj_bonybeetle/Other_10.gml(1): 3
objects/obj_bonybeetle/Step_0.gml(1): 1
objects/obj_bonybeetle/Step_2.gml(1): 1
objects/obj_bonybeetle_b/Alarm_0.gml(1): 2
objects/obj_bonybeetle_b/Step_2.gml(1): 1
objects/obj_bonybeetle_b_res/Other_13.gml(1): 6
objects/obj_bonybeetle_b_res/Step_2.gml(1): 2
objects/obj_bonybeetle_res/Step_2.gml(1): 2
objects/obj_boo/Alarm_1.gml(1): 8
objects/obj_boo/Other_10.gml(1): 6
objects/obj_boo/Step_0.gml(1): 34
objects/obj_boomboom/Create_0.gml(1): 1
objects/obj_boomboom/Draw_0.gml(1): 2
objects/obj_boomboom/Other_10.gml(1): 9
objects/obj_boomboom/Other_11.gml(1): 32
objects/obj_boomboom/Step_2.gml(1): 13
objects/obj_boomboom_b/Create_0.gml(1): 1
objects/obj_boomboom_b/Other_11.gml(1): 32
objects/obj_boomboom_b/Step_2.gml(1): 13
objects/obj_boomboom_b_res/Step_2.gml(1): 2
objects/obj_boomboom_res/Step_2.gml(1): 2
objects/obj_boomerang/Create_0.gml(1): 1
objects/obj_boomerangbro/Other_17.gml(1): 1
objects/obj_boomerangbro/Other_7.gml(1): 1
objects/obj_boomerangbro_res/Other_11.gml(1): 6
objects/obj_boomerangbro_res/Other_13.gml(1): 2
objects/obj_boomerangbro_res/Step_2.gml(1): 2
objects/obj_bortice/Collision_obj_mario.gml(1): 27
objects/obj_bortice/Create_0.gml(1): 4
objects/obj_boss_or/Collision_obj_mario.gml(1): 1
objects/obj_bossparent/Other_25.gml(1): 1
objects/obj_bowser_dead/Alarm_0.gml(1): 3
objects/obj_bowser_dead/Create_0.gml(1): 1
objects/obj_bowser_dead_castle/Alarm_1.gml(1): 2
objects/obj_bowser_dead_castle/Alarm_2.gml(1): 3
objects/obj_bowser_fire/Create_0.gml(1): 1
objects/obj_bowser_res/Step_2.gml(1): 2
objects/obj_bowserjr/Alarm_3.gml(1): 3
objects/obj_bowserjr/Alarm_8.gml(1): 3
objects/obj_bowserjr/Create_0.gml(1): 2
objects/obj_bowserjr/Other_10.gml(1): 17
objects/obj_bowserjr/Other_7.gml(1): 1
objects/obj_bowserjr/Step_2.gml(1): 1
objects/obj_bowserjr_dead_castle/Alarm_1.gml(1): 2
objects/obj_bowserjr_fire/Create_0.gml(1): 2
objects/obj_bowserjr_shell/Alarm_1.gml(1): 3
objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml(1): 5
objects/obj_brickhelmet/Draw_0.gml(1): 4
objects/obj_brohammer_yoshi/Create_0.gml(1): 1
objects/obj_brohammer_yoshi/Step_0.gml(1): 1
objects/obj_bt_gb_delete/Mouse_4.gml(1): 1
objects/obj_bt_gb_edit/Alarm_1.gml(1): 1
objects/obj_bt_gb_edit/Step_2.gml(1): 1
objects/obj_bt_gb_play/Alarm_1.gml(1): 1
objects/obj_bt_gb_play/Draw_0.gml(1): 2
objects/obj_bt_gb_play/Mouse_4.gml(1): 1
objects/obj_bt_rename/Draw_0.gml(1): 2
objects/obj_bt_rename/Mouse_4.gml(1): 2
objects/obj_btn_invitado/Draw_0.gml(1): 2
objects/obj_btn_invitado/Mouse_4.gml(1): 1
objects/obj_btn_reload/Mouse_4.gml(1): 1
objects/obj_btn_settings_hd/Create_0.gml(1): 8
objects/obj_btn_settings_hd/Draw_0.gml(1): 2
objects/obj_bubble/Step_0.gml(1): 1
objects/obj_bullebill_base/Draw_0.gml(1): 11
objects/obj_bullebill_base_red/Create_0.gml(1): 3
objects/obj_bullebill_base_red/Draw_0.gml(1): 11
objects/obj_bullebill_base_red/Other_10.gml(1): 3
objects/obj_bullebill_base_red/Other_11.gml(1): 8
objects/obj_bullebill_base_red/Other_12.gml(1): 8
objects/obj_bullebill_base_red_res/Other_10.gml(1): 5
objects/obj_bullebill_base_red_res/Step_2.gml(1): 1
objects/obj_bullebill_base_res/Other_10.gml(1): 5
objects/obj_bullebill_base_res/Other_11.gml(1): 6
objects/obj_bulletbill/Alarm_1.gml(1): 1
objects/obj_bulletbill/Draw_0.gml(1): 1
objects/obj_bulletbill/Step_0.gml(1): 1
objects/obj_bulletbull_red/Draw_0.gml(1): 1
objects/obj_bulletbull_red/Step_0.gml(1): 16
objects/obj_bumper/Create_0.gml(1): 1
objects/obj_bumper_res/Create_0.gml(1): 2
objects/obj_bumper_res/Step_2.gml(1): 1
objects/obj_button_autoavance/Draw_0.gml(1): 3
objects/obj_button_creditos/Create_0.gml(1): 2
objects/obj_button_ok/Draw_0.gml(1): 2
objects/obj_button_ok/KeyPress_13.gml(1): 17
objects/obj_button_ok/Mouse_4.gml(1): 17
objects/obj_button_parent/Draw_0.gml(1): 2
objects/obj_button_save_changes/Create_0.gml(1): 2
objects/obj_button_sdog/Create_0.gml(1): 2
objects/obj_button_sdog/Step_2.gml(1): 1
objects/obj_button_settings_close/Mouse_4.gml(1): 10
objects/obj_button_settings_close2/Mouse_4.gml(1): 7
objects/obj_button_settings_controls/Create_0.gml(1): 6
objects/obj_button_settings_controls/Draw_0.gml(1): 2
objects/obj_button_settings_estrella/Create_0.gml(1): 7
objects/obj_button_settings_estrella/Draw_0.gml(1): 2
objects/obj_button_settings_idioma/Draw_0.gml(1): 2
objects/obj_button_settings_sm4j/Create_0.gml(1): 6
objects/obj_button_settings_sm4j/Draw_0.gml(1): 2
objects/obj_button_settings_sombras/Draw_0.gml(1): 2
objects/obj_button_sombras/Draw_0.gml(1): 2
objects/obj_button_speed_water/Mouse_4.gml(1): 2
objects/obj_button_speed_water/Step_2.gml(1): 1
objects/obj_button_superado/Create_0.gml(1): 3
objects/obj_button_superado/Draw_0.gml(1): 2
objects/obj_button_trail/Create_0.gml(1): 2
objects/obj_button_trail/Step_2.gml(1): 1
objects/obj_button_wings/Create_0.gml(1): 1
objects/obj_buzzy_ceiling/Create_0.gml(1): 1
objects/obj_buzzy_ceiling/Other_11.gml(1): 7
objects/obj_buzzy_ceiling/Other_14.gml(1): 61
objects/obj_buzzy_shell_res/Other_10.gml(1): 5
objects/obj_buzzybeetle/Draw_0.gml(1): 8
objects/obj_buzzybeetle_b/Draw_0.gml(1): 8
objects/obj_buzzybeetle_b_res/Other_13.gml(1): 6
objects/obj_buzzybeetle_res/Other_10.gml(1): 4
objects/obj_cannon/Draw_0.gml(1): 1
objects/obj_cannon/Step_0.gml(1): 1
objects/obj_cannon_red/Create_0.gml(1): 2
objects/obj_cannon_red_res/Other_10.gml(1): 5
objects/obj_cannon_red_res/Step_2.gml(1): 3
objects/obj_cannon_res/Other_10.gml(1): 5
objects/obj_cannon_res/Other_11.gml(1): 6
objects/obj_cannonball/Other_10.gml(1): 5
objects/obj_cannonball/Other_11.gml(1): 5
objects/obj_cap/Alarm_0.gml(1): 4
objects/obj_cap/Alarm_10.gml(1): 12
objects/obj_cap/Create_0.gml(1): 1
objects/obj_cap_mario/Draw_0.gml(1): 4
objects/obj_cap_mario/Other_11.gml(1): 1
objects/obj_cap_mario/Other_15.gml(1): 70
objects/obj_cap_mario/Other_16.gml(1): 35
objects/obj_cap_mario/Step_0.gml(1): 3
objects/obj_cap_res/Other_13.gml(1): 19
objects/obj_cap_res/Other_14.gml(1): 11
objects/obj_cap_res/Step_2.gml(1): 3
objects/obj_card_autoavance/Step_0.gml(1): 3
objects/obj_card_block_sounds/Mouse_4.gml(1): 6
objects/obj_card_bout/Mouse_4.gml(1): 1
objects/obj_card_circle/Create_0.gml(1): 1
objects/obj_card_item/Create_0.gml(1): 1
objects/obj_card_logo/Other_10.gml(1): 1
objects/obj_card_rocket/Alarm_0.gml(1): 1
objects/obj_card_rocket/Other_10.gml(1): 43
objects/obj_card_rocket/Step_0.gml(1): 20
objects/obj_castle/Create_0.gml(1): 1
objects/obj_castle/Draw_0.gml(1): 1
objects/obj_castle/Step_0.gml(1): 7
objects/obj_castle_floor/Create_0.gml(1): 2
objects/obj_castle_front/Create_0.gml(1): 2
objects/obj_cerdito_snd_res/Other_11.gml(1): 6
objects/obj_chain_chomp_free/Alarm_10.gml(1): 3
objects/obj_chain_chomp_free/Step_0.gml(1): 22
objects/obj_change_view/Draw_0.gml(1): 1
objects/obj_charginchuck/Alarm_0.gml(1): 2
objects/obj_charginchuck/Other_11.gml(1): 3
objects/obj_charginchuck/Other_7.gml(1): 1
objects/obj_charginchuck_res/Step_2.gml(1): 2
objects/obj_checkpoint_res/Step_2.gml(1): 1
objects/obj_cheepcheep/Alarm_1.gml(1): 3
objects/obj_cheepcheep/Alarm_10.gml(1): 3
objects/obj_cheepcheep/Collision_obj_mario.gml(1): 1
objects/obj_cheepcheep/Other_10.gml(1): 4
objects/obj_cheepcheep2/Alarm_10.gml(1): 3
objects/obj_cheepcheep2/Create_0.gml(1): 2
objects/obj_cheepcheep2/Other_10.gml(1): 4
objects/obj_cheepcheep2_res/Other_11.gml(1): 6
objects/obj_cheepcheep_res/Other_11.gml(1): 6
objects/obj_chisporreteo_snd_res/Other_11.gml(1): 6
objects/obj_cinta_on_res/Create_0.gml(1): 17
objects/obj_cinta_res/Create_0.gml(1): 17
objects/obj_claw/Collision_obj_shell_held.gml(1): 16
objects/obj_claw/Collision_obj_spike_ball.gml(1): 11
objects/obj_claw/Create_0.gml(1): 2
objects/obj_claw/Other_10.gml(1): 1
objects/obj_claw/Other_11.gml(1): 1
objects/obj_claw_res/Step_2.gml(1): 1
objects/obj_cloud_lakitu/Collision_obj_mario.gml(1): 3
objects/obj_cloud_lakitu/Create_0.gml(1): 1
objects/obj_clown/Create_0.gml(1): 5
objects/obj_clown_explotion/Create_0.gml(1): 1
objects/obj_clown_fire/Draw_0.gml(1): 4
objects/obj_clown_fire_res/Other_11.gml(1): 6
objects/obj_clown_fire_res/Step_2.gml(1): 3
objects/obj_clown_res/Other_11.gml(1): 6
objects/obj_clown_res/Step_2.gml(1): 3
objects/obj_coin/Collision_obj_clown.gml(1): 2
objects/obj_coin/Collision_obj_enemyparent_held.gml(1): 2
objects/obj_coin/Collision_obj_player_goal_parent.gml(1): 1
objects/obj_coin/Collision_obj_shell_held.gml(1): 1
objects/obj_coin/Other_12.gml(1): 3
objects/obj_coin/Step_2.gml(1): 45
objects/obj_coin10/Other_10.gml(1): 13
objects/obj_coin10/Other_11.gml(1): 1
objects/obj_coin_pow/Other_14.gml(1): 53
objects/obj_coin_res/Other_11.gml(1): 6
objects/obj_configurar_controles/Draw_0.gml(1): 2
objects/obj_configurar_controles_reset/Create_0.gml(1): 2
objects/obj_configurar_controles_reset/Step_1.gml(1): 1
objects/obj_continue_btn/Mouse_4.gml(1): 6
objects/obj_crumblebones/Alarm_1.gml(1): 1
objects/obj_crumblebones/Other_10.gml(1): 3
objects/obj_crumblebony/Alarm_1.gml(1): 1
objects/obj_crumblebony/Other_10.gml(1): 3
objects/obj_crumblebony_b/Alarm_1.gml(1): 1
objects/obj_crumblebony_b/Other_10.gml(1): 3
objects/obj_crystalorb/Create_0.gml(1): 1
objects/obj_cursor/Alarm_0.gml(1): 7
objects/obj_deadmario/Destroy_0.gml(1): 1
objects/obj_deadmario/Step_0.gml(1): 11
objects/obj_destello_snd_res/Other_11.gml(1): 6
objects/obj_dog/Mouse_4.gml(1): 3
objects/obj_donut/Draw_0.gml(1): 4
objects/obj_door/Alarm_1.gml(1): 6
objects/obj_door/Create_0.gml(1): 1
objects/obj_door/Other_7.gml(1): 8
objects/obj_door/Step_0.gml(1): 1
objects/obj_door_exit/Alarm_1.gml(1): 6
objects/obj_door_exit/Create_0.gml(1): 1
objects/obj_door_exit/Other_7.gml(1): 8
objects/obj_door_exit/Step_0.gml(1): 1
objects/obj_door_exit_res/Step_2.gml(1): 1
objects/obj_door_lock/Create_0.gml(1): 1
objects/obj_door_lock_exit/Create_0.gml(1): 1
objects/obj_door_lock_exit_res/Step_2.gml(1): 1
objects/obj_door_lock_res/Step_2.gml(1): 1
objects/obj_door_res/Step_2.gml(1): 1
objects/obj_door_switch/Create_0.gml(1): 1
objects/obj_door_switch/Step_0.gml(1): 5
objects/obj_door_switch_exit/Create_0.gml(1): 1
objects/obj_door_switch_exit/Step_0.gml(1): 5
objects/obj_door_switch_exit_res/Step_2.gml(1): 1
objects/obj_door_switch_res/Step_2.gml(1): 1
objects/obj_doormario_exit/Alarm_0.gml(1): 4
objects/obj_doormario_exit/Create_0.gml(1): 10
objects/obj_drybones/Alarm_0.gml(1): 1
objects/obj_drybones/Draw_0.gml(1): 2
objects/obj_drybones/Other_10.gml(1): 2
objects/obj_drybones/Step_0.gml(1): 1
objects/obj_drybones_res/Step_2.gml(1): 2
objects/obj_edit_menu/Create_0.gml(1): 4
objects/obj_editor_screen/Create_0.gml(1): 2
objects/obj_editormanager/Alarm_2.gml(1): 1
objects/obj_egg/Collision_obj_mario.gml(1): 1
objects/obj_egg/Other_17.gml(1): 5
objects/obj_egg/Other_7.gml(1): 1
objects/obj_egg_hatch/Alarm_0.gml(1): 1
objects/obj_egg_hatch/Collision_obj_mario.gml(1): 1
objects/obj_egg_hatch/Create_0.gml(1): 1
objects/obj_egg_hatch/Other_7.gml(1): 3
objects/obj_egg_red_res/Create_0.gml(1): 5
objects/obj_egg_red_res/Other_11.gml(1): 6
objects/obj_egg_red_res/Other_7.gml(1): 1
objects/obj_egg_red_res/Step_2.gml(1): 3
objects/obj_egg_res/Create_0.gml(1): 4
objects/obj_egg_res/Other_11.gml(1): 6
objects/obj_egg_res/Other_14.gml(1): 1
objects/obj_egg_res/Other_7.gml(1): 1
objects/obj_egg_res/Step_2.gml(1): 3
objects/obj_enemy_dead/Create_0.gml(1): 3
objects/obj_enemy_dead/Destroy_0.gml(1): 1
objects/obj_enemy_dead_castle/Alarm_0.gml(1): 3
objects/obj_enemy_dead_castle/Alarm_1.gml(1): 2
objects/obj_enemyfrozen/Other_14.gml(1): 83
objects/obj_enemyfrozen/Other_18.gml(1): 1
objects/obj_enemyparent/Alarm_10.gml(1): 3
objects/obj_enemyparent/Other_12.gml(1): 46
objects/obj_enemyparent/Step_1.gml(1): 46
objects/obj_enemyparent_lava/Collision_obj_mario.gml(1): 1
objects/obj_enemyparent_lava/Step_0.gml(1): 16
objects/obj_error_snd_res/Other_11.gml(1): 6
objects/obj_espina/Create_0.gml(1): 2
objects/obj_etiquetas/Draw_0.gml(1): 2
objects/obj_expand/Mouse_4.gml(1): 1
objects/obj_fast_lava_lift/Create_0.gml(1): 1
objects/obj_fast_lava_lift_res/Other_11.gml(1): 6
objects/obj_fast_lava_lift_res/Step_2.gml(1): 1
objects/obj_fire_clown/Step_0.gml(1): 6
objects/obj_fireball/Other_10.gml(1): 6
objects/obj_fireball_b/Create_0.gml(1): 1
objects/obj_fireball_bro/Other_10.gml(1): 3
objects/obj_fireball_bro/Step_0.gml(1): 2
objects/obj_firebro/Other_17.gml(1): 1
objects/obj_firebro/Other_7.gml(1): 1
objects/obj_firebro_res/Other_11.gml(1): 6
objects/obj_firebro_res/Other_13.gml(1): 2
objects/obj_firebro_res/Step_2.gml(1): 2
objects/obj_fireflower/Create_0.gml(1): 2
objects/obj_fireflower_res/Other_10.gml(1): 1
objects/obj_fireflower_res/Other_13.gml(1): 19
objects/obj_fireflower_res/Step_2.gml(1): 3
objects/obj_fishbone_res/Step_2.gml(1): 2
objects/obj_flagpole/Alarm_0.gml(1): 6
objects/obj_flagpole/Collision_obj_mario.gml(1): 1
objects/obj_flagpole/Collision_obj_marioU.gml(1): 2
objects/obj_flipblock/Alarm_1.gml(1): 3
objects/obj_floruga/Draw_0.gml(1): 3
objects/obj_floruga_angry_res/Other_11.gml(1): 6
objects/obj_floruga_angry_res/Step_2.gml(1): 1
objects/obj_floruga_body/Step_0.gml(1): 1
objects/obj_floruga_res/Other_11.gml(1): 6
objects/obj_floruga_res/Step_2.gml(1): 1
objects/obj_foo/Destroy_0.gml(1): 1
objects/obj_foo/Other_10.gml(1): 1
objects/obj_foo_fog/Create_0.gml(1): 1
objects/obj_foo_fog/Step_0.gml(1): 10
objects/obj_foo_res/Other_11.gml(1): 6
objects/obj_foo_res/Step_2.gml(1): 2
objects/obj_frogsuit_res/Other_11.gml(1): 6
objects/obj_frogsuit_res/Other_13.gml(1): 19
objects/obj_frogsuit_res/Step_2.gml(1): 3
objects/obj_frozenmario/Destroy_0.gml(1): 3
objects/obj_frozenmario/Other_11.gml(1): 1
objects/obj_fuegos_snd_res/Other_11.gml(1): 6
objects/obj_galoomba/Alarm_10.gml(1): 5
objects/obj_galoomba/Destroy_0.gml(1): 3
objects/obj_galoomba/Other_10.gml(1): 5
objects/obj_galoomba/Other_15.gml(1): 2
objects/obj_galoomba/Other_17.gml(1): 1
objects/obj_galoomba2/Other_10.gml(1): 5
objects/obj_galoomba2_b/Other_10.gml(1): 5
objects/obj_galoomba_b/Alarm_10.gml(1): 5
objects/obj_galoomba_b/Destroy_0.gml(1): 3
objects/obj_galoomba_b/Other_10.gml(1): 5
objects/obj_galoomba_b/Other_17.gml(1): 1
objects/obj_galoomba_hold/Other_10.gml(1): 4
objects/obj_game_over/Create_0.gml(1): 2
objects/obj_gb_button/Draw_0.gml(1): 2
objects/obj_gb_button/Step_0.gml(1): 6
objects/obj_getshoe/Create_0.gml(1): 6
objects/obj_getshoe/Step_0.gml(1): 4
objects/obj_goalcard/Alarm_2.gml(1): 6
objects/obj_goalcard/Step_0.gml(1): 6
objects/obj_goalgate/Alarm_1.gml(1): 6
objects/obj_goalgate_front/Step_0.gml(1): 6
objects/obj_goalgate_tape/Other_10.gml(1): 8
objects/obj_goalgate_tape/Step_0.gml(1): 6
objects/obj_golpe_gato_snd_res/Other_11.gml(1): 6
objects/obj_goomba_b_res/Other_11.gml(1): 6
objects/obj_goomba_b_res/Other_13.gml(1): 6
objects/obj_goomba_res/Other_11.gml(1): 6
objects/obj_goombrat_b_res/Other_11.gml(1): 6
objects/obj_goombrat_b_res/Other_13.gml(1): 6
objects/obj_goombrat_res/Other_11.gml(1): 6
objects/obj_grinder/Collision_obj_mario.gml(1): 1
objects/obj_grinder/Create_0.gml(1): 2
objects/obj_grinder/Draw_0.gml(1): 2
objects/obj_grinder_res/Create_0.gml(1): 2
objects/obj_grinder_res/Step_2.gml(1): 1
objects/obj_ground/Mouse_1.gml(1): 1
objects/obj_ground2/Draw_0.gml(1): 19
objects/obj_ground3/Step_0.gml(1): 49
objects/obj_grrrol/Create_0.gml(1): 2
objects/obj_grrrol/Other_13.gml(1): 84
objects/obj_grrrol_b/Create_0.gml(1): 2
objects/obj_grrrol_b/Other_13.gml(1): 84
objects/obj_grrrol_b_res/Step_2.gml(1): 2
objects/obj_grrrol_new/Create_0.gml(1): 2
objects/obj_grrrol_new/Other_13.gml(1): 84
objects/obj_grrrol_new_res/Step_2.gml(1): 2
objects/obj_grrrol_res/Step_2.gml(1): 2
objects/obj_guardabot/Alarm_0.gml(1): 1
objects/obj_guardabot/Draw_0.gml(1): 6
objects/obj_hammer/Create_0.gml(1): 6
objects/obj_hammerbro/Other_14.gml(1): 47
objects/obj_hammerbro/Other_17.gml(1): 1
objects/obj_hammerbro/Other_25.gml(1): 57
objects/obj_hammerbro/Other_7.gml(1): 1
objects/obj_hammerbro_res/Other_11.gml(1): 6
objects/obj_hammerbro_res/Other_13.gml(1): 2
objects/obj_hammerbro_res/Step_2.gml(1): 2
objects/obj_header/Draw_0.gml(1): 5
objects/obj_helmet/Collision_obj_holdparent.gml(1): 1
objects/obj_helmet_spiny/Collision_obj_holdparent.gml(1): 1
objects/obj_helmet_spiny/Collision_obj_shell.gml(1): 1
objects/obj_hen_mushroom/Step_0.gml(1): 4
objects/obj_hen_mushroom_res/Other_11.gml(1): 6
objects/obj_hen_mushroom_res/Other_13.gml(1): 19
objects/obj_hen_mushroom_res/Step_2.gml(1): 3
objects/obj_holdparent/Collision_obj_blockparent.gml(1): 3
objects/obj_hurtsolid2/Step_0.gml(1): 2
objects/obj_ice_res/Step_2.gml(1): 3
objects/obj_icebro/Other_17.gml(1): 1
objects/obj_icebro/Other_7.gml(1): 1
objects/obj_icebro_res/Other_11.gml(1): 6
objects/obj_icebro_res/Other_13.gml(1): 2
objects/obj_icebro_res/Step_2.gml(1): 2
objects/obj_icecoin/Collision_obj_angrysun.gml(1): 1
objects/obj_icecoin/Collision_obj_cheepcheep.gml(1): 1
objects/obj_icecoin/Draw_0.gml(1): 2
objects/obj_icecoin_res/Other_11.gml(1): 6
objects/obj_icicle/Alarm_0.gml(1): 1
objects/obj_icicle/Create_0.gml(1): 2
objects/obj_icicle/Step_0.gml(1): 24
objects/obj_icicle2/Create_0.gml(1): 2
objects/obj_icicle2_res/Step_2.gml(1): 1
objects/obj_icicle_res/Step_2.gml(1): 1
objects/obj_iname/Draw_0.gml(1): 3
objects/obj_iname_control/Create_0.gml(1): 9
objects/obj_iname_control/Draw_0.gml(1): 10
objects/obj_iname_control2/Create_0.gml(1): 9
objects/obj_input/Draw_0.gml(1): 2
objects/obj_input_desc/Draw_0.gml(1): 2
objects/obj_input_desc/Step_0.gml(1): 34
objects/obj_input_rename/Draw_0.gml(1): 2
objects/obj_intro_controller/Draw_0.gml(1): 3
objects/obj_invincibility/Collision_obj_enemyparent.gml(1): 1
objects/obj_invincibility/Step_0.gml(1): 3
objects/obj_jumppiranha/Alarm_0.gml(1): 1
objects/obj_jumppiranha/Alarm_1.gml(1): 1
objects/obj_jumppiranha/Create_0.gml(1): 1
objects/obj_jumppiranha/Other_10.gml(1): 1
objects/obj_key/Other_10.gml(1): 6
objects/obj_key_appear/Create_0.gml(1): 1
objects/obj_key_appear/Other_10.gml(1): 6
objects/obj_key_appear/Step_0.gml(1): 3
objects/obj_key_fallow/Create_0.gml(1): 1
objects/obj_key_fallow/Draw_0.gml(1): 1
objects/obj_key_fallow/Step_0.gml(1): 68
objects/obj_key_res/Step_2.gml(1): 3
objects/obj_koopa/Create_0.gml(1): 1
objects/obj_koopa/Draw_0.gml(1): 2
objects/obj_koopa/Other_10.gml(1): 3
objects/obj_koopa/Other_11.gml(1): 5
objects/obj_koopa/Other_15.gml(1): 2
objects/obj_koopa/Other_17.gml(1): 1
objects/obj_koopa_b/Create_0.gml(1): 1
objects/obj_koopa_b/Draw_0.gml(1): 2
objects/obj_koopa_b/Other_10.gml(1): 3
objects/obj_koopa_b/Other_11.gml(1): 5
objects/obj_koopa_b/Other_15.gml(1): 2
objects/obj_koopa_b_res/Other_11.gml(1): 6
objects/obj_koopa_b_res/Other_13.gml(1): 6
objects/obj_koopa_red/Create_0.gml(1): 1
objects/obj_koopa_red/Draw_0.gml(1): 2
objects/obj_koopa_red/Other_10.gml(1): 3
objects/obj_koopa_red/Other_15.gml(1): 2
objects/obj_koopa_red/Other_17.gml(1): 1
objects/obj_koopa_red/Step_0.gml(1): 27
objects/obj_koopa_red_b/Create_0.gml(1): 1
objects/obj_koopa_red_b/Draw_0.gml(1): 2
objects/obj_koopa_red_b/Other_10.gml(1): 3
objects/obj_koopa_red_b/Other_15.gml(1): 2
objects/obj_koopa_red_b_res/Other_11.gml(1): 6
objects/obj_koopa_red_b_res/Other_13.gml(1): 6
objects/obj_koopa_red_res/Other_11.gml(1): 6
objects/obj_koopa_res/Other_11.gml(1): 6
objects/obj_kuribo_drybones/Alarm_4.gml(1): 1
objects/obj_kuribo_drybones/Other_10.gml(1): 16
objects/obj_kuribo_drybones/Other_15.gml(1): 6
objects/obj_kuriboshoe/Alarm_0.gml(1): 43
objects/obj_kuriboshoe/Destroy_0.gml(1): 1
objects/obj_kuriboshoe_movement/Step_0.gml(1): 5
objects/obj_lakitu/Alarm_2.gml(1): 1
objects/obj_lakitu/Create_0.gml(1): 1
objects/obj_lakitu/Other_10.gml(1): 5
objects/obj_lakitu_res/Step_2.gml(1): 2
objects/obj_lava_lift/Create_0.gml(1): 1
objects/obj_lava_lift_part/Create_0.gml(1): 1
objects/obj_lava_lift_res/Other_11.gml(1): 6
objects/obj_lava_lift_res/Step_2.gml(1): 1
objects/obj_leafmaker/Create_0.gml(1): 5
objects/obj_levelmanager/Alarm_4.gml(1): 3
objects/obj_levelmanager/Alarm_8.gml(1): 3
objects/obj_levelmanager/Alarm_9.gml(1): 1
objects/obj_levelmanager/Draw_0.gml(1): 3
objects/obj_levelmanager/Other_15.gml(1): 1
objects/obj_levelmanager/Other_18.gml(1): 112
objects/obj_link_arrow/Alarm_10.gml(1): 34
objects/obj_link_arrow_anim/Draw_0.gml(1): 4
objects/obj_link_arrow_anim/Step_0.gml(1): 3
objects/obj_link_atack/Step_0.gml(1): 3
objects/obj_link_bomb/Alarm_10.gml(1): 1
objects/obj_link_bomb/Other_12.gml(1): 7
objects/obj_link_dash_atack/Draw_0.gml(1): 4
objects/obj_link_dash_atack/Step_0.gml(1): 3
objects/obj_link_down_atack/Step_0.gml(1): 3
objects/obj_load_level/Create_0.gml(1): 1
objects/obj_load_level/Other_4.gml(1): 1
objects/obj_logo_c/Draw_0.gml(1): 1
objects/obj_logo_game/Step_0.gml(1): 3
objects/obj_lp/Draw_0.gml(1): 2
objects/obj_ludwig_res/Step_2.gml(1): 2
objects/obj_lun/Draw_0.gml(1): 2
objects/obj_magic/Draw_0.gml(1): 1
objects/obj_magic/Other_10.gml(1): 1
objects/obj_magic/Step_0.gml(1): 8
objects/obj_magikoopa/Other_10.gml(1): 4
objects/obj_magikoopa_res/Step_2.gml(1): 2
objects/obj_mario/Alarm_5.gml(1): 2
objects/obj_mario/Alarm_6.gml(1): 2
objects/obj_mario/Other_17.gml(1): 10
objects/obj_mario/Other_7.gml(1): 1
objects/obj_marioU/Create_0.gml(1): 27
objects/obj_mario_editor/Create_0.gml(1): 13
objects/obj_mario_pballon/Create_0.gml(1): 3
objects/obj_mario_pballon/Draw_0.gml(1): 5
objects/obj_mario_temp/Alarm_0.gml(1): 2
objects/obj_mario_temp/Create_0.gml(1): 1
objects/obj_mario_temp/Other_10.gml(1): 5
objects/obj_mario_transform2/Alarm_1.gml(1): 10
objects/obj_mario_transform2/Alarm_2.gml(1): 10
objects/obj_mario_transform2/Alarm_3.gml(1): 10
objects/obj_mario_transform2/Alarm_4.gml(1): 10
objects/obj_mario_transform2/Create_0.gml(1): 39
objects/obj_mariostart/Alarm_1.gml(1): 5
objects/obj_mariostart/Create_0.gml(1): 8
objects/obj_mariostart_m/Create_0.gml(1): 4
objects/obj_mariostart_m/Other_10.gml(1): 1
objects/obj_mariostart_m/Other_11.gml(1): 1
objects/obj_mariostart_m/Other_7.gml(1): 1
objects/obj_mariostart_m/Step_2.gml(1): 24
objects/obj_mechakoopa_held/Alarm_1.gml(1): 1
objects/obj_mechakoopa_held/Alarm_2.gml(1): 1
objects/obj_mechakoopa_res/Other_11.gml(1): 6
objects/obj_mechakoopa_res/Step_2.gml(1): 2
objects/obj_megamushroom/Step_0.gml(1): 4
objects/obj_menu_editor_ext/Mouse_4.gml(1): 1
objects/obj_menu_pausa/Other_10.gml(1): 46
objects/obj_meteorites/Collision_obj_mario.gml(1): 1
objects/obj_meteorites/Create_0.gml(1): 1
objects/obj_meteorites_big/Alarm_0.gml(1): 2
objects/obj_meteorites_big/Collision_obj_mario.gml(1): 1
objects/obj_meteorites_big/Create_0.gml(1): 1
objects/obj_meteorites_maker/Alarm_0.gml(1): 1
objects/obj_meteorites_maker/Alarm_1.gml(1): 2
objects/obj_meteorites_maker/Alarm_10.gml(1): 1
objects/obj_meteorites_maker/Alarm_2.gml(1): 1
objects/obj_meteorites_maker/Alarm_3.gml(1): 1
objects/obj_meteorites_maker/Alarm_4.gml(1): 1
objects/obj_meteorites_maker/Alarm_5.gml(1): 1
objects/obj_meteorites_maker/Alarm_6.gml(1): 1
objects/obj_meteorites_maker/Alarm_7.gml(1): 1
objects/obj_meteorites_maker/Alarm_8.gml(1): 1
objects/obj_meteorites_maker/Alarm_9.gml(1): 1
objects/obj_mini_icicle2_res/Step_2.gml(1): 1
objects/obj_mini_icicle_res/Step_2.gml(1): 1
objects/obj_monty_chase/Draw_0.gml(1): 3
objects/obj_monty_chase/Other_10.gml(1): 5
objects/obj_monty_res/Step_2.gml(1): 2
objects/obj_multiveggiecoin/Collision_obj_mario.gml(1): 4
objects/obj_muncher/Collision_obj_shield_left.gml(1): 1
objects/obj_muncher/Collision_obj_shield_right.gml(1): 1
objects/obj_muncher/Step_0.gml(1): 20
objects/obj_muncher_b_res/Other_13.gml(1): 6
objects/obj_mushroom/Alarm_10.gml(1): 12
objects/obj_mushroom_platform_res/Create_0.gml(1): 2
objects/obj_mushroom_platform_res/Other_11.gml(1): 6
objects/obj_mushroom_res/Step_2.gml(1): 3
objects/obj_n64_or/Collision_obj_mario.gml(1): 1
objects/obj_night_change/Create_0.gml(1): 3
objects/obj_night_change/Mouse_7.gml(1): 6
objects/obj_ninji/Alarm_0.gml(1): 21
objects/obj_nota_musical_snd_res/Other_11.gml(1): 6
objects/obj_noteblock_s_res/Step_2.gml(1): 2
objects/obj_noti_load_button/Mouse_4.gml(1): 5
objects/obj_oneway_res/Step_2.gml(1): 1
objects/obj_onoffblock/Create_0.gml(1): 1
objects/obj_onoffblock/Destroy_0.gml(1): 1
objects/obj_onoffblock_res/Step_2.gml(1): 3
objects/obj_onoffplatform/Create_0.gml(1): 1
objects/obj_onoffplatform/Step_0.gml(1): 1
objects/obj_onoffplatform_blue/Create_0.gml(1): 1
objects/obj_onoffplatform_blue/Step_0.gml(1): 1
objects/obj_onoffplatform_blue_res/Other_11.gml(1): 6
objects/obj_onoffplatform_blue_res/Step_2.gml(1): 3
objects/obj_onoffplatform_res/Other_11.gml(1): 6
objects/obj_onoffplatform_res/Step_2.gml(1): 3
objects/obj_panel_circle/Create_0.gml(1): 1
objects/obj_panel_circle/Other_11.gml(1): 45
objects/obj_paracaidas_dead/Create_0.gml(1): 2
objects/obj_paracaidas_go/Create_0.gml(1): 2
objects/obj_parcarry/Alarm_0.gml(1): 20
objects/obj_parcarry/Other_10.gml(1): 9
objects/obj_parent_resource/Collision_obj_key_res.gml(1): 9
objects/obj_parent_resource/Mouse_1.gml(1): 5
objects/obj_parent_resource/Other_12.gml(1): 1
objects/obj_parent_sounds/Mouse_1.gml(1): 5
objects/obj_pausa_button/Draw_0.gml(1): 2
objects/obj_pballon/Create_0.gml(1): 3
objects/obj_pblock/Create_0.gml(1): 1
objects/obj_pblock2_res/Other_11.gml(1): 6
objects/obj_pblock2_res/Step_2.gml(1): 3
objects/obj_pblock_res/Other_11.gml(1): 6
objects/obj_pblock_res/Step_2.gml(1): 3
objects/obj_penguin_attack/Collision_obj_blockparent.gml(1): 5
objects/obj_persistent/Alarm_11.gml(1): 2
objects/obj_persistent/Alarm_9.gml(1): 4
objects/obj_persistent/Other_10.gml(1): 5
objects/obj_persistent/Other_3.gml(1): 7
objects/obj_persistent/Other_70.gml(1): 7
objects/obj_physicsparent/Collision_obj_blockparent.gml(1): 5
objects/obj_physicsparent/Other_14.gml(1): 98
objects/obj_physicsparent/Step_0.gml(1): 1
objects/obj_pink_coin/Step_0.gml(1): 3
objects/obj_pink_coin_res/Step_2.gml(1): 1
objects/obj_piranhaplant/Create_0.gml(1): 1
objects/obj_piranhaplant/Other_10.gml(1): 1
objects/obj_plant_fire/Alarm_2.gml(1): 2
objects/obj_plant_fire/Alarm_4.gml(1): 2
objects/obj_plant_fire/Other_10.gml(1): 4
objects/obj_plant_fire_res/Other_11.gml(1): 6
objects/obj_plant_fire_res/Step_2.gml(1): 2
objects/obj_plantfire/Other_10.gml(1): 4
objects/obj_plataforma_blue/Create_0.gml(1): 2
objects/obj_plataforma_blue/Step_0.gml(1): 5
objects/obj_platform_blue_res/Other_11.gml(1): 6
objects/obj_platform_blue_res/Step_2.gml(1): 1
objects/obj_platform_help/Create_0.gml(1): 1
objects/obj_platform_res/Other_11.gml(1): 6
objects/obj_platform_res/Step_2.gml(1): 1
objects/obj_play_screen/Create_0.gml(1): 2
objects/obj_player_goal_nsmbu/Draw_0.gml(1): 6
objects/obj_player_goal_nsmbu/Other_23.gml(1): 1
objects/obj_player_goal_parent/Step_0.gml(1): 1
objects/obj_player_goal_smb1/Alarm_11.gml(1): 1
objects/obj_player_goal_smb1/Draw_0.gml(1): 2
objects/obj_player_goal_smb1/Other_14.gml(1): 53
objects/obj_player_goal_smb2/Step_0.gml(1): 2
objects/obj_player_goal_smw_castle/Alarm_2.gml(1): 8
objects/obj_player_goal_smw_castle/Alarm_5.gml(1): 1
objects/obj_player_trail/Draw_0.gml(1): 1
objects/obj_player_warp/Alarm_1.gml(1): 67
objects/obj_player_warp/Create_0.gml(1): 25
objects/obj_player_warp/Step_2.gml(1): 2
objects/obj_podoboo/Alarm_10.gml(1): 1
objects/obj_podoboo/Create_0.gml(1): 1
objects/obj_podoboo_b/Create_0.gml(1): 1
objects/obj_podoboo_b_res/Other_13.gml(1): 6
objects/obj_podoboo_b_res/Step_2.gml(1): 3
objects/obj_podoboo_res/Step_2.gml(1): 2
objects/obj_pokey/Destroy_0.gml(1): 3
objects/obj_powerupparent/Collision_obj_blockparent.gml(1): 8
objects/obj_powerupparent/Create_0.gml(1): 10
objects/obj_powerupsprout/Alarm_1.gml(1): 1
objects/obj_powerupsprout/Alarm_2.gml(1): 1
objects/obj_powerupsprout_note/Alarm_1.gml(1): 2
objects/obj_pplant_res/Other_11.gml(1): 6
objects/obj_pplant_res/Step_2.gml(1): 3
objects/obj_pswitch/Create_0.gml(1): 2
objects/obj_pswitch/Draw_0.gml(1): 7
objects/obj_pswitch/Other_17.gml(1): 1
objects/obj_pswitch_press/Create_0.gml(1): 2
objects/obj_pswitch_res/Step_2.gml(1): 3
objects/obj_remolino_snd_res/Other_11.gml(1): 6
objects/obj_rename/Draw_0.gml(1): 3
objects/obj_rename_button2/Mouse_4.gml(1): 5
objects/obj_rename_control/Create_0.gml(1): 8
objects/obj_rename_control/Draw_0.gml(1): 10
objects/obj_risas_snd_res/Other_11.gml(1): 6
objects/obj_robot/Mouse_4.gml(1): 1
objects/obj_rocangrejo/Alarm_1.gml(1): 3
objects/obj_rocangrejo/Alarm_2.gml(1): 1
objects/obj_rocangrejo/Other_10.gml(1): 5
objects/obj_rocangrejo/Other_14.gml(1): 83
objects/obj_rocangrejo_res/Step_2.gml(1): 2
objects/obj_rockparent/Step_0.gml(1): 4
objects/obj_rocky/Alarm_3.gml(1): 2
objects/obj_rocky/Alarm_4.gml(1): 3
objects/obj_rocky/Create_0.gml(1): 1
objects/obj_rocky/Other_14.gml(1): 73
objects/obj_rocky/Other_16.gml(1): 2
objects/obj_rocky/Other_7.gml(1): 4
objects/obj_rocky_res/Step_2.gml(1): 2
objects/obj_rorock/Create_0.gml(1): 2
objects/obj_score/Create_0.gml(1): 1
objects/obj_scrollbar2/Step_0.gml(1): 1
objects/obj_scrollbar3/Step_0.gml(1): 1
objects/obj_scrollbar4/Step_0.gml(1): 1
objects/obj_selecting_fps/Create_0.gml(1): 3
objects/obj_selecting_player/Mouse_4.gml(1): 34
objects/obj_semisolid_platform1/Create_0.gml(1): 4
objects/obj_semisolid_platform1/Other_11.gml(1): 6
objects/obj_serpentina_snd_res/Other_11.gml(1): 6
objects/obj_settings_custom/Draw_0.gml(1): 2
objects/obj_settings_custom/Other_10.gml(1): 43
objects/obj_shard/Step_0.gml(1): 6
objects/obj_shell/Other_17.gml(1): 15
objects/obj_shell_drybones/Create_0.gml(1): 5
objects/obj_shell_drybones/Other_10.gml(1): 2
objects/obj_shell_drybones/Other_14.gml(1): 75
objects/obj_shell_drybones/Other_17.gml(1): 1
objects/obj_shell_drybones_held/Other_10.gml(1): 2
objects/obj_shell_drybones_held/Other_14.gml(1): 75
objects/obj_shell_drybones_held/Other_15.gml(1): 3
objects/obj_shell_drybones_res/Step_2.gml(1): 2
objects/obj_shell_held/Collision_obj_enemyparent.gml(1): 5
objects/obj_shell_held/Other_11.gml(1): 30
objects/obj_shell_held/Other_14.gml(1): 78
objects/obj_shell_held/Other_15.gml(1): 22
objects/obj_shield_left/Step_0.gml(1): 3
objects/obj_shield_right/Step_0.gml(1): 3
objects/obj_skewertrunk/Alarm_0.gml(1): 17
objects/obj_skewertrunk/Alarm_1.gml(1): 2
objects/obj_skewertrunk/Alarm_2.gml(1): 17
objects/obj_skewertrunk/Other_15.gml(1): 1
objects/obj_skewertrunk/Other_16.gml(1): 1
objects/obj_sledgebro/Alarm_1.gml(1): 1
objects/obj_sledgebro/Alarm_3.gml(1): 12
objects/obj_sledgebro/Draw_0.gml(1): 2
objects/obj_sledgebro/Other_10.gml(1): 4
objects/obj_sledgebro/Other_7.gml(1): 1
objects/obj_sledgebro_res/Other_13.gml(1): 2
objects/obj_sledgebro_res/Step_2.gml(1): 2
objects/obj_sm4j_jump/Mouse_0.gml(1): 1
objects/obj_sm4j_jump/Mouse_7.gml(1): 1
objects/obj_smoke/Create_0.gml(1): 1
objects/obj_smoke_steps/Create_0.gml(1): 1
objects/obj_snow_ball/Create_0.gml(1): 2
objects/obj_snow_ball/Draw_0.gml(1): 3
objects/obj_snow_ball/Other_10.gml(1): 3
objects/obj_snow_ball/Other_14.gml(1): 86
objects/obj_snow_ball/Other_17.gml(1): 1
objects/obj_snow_ball_b/Create_0.gml(1): 2
objects/obj_snow_ball_b/Draw_0.gml(1): 3
objects/obj_snow_ball_b/Other_10.gml(1): 3
objects/obj_snow_ball_held/Create_0.gml(1): 1
objects/obj_snow_ball_held/Other_10.gml(1): 8
objects/obj_snow_ball_held/Other_14.gml(1): 72
objects/obj_snow_ball_held/Other_15.gml(1): 6
objects/obj_snow_ball_held/Step_0.gml(1): 16
objects/obj_snowball/Step_0.gml(1): 2
objects/obj_snowball_bro/Other_10.gml(1): 1
objects/obj_soplete/Create_0.gml(1): 1
objects/obj_soplete/Draw_0.gml(1): 3
objects/obj_soplete_global/Create_0.gml(1): 1
objects/obj_soplete_global/Other_7.gml(1): 5
objects/obj_soplete_invert/Create_0.gml(1): 1
objects/obj_soplete_invert_global/Create_0.gml(1): 1
objects/obj_soplete_invert_global/Other_7.gml(1): 5
objects/obj_soplete_res/Create_0.gml(1): 7
objects/obj_soplete_res/Other_11.gml(1): 10
objects/obj_soplete_res/Step_2.gml(1): 11
objects/obj_sparkletrail/Create_0.gml(1): 1
objects/obj_spike/Alarm_1.gml(1): 1
objects/obj_spike/Alarm_10.gml(1): 1
objects/obj_spike/Destroy_0.gml(1): 8
objects/obj_spike/Other_7.gml(1): 5
objects/obj_spike_ball/Collision_obj_mario.gml(1): 1
objects/obj_spike_ball/Draw_0.gml(1): 3
objects/obj_spike_ball/Other_10.gml(1): 3
objects/obj_spike_ball_b/Draw_0.gml(1): 3
objects/obj_spike_ball_b/Other_10.gml(1): 3
objects/obj_spike_ball_b_res/Other_13.gml(1): 6
objects/obj_spike_res/Step_2.gml(1): 2
objects/obj_spinner/Step_0.gml(1): 3
objects/obj_spinsmoke/Create_0.gml(1): 1
objects/obj_spinthump/Create_0.gml(1): 1
objects/obj_spiny/Alarm_0.gml(1): 1
objects/obj_spiny/Other_10.gml(1): 3
objects/obj_spiny/Other_15.gml(1): 2
objects/obj_spiny/Other_19.gml(1): 2
objects/obj_spiny_ball/Create_0.gml(1): 1
objects/obj_spiny_ball/Step_0.gml(1): 18
objects/obj_spiny_empty/Create_0.gml(1): 2
objects/obj_spiny_empty/Other_11.gml(1): 1
objects/obj_spiny_shell_res/Step_2.gml(1): 2
objects/obj_spiny_thrown/Create_0.gml(1): 1
objects/obj_spring/Create_0.gml(1): 1
objects/obj_spring_land/Create_0.gml(1): 1
objects/obj_spring_land/Step_0.gml(1): 1
objects/obj_spring_land_res/Other_11.gml(1): 6
objects/obj_spring_land_res/Step_2.gml(1): 2
objects/obj_spring_res/Other_11.gml(1): 6
objects/obj_spring_res/Step_2.gml(1): 3
objects/obj_st_slider/Create_0.gml(1): 1
objects/obj_st_slider/Draw_0.gml(1): 5
objects/obj_st_slider/Other_10.gml(1): 2
objects/obj_star/Collision_obj_mario.gml(1): 19
objects/obj_star/Create_0.gml(1): 1
objects/obj_star_res/Step_2.gml(1): 2
objects/obj_superarcon/Draw_0.gml(1): 5
objects/obj_superball/Step_0.gml(1): 85
objects/obj_superflower_res/Other_10.gml(1): 1
objects/obj_superflower_res/Other_13.gml(1): 19
objects/obj_superflower_res/Step_2.gml(1): 3
objects/obj_tabs_condiciones/Draw_0.gml(1): 22
objects/obj_tabs_condiciones/Mouse_4.gml(1): 5
objects/obj_thwomp/Alarm_10.gml(1): 3
objects/obj_thwomp/Create_0.gml(1): 1
objects/obj_thwomp/Other_13.gml(1): 76
objects/obj_thwomp_b/Alarm_10.gml(1): 3
objects/obj_thwomp_b/Create_0.gml(1): 1
objects/obj_thwomp_b_res/Other_11.gml(1): 6
objects/obj_thwomp_b_res/Other_13.gml(1): 6
objects/obj_thwomp_b_res/Step_2.gml(1): 2
objects/obj_thwomp_res/Step_2.gml(1): 2
objects/obj_timeup/Other_7.gml(1): 2
objects/obj_title_controller/Step_2.gml(1): 1
objects/obj_titlemenu_key/Create_0.gml(1): 8
objects/obj_toast/Draw_0.gml(1): 3
objects/obj_tongue/Collision_obj_powerupparent.gml(1): 10
objects/obj_tongue/Step_2.gml(1): 69
objects/obj_tongue_blue/Collision_obj_powerupparent.gml(1): 10
objects/obj_tongue_blue/Step_2.gml(1): 69
objects/obj_torbellino/Alarm_10.gml(1): 1
objects/obj_torbellino/Step_0.gml(1): 1
objects/obj_torbellino_res/Other_11.gml(1): 6
objects/obj_torbellino_res/Step_2.gml(1): 3
objects/obj_tuberia/Alarm_1.gml(1): 58
objects/obj_tuberia_res/Other_11.gml(1): 20
objects/obj_ubsi_snd_res/Other_11.gml(1): 6
objects/obj_uhh_snd_res/Other_11.gml(1): 6
objects/obj_veggiecoin/Step_0.gml(1): 8
objects/obj_ventana/Create_0.gml(1): 6
objects/obj_ventana_mario/Step_1.gml(1): 7
objects/obj_version/Create_0.gml(1): 3
objects/obj_vine/Create_0.gml(1): 1
objects/obj_vine_green/Create_0.gml(1): 1
objects/obj_vine_res/Step_2.gml(1): 1
objects/obj_vsync/Create_0.gml(1): 3
objects/obj_waddlewing/Alarm_10.gml(1): 5
objects/obj_waddlewing/Draw_0.gml(1): 4
objects/obj_waddlewing/Other_14.gml(1): 98
objects/obj_waddlewing/Other_17.gml(1): 1
objects/obj_waddlewing_res/Create_0.gml(1): 5
objects/obj_waddlewing_res/Step_2.gml(1): 4
objects/obj_window_alert/Draw_0.gml(1): 1
objects/obj_window_button/Create_0.gml(1): 10
objects/obj_window_mario_button/Create_0.gml(1): 1
objects/obj_window_select/Mouse_4.gml(1): 13
objects/obj_wings_dead/Create_0.gml(1): 1
objects/obj_wings_dead/Step_0.gml(1): 42
objects/obj_wings_dead_b/Create_0.gml(1): 1
objects/obj_wings_dead_b/Step_0.gml(1): 42
objects/obj_wrench/Create_0.gml(1): 1
objects/obj_wrench/Step_0.gml(1): 3
objects/obj_yoshi2/Destroy_0.gml(1): 1
objects/obj_yoshi2/Other_12.gml(1): 25
objects/obj_yoshi_abandon/Collision_obj_mario.gml(1): 2
objects/obj_yoshi_abandon/Other_14.gml(1): 85
objects/obj_yoshi_runaway/Create_0.gml(1): 17
rooms/rm_editor/InstanceCreationCode_inst_186BE.gml(1): 2
scripts/LoadJSONFromFile/LoadJSONFromFile.gml(1): 9
scripts/action_set_motion/action_set_motion.gml(1): 7
scripts/discord_free_app/discord_free_app.gml(1): 2
scripts/discord_init_app/discord_init_app.gml(1): 2
scripts/discord_update_presence/discord_update_presence.gml(1): 2
scripts/scr_NSMBU_acrouch/scr_NSMBU_acrouch.gml(1): 4
scripts/scr_NSMBU_airspin1/scr_NSMBU_airspin1.gml(1): 4
scripts/scr_NSMBU_climb_pole/scr_NSMBU_climb_pole.gml(1): 3
scripts/scr_NSMBU_crouch/scr_NSMBU_crouch.gml(1): 4
scripts/scr_NSMBU_crouch_fall/scr_NSMBU_crouch_fall.gml(1): 4
scripts/scr_NSMBU_crouch_idle/scr_NSMBU_crouch_idle.gml(1): 4
scripts/scr_NSMBU_crouch_jump/scr_NSMBU_crouch_jump.gml(1): 4
scripts/scr_NSMBU_drill_spin/scr_NSMBU_drill_spin.gml(1): 3
scripts/scr_NSMBU_flip/scr_NSMBU_flip.gml(1): 3
scripts/scr_NSMBU_flip_start/scr_NSMBU_flip_start.gml(1): 3
scripts/scr_NSMBU_goal_pole/scr_NSMBU_goal_pole.gml(1): 3
scripts/scr_NSMBU_groundpound/scr_NSMBU_groundpound.gml(1): 3
scripts/scr_NSMBU_groundpound_canceled/scr_NSMBU_groundpound_canceled.gml(1): 3
scripts/scr_NSMBU_hold/scr_NSMBU_hold.gml(1): 3
scripts/scr_NSMBU_hold_airspin/scr_NSMBU_hold_airspin.gml(1): 3
scripts/scr_NSMBU_hold_ground/scr_NSMBU_hold_ground.gml(1): 3
scripts/scr_NSMBU_hold_jump/scr_NSMBU_hold_jump.gml(1): 3
scripts/scr_NSMBU_hold_spinjump/scr_NSMBU_hold_spinjump.gml(1): 3
scripts/scr_NSMBU_jump1/scr_NSMBU_jump1.gml(1): 4
scripts/scr_NSMBU_jump2/scr_NSMBU_jump2.gml(1): 4
scripts/scr_NSMBU_jump3/scr_NSMBU_jump3.gml(1): 4
scripts/scr_NSMBU_jump_star/scr_NSMBU_jump_star.gml(1): 3
scripts/scr_NSMBU_marioclimb_start/scr_NSMBU_marioclimb_start.gml(1): 3
scripts/scr_NSMBU_run/scr_NSMBU_run.gml(1): 4
scripts/scr_NSMBU_runmax/scr_NSMBU_runmax.gml(1): 4
scripts/scr_NSMBU_skid/scr_NSMBU_skid.gml(1): 4
scripts/scr_NSMBU_skid_left/scr_NSMBU_skid_left.gml(1): 4
scripts/scr_NSMBU_skid_right/scr_NSMBU_skid_right.gml(1): 4
scripts/scr_NSMBU_spincrouch/scr_NSMBU_spincrouch.gml(1): 3
scripts/scr_NSMBU_spinjump/scr_NSMBU_spinjump.gml(1): 4
scripts/scr_NSMBU_standup/scr_NSMBU_standup.gml(1): 3
scripts/scr_NSMBU_standup_pole/scr_NSMBU_standup_pole.gml(1): 3
scripts/scr_NSMBU_stun/scr_NSMBU_stun.gml(1): 3
scripts/scr_NSMBU_swim/scr_NSMBU_swim.gml(1): 3
scripts/scr_NSMBU_swim2/scr_NSMBU_swim2.gml(1): 3
scripts/scr_NSMBU_swim_fall/scr_NSMBU_swim_fall.gml(1): 3
scripts/scr_NSMBU_swim_hold/scr_NSMBU_swim_hold.gml(1): 3
scripts/scr_NSMBU_triple_jump0/scr_NSMBU_triple_jump0.gml(1): 3
scripts/scr_NSMBU_triple_jump1/scr_NSMBU_triple_jump1.gml(1): 3
scripts/scr_NSMBU_triple_jump2/scr_NSMBU_triple_jump2.gml(1): 3
scripts/scr_NSMBU_triple_jump3/scr_NSMBU_triple_jump3.gml(1): 3
scripts/scr_NSMBU_walkhold/scr_NSMBU_walkhold.gml(1): 3
scripts/scr_NSMBU_walkhome/scr_NSMBU_walkhome.gml(1): 4
scripts/scr_NSMBU_walkpipes/scr_NSMBU_walkpipes.gml(1): 3
scripts/scr_NSMBU_wall_slide/scr_NSMBU_wall_slide.gml(1): 4
scripts/scr_canpull/scr_canpull.gml(1): 2
scripts/scr_mario_cap_fly/scr_mario_cap_fly.gml(1): 2
scripts/scr_mario_cap_fly_acender/scr_mario_cap_fly_acender.gml(1): 2
scripts/scr_mario_cap_fly_acender_decender/scr_mario_cap_fly_acender_decender.gml(1): 2
scripts/scr_mario_cap_fly_decender/scr_mario_cap_fly_decender.gml(1): 2
scripts/scr_mario_shoe_fall/scr_mario_shoe_fall.gml(1): 3
scripts/scr_marioswim2/scr_marioswim2.gml(1): 2
scripts/scr_marioswim3/scr_marioswim3.gml(1): 2
scripts/scr_marioswim_hold_idle/scr_marioswim_hold_idle.gml(1): 2
scripts/scr_marioswim_idle/scr_marioswim_idle.gml(1): 2
scripts/scr_meteorites_shard/scr_meteorites_shard.gml(1): 2
scripts/scr_meteorites_shard_big/scr_meteorites_shard_big.gml(1): 2
scripts/scr_music_link/scr_music_link.gml(1): 2
scripts/scr_play_to_edit/scr_play_to_edit.gml(1): 517
scripts/scr_snd_bowserjr_shell/scr_snd_bowserjr_shell.gml(1): 2
scripts/scr_snd_break/scr_snd_break.gml(1): 2
scripts/scr_snd_bump/scr_snd_bump.gml(1): 2
scripts/scr_snd_clown_damage/scr_snd_clown_damage.gml(1): 2
scripts/scr_snd_clown_fire_charge/scr_snd_clown_fire_charge.gml(1): 2
scripts/scr_snd_coin/scr_snd_coin.gml(1): 2
scripts/scr_snd_door_close/scr_snd_door_close.gml(1): 2
scripts/scr_snd_door_open/scr_snd_door_open.gml(1): 2
scripts/scr_snd_editor_airship/scr_snd_editor_airship.gml(1): 2
scripts/scr_snd_editor_beach/scr_snd_editor_beach.gml(1): 2
scripts/scr_snd_editor_castle/scr_snd_editor_castle.gml(1): 2
scripts/scr_snd_editor_desert/scr_snd_editor_desert.gml(1): 2
scripts/scr_snd_editor_forest/scr_snd_editor_forest.gml(1): 2
scripts/scr_snd_editor_ghost/scr_snd_editor_ghost.gml(1): 2
scripts/scr_snd_editor_ground/scr_snd_editor_ground.gml(1): 2
scripts/scr_snd_editor_sky/scr_snd_editor_sky.gml(1): 2
scripts/scr_snd_editor_snow/scr_snd_editor_snow.gml(1): 2
scripts/scr_snd_editor_underground/scr_snd_editor_underground.gml(1): 2
scripts/scr_snd_editor_underwater/scr_snd_editor_underwater.gml(1): 2
scripts/scr_snd_editor_volcano/scr_snd_editor_volcano.gml(1): 2
scripts/scr_snd_explode/scr_snd_explode.gml(1): 2
scripts/scr_snd_getcheckpoint/scr_snd_getcheckpoint.gml(1): 2
scripts/scr_snd_hurryup/scr_snd_hurryup.gml(1): 2
scripts/scr_snd_kick/scr_snd_kick.gml(1): 2
scripts/scr_snd_meteorites_break/scr_snd_meteorites_break.gml(1): 2
scripts/scr_snd_oneway/scr_snd_oneway.gml(1): 2
scripts/scr_snd_pipes/scr_snd_pipes.gml(1): 2
scripts/scr_snd_powerup/scr_snd_powerup.gml(1): 2
scripts/scr_snd_pwarning/scr_snd_pwarning.gml(1): 2
scripts/scr_snd_skid/scr_snd_skid.gml(1): 2
scripts/scr_snd_soplete/scr_snd_soplete.gml(1): 4
scripts/scr_snd_spinjump/scr_snd_spinjump.gml(1): 2
scripts/scr_snd_spring/scr_snd_spring.gml(1): 2
scripts/scr_snd_sprout/scr_snd_sprout.gml(1): 2
scripts/scr_snd_starman/scr_snd_starman.gml(1): 2
scripts/scr_snd_stomp/scr_snd_stomp.gml(1): 3
scripts/scr_snd_switchalert/scr_snd_switchalert.gml(1): 2
scripts/scr_snd_switchsong/scr_snd_switchsong.gml(1): 2
scripts/scr_snd_thwomp/scr_snd_thwomp.gml(1): 2
scripts/scr_swim/scr_swim.gml(1): 2
scripts/scr_switchsong/scr_switchsong.gml(1): 2
scripts/scr_verify_pub/scr_verify_pub.gml(1): 9
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/cre_control/Create_0.gml:12 | `global.timer = 0` |
| objects/obj_bowser_dead_castle/Alarm_2.gml:3 | `if (global.bg_level == "forest")` |
| objects/obj_checkpoint/Create_0.gml:75 | `pink_coin5_y = global.pink_coin5_y` |
| objects/obj_donut/Create_0.gml:28 | `else if (global.bg_level == "underground" \|\| global.bg_level == "ghost" \|\| global.modo_noche == 1)` |
| objects/obj_ground3/Draw_0.gml:25 | `if (global.bg_level == "castle")` |
| objects/obj_levelmanager/Other_5.gml:26 | `global.condiciones_object = 0` |
| objects/obj_marioU/Other_12.gml:279 | `if (keyboard_check_pressed(global.saltar_spin) && disablecontrols == 0 && global.powerup == -30 && global.yoshi == 0 && isduck == 0 && walljump == 0 &…` |
| objects/obj_parent_resource/Other_12.gml:1 | `if (global.cursor == 2 and !place_meeting(x,y,obj_erase))` |
| objects/obj_pswitch/Step_0.gml:114 | `else if (instance_exists(obj_lava_water) && (bbox_bottom - 8) >= obj_lava_water.y && global.bg_level == "forest" && global.modo_noche == 1 && modo_lav…` |
| objects/obj_torbellino_res/Step_2.gml:3 | `switch global.apariencia` |
| scripts/__global_object_depths/__global_object_depths.gml:475 | `global.__objectDepths[468] = -12; // obj_card_autoavance` |
| scripts/__global_object_depths/__global_object_depths.gml:1138 | `global.__objectNames[334] = "obj_splash_agua";` |
| scripts/scr_edit_to_play/scr_edit_to_play.gml:249 | `else if (global.apariencia == 2)` |
| scripts/scr_mariorun/scr_mariorun.gml:2 | `if (global.apariencia == 1)` |

### 3.8 ds_*

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| ds_*: `\bds_(map\|list\|grid\|stack\|queue\|priority)_\w+` | 598 | 19 |
| **并集（本类合计）** | **598** | **19** |

<details><summary>按文件完整索引（19 个文件，598 行命中）</summary>

```
objects/obj_button_notification_aceptar/Other_10.gml(136): 11,12,13,14,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,…+116
objects/obj_button_save_changes/Other_10.gml(136): 11,12,13,14,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,…+116
objects/obj_load_level/Other_10.gml(129): 7,8,9,10,12,23,26,29,34,38,43,48,49,52,59,60,61,65,66,67,…+109
objects/obj_load_guardabot/Other_11.gml(128): 8,14,16,23,25,31,32,37,40,43,46,60,63,64,65,66,76,77,80,81,…+108
objects/obj_gb_level/Create_0.gml(18): 62,63,64,65,66,67,76,77,78,79,80,126,127,128,129,130,131,135
objects/obj_dcw/Create_0.gml(13): 84,90,94,97,101,104,107,110,114,117,121,124,127
objects/obj_iname/Other_63.gml(4): 1,4,6,8
objects/obj_input/Other_63.gml(4): 1,4,6,8
objects/obj_input_desc/Other_63.gml(4): 1,4,6,8
objects/obj_input_rename/Other_63.gml(4): 1,4,6,8
objects/obj_lun/Other_63.gml(4): 1,4,6,8
objects/obj_rename/Other_63.gml(4): 1,4,6,8
objects/obj_rename_input/Other_63.gml(4): 1,4,6,8
objects/obj_guardabot/Create_0.gml(3): 19,30,31
objects/obj_guardabot/Other_10.gml(3): 2,5,9
objects/obj_dcw/Destroy_0.gml(1): 1
objects/obj_dcw/Other_10.gml(1): 3
objects/obj_guardabot/Other_5.gml(1): 1
objects/obj_persistent/Create_0.gml(1): 69
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_button_notification_aceptar/Other_10.gml:11 | `var _root_list2 = ds_list_create()` |
| objects/obj_button_notification_aceptar/Other_10.gml:85 | `ds_map_add(_map6, "sprite", sprite_get_name(sprite_index))` |
| objects/obj_button_notification_aceptar/Other_10.gml:142 | `var _root_list5 = ds_list_create()` |
| objects/obj_button_notification_aceptar/Other_10.gml:203 | `ds_map_add_list(_wrapper, "PUERTAS", _root_list8)` |
| objects/obj_button_save_changes/Other_10.gml:71 | `ds_map_add(_map3, "index", image_index)` |
| objects/obj_button_save_changes/Other_10.gml:132 | `ds_map_add(_map4, "t_y_pos", t_y_pos)` |
| objects/obj_button_save_changes/Other_10.gml:195 | `var _wrapper = ds_map_create()` |
| objects/obj_gb_level/Create_0.gml:127 | `global.condiciones_type = ds_map_find_value(_map, "condiciones_type")` |
| objects/obj_load_guardabot/Other_11.gml:64 | `global.condiciones_type = ds_map_find_value(_map, "condiciones_type")` |
| objects/obj_load_guardabot/Other_11.gml:144 | `for (l = 0; l < ds_list_size(_list4); l++)` |
| objects/obj_load_guardabot/Other_11.gml:198 | `o_objecto.u = ds_map_find_value(_map6, "up")` |
| objects/obj_load_level/Other_10.gml:52 | `room_width = ds_map_find_value(_map, "size")` |
| objects/obj_load_level/Other_10.gml:128 | `for (l = 0; l < ds_list_size(_list4); l++)` |
| objects/obj_load_level/Other_10.gml:182 | `o_objecto.d = ds_map_find_value(_map6, "down")` |

### 3.9 存档

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| file_*/ini_*/buffer_*/json_*/directory_*: `\b(file_\w+\|ini_\w+\|buffer_\w+\|json_\w+\|directory_\w+\|game_save\w*\|game_load\w*\|get_open_filename\w*\|get_save_filename\w*\|working_directory\|program_directory\|temp_directory\|LoadJSONFromFile\|SaveStringToFile\|zip_\w+\|base64_\w+)\b` | 182 | 20 |
| 名称含save/load的自定义调用: `\b(?!game_)\w*(save\|load)\w*\s*\(` | 5 | 5 |
| **并集（本类合计）** | **184** | **20** |

<details><summary>按文件完整索引（20 个文件，184 行命中）</summary>

```
objects/obj_persistent/Other_17.gml(46): 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,…+26
objects/obj_persistent/Other_2.gml(46): 21,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,…+26
scripts/scr_save/scr_save.gml(18): 1,3,4,5,6,7,8,9,10,11,12,13,14,15,18,19,20,22
scripts/scr_load/scr_load.gml(17): 1,2,3,4,5,6,7,8,9,10,11,12,13,14,18,19,21
scripts/sha1_string_utf8_hmac/sha1_string_utf8_hmac.gml(17): 9,10,11,16,19,22,23,24,26,27,28,29,31,32,33,34,35
scripts/LoadJSONFromFile/LoadJSONFromFile.gml(6): 1,4,5,6,12,13
objects/obj_button_notification_aceptar/Other_10.gml(5): 3,4,210,212,215
objects/obj_button_save_changes/Other_10.gml(5): 3,4,210,212,215
scripts/SaveStringToFile/SaveStringToFile.gml(5): 1,5,6,7,8
objects/obj_persistent/Create_0.gml(4): 133,137,138,139
scripts/scr_verify_pub/scr_verify_pub.gml(3): 4,5,6
objects/obj_gb_level/Create_0.gml(2): 47,49
objects/obj_load_guardabot/Other_11.gml(2): 5,7
objects/obj_load_level/Other_10.gml(2): 4,6
objects/obj_bt_gb_delete/Alarm_1.gml(1): 1
objects/obj_button_notification_aceptar/Mouse_4.gml(1): 8
objects/obj_button_save_changes/Mouse_4.gml(1): 9
objects/obj_dcw/Create_0.gml(1): 129
objects/obj_guardabot/Create_0.gml(1): 29
objects/obj_rename_button2/Mouse_4.gml(1): 5
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_bt_gb_delete/Alarm_1.gml:1 | `file_delete((global.directorio + global.levelguardabot))` |
| objects/obj_dcw/Create_0.gml:129 | `_embed = json_encode(_embed)` |
| objects/obj_persistent/Other_17.gml:3 | `file_text_write_string(file, string(fullscreen))` |
| objects/obj_persistent/Other_17.gml:16 | `file_text_writeln(file)` |
| objects/obj_persistent/Other_17.gml:29 | `file_text_write_string(file, string(global.name_user))` |
| objects/obj_persistent/Other_17.gml:42 | `file_text_writeln(file)` |
| objects/obj_persistent/Other_2.gml:29 | `file_text_readln(file)` |
| objects/obj_persistent/Other_2.gml:43 | `file_text_readln(file)` |
| objects/obj_persistent/Other_2.gml:56 | `global.audiomaster = real(file_text_read_string(file))` |
| scripts/LoadJSONFromFile/LoadJSONFromFile.gml:1 | `function LoadJSONFromFile(argument0) {` |
| scripts/scr_load/scr_load.gml:3 | `global.lives = real(base64_decode(file_text_read_string(file)))` |
| scripts/scr_load/scr_load.gml:19 | `file_text_readln(file)` |
| scripts/scr_save/scr_save.gml:13 | `file_text_writeln(file)` |
| scripts/sha1_string_utf8_hmac/sha1_string_utf8_hmac.gml:16 | `buffer_write(_key_buffer, buffer_u8, hex_string_byte(_sha1_key, _i))` |

### 3.10 异步

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| http_*/network_*/async_load等: `\b(http_\w+\|network_\w+\|async_load\|get_string_async\|get_integer_async\|get_login_async\|show_message_async\|get_open_filename_ext\|audio_\w*async\w*\|buffer_async_group\w*\|url_open\|steam_\w+)\b` | 44 | 21 |
| **并集（本类合计）** | **44** | **21** |

Other 事件 eventNum>=60（GMS 将 60 以上编号用于 Async 事件；具体编号→种类的对应未在本项目中验证，见 §6）：9 个事件，分布于 8 个 object（路径 `objects/<object>/<事件文件>.gml`，来源 `objects/<object>/<object>.yy` 的 `eventList`）：

<details><summary>展开 object → 事件列表</summary>

```
obj_iname: Other_63
obj_input: Other_63
obj_input_desc: Other_63
obj_input_rename: Other_63
obj_lun: Other_63
obj_persistent: Other_60, Other_70
obj_rename: Other_63
obj_rename_input: Other_63
```
</details>

<details><summary>按文件完整索引（21 个文件，44 行命中）</summary>

```
objects/obj_iname/Other_63.gml(4): 1,4,6,8
objects/obj_input/Other_63.gml(4): 1,4,6,8
objects/obj_input_desc/Other_63.gml(4): 1,4,6,8
objects/obj_input_rename/Other_63.gml(4): 1,4,6,8
objects/obj_lun/Other_63.gml(4): 1,4,6,8
objects/obj_rename/Other_63.gml(4): 1,4,6,8
objects/obj_rename_input/Other_63.gml(4): 1,4,6,8
objects/obj_persistent/Other_60.gml(2): 3,4
objects/obj_persistent/Other_70.gml(2): 3,15
objects/obj_btn_social/Mouse_4.gml(1): 1
objects/obj_create_account/Mouse_4.gml(1): 1
objects/obj_dcw/Create_0.gml(1): 139
objects/obj_iname/Mouse_4.gml(1): 2
objects/obj_input/Mouse_4.gml(1): 2
objects/obj_input_desc/Mouse_4.gml(1): 2
objects/obj_input_rename/Mouse_4.gml(1): 2
objects/obj_lp/Mouse_4.gml(1): 2
objects/obj_lun/Mouse_4.gml(1): 2
objects/obj_rename/Mouse_4.gml(1): 2
objects/obj_rename_input/Mouse_4.gml(1): 2
scripts/has_internet/has_internet.gml(1): 2
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/obj_btn_social/Mouse_4.gml:1 | `url_open(link)` |
| objects/obj_iname/Mouse_4.gml:2 | `texto = get_string_async("Nombre", texto)` |
| objects/obj_iname/Other_63.gml:6 | `if (ds_map_find_value(async_load, "result") != "")` |
| objects/obj_input/Other_63.gml:1 | `var i_d = ds_map_find_value(async_load, "id")` |
| objects/obj_input/Other_63.gml:8 | `text_temp = ds_map_find_value(async_load, "result")` |
| objects/obj_input_desc/Other_63.gml:4 | `if ds_map_find_value(async_load, "status")` |
| objects/obj_input_rename/Mouse_4.gml:2 | `texto = get_string_async(scr_language(87), texto)` |
| objects/obj_input_rename/Other_63.gml:8 | `text_temp = ds_map_find_value(async_load, "result")` |
| objects/obj_lun/Other_63.gml:1 | `var i_d = ds_map_find_value(async_load, "id")` |
| objects/obj_lun/Other_63.gml:8 | `var text_temp = ds_map_find_value(async_load, "result")` |
| objects/obj_persistent/Other_70.gml:3 | `var ev_type = async_load[? "event_type"];` |
| objects/obj_rename/Other_63.gml:1 | `var i_d = ds_map_find_value(async_load, "id")` |
| objects/obj_rename/Other_63.gml:8 | `var text_temp = ds_map_find_value(async_load, "result")` |
| objects/obj_rename_input/Other_63.gml:4 | `if ds_map_find_value(async_load, "status")` |

### 3.11 视图

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| view_*/camera_*/window_*/display_*/room_set_*: `\b(view_\w+\|camera_\w+\|window_\w+\|display_\w+\|room_set_view\w*\|room_set_camera\|__view_get\|__view_set\|__view_set_internal\|gui_\w+\|browser_\w+)\b` | 1275 | 320 |
| **并集（本类合计）** | **1275** | **320** |

<details><summary>按文件完整索引（320 个文件，1275 行命中）</summary>

```
objects/obj_levelmanager/Other_21.gml(96): 7,8,9,10,11,12,13,16,18,21,22,23,24,25,26,27,31,32,33,34,…+76
objects/obj_lighting/Step_0.gml(53): 6,15,19,24,28,34,38,43,47,52,56,61,65,70,74,79,83,94,96,98,…+33
objects/obj_editormanager/Step_1.gml(35): 13,15,19,21,25,27,31,33,40,42,46,48,52,54,58,60,73,74,76,77,…+15
objects/obj_levelmanager/Step_2.gml(33): 48,57,59,62,71,73,76,81,102,113,115,118,127,129,132,137,166,168,171,188,…+13
objects/obj_persistent/Draw_0.gml(27): 6,16,18,20,22,24,26,28,30,33,35,42,46,50,52,54,56,58,60,62,…+7
objects/obj_menu_pausa/Draw_0.gml(24): 7,10,12,17,18,19,20,21,22,23,24,25,26,27,60,61,62,63,64,65,…+4
objects/obj_levelmanager/Other_18.gml(20): 1,3,7,9,13,15,81,84,86,97,100,102,115,117,120,126,128,131,133,136
objects/obj_settings_panel/Create_0.gml(20): 95,96,97,99,101,102,103,104,105,111,117,123,129,137,143,149,155,161,169,170
objects/obj_settings_panel/Other_10.gml(20): 1,2,3,5,7,8,9,10,11,17,23,29,35,43,49,55,61,67,75,77
objects/obj_window_alert/Create_0.gml(19): 5,6,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,38
objects/obj_title_controller/Draw_0.gml(18): 1,2,3,4,5,6,7,8,9,10,11,12,17,18,20,21,23,25
scripts/__view_get/__view_get.gml(18): 1,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
scripts/__view_set_internal/__view_set_internal.gml(18): 1,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24
objects/obj_mariostart/Draw_0.gml(17): 7,13,14,15,16,17,18,19,20,26,27,28,29,30,31,32,46
objects/obj_bg_selection/Other_7.gml(14): 5,13,21,29,37,45,53,61,69,77,85,93,101,109
objects/obj_gb_level/Draw_0.gml(13): 7,8,10,14,15,17,19,20,21,22,23,26,27
objects/obj_levelmanager/Other_19.gml(13): 22,23,25,30,31,33,35,39,41,43,44,45,47
objects/obj_login_control/Draw_0.gml(13): 1,2,3,4,5,6,7,8,9,10,11,12,13
objects/obj_levelmanager/Other_20.gml(12): 7,8,13,14,15,16,20,22,25,27,28,30
objects/obj_settings_panel/Draw_0.gml(11): 3,4,6,9,10,11,12,13,14,16,21
objects/obj_bowserfire_up/Alarm_0.gml(10): 3,4,5,6,7,11,12,13,14,15
objects/obj_bowserfire_up/Other_11.gml(10): 3,4,5,6,7,11,12,13,14,15
objects/obj_cursor/Step_1.gml(10): 20,27,60,67,97,104,134,141,171,178
objects/obj_editormanager/Step_0.gml(10): 3,16,18,22,24,35,37,45,47,58
objects/obj_panel_circle/Other_12.gml(10): 7,23,44,53,60,67,74,89,96,103
objects/obj_block_pow_active/Alarm_0.gml(9): 6,17,19,24,35,46,57,68,82
objects/obj_menu_pausa/Create_0.gml(9): 70,71,77,86,87,94,97,98,102
objects/obj_panel_expand/Create_0.gml(9): 213,214,216,218,220,222,223,225,227
objects/obj_angrysun/Step_0.gml(8): 4,5,13,14,26,27,31,32
objects/obj_card_item/Draw_0.gml(8): 3,4,5,7,11,12,13,14
objects/obj_panel_circle/Other_10.gml(8): 7,15,24,31,54,61,73,85
objects/obj_panel_circle/Other_11.gml(8): 7,15,22,29,36,43,64,71
objects/obj_panel_circle/Other_14.gml(8): 7,23,30,37,44,51,80,87
objects/obj_panel_circle/Other_15.gml(8): 7,23,30,37,50,57,65,72
objects/obj_panel_circle/Other_20.gml(8): 7,15,41,56,63,70,85,92
objects/obj_panel_left/Create_0.gml(8): 1,2,3,4,5,6,7,8
objects/obj_persistent/Other_4.gml(8): 1,2,3,4,5,6,7,8
objects/obj_settings_custom/Other_10.gml(8): 1,7,13,19,25,31,37,44
objects/obj_condiciones/Other_7.gml(7): 6,12,18,25,34,40,46
objects/obj_edit_menu/Create_0.gml(7): 5,8,16,26,27,29,31
objects/obj_intro_controller/Other_4.gml(7): 4,7,10,19,22,32,35
objects/obj_lakitu/Step_0.gml(7): 16,18,47,50,52,55,57
objects/obj_panel_circle/Other_13.gml(7): 7,24,39,54,62,77,84
objects/obj_panel_circle/Other_16.gml(7): 7,17,24,31,38,50,57
objects/obj_panel_circle/Other_18.gml(7): 7,16,24,32,40,48,56
objects/obj_panel_circle/Other_19.gml(7): 7,18,33,48,63,88,103
objects/obj_panel_circle/Other_21.gml(7): 7,23,38,46,53,60,67
objects/obj_panel_circle/Other_22.gml(7): 7,15,30,38,45,52,63
objects/obj_bowser_fire_down/Other_14.gml(6): 9,11,13,15,17,29
objects/obj_clown/Step_0.gml(6): 14,16,20,22,146,147
objects/obj_editormanager/Create_0.gml(6): 1,2,3,7,39,40
objects/obj_guardabot/Draw_0.gml(6): 3,4,5,7,8,10
objects/obj_mario/Step_0.gml(6): 415,416,424,425,433,434
objects/obj_marioU/Step_0.gml(6): 346,347,355,356,364,365
objects/obj_panel_circle/Other_17.gml(6): 7,15,22,29,36,43
objects/obj_play_screen/Draw_0.gml(6): 3,4,7,12,13,16
objects/obj_sidefade/Draw_0.gml(6): 3,4,5,6,10,15
objects/obj_autoavance/Other_7.gml(5): 5,13,24,35,46
objects/obj_autoscroll/Step_0.gml(5): 11,22,27,38,43
objects/obj_creator_jugar_editar/Other_13.gml(5): 40,44,48,56,305
objects/obj_editormanager/Draw_0.gml(5): 5,7,8,21,25
objects/obj_gb_level/Create_0.gml(5): 2,3,4,5,6
objects/obj_levelmanager/Create_0.gml(5): 10,20,21,38,52
objects/obj_persistent/Alarm_11.gml(5): 3,4,5,7,12
scripts/outside_view_modelsizable/outside_view_modelsizable.gml(5): 3,4,5,6,19
objects/obj_alert_condicion/Draw_0.gml(4): 1,2,5,9
objects/obj_apariencia/Other_7.gml(4): 5,12,19,26
objects/obj_bg1/Mouse_4.gml(4): 21,48,75,105
objects/obj_button_home/Step_2.gml(4): 3,7,10,13
objects/obj_card_rocket/Draw_0.gml(4): 1,3,5,7
objects/obj_cloud_lakitu/Step_0.gml(4): 12,14,18,20
objects/obj_editormanager/Alarm_2.gml(4): 7,9,12,34
objects/obj_header/Alarm_0.gml(4): 3,7,11,15
objects/obj_levelmanager/Other_17.gml(4): 6,7,20,21
objects/obj_load_guardabot/Other_11.gml(4): 351,355,359,381
objects/obj_load_guardabot/Other_12.gml(4): 289,321,353,388
objects/obj_load_image/Step_0.gml(4): 4,5,9,10
objects/obj_load_level/Other_11.gml(4): 350,380,410,443
objects/obj_mario_editor/Step_0.gml(4): 92,94,98,100
objects/obj_mariostart_m/Step_2.gml(4): 1,5,19,23
objects/obj_play_screen/Step_2.gml(4): 3,4,8,9
objects/obj_title_oprime/Mouse_4.gml(4): 8,9,36,37
objects/obj_title_oprime/Step_2.gml(4): 3,4,8,9
objects/obj_water_level_control/Draw_0.gml(4): 2,15,19,25
objects/obj_bg1/Draw_0.gml(3): 1,2,6
objects/obj_btn_header_1/Alarm_0.gml(3): 4,8,12
objects/obj_btn_header_2/Alarm_0.gml(3): 2,8,12
objects/obj_btn_header_3/Alarm_0.gml(3): 2,7,16
objects/obj_btn_header_4/Alarm_0.gml(3): 2,7,12
objects/obj_button_home/Draw_0.gml(3): 30,35,41
objects/obj_button_superado/Draw_0.gml(3): 1,5,10
objects/obj_call_mario/Mouse_4.gml(3): 5,6,7
objects/obj_card_autoavance/Draw_0.gml(3): 2,3,7
objects/obj_card_bg/Draw_0.gml(3): 2,3,7
objects/obj_card_condiciones/Draw_0.gml(3): 1,3,7
objects/obj_card_logo/Draw_0.gml(3): 1,2,6
objects/obj_condiciones/Draw_0.gml(3): 8,13,16
objects/obj_creator_jugar_editar/Draw_0.gml(3): 3,4,8
objects/obj_expand/Step_0.gml(3): 2,4,5
objects/obj_expand_paneles_top/Step_0.gml(3): 4,9,11
objects/obj_expand_panels/Step_0.gml(3): 1,5,10
objects/obj_expand_panels_left/Step_0.gml(3): 1,5,10
objects/obj_iname_control/Draw_0.gml(3): 5,8,9
objects/obj_lava_water/Draw_0.gml(3): 2,3,20
objects/obj_lighting/Draw_0.gml(3): 2,3,4
objects/obj_logo_game/Draw_0.gml(3): 2,3,7
objects/obj_mario/Other_18.gml(3): 11,22,33
objects/obj_modo_sonidos_control/Draw_0.gml(3): 2,14,18
objects/obj_panel_save_load/Other_7.gml(3): 5,6,7
objects/obj_panel_time/Draw_0.gml(3): 1,6,10
objects/obj_persistent/Other_11.gml(3): 2,3,4
objects/obj_rename_control/Create_0.gml(3): 12,13,14
objects/obj_rename_control/Draw_0.gml(3): 5,8,9
objects/obj_robot/Draw_0.gml(3): 2,3,7
objects/obj_score/Draw_0.gml(3): 1,9,11
objects/obj_time/Draw_0.gml(3): 10,16,17
objects/obj_time/Other_7.gml(3): 5,7,9
objects/obj_titlemenu_key/Draw_0.gml(3): 5,8,12
objects/obj_toast/Draw_0.gml(3): 1,2,5
objects/obj_water_level_control/Create_0.gml(3): 2,3,4
objects/obj_window_alert/Draw_0.gml(3): 3,4,5
scripts/__view_set/__view_set.gml(3): 1,6,8
objects/cre_control/Create_0.gml(2): 5,6
objects/obj_alert_load/Create_0.gml(2): 2,3
objects/obj_alert_message/Create_0.gml(2): 2,3
objects/obj_alert_message/Draw_0.gml(2): 1,6
objects/obj_angrysun/Draw_0.gml(2): 4,6
objects/obj_block_pow_active/Create_0.gml(2): 36,37
objects/obj_bt_close_water/Step_2.gml(2): 1,2
objects/obj_button_home/Mouse_4.gml(2): 34,46
objects/obj_button_meteoritos/Draw_0.gml(2): 1,6
objects/obj_button_meteoritos/Step_2.gml(2): 6,7
objects/obj_button_save_load/Mouse_4.gml(2): 11,22
objects/obj_button_sdog/Draw_0.gml(2): 1,4
objects/obj_button_sdog/Step_2.gml(2): 2,3
objects/obj_button_superado/Step_0.gml(2): 1,2
objects/obj_button_trail/Draw_0.gml(2): 1,4
objects/obj_button_trail/Step_2.gml(2): 2,3
objects/obj_card_autoavance/Step_0.gml(2): 1,2
objects/obj_card_bg/Step_0.gml(2): 1,2
objects/obj_card_block_sounds/Draw_0.gml(2): 1,5
objects/obj_card_block_sounds/Step_0.gml(2): 1,2
objects/obj_card_bout/Draw_0.gml(2): 1,5
objects/obj_card_bout/Step_0.gml(2): 5,6
objects/obj_card_condiciones/Step_0.gml(2): 1,2
objects/obj_card_item/Create_0.gml(2): 23,24
objects/obj_card_item/Step_0.gml(2): 1,2
objects/obj_card_rocket/Step_0.gml(2): 1,2
objects/obj_change_view/Step_2.gml(2): 1,2
objects/obj_cloud_lakitu/Other_14.gml(2): 51,52
objects/obj_creator_jugar_editar/Step_0.gml(2): 3,4
objects/obj_curtainin/Other_10.gml(2): 3,4
objects/obj_curtainin/Step_0.gml(2): 3,9
objects/obj_curtainout/Create_0.gml(2): 2,4
objects/obj_curtainout/Step_0.gml(2): 3,9
objects/obj_dog/Draw_0.gml(2): 1,5
objects/obj_dog/Step_0.gml(2): 1,2
objects/obj_edit_menu/Draw_0.gml(2): 1,2
objects/obj_editor_screen/Create_0.gml(2): 3,4
objects/obj_efecto_musica/Step_2.gml(2): 1,2
objects/obj_efecto_sonido/Step_2.gml(2): 3,4
objects/obj_enemyparent_held/Step_2.gml(2): 90,91
objects/obj_erase/Draw_0.gml(2): 1,5
objects/obj_erase/Step_0.gml(2): 1,2
objects/obj_expand/Draw_0.gml(2): 1,5
objects/obj_expand_paneles_top/Create_0.gml(2): 1,2
objects/obj_expand_panels/Create_0.gml(2): 1,2
objects/obj_expand_panels_left/Create_0.gml(2): 1,2
objects/obj_holdparent/Step_2.gml(2): 63,64
objects/obj_intro_controller/Step_2.gml(2): 3,17
objects/obj_lava_water/Create_0.gml(2): 3,9
objects/obj_lava_water/Step_0.gml(2): 2,79
objects/obj_levelmanager/KeyPress_13.gml(2): 7,10
objects/obj_logo_game/Step_0.gml(2): 1,2
objects/obj_magikoopa/Alarm_2.gml(2): 9,10
objects/obj_mariostart_m/Draw_0.gml(2): 14,15
objects/obj_menu_editor/Draw_0.gml(2): 1,5
objects/obj_menu_editor/Step_0.gml(2): 1,2
objects/obj_next_before/Other_10.gml(2): 25,54
objects/obj_panel_left/Step_0.gml(2): 1,2
objects/obj_panel_time/Step_0.gml(2): 1,2
objects/obj_play_screen/Create_0.gml(2): 3,4
objects/obj_robot/Step_0.gml(2): 1,2
objects/obj_rotten_signal/Step_0.gml(2): 7,8
objects/obj_score/Step_0.gml(2): 7,8
objects/obj_silbido/Step_0.gml(2): 1,2
objects/obj_skewertrunk/Other_14.gml(2): 49,61
objects/obj_title_oprime/Draw_0.gml(2): 2,5
objects/obj_toast/Step_0.gml(2): 3,4
objects/obj_water_level_control/Step_2.gml(2): 1,2
objects/obj_water_move/Draw_0.gml(2): 1,2
objects/obj_water_move_limit/Draw_0.gml(2): 4,6
objects/obj_zoomclose/Step_0.gml(2): 1,2
scripts/init_shockwave/init_shockwave.gml(2): 9,10
objects/obj_SMB3_bowser/Step_0.gml(1): 71
objects/obj_alert_load/Draw_0.gml(1): 1
objects/obj_angrysun_res/Other_13.gml(1): 8
objects/obj_apariencia/Draw_0.gml(1): 6
objects/obj_apariencia/Mouse_4.gml(1): 1
objects/obj_autoavance/Draw_0.gml(1): 12
objects/obj_autoavance/Mouse_4.gml(1): 1
objects/obj_axe_smw/Alarm_3.gml(1): 13
objects/obj_bg_selection/Draw_0.gml(1): 8
objects/obj_bg_selection/Mouse_4.gml(1): 1
objects/obj_bone/Step_0.gml(1): 1
objects/obj_bones_yoshi/Step_0.gml(1): 5
objects/obj_bones_yoshi_one/Step_0.gml(1): 5
objects/obj_bonus_or/Other_10.gml(1): 1
objects/obj_bouncycloud/Step_0.gml(1): 48
objects/obj_bowser_dead/Step_0.gml(1): 39
objects/obj_bowserfire_up/Step_0.gml(1): 2
objects/obj_brohammer/Step_0.gml(1): 28
objects/obj_brohammer_yoshi/Step_0.gml(1): 10
objects/obj_bt_close_water/Draw_0.gml(1): 1
objects/obj_bt_rename/Mouse_4.gml(1): 5
objects/obj_btn_header_1/Mouse_4.gml(1): 8
objects/obj_btn_header_2/Mouse_4.gml(1): 8
objects/obj_btn_header_3/Mouse_4.gml(1): 8
objects/obj_btn_header_4/Mouse_4.gml(1): 8
objects/obj_btn_invitado/Mouse_4.gml(1): 2
objects/obj_bullebill_base/Step_0.gml(1): 37
objects/obj_bullebill_base_red/Step_0.gml(1): 41
objects/obj_button_notification_aceptar/Mouse_4.gml(1): 12
objects/obj_button_save_changes/Mouse_4.gml(1): 10
objects/obj_card_autoavance/Mouse_4.gml(1): 16
objects/obj_card_bg/Mouse_4.gml(1): 16
objects/obj_card_block_sounds/Other_12.gml(1): 7
objects/obj_card_bout/Mouse_4.gml(1): 6
objects/obj_card_condiciones/Mouse_4.gml(1): 16
objects/obj_change_view/Draw_0.gml(1): 1
objects/obj_claw/Step_0.gml(1): 212
objects/obj_condiciones/Mouse_4.gml(1): 1
objects/obj_create_account/Mouse_4.gml(1): 2
objects/obj_curtainin/Create_0.gml(1): 2
objects/obj_curtainin/Draw_0.gml(1): 3
objects/obj_curtainout/Draw_0.gml(1): 2
objects/obj_efecto_musica/Draw_0.gml(1): 1
objects/obj_efecto_sonido/Draw_0.gml(1): 2
objects/obj_enemy_dead/Step_0.gml(1): 58
objects/obj_espina/Step_2.gml(1): 1
objects/obj_expand/Mouse_4.gml(1): 7
objects/obj_expand_paneles_top/Draw_0.gml(1): 6
objects/obj_expand_panels/Draw_0.gml(1): 6
objects/obj_expand_panels_left/Draw_0.gml(1): 6
objects/obj_fadein/Draw_0.gml(1): 4
objects/obj_firemaker/Create_0.gml(1): 15
objects/obj_firemaker/Step_2.gml(1): 1
objects/obj_flagpole/Alarm_0.gml(1): 14
objects/obj_gb_button/Mouse_4.gml(1): 14
objects/obj_goalcard/Alarm_2.gml(1): 14
objects/obj_goalgate/Alarm_1.gml(1): 14
objects/obj_guardabot/Create_0.gml(1): 10
objects/obj_guardabot/Other_10.gml(1): 8
objects/obj_hammer/Step_0.gml(1): 29
objects/obj_hawmask/Alarm_2.gml(1): 9
objects/obj_leafmaker/Create_0.gml(1): 30
objects/obj_leafmaker/Step_2.gml(1): 1
objects/obj_levelmanager/Alarm_4.gml(1): 5
objects/obj_lighting/Create_0.gml(1): 1
objects/obj_link_arrow/Step_0.gml(1): 35
objects/obj_load_image/Draw_0.gml(1): 2
objects/obj_logo_game/Mouse_4.gml(1): 16
objects/obj_mario/Alarm_0.gml(1): 2
objects/obj_mario/Create_0.gml(1): 47
objects/obj_mario/Other_11.gml(1): 10
objects/obj_marioU/Other_11.gml(1): 9
objects/obj_mario_transform2/Draw_0.gml(1): 5
objects/obj_mariostart/Alarm_0.gml(1): 10
objects/obj_menu_editor/Mouse_4.gml(1): 4
objects/obj_menu_editor_ext/Mouse_4.gml(1): 4
objects/obj_meteorites_maker/Alarm_1.gml(1): 4
objects/obj_meteorites_maker/Alarm_10.gml(1): 3
objects/obj_meteorites_maker/Alarm_2.gml(1): 3
objects/obj_meteorites_maker/Alarm_3.gml(1): 3
objects/obj_meteorites_maker/Alarm_4.gml(1): 3
objects/obj_meteorites_maker/Alarm_5.gml(1): 3
objects/obj_meteorites_maker/Alarm_6.gml(1): 3
objects/obj_meteorites_maker/Alarm_7.gml(1): 3
objects/obj_meteorites_maker/Alarm_8.gml(1): 3
objects/obj_meteorites_maker/Alarm_9.gml(1): 3
objects/obj_modelsolid/Draw_0.gml(1): 1
objects/obj_night_change/Other_13.gml(1): 8
objects/obj_noteblock/Other_14.gml(1): 2
objects/obj_panel_circle/Draw_0.gml(1): 3
objects/obj_panel_circle/Other_23.gml(1): 7
objects/obj_panel_expand/Draw_0.gml(1): 1
objects/obj_panel_left/Draw_0.gml(1): 1
objects/obj_panel_save_load/Draw_0.gml(1): 10
objects/obj_panel_save_load/Mouse_4.gml(1): 1
objects/obj_panel_time/Mouse_4.gml(1): 16
objects/obj_paracaidas_dead/Step_0.gml(1): 4
objects/obj_persistent/Alarm_2.gml(1): 2
objects/obj_persistent/Alarm_4.gml(1): 40
objects/obj_persistent/Alarm_5.gml(1): 4
objects/obj_platform_help/Step_2.gml(1): 3
objects/obj_play_screen/Other_10.gml(1): 3
objects/obj_player_goal_smb1/Alarm_2.gml(1): 9
objects/obj_podoboo/Alarm_1.gml(1): 1
objects/obj_rainmaker/Create_0.gml(1): 12
objects/obj_rainmaker/Step_2.gml(1): 1
objects/obj_robot/Mouse_4.gml(1): 12
objects/obj_rorock/Step_0.gml(1): 1
objects/obj_settings_button/Mouse_4.gml(1): 7
objects/obj_settings_controls/Draw_0.gml(1): 3
objects/obj_skewertrunk/Other_12.gml(1): 49
objects/obj_snowmaker/Create_0.gml(1): 66
objects/obj_snowmaker/Step_2.gml(1): 1
objects/obj_st_slider/Draw_0.gml(1): 8
objects/obj_time/Mouse_4.gml(1): 1
objects/obj_timeup/Draw_0.gml(1): 1
objects/obj_title_controller/Create_0.gml(1): 15
objects/obj_water_move/Step_2.gml(1): 7
objects/obj_water_move_limit/Step_2.gml(1): 1
objects/obj_wrench/Step_0.gml(1): 1
objects/obj_yoshifire/Other_40.gml(1): 1
objects/obj_yoshifire/Step_0.gml(1): 1
objects/obj_zoomclose/Draw_0.gml(1): 1
scripts/outside_view/outside_view.gml(1): 3
scripts/scr_insideview/scr_insideview.gml(1): 2
scripts/scr_lose_condition/scr_lose_condition.gml(1): 9
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/cre_control/Create_0.gml:5 | `x_pos = (camera_get_view_x(view_get_camera(0)) + (camera_get_view_width(view_get_camera(0)) / 2))` |
| objects/obj_bowserfire_up/Alarm_0.gml:4 | `instance_create((pos + 16), (camera_get_view_y(view_get_camera(0)) - 44), obj_bowser_fire_down)` |
| objects/obj_card_block_sounds/Draw_0.gml:5 | `scr_anim_hover((camera_get_view_x(view_get_camera(0)) + 6), ((camera_get_view_y(view_get_camera(0)) + 5) - obj_cursor.anim_top), anim, 2)` |
| objects/obj_curtainout/Create_0.gml:4 | `surf = surface_create(camera_get_view_width(view_get_camera(0)), camera_get_view_height(view_get_camera(0)))` |
| objects/obj_erase/Step_0.gml:2 | `y = (camera_get_view_y(view_get_camera(0)) + 129)` |
| objects/obj_lava_water/Step_0.gml:2 | `x = camera_get_view_x(view_get_camera(0))` |
| objects/obj_levelmanager/Other_21.gml:57 | `__background_set( e__BG.X, 0, (camera_get_view_x(view_get_camera(0)) * 0.9) )` |
| objects/obj_levelmanager/Step_2.gml:207 | `if (obj_mario_pballon.x < (camera_get_view_x(view_get_camera(0)) + 5))` |
| objects/obj_login_control/Draw_0.gml:9 | `draw_sprite(spr_letters_white, 1, (camera_get_view_x(view_get_camera(0)) + 218), (camera_get_view_y(view_get_camera(0)) + 57))` |
| objects/obj_menu_pausa/Draw_0.gml:61 | `draw_text((camera_get_view_x(view_get_camera(0)) + 16), (camera_get_view_y(view_get_camera(0)) + 26), string_hash_to_newline(level))` |
| objects/obj_panel_circle/Other_18.gml:16 | `with (instance_create((camera_get_view_x(view_get_camera(0)) + 218), (camera_get_view_y(view_get_camera(0)) + 74), obj_card_circle))` |
| objects/obj_persistent/Draw_0.gml:52 | `draw_sprite_ext(spr_key_al_sm4j, 0, (camera_get_view_x(view_get_camera(0)) + 320), (camera_get_view_y(view_get_camera(0)) + 30), 1, 1, 0, c_white, 0.2…` |
| objects/obj_settings_panel/Create_0.gml:170 | `instance_create((camera_get_view_x(view_get_camera(0)) + 263), (camera_get_view_y(view_get_camera(0)) + 186), obj_button_settings_close)` |
| objects/obj_water_level_control/Create_0.gml:2 | `instance_create((camera_get_view_x(view_get_camera(0)) + 350), (camera_get_view_y(view_get_camera(0)) + 19), obj_bt_close_water)` |

### 3.12 音频

| 子正则（Python re） | 命中行数 | 涉及文件数 |
|---|---|---|
| audio_*/sound_*: `\b(audio_\w+\|sound_\w+)\b` | 2598 | 872 |
| **并集（本类合计）** | **2598** | **872** |

<details><summary>按文件完整索引（872 个文件，2598 行命中）</summary>

```
scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml(61): 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,…+41
objects/obj_levelmanager/Step_2.gml(58): 12,13,14,15,16,17,18,19,40,306,310,312,313,314,315,316,317,323,324,325,…+38
objects/obj_menu_pausa/Create_0.gml(47): 20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,…+27
scripts/scr_musicalscale/scr_musicalscale.gml(42): 9,15,21,27,33,39,45,52,53,65,67,102,103,116,122,128,134,140,146,152,…+22
objects/obj_marioU/Other_12.gml(35): 60,124,127,135,162,226,228,230,267,293,294,299,331,332,343,344,345,346,347,348,…+15
objects/obj_menu_pausa/Other_10.gml(32): 13,14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,…+12
objects/obj_menu_pausa/Other_11.gml(32): 42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,…+12
objects/obj_mario/Other_13.gml(22): 10,17,24,31,76,77,87,88,104,105,118,119,131,179,180,194,195,238,298,299,…+2
objects/obj_creator_jugar_editar/Other_13.gml(21): 125,127,134,137,140,143,148,149,150,151,152,153,154,182,250,259,262,263,265,266,…+1
objects/obj_marioU/Step_2.gml(19): 10,11,59,67,90,199,340,519,1027,1028,1248,1249,1257,1258,1419,1422,1423,1424,1426
objects/obj_boo/Other_18.gml(18): 34,35,37,46,47,49,61,62,64,73,74,76,86,87,89,99,100,102
scripts/scr_musicalscale_kick/scr_musicalscale_kick.gml(18): 25,31,37,43,49,55,61,68,69,82,88,94,100,106,112,118,125,126
objects/obj_card_circle/Other_10.gml(16): 1,2,3,4,5,6,7,8,10,12,14,16,18,20,22,24
objects/obj_deadmario/Create_0.gml(16): 5,7,11,25,26,27,28,29,30,31,32,33,34,35,36,37
objects/obj_menu_pausa/Other_12.gml(16): 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
objects/obj_powerupparent/Collision_obj_mario.gml(16): 39,40,44,45,49,50,72,73,89,90,94,95,102,103,107,108
objects/obj_marioU/Other_13.gml(15): 27,28,57,58,111,156,157,172,173,220,221,265,271,272,302
objects/obj_marioU/Step_0.gml(15): 23,24,91,92,233,235,236,287,288,289,303,304,379,380,431
scripts/scr_snd_pink_coins/scr_snd_pink_coins.gml(15): 7,10,13,16,19,27,30,33,36,39,47,50,53,56,59
objects/obj_levelmanager/Other_5.gml(14): 3,4,9,10,11,12,13,14,15,16,17,18,19,20
objects/obj_button_home/Mouse_4.gml(13): 4,5,6,7,8,9,10,11,12,13,14,24,53
objects/obj_mario/Other_12.gml(12): 64,72,80,90,152,184,252,525,552,576,760,761
objects/obj_thwomp_b/Step_0.gml(12): 41,42,67,68,133,134,145,146,208,209,220,221
objects/obj_clown/Step_0.gml(11): 89,90,108,109,123,156,157,236,237,238,240
objects/obj_mario/Step_0.gml(11): 251,253,254,318,319,320,332,333,448,449,495
objects/obj_shell/Collision_obj_mario.gml(11): 12,26,33,44,75,76,99,101,104,111,128
objects/obj_bowser_dead_castle/Alarm_1.gml(10): 5,6,9,10,13,14,17,18,19,20
objects/obj_editor_screen/Other_12.gml(10): 1,2,3,4,5,6,7,8,9,11
objects/obj_kuribo_drybones/Step_2.gml(10): 95,96,100,101,105,106,134,169,184,185
objects/obj_NSMBU_boomboom/Step_2.gml(9): 50,51,52,61,62,63,69,70,72
objects/obj_NSMBU_boomboom_b/Step_2.gml(9): 58,59,60,69,70,71,77,78,80
objects/obj_bumper/Collision_obj_mario.gml(9): 4,6,8,20,21,25,26,30,31
objects/obj_door_lock/Step_0.gml(9): 42,43,45,46,108,111,114,117,162
objects/obj_door_lock_exit/Step_0.gml(9): 42,43,45,46,108,111,114,117,161
objects/obj_mario/Step_2.gml(9): 80,109,164,191,192,400,446,671,765
objects/obj_mushroom_platform_res/Step_2.gml(9): 13,14,23,24,33,34,44,45,69
objects/obj_pokey_res/Step_2.gml(9): 35,36,46,47,57,58,66,67,94
objects/obj_selecting_player/Mouse_4.gml(9): 9,10,11,12,13,18,22,26,30
objects/obj_semisolid_platform1/Step_2.gml(9): 13,14,23,24,33,34,44,45,69
objects/obj_vine_res/Step_2.gml(9): 23,24,34,35,45,46,54,55,80
scripts/scr_NSMBU_musicalscale_minirebote/scr_NSMBU_musicalscale_minirebote.gml(9): 8,14,20,26,32,38,44,51,52
scripts/scr_NSMBU_musicalscale_rebote/scr_NSMBU_musicalscale_rebote.gml(9): 8,14,20,26,32,38,44,51,52
scripts/scr_NSMBU_spinstomp/scr_NSMBU_spinstomp.gml(9): 8,14,20,26,32,38,44,51,52
scripts/scr_musicalscale_SMB/scr_musicalscale_SMB.gml(9): 8,14,20,26,32,38,44,51,52
scripts/scr_musicalscale_SMB3/scr_musicalscale_SMB3.gml(9): 8,14,20,26,32,38,44,51,52
objects/obj_NSMBU_bowser/Other_14.gml(8): 22,23,30,31,88,89,101,102
objects/obj_block_pow_active/Create_0.gml(8): 5,6,10,11,15,16,20,21
objects/obj_bossparent/Other_25.gml(8): 4,5,8,9,12,13,16,17
objects/obj_bowserjr_dead_castle/Alarm_1.gml(8): 5,6,9,10,13,14,17,18
objects/obj_cap/Collision_obj_mario.gml(8): 28,43,58,63,80,97,113,118
objects/obj_claw/Other_10.gml(8): 4,5,8,9,12,13,16,17
objects/obj_claw/Other_11.gml(8): 4,5,8,9,12,13,16,17
objects/obj_clown_fire/Step_1.gml(8): 6,8,19,20,41,43,44,45
objects/obj_coin_pow/Collision_obj_mario.gml(8): 3,4,17,18,21,22,25,26
objects/obj_enemy_dead_castle/Alarm_1.gml(8): 5,6,9,10,13,14,17,18
objects/obj_enemyfrozen/Other_18.gml(8): 4,5,8,9,12,13,16,17
objects/obj_enemyparent/Collision_obj_mario.gml(8): 61,74,88,89,115,125,126,197
objects/obj_frozenmario/Other_11.gml(8): 4,5,8,9,12,13,16,17
objects/obj_icicle/Alarm_0.gml(8): 4,5,8,9,12,13,16,17
objects/obj_icicle/Other_10.gml(8): 4,5,8,9,12,13,16,17
objects/obj_kuriboshoe/Alarm_0.gml(8): 45,46,50,51,105,106,160,161
objects/obj_magikoopa/Alarm_0.gml(8): 6,7,10,11,14,15,18,19
objects/obj_mini_icicle/Other_10.gml(8): 4,5,8,9,12,13,16,17
objects/obj_next_before/Other_10.gml(8): 7,8,12,13,36,37,41,42
objects/obj_superball/Step_0.gml(8): 8,9,15,16,46,47,53,54
objects/obj_1up/Collision_obj_mario.gml(7): 7,31,32,35,36,39,40
objects/obj_link/Collision_obj_mario.gml(7): 10,11,12,13,14,18,21
objects/obj_mario/Other_10.gml(7): 61,70,89,97,114,133,181
objects/obj_player_goal_smw_castle/Alarm_6.gml(7): 1,7,9,12,15,18,34
objects/obj_yoshi2/Other_10.gml(7): 2,29,33,41,115,119,127
objects/obj_SMB2_mushroom/Collision_obj_mario.gml(6): 35,36,46,47,52,53
objects/obj_SMB2_mushroom/Step_0.gml(6): 45,46,58,59,67,68
objects/obj_SMB_bowser/Other_14.gml(6): 28,29,75,76,88,89
objects/obj_SMW_bowser/Other_14.gml(6): 28,29,79,80,92,93
objects/obj_bossparent/Collision_obj_mario.gml(6): 10,13,14,34,37,38
objects/obj_bullebill_base/Alarm_0.gml(6): 15,18,21,48,51,54
objects/obj_bullebill_base_red/Alarm_0.gml(6): 20,23,26,58,61,64
objects/obj_card_item/Mouse_4.gml(6): 5,6,12,29,30,39
objects/obj_coin10/Other_11.gml(6): 4,5,8,9,12,13
objects/obj_flagpole/Alarm_1.gml(6): 22,28,30,37,38,41
objects/obj_frogsuit/Collision_obj_mario.gml(6): 26,27,37,38,43,44
objects/obj_hammersuit/Collision_obj_mario.gml(6): 18,19,29,30,35,36
objects/obj_hen_mushroom/Collision_obj_mario.gml(6): 7,8,9,10,14,17
objects/obj_levelmanager/Other_11.gml(6): 5,6,7,8,9,12
objects/obj_mario/Other_24.gml(6): 3,5,6,7,8,9
objects/obj_mushroom/Collision_obj_mario.gml(6): 26,27,40,41,45,46
objects/obj_mushroom/Step_0.gml(6): 38,39,51,52,60,61
objects/obj_noteblock/Alarm_1.gml(6): 9,10,21,22,26,27
objects/obj_skewertrunk/Other_11.gml(6): 50,51,52,62,63,64
objects/obj_skewertrunk/Other_12.gml(6): 53,54,55,65,66,67
objects/obj_skewertrunk/Other_13.gml(6): 56,57,58,68,69,70
objects/obj_skewertrunk/Other_14.gml(6): 53,54,55,65,66,67
objects/obj_superflower/Collision_obj_mario.gml(6): 19,20,31,32,37,38
objects/obj_thwomp/Step_0.gml(6): 39,40,115,116,176,177
scripts/scr_step_sounds/scr_step_sounds.gml(6): 6,8,12,14,18,20
objects/obj_SMB3_bowser/Other_14.gml(5): 36,114,115,127,128
objects/obj_bullebill_base_red_res/Step_2.gml(5): 23,24,34,35,57
objects/obj_bullebill_base_res/Step_2.gml(5): 34,35,45,46,68
objects/obj_cinta_on_res/Step_2.gml(5): 39,40,48,49,69
objects/obj_cinta_res/Step_2.gml(5): 67,68,76,77,97
objects/obj_clown/Collision_obj_mario.gml(5): 3,4,18,19,22
objects/obj_goalgate/Alarm_0.gml(5): 22,27,28,34,35
objects/obj_grinder_res/Alarm_0.gml(5): 15,25,26,54,59
objects/obj_levelmanager/Alarm_10.gml(5): 5,9,12,13,14
objects/obj_levelmanager/Other_13.gml(5): 1,2,3,4,5
objects/obj_mariostart_m/Alarm_1.gml(5): 2,8,11,14,17
objects/obj_muncher_res/Alarm_0.gml(5): 15,20,21,48,53
objects/obj_mushroom_platform_res/Alarm_0.gml(5): 15,25,26,53,58
objects/obj_parent_resource/Alarm_0.gml(5): 20,30,31,62,67
objects/obj_parent_sounds/Alarm_0.gml(5): 15,25,26,53,58
objects/obj_pink_coin/Other_10.gml(5): 3,9,12,15,18
objects/obj_platform_blue_res/Step_2.gml(5): 23,24,32,33,51
objects/obj_platform_res/Step_2.gml(5): 23,24,32,33,51
objects/obj_puente_res/Step_2.gml(5): 170,171,179,180,200
objects/obj_rails_res/Step_2.gml(5): 7,8,16,17,37
objects/obj_semisolid_platform1/Alarm_0.gml(5): 17,27,28,55,60
objects/obj_shell_drybones/Collision_obj_mario.gml(5): 14,44,46,49,55
objects/obj_skewertrunk/Destroy_0.gml(5): 1,2,3,4,5
objects/obj_skewertrunk/Other_15.gml(5): 3,4,5,9,10
objects/obj_snow_ball_b/Collision_obj_mario.gml(5): 12,14,17,25,26
objects/obj_spring/Step_0.gml(5): 10,13,14,19,20
objects/obj_star/Collision_obj_mario.gml(5): 14,18,21,22,23
objects/obj_tuberia_res/Step_2.gml(5): 83,84,115,116,200
objects/obj_window_mario_button/Mouse_4.gml(5): 5,16,21,30,31
objects/obj_1up/Other_13.gml(4): 31,32,37,38
objects/obj_NSMBU_bowser/Step_2.gml(4): 122,123,127,128
objects/obj_bowserjr/Alarm_8.gml(4): 5,6,10,11
objects/obj_brohammer_yoshi/Collision_obj_enemyparent.gml(4): 3,4,13,14
objects/obj_button_autoavance/Mouse_4.gml(4): 3,4,16,17
objects/obj_button_notification_aceptar/Mouse_4.gml(4): 4,7,21,26
objects/obj_button_settings_close/Mouse_4.gml(4): 3,4,10,11
objects/obj_button_superado/Mouse_4.gml(4): 8,11,24,27
objects/obj_button_time/Alarm_0.gml(4): 8,9,17,18
objects/obj_charginchuck/Other_11.gml(4): 1,2,5,6
objects/obj_crumblebones/Create_0.gml(4): 31,32,37,38
objects/obj_crumblebony/Create_0.gml(4): 32,33,38,39
objects/obj_crumblebony_b/Create_0.gml(4): 32,33,38,39
objects/obj_efecto_sonido/Alarm_0.gml(4): 4,5,10,11
objects/obj_enemyparent/Collision_obj_blockparent.gml(4): 3,4,14,15
objects/obj_enemyparent_held/Step_2.gml(4): 67,68,77,78
objects/obj_erase/Alarm_0.gml(4): 5,6,12,13
objects/obj_explosion/Create_0.gml(4): 22,23,27,28
objects/obj_flipblock/Step_0.gml(4): 4,13,26,53
objects/obj_goalcard/Collision_obj_mario.gml(4): 9,10,11,12
objects/obj_grrrol/Other_13.gml(4): 22,45,82,83
objects/obj_grrrol_b/Other_13.gml(4): 22,45,82,83
objects/obj_grrrol_new/Other_13.gml(4): 22,45,82,83
objects/obj_helmet/Collision_obj_bulletbill.gml(4): 3,4,8,9
objects/obj_helmet/Collision_obj_bulletbull_red.gml(4): 3,4,8,9
objects/obj_link_down_atack/Collision_obj_enemyparent.gml(4): 3,4,39,40
objects/obj_load_level/Other_11.gml(4): 337,338,339,340
objects/obj_magikoopa/Step_0.gml(4): 7,8,28,29
objects/obj_mariostart_m/Other_11.gml(4): 4,7,10,13
objects/obj_noteblock/Create_0.gml(4): 7,66,72,78
objects/obj_noteblock_s/Alarm_1.gml(4): 8,9,22,24
objects/obj_onoffblock/Other_10.gml(4): 4,7,10,13
objects/obj_pokey/Other_13.gml(4): 14,15,21,22
objects/obj_settings_button/Mouse_4.gml(4): 5,6,16,19
objects/obj_snow_ball/Collision_obj_mario.gml(4): 20,22,25,33
objects/obj_tongue/Step_2.gml(4): 55,61,67,68
objects/obj_tongue_blue/Step_2.gml(4): 55,61,67,68
objects/obj_yoshi_red/Other_10.gml(4): 10,23,45,58
objects/obj_NSMBU_bowserjr/Alarm_4.gml(3): 9,10,11
objects/obj_angrysun_res/Other_11.gml(3): 6,310,311
objects/obj_bg1/Mouse_4.gml(3): 3,11,12
objects/obj_block_pow_hold/Other_12.gml(3): 16,46,49
objects/obj_blockbumper/Collision_obj_blockparent.gml(3): 7,12,19
objects/obj_blockparent/Alarm_2.gml(3): 7,148,149
objects/obj_button_creditos/Mouse_10.gml(3): 3,4,5
objects/obj_button_sombras/Mouse_10.gml(3): 3,4,5
objects/obj_card_circle/Mouse_4.gml(3): 123,141,144
objects/obj_card_logo/Mouse_4.gml(3): 11,314,315
objects/obj_cinta_on_res/Mouse_4.gml(3): 13,21,29
objects/obj_cinta_res/Mouse_4.gml(3): 13,21,29
objects/obj_enemyparent_held/Collision_obj_enemyparent.gml(3): 3,9,15
objects/obj_etiquetas/Mouse_4.gml(3): 7,21,36
objects/obj_goalcard/Alarm_3.gml(3): 22,27,33
objects/obj_hawmask/Alarm_1.gml(3): 18,23,29
objects/obj_helmet/Collision_obj_brohammer.gml(3): 2,5,6
objects/obj_helmet/Collision_obj_cannonball.gml(3): 2,5,6
objects/obj_helmet/Collision_obj_snow_ball_held.gml(3): 5,12,13
objects/obj_helmet/Collision_obj_spike_ball.gml(3): 4,7,8
objects/obj_holdparent/Other_12.gml(3): 23,43,46
objects/obj_levelmanager/Alarm_0.gml(3): 1,3,4
objects/obj_mario_editor/Alarm_0.gml(3): 11,12,39
objects/obj_mario_pballon/Step_0.gml(3): 41,42,45
objects/obj_meteorites/Other_11.gml(3): 2,4,6
objects/obj_meteorites_big/Other_11.gml(3): 2,4,6
objects/obj_meteorites_big/Other_12.gml(3): 2,4,6
objects/obj_noteblock/Other_15.gml(3): 8,11,12
objects/obj_noteblock_s/Create_0.gml(3): 6,9,12
objects/obj_pausa_button/Mouse_4.gml(3): 7,14,22
objects/obj_pballon/Collision_obj_mario.gml(3): 27,32,33
objects/obj_penguin_attack/Collision_obj_blockparent.gml(3): 7,12,19
objects/obj_player_goal_smb1/Collision_obj_flagpole.gml(3): 4,6,8
objects/obj_powerupsprout/Alarm_0.gml(3): 53,55,57
objects/obj_selecting_fps/Mouse_10.gml(3): 3,4,5
objects/obj_selecting_player/Mouse_10.gml(3): 5,6,7
objects/obj_shell/Other_12.gml(3): 17,35,38
objects/obj_shell_drybones/Other_12.gml(3): 15,39,42
objects/obj_skewertrunk/Alarm_2.gml(3): 19,20,21
objects/obj_skewertrunk/Other_16.gml(3): 3,4,5
objects/obj_slider/Step_0.gml(3): 28,66,77
objects/obj_snow_ball/Collision_obj_enemyparent.gml(3): 5,11,17
objects/obj_snow_ball/Other_12.gml(3): 19,42,45
objects/obj_vsync/Mouse_10.gml(3): 3,4,5
objects/obj_water_move/Alarm_0.gml(3): 17,18,25
objects/obj_water_move_limit/Alarm_0.gml(3): 43,44,58
objects/obj_window_select/Mouse_10.gml(3): 5,6,7
objects/obj_yoshifire/Step_2.gml(3): 3,16,29
scripts/scr_snd_pink_coin5/scr_snd_pink_coin5.gml(3): 4,6,8
objects/obj_1up_res/Other_14.gml(2): 3,8
objects/obj_NSMBU_boomboom/Other_10.gml(2): 11,12
objects/obj_NSMBU_boomboom_b/Other_10.gml(2): 11,12
objects/obj_NSMBU_bowser/Alarm_0.gml(2): 23,24
objects/obj_NSMBU_bowser/Alarm_2.gml(2): 1,2
objects/obj_NSMBU_bowser/Alarm_3.gml(2): 10,11
objects/obj_NSMBU_bowser/Alarm_4.gml(2): 2,3
objects/obj_NSMBU_bowser/Other_10.gml(2): 6,7
objects/obj_NSMBU_bowserjr/Alarm_0.gml(2): 14,15
objects/obj_NSMBU_bowserjr/Alarm_8.gml(2): 3,4
objects/obj_NSMBU_bowserjr/Other_11.gml(2): 11,21
objects/obj_NSMBU_bowserjr/Other_14.gml(2): 21,34
objects/obj_NSMBU_charginchuck/Alarm_0.gml(2): 6,7
objects/obj_NSMBU_charginchuck/Other_11.gml(2): 1,2
objects/obj_SMB2_mushroom_res/Other_14.gml(2): 3,8
objects/obj_alert_button/Mouse_4.gml(2): 3,4
objects/obj_angrysun_movement/Alarm_3.gml(2): 9,11
objects/obj_arrow_res/Mouse_4.gml(2): 13,24
objects/obj_axe_smw/Step_0.gml(2): 7,9
objects/obj_bg1/Mouse_10.gml(2): 2,3
objects/obj_big_pplant/Alarm_11.gml(2): 1,2
objects/obj_big_pplant/Other_10.gml(2): 2,3
objects/obj_big_pplant_b/Other_10.gml(2): 2,3
objects/obj_billbanzai_red_res/Mouse_4.gml(2): 13,27
objects/obj_billbanzai_res/Mouse_4.gml(2): 13,27
objects/obj_bl2/Mouse_4.gml(2): 3,14
objects/obj_block_gold/Alarm_1.gml(2): 5,6
objects/obj_blockcoin/Create_0.gml(2): 68,69
objects/obj_blockparent/Collision_obj_meteorites.gml(2): 2,4
objects/obj_blockparent/Collision_obj_meteorites_big.gml(2): 2,4
objects/obj_blockparent/Other_25.gml(2): 2,3
objects/obj_bobomb_hold/Other_11.gml(2): 21,23
objects/obj_bobomb_ready_res/Other_14.gml(2): 3,8
objects/obj_bones_yoshi/Collision_obj_enemyparent.gml(2): 3,12
objects/obj_bones_yoshi_one/Collision_obj_enemyparent.gml(2): 3,12
objects/obj_bonybeetle/Other_10.gml(2): 1,2
objects/obj_bonybeetle_b/Other_10.gml(2): 1,2
objects/obj_boo/Collision_obj_blockparent.gml(2): 3,4
objects/obj_boo/Other_10.gml(2): 8,9
objects/obj_boo/Step_2.gml(2): 9,10
objects/obj_boomboom/Step_2.gml(2): 31,33
objects/obj_boomboom_b/Step_2.gml(2): 31,33
objects/obj_boomerangbro/Alarm_3.gml(2): 3,4
objects/obj_bouncycloud/Step_0.gml(2): 43,44
objects/obj_bowser_dead_castle/Alarm_0.gml(2): 20,21
objects/obj_bowserjr_dead_castle/Alarm_0.gml(2): 20,21
objects/obj_bowserjr_shell/Other_13.gml(2): 40,41
objects/obj_brohammer_yoshi/Collision_obj_enemyparent_held.gml(2): 1,2
objects/obj_bt_gb_delete/Mouse_10.gml(2): 5,6
objects/obj_bt_gb_edit/Mouse_10.gml(2): 5,6
objects/obj_bt_gb_edit/Mouse_4.gml(2): 5,6
objects/obj_bt_gb_play/Mouse_10.gml(2): 5,6
objects/obj_bt_gb_play/Mouse_4.gml(2): 5,6
objects/obj_bt_rename/Mouse_10.gml(2): 6,7
objects/obj_btn_header_1/Mouse_10.gml(2): 2,3
objects/obj_btn_header_1/Mouse_4.gml(2): 13,14
objects/obj_btn_header_2/Mouse_10.gml(2): 2,3
objects/obj_btn_header_2/Mouse_4.gml(2): 13,14
objects/obj_btn_header_3/Mouse_10.gml(2): 2,3
objects/obj_btn_header_3/Mouse_4.gml(2): 13,14
objects/obj_btn_header_4/Mouse_10.gml(2): 2,3
objects/obj_btn_header_4/Mouse_4.gml(2): 13,14
objects/obj_btn_header_parent/Mouse_10.gml(2): 2,3
objects/obj_btn_settings_hd/Mouse_10.gml(2): 3,4
objects/obj_btn_settings_hd/Mouse_4.gml(2): 1,2
objects/obj_bullebill_base/Collision_obj_bossparent.gml(2): 7,8
objects/obj_bullebill_base/Collision_obj_enemyparent.gml(2): 17,18
objects/obj_bullebill_base/Collision_obj_enemyparent_held.gml(2): 5,6
objects/obj_bulletbull_red/Alarm_2.gml(2): 2,3
objects/obj_bumper/Collision_obj_clown.gml(2): 4,6
objects/obj_button_autoavance/Mouse_10.gml(2): 3,4
objects/obj_button_close_menu/Mouse_4.gml(2): 3,15
objects/obj_button_creditos/Mouse_4.gml(2): 1,2
objects/obj_button_home/Mouse_10.gml(2): 3,4
objects/obj_button_meteoritos/Mouse_10.gml(2): 5,6
objects/obj_button_ok/KeyPress_13.gml(2): 3,4
objects/obj_button_ok/Mouse_4.gml(2): 3,4
objects/obj_button_parent/Mouse_10.gml(2): 5,6
objects/obj_button_save_changes/Mouse_10.gml(2): 5,6
objects/obj_button_save_load/Mouse_10.gml(2): 3,4
objects/obj_button_sdog/Mouse_10.gml(2): 5,6
objects/obj_button_sdog/Mouse_4.gml(2): 5,10
objects/obj_button_settings_close2/Mouse_4.gml(2): 3,4
objects/obj_button_settings_controls/Mouse_10.gml(2): 3,4
objects/obj_button_settings_controls/Mouse_4.gml(2): 1,2
objects/obj_button_settings_estrella/Mouse_10.gml(2): 3,4
objects/obj_button_settings_estrella/Mouse_4.gml(2): 1,2
objects/obj_button_settings_idioma/Mouse_10.gml(2): 3,4
objects/obj_button_settings_idioma/Mouse_4.gml(2): 1,2
objects/obj_button_settings_sm4j/Mouse_10.gml(2): 3,4
objects/obj_button_settings_sm4j/Mouse_4.gml(2): 1,2
objects/obj_button_sombras/Mouse_4.gml(2): 1,2
objects/obj_button_speed_water/Mouse_10.gml(2): 3,4
objects/obj_button_trail/Mouse_10.gml(2): 5,6
objects/obj_button_trail/Mouse_4.gml(2): 5,10
objects/obj_button_wings/Mouse_10.gml(2): 3,4
objects/obj_button_wings/Mouse_4.gml(2): 25,30
objects/obj_call_mario/Mouse_4.gml(2): 3,4
objects/obj_cannon/Alarm_0.gml(2): 6,7
objects/obj_cannon_red/Alarm_0.gml(2): 6,7
objects/obj_cannon_red_res/Mouse_4.gml(2): 11,48
objects/obj_cannon_res/Mouse_4.gml(2): 11,48
objects/obj_cap_mario/Collision_obj_enemyparent.gml(2): 9,10
objects/obj_cap_mario/Collision_obj_spike_ball.gml(2): 5,6
objects/obj_cap_res/Other_13.gml(2): 8,13
objects/obj_cap_res/Other_14.gml(2): 3,8
objects/obj_card_autoavance/Mouse_10.gml(2): 5,6
objects/obj_card_autoavance/Mouse_4.gml(2): 10,17
objects/obj_card_bg/Mouse_10.gml(2): 5,6
objects/obj_card_bg/Mouse_4.gml(2): 10,17
objects/obj_card_block_sounds/Mouse_10.gml(2): 5,6
objects/obj_card_bout/Mouse_10.gml(2): 5,6
objects/obj_card_condiciones/Mouse_10.gml(2): 5,6
objects/obj_card_condiciones/Mouse_4.gml(2): 10,17
objects/obj_card_item/Mouse_10.gml(2): 6,7
objects/obj_card_logo/Mouse_10.gml(2): 3,4
objects/obj_card_rocket/Mouse_10.gml(2): 7,8
objects/obj_card_rocket/Mouse_4.gml(2): 3,4
objects/obj_card_rocket/Step_0.gml(2): 9,26
objects/obj_castle_floor/Alarm_0.gml(2): 1,2
objects/obj_chain_chomp_free/Step_0.gml(2): 28,29
objects/obj_charginchuck/Alarm_0.gml(2): 6,7
objects/obj_checkpoint/Collision_obj_mario.gml(2): 1,54
objects/obj_checkpoint/Collision_obj_shell_held.gml(2): 1,54
objects/obj_checkpoint_res/Mouse_4.gml(2): 13,24
objects/obj_claw/Step_2.gml(2): 93,139
objects/obj_cloud_lakitu/Step_0.gml(2): 97,115
objects/obj_clown/Collision_obj_boomboom.gml(2): 5,6
objects/obj_clown/Collision_obj_clown.gml(2): 3,4
objects/obj_clown/Collision_obj_pinchos.gml(2): 3,4
objects/obj_clown/Destroy_0.gml(2): 2,3
objects/obj_clown/Other_14.gml(2): 23,24
objects/obj_coin/Other_11.gml(2): 1,2
objects/obj_coin/Other_12.gml(2): 1,2
objects/obj_coin/Step_2.gml(2): 3,13
objects/obj_coin_res/Other_14.gml(2): 3,8
objects/obj_condiciones_button/Mouse_4.gml(2): 3,15
objects/obj_configurar_controles_reset/Mouse_10.gml(2): 3,4
objects/obj_crumblebones/Alarm_1.gml(2): 3,4
objects/obj_crumblebones/Other_10.gml(2): 1,2
objects/obj_crumblebony/Alarm_1.gml(2): 3,4
objects/obj_crumblebony/Other_10.gml(2): 1,2
objects/obj_crumblebony_b/Alarm_1.gml(2): 3,4
objects/obj_crumblebony_b/Other_10.gml(2): 1,2
objects/obj_crystalorb/Collision_obj_mario.gml(2): 8,9
objects/obj_cursor/Other_11.gml(2): 3,4
objects/obj_dog/Mouse_10.gml(2): 5,6
objects/obj_donut_res/Other_14.gml(2): 3,8
objects/obj_door_switch/Step_0.gml(2): 1,13
objects/obj_door_switch_exit/Step_0.gml(2): 1,13
objects/obj_egg_hatch/Collision_obj_mario.gml(2): 17,18
objects/obj_egg_hatch/Create_0.gml(2): 6,7
objects/obj_egg_red_res/Other_14.gml(2): 3,8
objects/obj_egg_res/Other_14.gml(2): 4,9
objects/obj_enemy_dead_castle/Alarm_0.gml(2): 6,7
objects/obj_enemyfrozen/Alarm_5.gml(2): 7,8
objects/obj_enemyparent_held/Collision_obj_bossparent.gml(2): 3,8
objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml(2): 5,16
objects/obj_erase/Mouse_10.gml(2): 5,6
objects/obj_etiquetas/Mouse_10.gml(2): 5,6
objects/obj_expand/Mouse_10.gml(2): 5,6
objects/obj_fire_clown/Create_0.gml(2): 19,20
objects/obj_fireball/Create_0.gml(2): 15,16
objects/obj_fireball/Other_10.gml(2): 2,3
objects/obj_fireball_bro/Create_0.gml(2): 15,16
objects/obj_firebar_res/Mouse_4.gml(2): 11,20
objects/obj_firebar_res/Other_15.gml(2): 1,2
objects/obj_firebro/Alarm_3.gml(2): 3,4
objects/obj_fireflower_res/Other_13.gml(2): 8,13
objects/obj_fireflower_res/Other_14.gml(2): 3,8
objects/obj_flipblock_anim/Step_0.gml(2): 3,12
objects/obj_floruga/Other_11.gml(2): 1,2
objects/obj_foo/Other_10.gml(2): 12,13
objects/obj_frogsuit_res/Other_13.gml(2): 8,13
objects/obj_frogsuit_res/Other_14.gml(2): 3,8
objects/obj_galoomba2_b/Other_11.gml(2): 54,55
objects/obj_galoomba_b/Other_11.gml(2): 55,56
objects/obj_gb_button/Mouse_10.gml(2): 5,6
objects/obj_goalgate_tape/Other_10.gml(2): 2,3
objects/obj_gold_explosion/Collision_obj_bossparent.gml(2): 1,2
objects/obj_gold_explosion/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_gold_explosion/Collision_obj_enemyparent_held.gml(2): 3,4
objects/obj_gold_explosion/Collision_obj_muncher.gml(2): 1,2
objects/obj_gold_explosion/Collision_obj_snow_ball.gml(2): 1,2
objects/obj_gold_explosion/Collision_obj_spike_ball.gml(2): 1,2
objects/obj_goomba_b_res/Other_14.gml(2): 3,8
objects/obj_goomba_res/Other_14.gml(2): 3,8
objects/obj_goombrat_b_res/Other_14.gml(2): 3,8
objects/obj_goombrat_res/Other_14.gml(2): 3,8
objects/obj_grinder/Collision_obj_clown.gml(2): 1,2
objects/obj_grinder/Collision_obj_mario.gml(2): 5,6
objects/obj_ground/Alarm_5.gml(2): 8,9
objects/obj_ground2/Other_10.gml(2): 1,2
objects/obj_ground2/Step_0.gml(2): 95,96
objects/obj_ground3/Other_10.gml(2): 1,2
objects/obj_ground3/Step_0.gml(2): 63,64
objects/obj_groundpount/Collision_obj_blockparent.gml(2): 31,32
objects/obj_grrrol_b_res/Mouse_4.gml(2): 11,25
objects/obj_grrrol_new_res/Mouse_4.gml(2): 11,25
objects/obj_grrrol_res/Mouse_4.gml(2): 11,25
objects/obj_hammer/Collision_obj_bowserjr_shell.gml(2): 1,2
objects/obj_hammer/Collision_obj_brohammer.gml(2): 1,2
objects/obj_hammer/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_hammer/Collision_obj_enemyparent_held.gml(2): 1,2
objects/obj_hammer/Collision_obj_spike_ball.gml(2): 1,2
objects/obj_hammer/Create_0.gml(2): 1,2
objects/obj_hammer_b/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_hammerbro/Alarm_3.gml(2): 3,4
objects/obj_helmet/Collision_obj_banzaibill.gml(2): 2,5
objects/obj_helmet/Collision_obj_bone.gml(2): 2,5
objects/obj_helmet/Collision_obj_buzzy_ceiling.gml(2): 3,4
objects/obj_helmet/Collision_obj_clown.gml(2): 3,4
objects/obj_helmet/Collision_obj_espina.gml(2): 2,5
objects/obj_helmet/Collision_obj_holdparent.gml(2): 3,4
objects/obj_helmet/Collision_obj_muncher.gml(2): 3,4
objects/obj_helmet/Collision_obj_physicsparent.gml(2): 3,4
objects/obj_helmet/Collision_obj_shell_held.gml(2): 3,4
objects/obj_helmet/Collision_obj_thwomp.gml(2): 3,4
objects/obj_helmet/Other_15.gml(2): 1,2
objects/obj_helmet_spiny/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_holdparent.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_muncher.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_physicsparent.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_shell.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_shell_held.gml(2): 3,4
objects/obj_helmet_spiny/Collision_obj_thwomp.gml(2): 3,4
objects/obj_hen_mushroom_res/Other_13.gml(2): 8,13
objects/obj_hen_mushroom_res/Other_14.gml(2): 3,8
objects/obj_holdparent/Collision_obj_mario.gml(2): 11,12
objects/obj_icebro/Alarm_3.gml(2): 3,4
objects/obj_invincibility/Collision_obj_enemyparent_held.gml(2): 1,2
objects/obj_key/Collision_obj_mario.gml(2): 6,8
objects/obj_key/Other_10.gml(2): 1,2
objects/obj_key_appear/Alarm_0.gml(2): 2,3
objects/obj_key_appear/Create_0.gml(2): 23,24
objects/obj_key_appear/Other_10.gml(2): 1,2
objects/obj_key_appear/Other_11.gml(2): 6,8
objects/obj_kuriboshoe/Step_2.gml(2): 56,66
objects/obj_lakitu_res/Other_14.gml(2): 3,8
objects/obj_lava_water/Destroy_0.gml(2): 3,4
objects/obj_levelmanager/Alarm_11.gml(2): 5,6
objects/obj_levelmanager/Other_15.gml(2): 3,4
objects/obj_link_arrow/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_link_arrow/Create_0.gml(2): 1,2
objects/obj_link_arrow/Other_10.gml(2): 1,2
objects/obj_link_arrow/Other_11.gml(2): 1,2
objects/obj_link_arrow_anim/Destroy_0.gml(2): 1,2
objects/obj_link_atack/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_link_bomb/Collision_obj_link_atack.gml(2): 2,3
objects/obj_link_bomb/Collision_obj_link_down_atack.gml(2): 2,3
objects/obj_link_dash_atack/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_link_dash_atack/Other_10.gml(2): 7,17
objects/obj_link_down_atack/Collision_obj_grinder.gml(2): 3,4
objects/obj_link_down_atack/Collision_obj_spike_ball.gml(2): 1,2
objects/obj_link_down_atack/Other_10.gml(2): 5,6
objects/obj_link_res/Other_14.gml(2): 3,8
objects/obj_logo_game/Mouse_10.gml(2): 5,6
objects/obj_logo_game/Mouse_4.gml(2): 10,17
objects/obj_magic/Other_10.gml(2): 3,4
objects/obj_mario/Alarm_10.gml(2): 13,14
objects/obj_mario/Other_14.gml(2): 54,141
objects/obj_marioU/Other_11.gml(2): 25,30
objects/obj_marioU/Other_19.gml(2): 19,21
objects/obj_mario_editor/Other_11.gml(2): 2,3
objects/obj_mechakoopa_held/Other_11.gml(2): 21,23
objects/obj_menu_editor/Mouse_10.gml(2): 5,6
objects/obj_menu_editor_ext/Mouse_10.gml(2): 5,6
objects/obj_meteorites_maker/Destroy_0.gml(2): 1,2
objects/obj_muncher/Collision_obj_shield_left.gml(2): 5,6
objects/obj_muncher/Collision_obj_shield_right.gml(2): 5,6
objects/obj_muncher/Other_14.gml(2): 32,33
objects/obj_mushroom_res/Other_14.gml(2): 3,8
objects/obj_musicblock/Alarm_1.gml(2): 27,29
objects/obj_night_change/Mouse_10.gml(2): 4,5
objects/obj_night_change/Mouse_7.gml(2): 4,5
objects/obj_night_change/Other_11.gml(2): 301,302
objects/obj_noteblock/Other_14.gml(2): 92,93
objects/obj_oneway_res/Mouse_4.gml(2): 13,24
objects/obj_onewaygate_bottom/Other_10.gml(2): 1,2
objects/obj_onewaygate_left/Other_10.gml(2): 1,2
objects/obj_onewaygate_right/Other_10.gml(2): 1,2
objects/obj_onewaygate_top/Other_10.gml(2): 1,2
objects/obj_panel_time/Mouse_10.gml(2): 5,6
objects/obj_panel_time/Mouse_4.gml(2): 10,17
objects/obj_parcarry/Collision_obj_enemyparent.gml(2): 5,15
objects/obj_parent_resource/Collision_obj_key_res.gml(2): 5,20
objects/obj_parent_resource/Other_12.gml(2): 3,4
objects/obj_parent_resource/Other_14.gml(2): 3,8
objects/obj_pausa_button/KeyPress_82.gml(2): 6,15
objects/obj_penguin_attack/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_penguin_attack/Collision_obj_enemyparent_held.gml(2): 3,4
objects/obj_persistent/Other_2.gml(2): 68,87
objects/obj_physicssolid/Collision_obj_bossparent.gml(2): 7,8
objects/obj_physicssolid/Collision_obj_enemyparent.gml(2): 17,18
objects/obj_physicssolid/Collision_obj_enemyparent_held.gml(2): 5,6
objects/obj_plant_fire/Alarm_3.gml(2): 2,3
objects/obj_plant_fire_res/Other_14.gml(2): 3,8
objects/obj_platform_blue_res/Other_14.gml(2): 3,8
objects/obj_platform_res/Mouse_4.gml(2): 17,25
objects/obj_player_goal_smb1/Alarm_11.gml(2): 2,4
objects/obj_player_warp/Other_10.gml(2): 1,2
objects/obj_podoboo/Alarm_2.gml(2): 1,2
objects/obj_powerupsprout_note/Alarm_0.gml(2): 56,58
objects/obj_pplant_res/Other_14.gml(2): 3,8
objects/obj_profile/Mouse_10.gml(2): 5,6
objects/obj_pswitch/Other_16.gml(2): 5,10
objects/obj_pswitch_res/Other_14.gml(2): 4,9
objects/obj_rename_button2/Mouse_4.gml(2): 3,16
objects/obj_robot/Mouse_10.gml(2): 7,8
objects/obj_robot/Mouse_4.gml(2): 5,11
objects/obj_rocangrejo/Alarm_2.gml(2): 3,4
objects/obj_rock_res/Other_14.gml(2): 3,8
objects/obj_rockparent/Alarm_0.gml(2): 2,3
objects/obj_rockparent/Collision_obj_meteorites.gml(2): 2,4
objects/obj_rockparent/Collision_obj_meteorites_big.gml(2): 2,4
objects/obj_score/Other_17.gml(2): 4,5
objects/obj_selecting_fps/Mouse_4.gml(2): 1,2
objects/obj_settings_button/Mouse_10.gml(2): 5,6
objects/obj_settings_controls/Mouse_10.gml(2): 3,4
objects/obj_settings_custom/Mouse_10.gml(2): 3,4
objects/obj_settings_custom/Mouse_4.gml(2): 3,4
objects/obj_shell_held/Collision_obj_enemyparent.gml(2): 27,28
objects/obj_shell_held/Collision_obj_mario.gml(2): 3,10
objects/obj_shell_held/Other_14.gml(2): 28,29
objects/obj_shell_held/Step_0.gml(2): 43,44
objects/obj_shield_left/Other_10.gml(2): 1,2
objects/obj_shield_right/Other_10.gml(2): 1,2
objects/obj_skewer_res/Mouse_4.gml(2): 13,23
objects/obj_skewertrunk/Alarm_0.gml(2): 21,22
objects/obj_skewertrunk/Alarm_1.gml(2): 6,7
objects/obj_sledgebro/Alarm_4.gml(2): 3,4
objects/obj_sledgebro/Step_0.gml(2): 110,123
objects/obj_smoke_shoe/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_smoke_shoe/Collision_obj_muncher.gml(2): 3,4
objects/obj_smoke_shoe/Collision_obj_shell.gml(2): 3,4
objects/obj_snow_ball_held/Other_11.gml(2): 1,2
objects/obj_snowball/Collision_obj_enemyparent.gml(2): 6,7
objects/obj_snowball/Collision_obj_shell.gml(2): 4,5
objects/obj_snowball/Create_0.gml(2): 4,5
objects/obj_snowball/Other_10.gml(2): 1,2
objects/obj_snowball_bro/Collision_obj_mario.gml(2): 3,4
objects/obj_snowball_bro/Other_10.gml(2): 3,4
objects/obj_soplete_global/Alarm_0.gml(2): 12,13
objects/obj_soplete_invert_global/Alarm_0.gml(2): 12,13
objects/obj_soplete_res/Mouse_4.gml(2): 11,36
objects/obj_spike_ball/Other_10.gml(2): 1,2
objects/obj_spike_ball_b/Other_10.gml(2): 1,2
objects/obj_spiny_empty/Other_11.gml(2): 5,6
objects/obj_spring/Collision_obj_holdparent.gml(2): 16,17
objects/obj_spring/Collision_obj_physicsparent.gml(2): 25,26
objects/obj_spring/Collision_obj_powerupparent.gml(2): 16,17
objects/obj_spring_land/Other_11.gml(2): 4,5
objects/obj_spring_land_res/Other_14.gml(2): 3,8
objects/obj_spring_res/Other_14.gml(2): 3,8
objects/obj_star_res/Other_14.gml(2): 3,8
objects/obj_stomp/Create_0.gml(2): 11,12
objects/obj_superball/Collision_obj_enemyparent_held.gml(2): 3,24
objects/obj_superflower_res/Other_13.gml(2): 8,13
objects/obj_superflower_res/Other_14.gml(2): 3,8
objects/obj_tabs_condiciones/Mouse_10.gml(2): 3,4
objects/obj_thwomp/Alarm_1.gml(2): 8,9
objects/obj_thwomp/Collision_obj_enemyparent.gml(2): 3,4
objects/obj_thwomp_b_res/Mouse_4.gml(2): 11,30
objects/obj_thwomp_res/Mouse_4.gml(2): 11,30
objects/obj_titlemenu_key/KeyPress_1.gml(2): 7,42
objects/obj_tongue/Collision_obj_coin10.gml(2): 8,9
objects/obj_tongue_blue/Collision_obj_coin10.gml(2): 8,9
objects/obj_tuberia_res/Other_11.gml(2): 5,6
objects/obj_veggiecoin/Create_0.gml(2): 65,66
objects/obj_vsync/Mouse_4.gml(2): 1,2
objects/obj_window_button/Mouse_10.gml(2): 3,4
objects/obj_window_mario_button/Mouse_10.gml(2): 3,4
objects/obj_window_select/Mouse_4.gml(2): 3,4
objects/obj_wrench/Other_10.gml(2): 4,5
objects/obj_yoshi2/Step_2.gml(2): 20,21
objects/obj_yoshi_abandon/Collision_obj_mario.gml(2): 22,23
objects/cre_control/Other_4.gml(1): 1
objects/cre_control/Other_5.gml(1): 1
objects/obj_NSMBU_boomboom/Alarm_4.gml(1): 5
objects/obj_NSMBU_boomboom/Destroy_0.gml(1): 1
objects/obj_NSMBU_boomboom/Other_11.gml(1): 13
objects/obj_NSMBU_boomboom/Other_14.gml(1): 21
objects/obj_NSMBU_boomboom_b/Alarm_4.gml(1): 5
objects/obj_NSMBU_boomboom_b/Other_11.gml(1): 13
objects/obj_NSMBU_boomboom_b/Other_14.gml(1): 21
objects/obj_NSMBU_bowser/Collision_obj_mario.gml(1): 7
objects/obj_NSMBU_bowserjr/Alarm_2.gml(1): 5
objects/obj_SMB2_mushroom_res/Other_13.gml(1): 1
objects/obj_SMB3_bowser/Alarm_2.gml(1): 1
objects/obj_SMB3_bowser/Collision_obj_mario.gml(1): 7
objects/obj_SMB3_bowser/Other_10.gml(1): 6
objects/obj_SMB_bowser/Alarm_2.gml(1): 1
objects/obj_SMB_bowser/Collision_obj_mario.gml(1): 7
objects/obj_SMB_bowser/Other_10.gml(1): 6
objects/obj_SMW_bowser/Alarm_2.gml(1): 1
objects/obj_SMW_bowser/Alarm_7.gml(1): 1
objects/obj_SMW_bowser/Collision_obj_mario.gml(1): 7
objects/obj_SMW_bowser/Other_10.gml(1): 6
objects/obj_alert_close/Mouse_4.gml(1): 3
objects/obj_angrysun/Collision_obj_mario.gml(1): 4
objects/obj_anti_pblock/Step_0.gml(1): 1
objects/obj_apariencia/Mouse_4.gml(1): 3
objects/obj_audio_control/Create_0.gml(1): 2
objects/obj_autoavance/Mouse_4.gml(1): 3
objects/obj_axe_smw/Alarm_1.gml(1): 1
objects/obj_axe_smw/Alarm_3.gml(1): 1
objects/obj_beachkoopa/Collision_obj_mario.gml(1): 5
objects/obj_bg_selection/Mouse_4.gml(1): 3
objects/obj_big_pplant_b_res/Other_13.gml(1): 1
objects/obj_big_pplant_res/Other_13.gml(1): 1
objects/obj_block_hidden_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_block_hidden_res/Other_12.gml(1): 5
objects/obj_block_pow_hold/Step_0.gml(1): 66
objects/obj_block_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_block_res/Other_12.gml(1): 5
objects/obj_bobomb_hold/Alarm_1.gml(1): 13
objects/obj_bobomb_hold/Create_0.gml(1): 20
objects/obj_bobomb_hold/Destroy_0.gml(1): 3
objects/obj_bobomb_ready/Alarm_1.gml(1): 2
objects/obj_bobomb_ready/Create_0.gml(1): 21
objects/obj_bobomb_ready/Destroy_0.gml(1): 3
objects/obj_bones_yoshi/Collision_obj_shell.gml(1): 1
objects/obj_bones_yoshi_one/Collision_obj_shell.gml(1): 1
objects/obj_bonus_or/Collision_obj_mario.gml(1): 1
objects/obj_bonybeetle_b_res/Other_13.gml(1): 1
objects/obj_bonybeetle_res/Other_13.gml(1): 1
objects/obj_boomboom_b_res/Other_13.gml(1): 1
objects/obj_boomerangbro_res/Other_13.gml(1): 1
objects/obj_boss_or/Collision_obj_mario.gml(1): 1
objects/obj_bowser_fire/Collision_obj_helmet.gml(1): 1
objects/obj_bowser_fire/Collision_obj_kuribo_drybones.gml(1): 1
objects/obj_bowser_fire/Collision_obj_shield_left.gml(1): 3
objects/obj_bowser_fire/Collision_obj_shield_right.gml(1): 3
objects/obj_bowserjr/Alarm_2.gml(1): 3
objects/obj_bowserjr/Other_14.gml(1): 22
objects/obj_bowserjr_shell/Alarm_1.gml(1): 5
objects/obj_bowserjr_shell/Collision_obj_enemyparent_held.gml(1): 3
objects/obj_brickhelmet/Other_15.gml(1): 2
objects/obj_bt_close_water/Mouse_4.gml(1): 3
objects/obj_bt_gb_close/Mouse_4.gml(1): 3
objects/obj_bt_gb_delete/Mouse_4.gml(1): 3
objects/obj_bt_rename/Mouse_4.gml(1): 4
objects/obj_bullebill_base_red_res/Collision_obj_parent_resource.gml(1): 18
objects/obj_bullebill_base_red_res/Mouse_4.gml(1): 17
objects/obj_bullebill_base_res/Collision_obj_parent_resource.gml(1): 18
objects/obj_bullebill_base_res/Mouse_4.gml(1): 17
objects/obj_button_close/Mouse_4.gml(1): 3
objects/obj_button_meteoritos/Mouse_4.gml(1): 4
objects/obj_button_notification_cancelar/Mouse_4.gml(1): 5
objects/obj_button_save_changes/Mouse_4.gml(1): 3
objects/obj_button_save_load/Mouse_4.gml(1): 1
objects/obj_button_speed_water/Mouse_4.gml(1): 1
objects/obj_buzzybeetle_b_res/Other_13.gml(1): 1
objects/obj_buzzybeetle_res/Other_13.gml(1): 1
objects/obj_card_block_sounds/Mouse_4.gml(1): 3
objects/obj_card_bout/Mouse_4.gml(1): 3
objects/obj_checkpoint_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_chomp_b_res/Other_13.gml(1): 1
objects/obj_chomp_res/Other_13.gml(1): 1
objects/obj_cinta/Step_0.gml(1): 1
objects/obj_cinta_on_res/Other_15.gml(1): 1
objects/obj_cinta_res/Other_15.gml(1): 1
objects/obj_cinta_switch/Step_0.gml(1): 1
objects/obj_clown/Alarm_2.gml(1): 2
objects/obj_clown_explotion/Collision_obj_enemyparent.gml(1): 3
objects/obj_clown_fire/Destroy_0.gml(1): 2
objects/obj_coinchain/Create_0.gml(1): 4
objects/obj_condiciones/Mouse_4.gml(1): 3
objects/obj_continue_btn/Mouse_4.gml(1): 3
objects/obj_creator_jugar_editar/Mouse_4.gml(1): 6
objects/obj_creator_jugar_editar/Other_12.gml(1): 17
objects/obj_cursor/Step_1.gml(1): 34
objects/obj_door/Other_7.gml(1): 26
objects/obj_door/Step_0.gml(1): 9
objects/obj_door_exit/Other_7.gml(1): 26
objects/obj_door_exit/Step_0.gml(1): 9
objects/obj_door_lock/Alarm_3.gml(1): 1
objects/obj_door_lock/Other_7.gml(1): 18
objects/obj_door_lock_exit/Alarm_3.gml(1): 1
objects/obj_door_lock_exit/Other_7.gml(1): 18
objects/obj_door_switch/Other_7.gml(1): 11
objects/obj_door_switch_exit/Other_7.gml(1): 11
objects/obj_drybones/Other_10.gml(1): 1
objects/obj_edit_menu/Create_0.gml(1): 2
objects/obj_edit_menu/Destroy_0.gml(1): 25
objects/obj_edit_menu/Step_0.gml(1): 2
objects/obj_editormanager/Create_0.gml(1): 28
objects/obj_egg/Alarm_0.gml(1): 12
objects/obj_egg_red_res/Other_13.gml(1): 3
objects/obj_egg_res/Other_13.gml(1): 3
objects/obj_enemyfrozen/Step_0.gml(1): 32
objects/obj_enemyparent_held/Collision_obj_blockparent.gml(1): 3
objects/obj_enemyparent_held/Collision_obj_shell_held.gml(1): 3
objects/obj_enemyparent_held/Step_0.gml(1): 19
objects/obj_expand/Mouse_4.gml(1): 3
objects/obj_expand_paneles_top/Mouse_4.gml(1): 3
objects/obj_expand_panels/Mouse_4.gml(1): 3
objects/obj_expand_panels_left/Mouse_4.gml(1): 3
objects/obj_explosion/Collision_obj_mario.gml(1): 3
objects/obj_fireball/Collision_obj_bobomb.gml(1): 1
objects/obj_fireball/Collision_obj_enemyparent.gml(1): 5
objects/obj_fireball_b/Create_0.gml(1): 15
objects/obj_fireball_b/Other_10.gml(1): 1
objects/obj_firebar_res/Step_2.gml(1): 90
objects/obj_firebro_res/Other_13.gml(1): 1
objects/obj_foo/Destroy_0.gml(1): 2
objects/obj_foo/Step_0.gml(1): 47
objects/obj_game_over/Create_0.gml(1): 1
objects/obj_gb_button/Mouse_4.gml(1): 3
objects/obj_getshoe/Other_11.gml(1): 6
objects/obj_goalcard/Other_12.gml(1): 1
objects/obj_goomba_b_res/Other_13.gml(1): 1
objects/obj_goomba_res/Other_13.gml(1): 1
objects/obj_goombrat_b_res/Other_13.gml(1): 1
objects/obj_goombrat_res/Other_13.gml(1): 1
objects/obj_grrrol/Collision_obj_enemyparent.gml(1): 3
objects/obj_grrrol/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_grrrol/Collision_obj_spike_ball.gml(1): 1
objects/obj_grrrol_b/Collision_obj_enemyparent.gml(1): 3
objects/obj_grrrol_b/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_grrrol_b/Collision_obj_spike_ball.gml(1): 1
objects/obj_grrrol_b_res/Other_13.gml(1): 1
objects/obj_grrrol_new/Collision_obj_enemyparent.gml(1): 3
objects/obj_grrrol_new/Collision_obj_enemyparent_held.gml(1): 1
objects/obj_grrrol_new/Collision_obj_spike_ball.gml(1): 1
objects/obj_grrrol_new_res/Other_13.gml(1): 1
objects/obj_guardabot/Create_0.gml(1): 14
objects/obj_guardabot/Other_5.gml(1): 2
objects/obj_hammerbro_res/Other_13.gml(1): 1
objects/obj_hawmask/Alarm_0.gml(1): 2
objects/obj_helmet_spiny/Collision_obj_bossparent.gml(1): 7
objects/obj_holdparent/Step_0.gml(1): 18
objects/obj_icebro_res/Other_13.gml(1): 1
objects/obj_icecoin/Step_0.gml(1): 2
objects/obj_intro_controller/Alarm_1.gml(1): 1
objects/obj_intro_controller/Step_2.gml(1): 20
objects/obj_invincibility/Alarm_0.gml(1): 1
objects/obj_invincibility/Collision_obj_bossparent.gml(1): 1
objects/obj_koopa_b_res/Other_13.gml(1): 1
objects/obj_koopa_red_b_res/Other_13.gml(1): 1
objects/obj_koopa_red_res/Other_13.gml(1): 1
objects/obj_koopa_res/Other_13.gml(1): 1
objects/obj_kuribo_drybones/Other_15.gml(1): 1
objects/obj_kuriboshoe/Alarm_1.gml(1): 3
objects/obj_kuriboshoe/Alarm_2.gml(1): 3
objects/obj_kuriboshoe/Other_15.gml(1): 1
objects/obj_lakitu_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_levelmanager/Alarm_1.gml(1): 1
objects/obj_levelmanager/Alarm_3.gml(1): 1
objects/obj_levelmanager/Alarm_7.gml(1): 19
objects/obj_levelmanager/Alarm_9.gml(1): 3
objects/obj_levelmanager/Create_0.gml(1): 27
objects/obj_levelmanager/Other_4.gml(1): 5
objects/obj_link_atack/Create_0.gml(1): 1
objects/obj_link_bomb/Other_12.gml(1): 1
objects/obj_load_btn_c/Mouse_4.gml(1): 3
objects/obj_mario/Other_18.gml(1): 1
objects/obj_mario/Other_7.gml(1): 18
objects/obj_mario_editor/Mouse_4.gml(1): 9
objects/obj_mario_intro/Collision_obj_shell_intro.gml(1): 5
objects/obj_mario_pballon/Destroy_0.gml(1): 1
objects/obj_menu_editor/Mouse_4.gml(1): 3
objects/obj_menu_editor_ext/Mouse_4.gml(1): 3
objects/obj_meteorites/Collision_obj_mario.gml(1): 5
objects/obj_meteorites_big/Collision_obj_mario.gml(1): 5
objects/obj_meteorites_maker/Alarm_0.gml(1): 2
objects/obj_meteorites_maker/Alarm_1.gml(1): 3
objects/obj_meteorites_maker/Alarm_10.gml(1): 2
objects/obj_meteorites_maker/Alarm_2.gml(1): 2
objects/obj_meteorites_maker/Alarm_3.gml(1): 2
objects/obj_meteorites_maker/Alarm_4.gml(1): 2
objects/obj_meteorites_maker/Alarm_5.gml(1): 2
objects/obj_meteorites_maker/Alarm_6.gml(1): 2
objects/obj_meteorites_maker/Alarm_7.gml(1): 2
objects/obj_meteorites_maker/Alarm_8.gml(1): 2
objects/obj_meteorites_maker/Alarm_9.gml(1): 2
objects/obj_multiveggiecoin/Collision_obj_mario.gml(1): 3
objects/obj_muncher_b_res/Other_13.gml(1): 1
objects/obj_muncher_res/Other_13.gml(1): 1
objects/obj_mushroom_platform_res/Mouse_4.gml(1): 17
objects/obj_musicblock/Create_0.gml(1): 52
objects/obj_n64_or/Collision_obj_mario.gml(1): 1
objects/obj_noteblock/Other_10.gml(1): 5
objects/obj_noteblock/Other_11.gml(1): 5
objects/obj_noteblock_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_noteblock_res/Other_12.gml(1): 5
objects/obj_noti_load_button/Mouse_4.gml(1): 4
objects/obj_nube/Collision_obj_thwomp.gml(1): 3
objects/obj_panel_save_load/Mouse_4.gml(1): 3
objects/obj_parcarry/Step_0.gml(1): 7
objects/obj_parent_resource/Mouse_4.gml(1): 9
objects/obj_parent_sounds/Mouse_4.gml(1): 9
objects/obj_pblock/Step_0.gml(1): 1
objects/obj_persistent/Alarm_4.gml(1): 10
objects/obj_persistent/Alarm_6.gml(1): 1
objects/obj_persistent/Create_0.gml(1): 3
objects/obj_plantfire/Other_10.gml(1): 1
objects/obj_platform_blue_res/Mouse_4.gml(1): 17
objects/obj_play_screen/Other_12.gml(1): 1
objects/obj_player_goal_nsmbu/Alarm_5.gml(1): 5
objects/obj_player_goal_nsmbu/Create_0.gml(1): 5
objects/obj_player_goal_nsmbu/Other_23.gml(1): 89
objects/obj_player_goal_smb1/Alarm_2.gml(1): 1
objects/obj_player_goal_smb2/Step_0.gml(1): 36
objects/obj_player_goal_smw_castle/Alarm_2.gml(1): 9
objects/obj_podoboo_b_res/Other_13.gml(1): 1
objects/obj_podoboo_res/Other_13.gml(1): 1
objects/obj_pokey_res/Mouse_4.gml(1): 23
objects/obj_pswitch/Other_17.gml(1): 6
objects/obj_pswitch/Step_0.gml(1): 46
objects/obj_puente_res/Mouse_4.gml(1): 17
objects/obj_qblock_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_qblock_res/Other_12.gml(1): 5
objects/obj_quicksand/Collision_obj_mario.gml(1): 4
objects/obj_rails_res/Collision_obj_parent_resource.gml(1): 5
objects/obj_rails_res/Mouse_4.gml(1): 17
objects/obj_rockparent/Other_10.gml(1): 7
objects/obj_semisolid_platform1/Mouse_4.gml(1): 17
objects/obj_shell_drybones/Other_10.gml(1): 1
objects/obj_shell_drybones/Other_11.gml(1): 6
objects/obj_shell_drybones_held/Other_10.gml(1): 1
objects/obj_shell_held/Other_11.gml(1): 7
objects/obj_sledgebro_res/Other_13.gml(1): 1
objects/obj_slider/Create_0.gml(1): 10
objects/obj_snow_ball_held/Collision_obj_enemyparent.gml(1): 5
objects/obj_spike_ball/Collision_obj_enemyparent.gml(1): 3
objects/obj_spike_ball/Collision_obj_enemyparent_held.gml(1): 3
objects/obj_spike_ball/Collision_obj_mario.gml(1): 5
objects/obj_spike_ball_b_res/Other_13.gml(1): 1
objects/obj_spike_ball_res/Other_13.gml(1): 1
objects/obj_spinner/Collision_obj_enemyparent.gml(1): 3
objects/obj_spinner/Collision_obj_spike_ball.gml(1): 1
objects/obj_spinner/Create_0.gml(1): 7
objects/obj_spinsmoke/Create_0.gml(1): 8
objects/obj_st_slider/Other_10.gml(1): 1
objects/obj_superball/Collision_obj_bobomb.gml(1): 1
objects/obj_superball/Collision_obj_enemyparent.gml(1): 5
objects/obj_superball/Create_0.gml(1): 1
objects/obj_superball/Other_10.gml(1): 1
objects/obj_thwomp_b_res/Other_13.gml(1): 1
objects/obj_thwomp_intro/Alarm_1.gml(1): 3
objects/obj_time/Mouse_4.gml(1): 3
objects/obj_title_oprime/Mouse_4.gml(1): 1
objects/obj_tuberia_res/Collision_obj_pplant_res.gml(1): 3
objects/obj_tuberia_res/Mouse_4.gml(1): 17
objects/obj_ventana/Create_0.gml(1): 24
objects/obj_ventana_mario/Create_0.gml(1): 3
objects/obj_ventana_water/Create_0.gml(1): 4
objects/obj_vine_res/Mouse_4.gml(1): 23
objects/obj_water_move/Mouse_4.gml(1): 7
objects/obj_water_move_limit/Mouse_4.gml(1): 7
objects/obj_window_alert/Create_0.gml(1): 4
objects/obj_window_alert/Destroy_0.gml(1): 14
objects/obj_window_button/Mouse_4.gml(1): 2
objects/obj_yoshi2/Destroy_0.gml(1): 2
objects/obj_yoshi_runaway/Collision_obj_mario.gml(1): 15
objects/obj_yoshi_runaway/Create_0.gml(1): 20
objects/obj_yoshi_runaway_blue/Collision_obj_mario.gml(1): 15
objects/obj_yoshi_runaway_red/Collision_obj_mario.gml(1): 15
objects/obj_yoshifire/Collision_obj_boomboom.gml(1): 1
objects/obj_yoshifire/Collision_obj_enemyparent.gml(1): 17
```
</details>

代表性片段（对全部命中等距抽样 14 条）：

| 位置 | 代码 |
|---|---|
| objects/cre_control/Other_4.gml:1 | `audio_play_sound(snd_credits, 99, false);` |
| objects/obj_blockbumper/Collision_obj_blockparent.gml:19 | `audio_play_sound(snd_bump, 0, false)` |
| objects/obj_bullebill_base_red_res/Step_2.gml:24 | `audio_play_sound(snd_rieles, 0, false)` |
| objects/obj_card_condiciones/Mouse_10.gml:6 | `audio_play_sound(snd_panel_izquierdo_move, 0, false)` |
| objects/obj_crumblebony_b/Alarm_1.gml:3 | `audio_stop_sound(snd_NSMBU_drybones_armar)` |
| objects/obj_fireflower_res/Other_13.gml:13 | `audio_play_sound(snd_remove_hongo, 0, false)` |
| objects/obj_helmet/Collision_obj_clown.gml:3 | `audio_stop_sound(snd_helmet)` |
| objects/obj_levelmanager/Step_2.gml:325 | `audio_sound_pitch(scr_snd_switchsong(), 1.1)` |
| objects/obj_marioU/Other_12.gml:230 | `audio_play_sound(choose(snd_NSMBU_triplejump_1, snd_NSMBU_triplejump_2, snd_NSMBU_triplejump_3), 0, false)` |
| objects/obj_menu_pausa/Other_11.gml:42 | `if audio_is_paused(music)` |
| objects/obj_panel_time/Mouse_10.gml:6 | `audio_play_sound(snd_panel_izquierdo_move, 0, false)` |
| objects/obj_selecting_player/Mouse_10.gml:5 | `audio_stop_sound(snd_settings_move)` |
| objects/obj_spinner/Create_0.gml:7 | `audio_play_sound(snd_atack_leaf, 0, false)` |
| scripts/scr_NSMBU_musicalscale_minirebote/scr_NSMBU_musicalscale_minirebote.gml:32 | `audio_play_sound(snd_NSMBU_minirebote_5, 0, false)` |

## 4. room 清单

来源：`rooms/<room>/<room>.yy`。所有 room 的图层均名为 `Compatibility_*`（旧工程转换产物，见各 yy 的 `layers[].name`）。

### rm_logo

- 文件：rooms/rm_logo/rm_logo.yy
- 尺寸：384×216，persistent=False（rooms/rm_logo/rm_logo.yy:35）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_logo/rm_logo.yy:52）
- views 数组（rooms/rm_logo/rm_logo.yy:42 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_logo/rm_logo.yy:28）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=2
- 图层：
  - `Compatibility_Instances_Depth_-99`（InstanceLayer，depth=-99，实例 1；obj_persistent×1）— rooms/rm_logo/rm_logo.yy:15
  - `Compatibility_Instances_Depth_-2`（InstanceLayer，depth=-2，实例 1；obj_logo_c×1）— rooms/rm_logo/rm_logo.yy:18
  - `background`（BackgroundLayer，depth=2147483600，spriteId=None，colour=4278650370，htiled=False，vtiled=False，stretch=False）— rooms/rm_logo/rm_logo.yy:21
- 实例总数：2，不同 object 数：2；object 分布：obj_persistent×1, obj_logo_c×1
- room 创建代码：`creationCodeFile`=（rooms/rm_logo/rm_logo.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_intro

- 文件：rooms/rm_intro/rm_intro.yy
- 尺寸：384×216，persistent=False（rooms/rm_intro/rm_intro.yy:36）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_intro/rm_intro.yy:53）
- views 数组（rooms/rm_intro/rm_intro.yy:43 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_intro/rm_intro.yy:29）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=2
- 图层：
  - `Compatibility_Instances_Depth_-1`（InstanceLayer，depth=-1，实例 1；obj_mario_intro×1）— rooms/rm_intro/rm_intro.yy:15
  - `Compatibility_Instances_Depth_0`（InstanceLayer，depth=0，实例 1；obj_intro_controller×1）— rooms/rm_intro/rm_intro.yy:18
  - `Compatibility_Background_0`（BackgroundLayer，depth=16777216，spriteId=None，colour=16777215，htiled=True，vtiled=True，stretch=False）— rooms/rm_intro/rm_intro.yy:21
  - `Compatibility_Colour`（BackgroundLayer，depth=16777216，spriteId=None，colour=4280404735，htiled=False，vtiled=False，stretch=False）— rooms/rm_intro/rm_intro.yy:22
- 实例总数：2，不同 object 数：2；object 分布：obj_mario_intro×1, obj_intro_controller×1
- room 创建代码：`creationCodeFile`=（rooms/rm_intro/rm_intro.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_title

- 文件：rooms/rm_title/rm_title.yy
- 尺寸：1152×432，persistent=False（rooms/rm_title/rm_title.yy:59）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_title/rm_title.yy:76）
- views 数组（rooms/rm_title/rm_title.yy:66 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_title/rm_title.yy:52）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=8
- 图层：
  - `Compatibility_Instances_Depth_-40`（InstanceLayer，depth=-40，实例 1；obj_cursor×1）— rooms/rm_title/rm_title.yy:21
  - `Compatibility_Instances_Depth_-26`（InstanceLayer，depth=-26，实例 1；obj_title_controller×1）— rooms/rm_title/rm_title.yy:24
  - `Compatibility_Instances_Depth_-25`（InstanceLayer，depth=-25，实例 1；obj_title_oprime×1）— rooms/rm_title/rm_title.yy:27
  - `Compatibility_Instances_Depth_-11`（InstanceLayer，depth=-11，实例 1；obj_levelmanager×1）— rooms/rm_title/rm_title.yy:30
  - `Compatibility_Instances_Depth_-8`（InstanceLayer，depth=-8，实例 1；obj_mario×1）— rooms/rm_title/rm_title.yy:33
  - `Compatibility_Instances_Depth_0`（InstanceLayer，depth=0，实例 1；obj_load_guardabot×1）— rooms/rm_title/rm_title.yy:36
  - `Compatibility_Instances_Depth_10`（InstanceLayer，depth=10，实例 1；obj_ground2×1）— rooms/rm_title/rm_title.yy:39
  - `Compatibility_Instances_Depth_300`（InstanceLayer，depth=300，实例 1；obj_ground3×1）— rooms/rm_title/rm_title.yy:42
  - `Compatibility_Background_0_bg_ground`（BackgroundLayer，depth=2147483500，spriteId=bg_ground，colour=4294967295，htiled=True，vtiled=True，stretch=False）— rooms/rm_title/rm_title.yy:45
- 实例总数：8，不同 object 数：8；object 分布：obj_cursor×1, obj_title_controller×1, obj_title_oprime×1, obj_levelmanager×1, obj_mario×1, obj_load_guardabot×1, obj_ground2×1, obj_ground3×1
- room 创建代码：`creationCodeFile`=（rooms/rm_title/rm_title.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_template

- 文件：rooms/rm_template/rm_template.yy
- 尺寸：640×432，persistent=False（rooms/rm_template/rm_template.yy:34）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_template/rm_template.yy:51）
- views 数组（rooms/rm_template/rm_template.yy:41 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_template/rm_template.yy:27）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=1
- 图层：
  - `Compatibility_Instances_Depth_-11`（InstanceLayer，depth=-11，实例 1；obj_levelmanager×1）— rooms/rm_template/rm_template.yy:14
  - `Compatibility_Tiles_Depth_9`（GMRAssetLayer，depth=9）— rooms/rm_template/rm_template.yy:17
  - `Compatibility_Background_0_bg_ground`（BackgroundLayer，depth=2147483500，spriteId=bg_ground，colour=4294967295，htiled=True，vtiled=True，stretch=False）— rooms/rm_template/rm_template.yy:20
- 实例总数：1，不同 object 数：1；object 分布：obj_levelmanager×1
- room 创建代码：`creationCodeFile`=（rooms/rm_template/rm_template.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 1 个；磁盘 InstanceCreationCode_*.gml 1 个：
  - rooms/rm_template/InstanceCreationCode_inst_186AD.gml（2 行）：`leveltime = 300 levelmusic = 109`

### rm_gameover

- 文件：rooms/rm_gameover/rm_gameover.yy
- 尺寸：384×216，persistent=False（rooms/rm_gameover/rm_gameover.yy:31）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_gameover/rm_gameover.yy:48）
- views 数组（rooms/rm_gameover/rm_gameover.yy:38 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_gameover/rm_gameover.yy:24）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=1
- 图层：
  - `Compatibility_Instances_Depth_-5`（InstanceLayer，depth=-5，实例 1；obj_game_over×1）— rooms/rm_gameover/rm_gameover.yy:14
  - `Compatibility_Colour`（BackgroundLayer，depth=2147483600，spriteId=None，colour=4278190080，htiled=False，vtiled=False，stretch=False）— rooms/rm_gameover/rm_gameover.yy:17
- 实例总数：1，不同 object 数：1；object 分布：obj_game_over×1
- room 创建代码：`creationCodeFile`=（rooms/rm_gameover/rm_gameover.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_credito

- 文件：rooms/rm_credito/rm_credito.yy
- 尺寸：384×216，persistent=False（rooms/rm_credito/rm_credito.yy:39）
- 视图设置：enableViews=True，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_credito/rm_credito.yy:56）
- views 数组（rooms/rm_credito/rm_credito.yy:46 起）共 8 项，visible=true 的 1 项：
  - view[0]: xview=0 yview=0 wview=384 hview=216 | xport=0 yport=0 wport=384 hport=216 | hborder=32 vborder=32 hspeed=-1 vspeed=-1 | follow=None
- physicsSettings: PhysicsWorld=False（rooms/rm_credito/rm_credito.yy:32）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=3
- 图层：
  - `Compatibility_Instances_Depth_-40`（InstanceLayer，depth=-40，实例 1；obj_cursor×1）— rooms/rm_credito/rm_credito.yy:16
  - `Compatibility_Instances_Depth_-19`（InstanceLayer，depth=-19，实例 1；obj_ccred×1）— rooms/rm_credito/rm_credito.yy:19
  - `Compatibility_Instances_Depth_0`（InstanceLayer，depth=0，实例 1；cre_control×1）— rooms/rm_credito/rm_credito.yy:22
  - `Compatibility_Colour`（BackgroundLayer，depth=2147483600，spriteId=None，colour=4278650370，htiled=False，vtiled=False，stretch=False）— rooms/rm_credito/rm_credito.yy:25
- 实例总数：3，不同 object 数：3；object 分布：obj_cursor×1, obj_ccred×1, cre_control×1
- room 创建代码：`creationCodeFile`=（rooms/rm_credito/rm_credito.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_course_world

- 文件：rooms/rm_course_world/rm_course_world.yy
- 尺寸：384×216，persistent=False（rooms/rm_course_world/rm_course_world.yy:28）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_course_world/rm_course_world.yy:45）
- views 数组（rooms/rm_course_world/rm_course_world.yy:35 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_course_world/rm_course_world.yy:21）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=0
- 图层：
  - `Compatibility_Instances_Depth_-40`（InstanceLayer，depth=-40，实例 0；）— rooms/rm_course_world/rm_course_world.yy:12
  - `Compatibility_Instances_Depth_0`（InstanceLayer，depth=0，实例 0；）— rooms/rm_course_world/rm_course_world.yy:13
  - `Compatibility_Background_0_bg_super_experto`（BackgroundLayer，depth=2147483500，spriteId=bg_troll，colour=4294967295，htiled=True，vtiled=True，stretch=True）— rooms/rm_course_world/rm_course_world.yy:14
- 实例总数：0，不同 object 数：0；
- room 创建代码：`creationCodeFile`=（rooms/rm_course_world/rm_course_world.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_guardabot

- 文件：rooms/rm_guardabot/rm_guardabot.yy
- 尺寸：384×216，persistent=False（rooms/rm_guardabot/rm_guardabot.yy:40）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_guardabot/rm_guardabot.yy:57）
- views 数组（rooms/rm_guardabot/rm_guardabot.yy:47 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_guardabot/rm_guardabot.yy:33）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=3
- 图层：
  - `Compatibility_Instances_Depth_-40`（InstanceLayer，depth=-40，实例 1；obj_cursor×1）— rooms/rm_guardabot/rm_guardabot.yy:16
  - `Compatibility_Instances_Depth_-6`（InstanceLayer，depth=-6，实例 1；obj_guardabot×1）— rooms/rm_guardabot/rm_guardabot.yy:19
  - `Compatibility_Instances_Depth_-4`（InstanceLayer，depth=-4，实例 1；obj_btn_reload×1）— rooms/rm_guardabot/rm_guardabot.yy:22
  - `Compatibility_Background_0_bg_guardabot`（BackgroundLayer，depth=2147483500，spriteId=bg_guardabot，colour=4294967295，htiled=True，vtiled=True，stretch=False）— rooms/rm_guardabot/rm_guardabot.yy:25
  - `Compatibility_Colour`（BackgroundLayer，depth=2147483600，spriteId=None，colour=4290822336，htiled=False，vtiled=False，stretch=False）— rooms/rm_guardabot/rm_guardabot.yy:26
- 实例总数：3，不同 object 数：3；object 分布：obj_cursor×1, obj_guardabot×1, obj_btn_reload×1
- room 创建代码：`creationCodeFile`=（rooms/rm_guardabot/rm_guardabot.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_guardabot_play

- 文件：rooms/rm_guardabot_play/rm_guardabot_play.yy
- 尺寸：1152×432，persistent=False（rooms/rm_guardabot_play/rm_guardabot_play.yy:47）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_guardabot_play/rm_guardabot_play.yy:64）
- views 数组（rooms/rm_guardabot_play/rm_guardabot_play.yy:54 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_guardabot_play/rm_guardabot_play.yy:40）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=5
- 图层：
  - `Compatibility_Instances_Depth_-11`（InstanceLayer，depth=-11，实例 1；obj_levelmanager×1）— rooms/rm_guardabot_play/rm_guardabot_play.yy:18
  - `Compatibility_Instances_Depth_-8`（InstanceLayer，depth=-8，实例 1；obj_mario×1）— rooms/rm_guardabot_play/rm_guardabot_play.yy:21
  - `Compatibility_Instances_Depth_0`（InstanceLayer，depth=0，实例 1；obj_load_guardabot×1）— rooms/rm_guardabot_play/rm_guardabot_play.yy:24
  - `Compatibility_Instances_Depth_10`（InstanceLayer，depth=10，实例 1；obj_ground2×1）— rooms/rm_guardabot_play/rm_guardabot_play.yy:27
  - `Compatibility_Instances_Depth_300`（InstanceLayer，depth=300，实例 1；obj_ground3×1）— rooms/rm_guardabot_play/rm_guardabot_play.yy:30
  - `Compatibility_Background_0_bg_ground`（BackgroundLayer，depth=2147483500，spriteId=bg_ground，colour=4294967295，htiled=True，vtiled=True，stretch=False）— rooms/rm_guardabot_play/rm_guardabot_play.yy:33
- 实例总数：5，不同 object 数：5；object 分布：obj_levelmanager×1, obj_mario×1, obj_load_guardabot×1, obj_ground2×1, obj_ground3×1
- room 创建代码：`creationCodeFile`=（rooms/rm_guardabot_play/rm_guardabot_play.yy:5）；文件为空字符串
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 0 个；磁盘 InstanceCreationCode_*.gml 0 个。

### rm_editor

- 文件：rooms/rm_editor/rm_editor.yy
- 尺寸：1152×432，persistent=False（rooms/rm_editor/rm_editor.yy:107）
- 视图设置：enableViews=False，clearDisplayBuffer=True，clearViewBackground=True（rooms/rm_editor/rm_editor.yy:124）
- views 数组（rooms/rm_editor/rm_editor.yy:114 起）共 8 项，visible=true 的 0 项。
- physicsSettings: PhysicsWorld=False（rooms/rm_editor/rm_editor.yy:100）
- 创建顺序/继承：inheritCode=False，inheritLayers=False，parentRoom=None；instanceCreationOrder 项数=29
- 图层：
  - `Compatibility_Instances_Depth_-40`（InstanceLayer，depth=-40，实例 1；obj_cursor×1）— rooms/rm_editor/rm_editor.yy:42
  - `Compatibility_Instances_Depth_-14`（InstanceLayer，depth=-14，实例 1；obj_creator_jugar_editar×1）— rooms/rm_editor/rm_editor.yy:45
  - `Compatibility_Instances_Depth_-12`（InstanceLayer，depth=-12，实例 2；obj_robot×1, obj_card_autoavance×1）— rooms/rm_editor/rm_editor.yy:48
  - `Compatibility_Instances_Depth_-11`（InstanceLayer，depth=-11，实例 1；obj_levelmanager×1）— rooms/rm_editor/rm_editor.yy:52
  - `Compatibility_Instances_Depth_-10`（InstanceLayer，depth=-10，实例 18；obj_card_item×12, obj_erase×1, obj_card_rocket×1, obj_expand×1, obj_menu_editor×1, obj_card_block_sounds×1, obj_dog×1）— rooms/rm_editor/rm_editor.yy:55
  - `Compatibility_Instances_Depth_-9`（InstanceLayer，depth=-9，实例 1；obj_editormanager×1）— rooms/rm_editor/rm_editor.yy:75
  - `Compatibility_Instances_Depth_-8`（InstanceLayer，depth=-8，实例 1；obj_panel_left×1）— rooms/rm_editor/rm_editor.yy:78
  - `Compatibility_Instances_Depth_-7`（InstanceLayer，depth=-7，实例 1；obj_mario_editor×1）— rooms/rm_editor/rm_editor.yy:81
  - `Compatibility_Instances_Depth_10`（InstanceLayer，depth=10，实例 1；obj_ground2×1）— rooms/rm_editor/rm_editor.yy:84
  - `Compatibility_Instances_Depth_300`（InstanceLayer，depth=300，实例 1；obj_ground3×1）— rooms/rm_editor/rm_editor.yy:87
  - `Compatibility_Instances_Depth_369`（InstanceLayer，depth=369，实例 1；obj_grid×1）— rooms/rm_editor/rm_editor.yy:90
  - `Compatibility_Background_0_bg_ground`（BackgroundLayer，depth=2147483500，spriteId=bg_ground，colour=4294967295，htiled=True，vtiled=True，stretch=False）— rooms/rm_editor/rm_editor.yy:93
- 实例总数：29，不同 object 数：18；object 分布：obj_card_item×12, obj_cursor×1, obj_creator_jugar_editar×1, obj_robot×1, obj_card_autoavance×1, obj_levelmanager×1, obj_erase×1, obj_card_rocket×1, obj_expand×1, obj_menu_editor×1, obj_card_block_sounds×1, obj_dog×1, obj_editormanager×1, obj_panel_left×1, obj_mario_editor×1, obj_ground2×1, obj_ground3×1, obj_grid×1
- room 创建代码：`creationCodeFile`=${project_dir}/rooms/rm_editor/RoomCreationCode.gml（rooms/rm_editor/rm_editor.yy:5）；文件在磁盘上不存在
- 实例创建代码：yy 中 `hasCreationCode`=true 的实例 13 个；磁盘 InstanceCreationCode_*.gml 13 个：
  - rooms/rm_editor/InstanceCreationCode_inst_186BE.gml（5 行）：`editor = 1 if (global.levelguardabot == "") { leveltime = 300 }`
  - rooms/rm_editor/InstanceCreationCode_inst_186C2.gml（5 行）：`obj = obj_pswitch_res value = 0 x_pos = 38 obj_draw = 117 bg_color = 3`
  - rooms/rm_editor/InstanceCreationCode_inst_186C3.gml（5 行）：`obj = obj_spring_res value = 1 x_pos = 64 obj_draw = 128 bg_color = 3`
  - rooms/rm_editor/InstanceCreationCode_inst_186C4.gml（5 行）：`obj = obj_pplant_res value = 2 x_pos = 90 obj_draw = 116 bg_color = 2`
  - rooms/rm_editor/InstanceCreationCode_inst_186C5.gml（5 行）：`obj = obj_koopa_res value = 3 x_pos = 116 obj_draw = 94 bg_color = 2`
  - rooms/rm_editor/InstanceCreationCode_inst_186C6.gml（5 行）：`obj = obj_goomba_res value = 4 x_pos = 142 obj_draw = 69 bg_color = 2`
  - rooms/rm_editor/InstanceCreationCode_inst_186C7.gml（5 行）：`obj = obj_mushroom_res value = 5 x_pos = 168 obj_draw = 96 bg_color = 1`
  - rooms/rm_editor/InstanceCreationCode_inst_186C8.gml（5 行）：`obj = obj_coin_res value = 6 x_pos = 194 obj_draw = 46 bg_color = 1`
  - rooms/rm_editor/InstanceCreationCode_inst_186C9.gml（5 行）：`obj = obj_rock_res value = 7 x_pos = 220 obj_draw = 17 bg_color = 0`
  - rooms/rm_editor/InstanceCreationCode_inst_186CA.gml（5 行）：`obj = obj_block_res value = 8 x_pos = 246 obj_draw = 64 bg_color = 0`
  - rooms/rm_editor/InstanceCreationCode_inst_186CB.gml（5 行）：`obj = obj_qblock_res value = 9 x_pos = 272 obj_draw = 93 bg_color = 0`
  - rooms/rm_editor/InstanceCreationCode_inst_186CC.gml（5 行）：`obj = obj_pinchos_res value = 10 x_pos = 298 obj_draw = 106 bg_color = 0`
  - rooms/rm_editor/InstanceCreationCode_inst_186CD.gml（5 行）：`obj = obj_ground value = 11 x_pos = 324 obj_draw = 72 bg_color = 0`

## 5. 脚本调用关系

检测规则：
- 定义：`scripts/<name>/<name>.gml` 中匹配 `^\s*function\s+(\w+)` 的行（共 294 个脚本文件，294 个函数）。obj_dcw/Create_0.gml 内另有 8 个内联 function（对象内方法，见 §5.3）。
- 调用：在全部 .gml（已去注释/去字符串）中匹配 `(?<![\w.])<函数名>\s*\(`，排除 `function <名>` 定义行；另将 `script_execute(<名>` 视为调用。未覆盖：把函数当值传递、`asset_get_index` / 字符串名动态调用、extension 调用（见 §6）。
- 调用点显示规则：总调用点 ≤40 且涉及 ≤15 个文件时全部列出；否则列出调用次数最多的 15 个文件，每文件最多 8 个行号（超出以 `…`/`×N` 表示），余量计入“另 N 个文件”。总调用数与文件数始终完整。

### 5.1 调用次数排行（前 40）

| 函数 | 定义 | 调用点总数 | 调用文件数 |
|---|---|---|---|
| instance_create | scripts/instance_create/instance_create.gml:5 | 3581 | 1258 |
| __background_set | scripts/__background_set/__background_set.gml:1 | 1097 | 14 |
| scr_language | scripts/scr_language/scr_language.gml:3 | 241 | 71 |
| __view_get | scripts/__view_get/__view_get.gml:1 | 128 | 18 |
| scr_snd_kick | scripts/scr_snd_kick/scr_snd_kick.gml:1 | 117 | 70 |
| outside_view | scripts/outside_view/outside_view.gml:1 | 64 | 54 |
| scr_anim_hover | scripts/scr_anim_hover/scr_anim_hover.gml:1 | 61 | 59 |
| scr_snd_powerup | scripts/scr_snd_powerup/scr_snd_powerup.gml:1 | 45 | 27 |
| scr_snd_switchsong | scripts/scr_snd_switchsong/scr_snd_switchsong.gml:1 | 42 | 21 |
| scr_snd_starman | scripts/scr_snd_starman/scr_snd_starman.gml:1 | 34 | 16 |
| scr_snd_thwomp | scripts/scr_snd_thwomp/scr_snd_thwomp.gml:1 | 32 | 12 |
| scr_snd_bump | scripts/scr_snd_bump/scr_snd_bump.gml:1 | 29 | 15 |
| scr_swim | scripts/scr_swim/scr_swim.gml:1 | 29 | 3 |
| scr_snd_powerdown | scripts/scr_snd_powerdown/scr_snd_powerdown.gml:1 | 23 | 19 |
| scr_insideview | scripts/scr_insideview/scr_insideview.gml:1 | 23 | 23 |
| scr_snd_break | scripts/scr_snd_break/scr_snd_break.gml:1 | 22 | 12 |
| scr_snd_skid | scripts/scr_snd_skid/scr_snd_skid.gml:1 | 21 | 9 |
| scr_marioclimb | scripts/scr_marioclimb/scr_marioclimb.gml:1 | 18 | 9 |
| scr_snd_stomp | scripts/scr_snd_stomp/scr_snd_stomp.gml:1 | 17 | 8 |
| scr_marioidle | scripts/scr_marioidle/scr_marioidle.gml:1 | 17 | 15 |
| gpu_set_blendenable | scripts/draw_enable_alphablend/draw_enable_alphablend.gml:3 | 17 | 9 |
| scr_jump | scripts/scr_jump/scr_jump.gml:1 | 16 | 10 |
| scr_music_link | scripts/scr_music_link/scr_music_link.gml:1 | 16 | 10 |
| scr_mario_shoe | scripts/scr_mario_shoe/scr_mario_shoe.gml:1 | 16 | 4 |
| sprite_exists | scripts/background_exists/background_exists.gml:4 | 15 | 15 |
| scr_mariowalk | scripts/scr_mariowalk/scr_mariowalk.gml:1 | 14 | 8 |
| scr_NSMBU_idle | scripts/scr_NSMBU_idle/scr_NSMBU_idle.gml:1 | 14 | 5 |
| init_shake | scripts/init_shake/init_shake.gml:1 | 13 | 9 |
| gpu_set_blendmode | scripts/draw_set_blend_mode/draw_set_blend_mode.gml:3 | 13 | 7 |
| scr_musicalscale | scripts/scr_musicalscale/scr_musicalscale.gml:1 | 13 | 10 |
| string_add_zeros | scripts/string_add_zeros/string_add_zeros.gml:1 | 13 | 5 |
| scr_bg_underwater | scripts/scr_bg_underwater/scr_bg_underwater.gml:1 | 12 | 12 |
| scr_bg_ghost_house | scripts/scr_bg_ghost_house/scr_bg_ghost_house.gml:1 | 12 | 6 |
| scr_constant_get_sprite | scripts/scr_constant_get_sprite/scr_constant_get_sprite.gml:1 | 12 | 10 |
| scr_toast | scripts/scr_toast/scr_toast.gml:1 | 12 | 8 |
| __view_set | scripts/__view_set/__view_set.gml:1 | 12 | 1 |
| scr_snd_hurryup | scripts/scr_snd_hurryup/scr_snd_hurryup.gml:1 | 12 | 8 |
| scr_NSMBU_jump1 | scripts/scr_NSMBU_jump1/scr_NSMBU_jump1.gml:2 | 12 | 5 |
| draw_sprite_custom_origin | scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:13 | 11 | 10 |
| scr_marioswimhold | scripts/scr_marioswimhold/scr_marioswimhold.gml:1 | 11 | 5 |

### 5.2 全部脚本/函数

| 脚本(函数) | 定义 path:line | 行数 | 文件夹 | 调用点(总数/文件数) | 被谁调用 | 本脚本调用的脚本函数 |
|---|---|---|---|---|---|---|
| LoadJSONFromFile | scripts/LoadJSONFromFile/LoadJSONFromFile.gml:1 | 21 | Scripts | 3/3 | objects/obj_gb_level/Create_0.gml:49; objects/obj_load_guardabot/Other_11.gml:7; objects/obj_load_level/Other_10.gml:6 | sha1_string_utf8_hmac(:9) |
| SaveStringToFile | scripts/SaveStringToFile/SaveStringToFile.gml:1 | 12 | Scripts | 2/2 | objects/obj_button_notification_aceptar/Other_10.gml:215; objects/obj_button_save_changes/Other_10.gml:215 | - |
| __background_get | scripts/__background_get/__background_get.gml:1 | 11 | Scripts/compatibility/background | 1/1 | objects/obj_mario_transform2/Create_0.gml:91 | __background_get_element(:5), __background_get_internal(:7) |
| __background_get_element | scripts/__background_get_element/__background_get_element.gml:1 | 88 | Scripts/compatibility/background | 3/3 | scripts/__background_get/__background_get.gml:5; scripts/__background_get_internal/__background_get_internal.gml:10; scripts/__background_set/__background_set.gml:6 | __background_set_element(:79) |
| __background_get_internal | scripts/__background_get_internal/__background_get_internal.gml:1 | 48 | Scripts/compatibility/background | 2/2 | scripts/__background_get/__background_get.gml:7; scripts/__background_set/__background_set.gml:10 | __background_get_element(:10) |
| __background_set | scripts/__background_set/__background_set.gml:1 | 14 | Scripts/compatibility/background | 1097/14 | objects/obj_load_level/Other_11.gml:1,2,3,4,5,6,7,8…(×160); objects/obj_angrysun_res/Other_11.gml:11,12,13,14,15,16,17,18…(×159); objects/obj_bg1/Other_10.gml:1,2,3,4,5,6,7,8…(×159); objects/obj_card_logo/Mouse_4.gml:3,4,5,6,7,8,9,10…(×159); objects/obj_load_guardabot/Other_12.gml:1,2,3,4,5,6,7,8…(×159); objects/obj_night_change/Other_11.gml:2,3,4,5,6,7,8,9…(×159); objects/obj_levelmanager/Other_21.gml:7,8,9,10,11,12,13,16…(×96); objects/obj_creator_jugar_editar/Other_13.gml:70,71,72,73,74,75,80,82…(×23); objects/obj_load_guardabot/Other_11.gml:391,392,393,394,395,396,402,404…(×15); objects/obj_bganimator/Alarm_0.gml:63,67,76; objects/obj_titlemenu_key/KeyPress_1.gml:85,86; objects/obj_mario_transform2/Create_0.gml:92; objects/obj_mario_transform2/Destroy_0.gml:4; objects/obj_persistent/Alarm_4.gml:11 | __background_get_element(:6), __background_get_internal(:10), __background_set_internal(:8) |
| __background_set_element | scripts/__background_set_element/__background_set_element.gml:1 | 192 | Scripts/compatibility/background | 2/2 | scripts/__background_get_element/__background_get_element.gml:79; scripts/__background_set_internal/__background_set_internal.gml:38 | - |
| __background_set_internal | scripts/__background_set_internal/__background_set_internal.gml:1 | 72 | Scripts/compatibility/background | 1/1 | scripts/__background_set/__background_set.gml:8 | __background_set_element(:38), sprite_exists(:49) |
| __global_object_depths | scripts/__global_object_depths/__global_object_depths.gml:1 | 1611 | Scripts/compatibility | 0/0 | - | - |
| __init_action | scripts/__init_action/__init_action.gml:1 | 15 | Scripts/compatibility/action | 0/0 | - | - |
| __init_background | scripts/__init_background/__init_background.gml:1 | 24 | Scripts/compatibility/background | 0/0 | - | - |
| __init_global | scripts/__init_global/__init_global.gml:1 | 9 | Scripts/compatibility | 0/0 | - | - |
| __init_view | scripts/__init_view/__init_view.gml:1 | 24 | Scripts/compatibility/view | 0/0 | - | - |
| __view_get | scripts/__view_get/__view_get.gml:1 | 32 | Scripts/compatibility/view | 128/18 | objects/obj_editormanager/Step_1.gml:13,13,15,15,19,19,19,21…(×51); objects/obj_levelmanager/Step_2.gml:48,57,59,62,71,73,76,81…(×16); objects/obj_levelmanager/Other_18.gml:1,3,7,9,13,15,81,81…(×15); scripts/outside_view/outside_view.gml:3,3,3,3,3,3; objects/obj_levelmanager/Other_17.gml:6,7,20,21; objects/obj_meteorites_maker/Alarm_1.gml:4,4,4; objects/obj_meteorites_maker/Alarm_10.gml:3,3,3; objects/obj_meteorites_maker/Alarm_2.gml:3,3,3; objects/obj_meteorites_maker/Alarm_3.gml:3,3,3; objects/obj_meteorites_maker/Alarm_4.gml:3,3,3; objects/obj_meteorites_maker/Alarm_5.gml:3,3,3; objects/obj_meteorites_maker/Alarm_6.gml:3,3,3; objects/obj_meteorites_maker/Alarm_7.gml:3,3,3; objects/obj_meteorites_maker/Alarm_8.gml:3,3,3; objects/obj_meteorites_maker/Alarm_9.gml:3,3,3; …另 3 个文件 6 处 | - |
| __view_set | scripts/__view_set/__view_set.gml:1 | 13 | Scripts/compatibility/view | 12/1 | objects/obj_editormanager/Step_1.gml:76,77,81,82,86,87,97,98…(×12) | __view_get(:8), __view_set_internal(:6) |
| __view_set_internal | scripts/__view_set_internal/__view_set_internal.gml:1 | 31 | Scripts/compatibility/view | 1/1 | scripts/__view_set/__view_set.gml:6 | - |
| action_end_game | scripts/action_end_game/action_end_game.gml:2 | 6 | Scripts/compatibility/action | 0/0 | - | - |
| action_set_motion | scripts/action_set_motion/action_set_motion.gml:4 | 16 | Scripts/compatibility/action | 1/1 | objects/obj_bganimator/Alarm_0.gml:81 | - |
| background_create_from_surface | scripts/background_create_from_surface/background_create_from_surface.gml:10 | 15 | Scripts/compatibility/background | 10/10 | objects/obj_curtainout/Create_0.gml:2; objects/obj_fadein/Create_0.gml:2; objects/obj_iname_control/Create_0.gml:9; objects/obj_iname_control2/Create_0.gml:9; objects/obj_mario_transform2/Alarm_0.gml:7; objects/obj_menu_pausa/Create_0.gml:14; objects/obj_persistent/Other_10.gml:5; objects/obj_persistent/Other_5.gml:5; objects/obj_rename_control/Create_0.gml:8; objects/obj_titlemenu_key/Create_0.gml:8 | - |
| background_delete → sprite_delete | scripts/background_delete/background_delete.gml:4 | 9 | Scripts/compatibility/background | 9/9 | objects/obj_fadein/Step_2.gml:6; objects/obj_iname_control/Destroy_0.gml:19; objects/obj_mario_transform2/Destroy_0.gml:2; objects/obj_menu_pausa/Other_10.gml:5; objects/obj_menu_pausa/Other_11.gml:5; objects/obj_persistent/Alarm_0.gml:15; objects/obj_rename_control/Destroy_0.gml:9; objects/obj_titlemenu_key/KeyPress_1.gml:81; scripts/background_delete/background_delete.gml:6 | sprite_delete(:6) |
| background_exists → sprite_exists | scripts/background_exists/background_exists.gml:4 | 9 | Scripts/compatibility/background | 15/15 | objects/obj_fadein/Draw_0.gml:1; objects/obj_fadein/Step_2.gml:5; objects/obj_iname_control/Destroy_0.gml:18; objects/obj_iname_control/Draw_0.gml:1; objects/obj_mario_transform2/Draw_0.gml:1; objects/obj_menu_pausa/Draw_0.gml:3; objects/obj_menu_pausa/Other_10.gml:4; objects/obj_menu_pausa/Other_11.gml:4; objects/obj_persistent/Alarm_0.gml:14; objects/obj_persistent/Draw_0.gml:2; objects/obj_rename_control/Destroy_0.gml:8; objects/obj_rename_control/Draw_0.gml:1; objects/obj_titlemenu_key/Draw_0.gml:1; scripts/__background_set_internal/__background_set_internal.gml:49; scripts/background_exists/background_exists.gml:6 | sprite_exists(:6) |
| discord_free_app | scripts/discord_free_app/discord_free_app.gml:1 | 6 | Scripts/Misc | 0/0 | - | - |
| discord_free_dll | scripts/discord_free_dll/discord_free_dll.gml:1 | 6 | Scripts/Misc | 0/0 | - | - |
| discord_init_app | scripts/discord_init_app/discord_init_app.gml:1 | 6 | Scripts/Misc | 0/0 | - | - |
| discord_init_dll | scripts/discord_init_dll/discord_init_dll.gml:1 | 9 | Scripts/Misc | 0/0 | - | - |
| discord_update_presence | scripts/discord_update_presence/discord_update_presence.gml:1 | 6 | Scripts/Misc | 0/0 | - | - |
| discord_webhook | scripts/discord_webhook/discord_webhook.gml:3 | 23 | Scripts/Misc | 0/0 | - | - |
| draw_background | scripts/draw_background/draw_background.gml:6 | 11 | Scripts/compatibility/background | 0/0 | - | - |
| draw_background_ext | scripts/draw_background_ext/draw_background_ext.gml:11 | 16 | Scripts/compatibility/background | 0/0 | - | - |
| draw_circle_colour_precise | scripts/draw_circle_colour_precise/draw_circle_colour_precise.gml:1 | 7 | Scripts/Misc | 2/2 | objects/obj_curtainin/Step_0.gml:9; objects/obj_curtainout/Step_0.gml:9 | - |
| draw_enable_alphablend → gpu_set_blendenable | scripts/draw_enable_alphablend/draw_enable_alphablend.gml:3 | 7 | Scripts/compatibility/draw | 17/9 | objects/obj_fadein/Draw_0.gml:3,5; objects/obj_iname_control/Draw_0.gml:3,6; objects/obj_mario_transform2/Draw_0.gml:3,6; objects/obj_menu_pausa/Draw_0.gml:5,8; objects/obj_persistent/Draw_0.gml:4,7; objects/obj_persistent/Draw_64.gml:2,16; objects/obj_rename_control/Draw_0.gml:3,6; objects/obj_titlemenu_key/Draw_0.gml:3,6; scripts/draw_enable_alphablend/draw_enable_alphablend.gml:4 | gpu_set_blendenable(:4) |
| draw_set_blend_mode → gpu_set_blendmode | scripts/draw_set_blend_mode/draw_set_blend_mode.gml:3 | 7 | Scripts/compatibility/draw | 13/7 | objects/obj_blend_ring/Draw_0.gml:4,9; objects/obj_curtainin/Draw_0.gml:1,5; objects/obj_curtainin/Step_0.gml:8,10; objects/obj_curtainout/Draw_0.gml:1,3; objects/obj_curtainout/Step_0.gml:8,10; objects/obj_lighting/Step_0.gml:7,264; scripts/draw_set_blend_mode/draw_set_blend_mode.gml:4 | gpu_set_blendmode(:4) |
| draw_sprite_autotiled | scripts/draw_sprite_autotiled/draw_sprite_autotiled.gml:8 | 182 | Scripts | 0/0 | - | - |
| draw_sprite_autotiled2 | scripts/draw_sprite_autotiled2/draw_sprite_autotiled2.gml:8 | 183 | Scripts | 0/0 | - | - |
| draw_sprite_custom_origin | scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:13 | 32 | Scripts | 11/10 | objects/obj_block/Draw_0.gml:6; objects/obj_block_gold/Draw_0.gml:6; objects/obj_block_multicoin/Draw_0.gml:7; objects/obj_blockparent/Draw_0.gml:7; objects/obj_cooligan_res/Draw_0.gml:11; objects/obj_flipblock/Draw_0.gml:7; objects/obj_musicblock/Draw_0.gml:6; objects/obj_noteblock/Draw_0.gml:6; objects/obj_onoffblock/Draw_0.gml:3; objects/obj_waddlewing_res/Draw_0.gml:8,11 | - |
| draw_sprite_tiled_area_ext | scripts/draw_sprite_tiled_area_ext/draw_sprite_tiled_area_ext.gml:12 | 71 | Scripts | 4/1 | objects/obj_skewertrunk/Draw_0.gml:4,8,12,16 | - |
| draw_text_lang | scripts/draw_text_lang/draw_text_lang.gml:8 | 31 | Scripts | 0/0 | - | - |
| has_internet | scripts/has_internet/has_internet.gml:1 | 8 | Scripts/Misc | 0/0 | - | - |
| hex_string_byte | scripts/hex_string_byte/hex_string_byte.gml:1 | 20 | Scripts/Misc | 2/1 | scripts/sha1_string_utf8_hmac/sha1_string_utf8_hmac.gml:16,31 | - |
| init_shake | scripts/init_shake/init_shake.gml:1 | 13 | Scripts | 13/9 | objects/obj_ahh_or/Other_10.gml:9; objects/obj_axe_smw/Step_0.gml:10; objects/obj_block_pow_hold/Other_16.gml:3; objects/obj_meteorites_maker/Alarm_0.gml:3; objects/obj_muncher/Other_14.gml:34; objects/obj_skewertrunk/Other_15.gml:12; objects/obj_thwomp/Step_0.gml:41,117,178; objects/obj_thwomp_b/Step_0.gml:43,135,210; objects/obj_ubsi_or/Other_10.gml:9 | - |
| init_shockwave | scripts/init_shockwave/init_shockwave.gml:1 | 21 | Scripts/Misc | 1/1 | objects/obj_persistent/Create_0.gml:2 | - |
| instance_create | scripts/instance_create/instance_create.gml:5 | 10 | Scripts/compatibility/instance | 3581/1258 | scripts/scr_sprite_make_object/scr_sprite_make_object.gml:7,9,11,13,15,17,19,21…(×245); scripts/scr_sprite_make_object_rieles/scr_sprite_make_object_rieles.gml:7,9,11,13,15,17,19,21…(×245); scripts/scr_edit_to_play/scr_edit_to_play.gml:76,83,123,231,234,235,244,246…(×179); objects/obj_magic/Step_0.gml:19,24,27,32,37,42,47,54…(×75); scripts/scr_constant_make_object/scr_constant_make_object.gml:7,9,11,13,22,24,26,28…(×61); objects/obj_yoshi2/Other_10.gml:11,15,20,22,30,34,36,37…(×26); objects/obj_load_guardabot/Other_11.gml:112,126,147,180,191,207,227,279…(×20); objects/obj_settings_panel/Create_0.gml:95,96,97,99,101,102,103,105…(×19); objects/obj_settings_panel/Other_10.gml:1,2,3,5,7,8,9,11…(×19); objects/obj_window_alert/Create_0.gml:5,7,9,11,13,15,17,19…(×18); objects/obj_axe_smw/Create_0.gml:26,28,29,30,31,32,33,34…(×16); objects/obj_cap/Collision_obj_mario.gml:13,21,24,36,39,51,54,71…(×16); objects/obj_shell/Alarm_4.gml:14,20,26,34,43,57,66,84…(×15); scripts/scr_create_bg_anim/scr_create_bg_anim.gml:14,22,30,38,51,59,69,77…(×15); objects/obj_bg_selection/Other_7.gml:5,13,21,29,37,45,53,61…(×14); …另 1243 个文件 2598 处 | object_get_depth(:6) |
| key_to_string | scripts/key_to_string/key_to_string.gml:1 | 119 | Scripts | 7/1 | objects/obj_settings_controls/Step_0.gml:4,8,12,15,19,23,27 | - |
| macros | scripts/macros/macros.gml:1 | 31 | Scripts | 0/0 | - | - |
| object_get_depth | scripts/object_get_depth/object_get_depth.gml:4 | 14 | Scripts/compatibility/object | 1/1 | scripts/instance_create/instance_create.gml:6 | - |
| outside_view | scripts/outside_view/outside_view.gml:1 | 7 | Scripts/Misc | 64/54 | objects/obj_boo/Other_18.gml:36,48,63,75,88,101; objects/obj_NSMBU_boomboom/Step_2.gml:48,59,71; objects/obj_NSMBU_boomboom_b/Step_2.gml:56,67,79; objects/obj_magikoopa/Step_0.gml:5,26; objects/obj_NSMBU_bowser/Step_2.gml:118; objects/obj_big_pplant_b_res/Draw_0.gml:1; objects/obj_big_pplant_res/Draw_0.gml:1; objects/obj_block_hidden_res/Draw_0.gml:1; objects/obj_block_res/Draw_0.gml:1; objects/obj_bobomb_ready/Create_0.gml:20; objects/obj_boo_res/Draw_0.gml:1; objects/obj_boomerang/Step_0.gml:63; objects/obj_bulletbull_red/Step_0.gml:18; objects/obj_cannon/Step_0.gml:31; objects/obj_card_item/Draw_0.gml:1; …另 39 个文件 39 处 | __view_get(:3×6) |
| outside_view_modelsizable | scripts/outside_view_modelsizable/outside_view_modelsizable.gml:1 | 27 | Scripts/Misc | 0/0 | - | - |
| scr_NSMBU_acrouch | scripts/scr_NSMBU_acrouch/scr_NSMBU_acrouch.gml:2 | 22 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:310,326,1398 | - |
| scr_NSMBU_airspin1 | scripts/scr_NSMBU_airspin1/scr_NSMBU_airspin1.gml:1 | 38 | Scripts/marioU | 9/1 | objects/obj_marioU/Step_2.gml:655,657,742,764,782,792,799,826…(×9) | - |
| scr_NSMBU_climb_pole | scripts/scr_NSMBU_climb_pole/scr_NSMBU_climb_pole.gml:2 | 12 | Scripts/marioU | 3/3 | objects/obj_player_goal_nsmbu/Create_0.gml:3; objects/obj_player_goal_nsmbu/Other_23.gml:63; objects/obj_player_goal_nsmbu/Other_7.gml:1 | - |
| scr_NSMBU_crouch | scripts/scr_NSMBU_crouch/scr_NSMBU_crouch.gml:2 | 21 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:1391,1407 | - |
| scr_NSMBU_crouch_fall | scripts/scr_NSMBU_crouch_fall/scr_NSMBU_crouch_fall.gml:2 | 21 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:1371,1374 | - |
| scr_NSMBU_crouch_idle | scripts/scr_NSMBU_crouch_idle/scr_NSMBU_crouch_idle.gml:2 | 22 | Scripts/marioU | 5/1 | objects/obj_marioU/Step_2.gml:136,1384,1389,1394,1401 | - |
| scr_NSMBU_crouch_jump | scripts/scr_NSMBU_crouch_jump/scr_NSMBU_crouch_jump.gml:2 | 21 | Scripts/marioU | 4/1 | objects/obj_marioU/Step_2.gml:1312,1336,1338,1369 | - |
| scr_NSMBU_drill_spin | scripts/scr_NSMBU_drill_spin/scr_NSMBU_drill_spin.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:633,1190 | - |
| scr_NSMBU_flip | scripts/scr_NSMBU_flip/scr_NSMBU_flip.gml:2 | 13 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:283 | - |
| scr_NSMBU_flip_start | scripts/scr_NSMBU_flip_start/scr_NSMBU_flip_start.gml:2 | 13 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:275 | - |
| scr_NSMBU_goal_pole | scripts/scr_NSMBU_goal_pole/scr_NSMBU_goal_pole.gml:2 | 12 | Scripts/marioU | 2/2 | objects/obj_player_goal_nsmbu/Alarm_5.gml:6; objects/obj_player_goal_nsmbu/Other_23.gml:64 | - |
| scr_NSMBU_ground_idle | scripts/scr_NSMBU_ground_idle/scr_NSMBU_ground_idle.gml:2 | 41 | Scripts/marioU | 7/3 | objects/obj_doormario_exit/Draw_0.gml:97; objects/obj_marioU/Step_2.gml:248,250,253,287,344; objects/obj_player_warp/Step_2.gml:7 | - |
| scr_NSMBU_groundpound | scripts/scr_NSMBU_groundpound/scr_NSMBU_groundpound.gml:2 | 12 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:699 | - |
| scr_NSMBU_groundpound_canceled | scripts/scr_NSMBU_groundpound_canceled/scr_NSMBU_groundpound_canceled.gml:2 | 13 | Scripts/marioU | 3/2 | objects/obj_marioU/Other_12.gml:68; objects/obj_marioU/Step_2.gml:706,866 | - |
| scr_NSMBU_groundpound_stop | scripts/scr_NSMBU_groundpound_stop/scr_NSMBU_groundpound_stop.gml:2 | 7 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:159 | - |
| scr_NSMBU_hold | scripts/scr_NSMBU_hold/scr_NSMBU_hold.gml:2 | 12 | Scripts/marioU | 5/2 | objects/obj_doormario/Draw_0.gml:88; objects/obj_marioU/Step_2.gml:1018,1036,1042,1044 | - |
| scr_NSMBU_hold_airspin | scripts/scr_NSMBU_hold_airspin/scr_NSMBU_hold_airspin.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:1198,1200 | - |
| scr_NSMBU_hold_ground | scripts/scr_NSMBU_hold_ground/scr_NSMBU_hold_ground.gml:2 | 12 | Scripts/marioU | 5/3 | objects/obj_doormario_exit/Draw_0.gml:89; objects/obj_marioU/Step_2.gml:1018,1031,1033; objects/obj_player_warp/Step_2.gml:9 | - |
| scr_NSMBU_hold_jump | scripts/scr_NSMBU_hold_jump/scr_NSMBU_hold_jump.gml:2 | 12 | Scripts/marioU | 4/1 | objects/obj_marioU/Step_2.gml:1020,1208,1224,1226 | - |
| scr_NSMBU_hold_spinjump | scripts/scr_NSMBU_hold_spinjump/scr_NSMBU_hold_spinjump.gml:2 | 12 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:1020,1217,1219 | - |
| scr_NSMBU_idle | scripts/scr_NSMBU_idle/scr_NSMBU_idle.gml:1 | 90 | Scripts/marioU | 14/5 | objects/obj_marioU/Step_2.gml:150,248,257,265,290,301,305,307…(×10); objects/obj_mario_temp/Create_0.gml:2; objects/obj_mario_transform2/Create_0.gml:46; objects/obj_player_goal_smw_castle/Create_0.gml:4; objects/obj_player_goal_smw_castle/Step_2.gml:25 | - |
| scr_NSMBU_jump1 | scripts/scr_NSMBU_jump1/scr_NSMBU_jump1.gml:2 | 21 | Scripts/marioU | 12/5 | objects/obj_marioU/Other_11.gml:43; objects/obj_marioU/Step_0.gml:318; objects/obj_marioU/Step_2.gml:120,839,861,953,979,981; objects/obj_player_goal_nsmbu/Other_23.gml:20,43; objects/obj_player_goal_smw_castle/Step_2.gml:42,65 | - |
| scr_NSMBU_jump2 | scripts/scr_NSMBU_jump2/scr_NSMBU_jump2.gml:2 | 21 | Scripts/marioU | 10/4 | objects/obj_marioU/Other_11.gml:43; objects/obj_marioU/Step_2.gml:22,870,956,984,986; objects/obj_player_goal_nsmbu/Other_23.gml:23,46; objects/obj_player_goal_smw_castle/Step_2.gml:45,68 | - |
| scr_NSMBU_jump3 | scripts/scr_NSMBU_jump3/scr_NSMBU_jump3.gml:2 | 21 | Scripts/marioU | 8/4 | objects/obj_marioU/Other_11.gml:43; objects/obj_marioU/Step_2.gml:959,989,991; objects/obj_player_goal_nsmbu/Other_23.gml:26,49; objects/obj_player_goal_smw_castle/Step_2.gml:48,71 | - |
| scr_NSMBU_jump_star | scripts/scr_NSMBU_jump_star/scr_NSMBU_jump_star.gml:2 | 12 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:811 | - |
| scr_NSMBU_kick | scripts/scr_NSMBU_kick/scr_NSMBU_kick.gml:2 | 22 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:17 | - |
| scr_NSMBU_marioclimb_start | scripts/scr_NSMBU_marioclimb_start/scr_NSMBU_marioclimb_start.gml:2 | 11 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:1261,1276,1424 | - |
| scr_NSMBU_musicalscale_minirebote | scripts/scr_NSMBU_musicalscale_minirebote/scr_NSMBU_musicalscale_minirebote.gml:1 | 61 | Scripts/Sounds | 1/1 | objects/obj_enemyparent/Collision_obj_mario.gml:179 | instance_create(:3) |
| scr_NSMBU_musicalscale_rebote | scripts/scr_NSMBU_musicalscale_rebote/scr_NSMBU_musicalscale_rebote.gml:1 | 61 | Scripts/Sounds | 1/1 | objects/obj_enemyparent/Collision_obj_mario.gml:177 | instance_create(:3) |
| scr_NSMBU_penguin_swim | scripts/scr_NSMBU_penguin_swim/scr_NSMBU_penguin_swim.gml:2 | 10 | Scripts/marioU | 0/0 | - | - |
| scr_NSMBU_run | scripts/scr_NSMBU_run/scr_NSMBU_run.gml:2 | 21 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:431 | - |
| scr_NSMBU_runmax | scripts/scr_NSMBU_runmax/scr_NSMBU_runmax.gml:2 | 21 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:74,97,447 | - |
| scr_NSMBU_skid | scripts/scr_NSMBU_skid/scr_NSMBU_skid.gml:2 | 22 | Scripts/marioU | 3/2 | objects/obj_marioU/Step_2.gml:49,1417; objects/obj_mario_transform2/Create_0.gml:42 | - |
| scr_NSMBU_skid_left | scripts/scr_NSMBU_skid_left/scr_NSMBU_skid_left.gml:2 | 22 | Scripts/marioU | 4/1 | objects/obj_marioU/Step_2.gml:87,92,410,1417 | - |
| scr_NSMBU_skid_right | scripts/scr_NSMBU_skid_right/scr_NSMBU_skid_right.gml:2 | 22 | Scripts/marioU | 4/1 | objects/obj_marioU/Step_2.gml:64,69,410,1417 | - |
| scr_NSMBU_snd_dead | scripts/scr_NSMBU_snd_dead/scr_NSMBU_snd_dead.gml:1 | 13 | Scripts/Sounds | 1/1 | objects/obj_deadmario/Create_0.gml:5 | - |
| scr_NSMBU_spincrouch | scripts/scr_NSMBU_spincrouch/scr_NSMBU_spincrouch.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:1299,1301 | - |
| scr_NSMBU_spinjump | scripts/scr_NSMBU_spinjump/scr_NSMBU_spinjump.gml:1 | 38 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:848,850 | - |
| scr_NSMBU_spinstomp | scripts/scr_NSMBU_spinstomp/scr_NSMBU_spinstomp.gml:1 | 61 | Scripts/Sounds | 2/2 | objects/obj_enemyparent/Collision_obj_mario.gml:101; objects/obj_shell/Collision_obj_mario.gml:84 | instance_create(:3) |
| scr_NSMBU_standup | scripts/scr_NSMBU_standup/scr_NSMBU_standup.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:143,145 | - |
| scr_NSMBU_standup_pole | scripts/scr_NSMBU_standup_pole/scr_NSMBU_standup_pole.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_player_goal_nsmbu/Other_23.gml:75,80 | - |
| scr_NSMBU_stun | scripts/scr_NSMBU_stun/scr_NSMBU_stun.gml:2 | 12 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:127 | - |
| scr_NSMBU_swim | scripts/scr_NSMBU_swim/scr_NSMBU_swim.gml:2 | 12 | Scripts/marioU | 6/3 | objects/obj_mario/Other_13.gml:188; objects/obj_marioU/Other_13.gml:152,152,154,166; objects/obj_marioU/Step_2.gml:503 | - |
| scr_NSMBU_swim2 | scripts/scr_NSMBU_swim2/scr_NSMBU_swim2.gml:2 | 11 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:245,397,500 | - |
| scr_NSMBU_swim_fall | scripts/scr_NSMBU_swim_fall/scr_NSMBU_swim_fall.gml:2 | 12 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:114,507,525 | - |
| scr_NSMBU_swim_hold | scripts/scr_NSMBU_swim_hold/scr_NSMBU_swim_hold.gml:2 | 12 | Scripts/marioU | 6/1 | objects/obj_marioU/Step_2.gml:1013,1015,1056,1058,1088,1090 | - |
| scr_NSMBU_triple_jump0 | scripts/scr_NSMBU_triple_jump0/scr_NSMBU_triple_jump0.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:742,750 | - |
| scr_NSMBU_triple_jump1 | scripts/scr_NSMBU_triple_jump1/scr_NSMBU_triple_jump1.gml:2 | 12 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:742,753,794 | - |
| scr_NSMBU_triple_jump2 | scripts/scr_NSMBU_triple_jump2/scr_NSMBU_triple_jump2.gml:2 | 12 | Scripts/marioU | 3/1 | objects/obj_marioU/Step_2.gml:764,766,801 | - |
| scr_NSMBU_triple_jump3 | scripts/scr_NSMBU_triple_jump3/scr_NSMBU_triple_jump3.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:742,756 | - |
| scr_NSMBU_walk | scripts/scr_NSMBU_walk/scr_NSMBU_walk.gml:2 | 40 | Scripts/marioU | 9/5 | objects/obj_marioU/Step_2.gml:329,402,416,422; objects/obj_mario_editor/Step_0.gml:34; objects/obj_mario_transform2/Create_0.gml:44; objects/obj_player_goal_nsmbu/Other_23.gml:9,84; objects/obj_player_goal_smw_castle/Step_2.gml:33 | - |
| scr_NSMBU_walkhold | scripts/scr_NSMBU_walkhold/scr_NSMBU_walkhold.gml:2 | 12 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:1063,1065 | - |
| scr_NSMBU_walkhome | scripts/scr_NSMBU_walkhome/scr_NSMBU_walkhome.gml:2 | 22 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:294,331 | - |
| scr_NSMBU_walkpipes | scripts/scr_NSMBU_walkpipes/scr_NSMBU_walkpipes.gml:2 | 12 | Scripts/marioU | 1/1 | objects/obj_player_warp/Step_2.gml:19 | - |
| scr_NSMBU_wall_slide | scripts/scr_NSMBU_wall_slide/scr_NSMBU_wall_slide.gml:2 | 20 | Scripts/marioU | 1/1 | objects/obj_marioU/Step_2.gml:687 | - |
| scr_add3points | scripts/scr_add3points/scr_add3points.gml:1 | 18 | Scripts/Misc | 3/3 | objects/obj_gb_button/Draw_0.gml:4; objects/obj_gb_level/Draw_0.gml:6; objects/obj_menu_pausa/Draw_0.gml:52 | - |
| scr_addseparators | scripts/scr_addseparators/scr_addseparators.gml:1 | 19 | Scripts/Misc | 0/0 | - | - |
| scr_anim_hover | scripts/scr_anim_hover/scr_anim_hover.gml:1 | 15 | Scripts | 61/59 | objects/obj_button_home/Draw_0.gml:35,50; objects/obj_play_screen/Draw_0.gml:7,16; objects/obj_bg1/Draw_0.gml:6; objects/obj_bt_gb_delete/Draw_0.gml:5; objects/obj_bt_gb_play/Draw_0.gml:11; objects/obj_bt_rename/Draw_0.gml:10; objects/obj_btn_header_1/Draw_0.gml:4; objects/obj_btn_header_2/Draw_0.gml:4; objects/obj_btn_header_3/Draw_0.gml:4; objects/obj_btn_header_4/Draw_0.gml:4; objects/obj_btn_header_parent/Draw_0.gml:4; objects/obj_btn_settings_hd/Draw_0.gml:8; objects/obj_button_autoavance/Draw_0.gml:11; objects/obj_button_creditos/Draw_0.gml:5; objects/obj_button_meteoritos/Draw_0.gml:6; …另 44 个文件 44 处 | - |
| scr_anim_hover2 | scripts/scr_anim_hover2/scr_anim_hover2.gml:1 | 15 | Scripts | 1/1 | objects/obj_creator_jugar_editar/Draw_0.gml:8 | - |
| scr_arcon_fly | scripts/scr_arcon_fly/scr_arcon_fly.gml:2 | 10 | Scripts/marioU | 2/1 | objects/obj_marioU/Step_2.gml:917,1104 | - |
| scr_arcon_fly_start | scripts/scr_arcon_fly_start/scr_arcon_fly_start.gml:2 | 10 | Scripts/marioU | 4/1 | objects/obj_marioU/Step_2.gml:912,914,1099,1101 | - |
| scr_auto_tile | scripts/scr_auto_tile/scr_auto_tile.gml:1 | 243 | Scripts | 1/1 | objects/obj_ground/Other_15.gml:1 | - |
| scr_auto_tile_slope | scripts/scr_auto_tile_slope/scr_auto_tile_slope.gml:1 | 4 | Scripts | 1/1 | objects/obj_ground_slope/Other_15.gml:1 | - |
| scr_bg_airship | scripts/scr_bg_airship/scr_bg_airship.gml:1 | 41 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:126; objects/obj_bg1/Other_10.gml:129; objects/obj_card_logo/Mouse_4.gml:118; objects/obj_load_guardabot/Other_12.gml:104; objects/obj_load_level/Other_11.gml:129; objects/obj_night_change/Other_11.gml:116 | - |
| scr_bg_beach | scripts/scr_bg_beach/scr_bg_beach.gml:1 | 37 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:262; objects/obj_bg1/Other_10.gml:283; objects/obj_card_logo/Mouse_4.gml:254; objects/obj_load_guardabot/Other_12.gml:228; objects/obj_load_level/Other_11.gml:284; objects/obj_night_change/Other_11.gml:252 | - |
| scr_bg_castle | scripts/scr_bg_castle/scr_bg_castle.gml:1 | 41 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:63; objects/obj_bg1/Other_10.gml:57; objects/obj_card_logo/Mouse_4.gml:55; objects/obj_load_guardabot/Other_12.gml:47; objects/obj_load_level/Other_11.gml:57; objects/obj_night_change/Other_11.gml:53 | - |
| scr_bg_control | scripts/scr_bg_control/scr_bg_control.gml:1 | 3 | Scripts/Backgrounds | 0/0 | - | - |
| scr_bg_desert | scripts/scr_bg_desert/scr_bg_desert.gml:1 | 41 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:191; objects/obj_bg1/Other_10.gml:203; objects/obj_card_logo/Mouse_4.gml:183; objects/obj_load_guardabot/Other_12.gml:163; objects/obj_load_level/Other_11.gml:203; objects/obj_night_change/Other_11.gml:181 | - |
| scr_bg_fall | scripts/scr_bg_fall/scr_bg_fall.gml:1 | 37 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:241; objects/obj_bg1/Other_10.gml:259; objects/obj_card_logo/Mouse_4.gml:233; objects/obj_load_guardabot/Other_12.gml:209; objects/obj_load_level/Other_11.gml:260; objects/obj_night_change/Other_11.gml:231 | - |
| scr_bg_forest | scripts/scr_bg_forest/scr_bg_forest.gml:1 | 41 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:149; objects/obj_bg1/Other_10.gml:155; objects/obj_card_logo/Mouse_4.gml:164; objects/obj_load_guardabot/Other_12.gml:146; objects/obj_load_level/Other_11.gml:155; objects/obj_night_change/Other_11.gml:139 | - |
| scr_bg_ghost_house | scripts/scr_bg_ghost_house/scr_bg_ghost_house.gml:1 | 35 | Scripts/Backgrounds | 12/6 | objects/obj_angrysun_res/Other_11.gml:84,87; objects/obj_bg1/Other_10.gml:84,87; objects/obj_card_logo/Mouse_4.gml:76,79; objects/obj_load_guardabot/Other_12.gml:64,67; objects/obj_load_level/Other_11.gml:84,87; objects/obj_night_change/Other_11.gml:74,77 | - |
| scr_bg_ground | scripts/scr_bg_ground/scr_bg_ground.gml:1 | 36 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:42; objects/obj_bg1/Other_10.gml:30; objects/obj_card_logo/Mouse_4.gml:34; objects/obj_load_guardabot/Other_12.gml:30; objects/obj_load_level/Other_11.gml:30; objects/obj_night_change/Other_11.gml:32 | - |
| scr_bg_init | scripts/scr_bg_init/scr_bg_init.gml:3 | 5 | Scripts/Backgrounds | 0/0 | - | - |
| scr_bg_mountain | scripts/scr_bg_mountain/scr_bg_mountain.gml:1 | 42 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:301; objects/obj_bg1/Other_10.gml:324; objects/obj_card_logo/Mouse_4.gml:293; objects/obj_load_guardabot/Other_12.gml:265; objects/obj_load_level/Other_11.gml:327; objects/obj_night_change/Other_11.gml:292 | - |
| scr_bg_sky | scripts/scr_bg_sky/scr_bg_sky.gml:1 | 41 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:172; objects/obj_bg1/Other_10.gml:181; objects/obj_card_logo/Mouse_4.gml:141; objects/obj_load_guardabot/Other_12.gml:125; objects/obj_load_level/Other_11.gml:181; objects/obj_night_change/Other_11.gml:162 | - |
| scr_bg_snow | scripts/scr_bg_snow/scr_bg_snow.gml:1 | 41 | Scripts/Backgrounds | 7/7 | objects/obj_angrysun_res/Other_11.gml:224; objects/obj_arrow_big/Step_0.gml:1; objects/obj_bg1/Other_10.gml:239; objects/obj_card_logo/Mouse_4.gml:216; objects/obj_load_guardabot/Other_12.gml:194; objects/obj_load_level/Other_11.gml:240; objects/obj_night_change/Other_11.gml:214 | - |
| scr_bg_underground | scripts/scr_bg_underground/scr_bg_underground.gml:1 | 36 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:48; objects/obj_bg1/Other_10.gml:39; objects/obj_card_logo/Mouse_4.gml:40; objects/obj_load_guardabot/Other_12.gml:34; objects/obj_load_level/Other_11.gml:39; objects/obj_night_change/Other_11.gml:38 | - |
| scr_bg_underwater | scripts/scr_bg_underwater/scr_bg_underwater.gml:1 | 36 | Scripts/Backgrounds | 12/12 | objects/obj_angrysun_res/Other_11.gml:69; objects/obj_bg1/Other_10.gml:66; objects/obj_bowser_fire_down/Other_14.gml:40; objects/obj_card_logo/Mouse_4.gml:61; objects/obj_link_arrow/Collision_obj_enemyparent.gml:9; objects/obj_link_atack/Collision_obj_enemyparent.gml:20; objects/obj_link_dash_atack/Collision_obj_enemyparent.gml:9; objects/obj_link_down_atack/Collision_obj_enemyparent.gml:9; objects/obj_load_guardabot/Other_12.gml:51; objects/obj_load_level/Other_11.gml:66; objects/obj_night_change/Other_11.gml:59; objects/obj_spinner/Collision_obj_enemyparent.gml:19 | - |
| scr_canhold | scripts/scr_canhold/scr_canhold.gml:1 | 26 | Scripts/Misc | 9/9 | objects/obj_block_pow_hold/Step_0.gml:53; objects/obj_enemyfrozen/Step_0.gml:21; objects/obj_enemyparent_held/Step_0.gml:12; objects/obj_holdparent/Collision_obj_mario.gml:9; objects/obj_holdparent/Step_0.gml:11; objects/obj_pswitch/Step_0.gml:23; objects/obj_shell/Collision_obj_mario.gml:5; objects/obj_shell_drybones/Collision_obj_mario.gml:7; objects/obj_snow_ball/Collision_obj_mario.gml:5 | - |
| scr_canpull | scripts/scr_canpull/scr_canpull.gml:1 | 9 | Scripts/Misc | 2/2 | objects/obj_mario/Other_12.gml:53; objects/obj_mario/Other_13.gml:3 | - |
| scr_constant_get_sprite | scripts/scr_constant_get_sprite/scr_constant_get_sprite.gml:1 | 607 | Scripts/Sprites | 12/10 | objects/obj_block/Alarm_1.gml:11,21,32; objects/obj_bullebill_base/Other_11.gml:13; objects/obj_bullebill_base/Other_12.gml:13; objects/obj_bullebill_base_red/Other_11.gml:18; objects/obj_bullebill_base_red/Other_12.gml:18; objects/obj_checkpoint/Collision_obj_mario.gml:65; objects/obj_checkpoint/Collision_obj_shell_held.gml:65; objects/obj_lakitu/Alarm_1.gml:24; objects/obj_noteblock/Other_10.gml:17; objects/obj_noteblock/Other_11.gml:18 | - |
| scr_constant_make_object | scripts/scr_constant_make_object/scr_constant_make_object.gml:1 | 171 | Scripts/Sprites | 5/3 | objects/obj_powerupsprout/Alarm_1.gml:10; objects/obj_powerupsprout/Alarm_2.gml:28,57; objects/obj_powerupsprout_note/Alarm_1.gml:29,58 | instance_create(:7×61) |
| scr_cont_lives | scripts/scr_cont_lives/scr_cont_lives.gml:3 | 5 | Scripts | 1/1 | objects/obj_levelmanager/Other_19.gml:31 | - |
| scr_create_bg_anim | scripts/scr_create_bg_anim/scr_create_bg_anim.gml:1 | 171 | Scripts/Backgrounds | 6/6 | objects/obj_angrysun_res/Other_11.gml:309; objects/obj_bg1/Other_10.gml:335; objects/obj_card_logo/Mouse_4.gml:313; objects/obj_load_guardabot/Other_12.gml:420; objects/obj_load_level/Other_11.gml:473; objects/obj_night_change/Other_11.gml:300 | instance_create(:14×15) |
| scr_diff | scripts/scr_diff/scr_diff.gml:3 | 5 | Scripts | 0/0 | - | - |
| scr_edit_to_play | scripts/scr_edit_to_play/scr_edit_to_play.gml:1 | 2311 | Scripts/Editor | 2/2 | objects/obj_creator_jugar_editar/Other_13.gml:31; objects/obj_load_guardabot/Other_11.gml:266 | instance_create(:76×179), scr_sprite_make_object_rieles(:165) |
| scr_etiq_search | scripts/scr_etiq_search/scr_etiq_search.gml:2 | 103 | Scripts | 0/0 | - | - |
| scr_etiquetas_trad | scripts/scr_etiquetas_trad/scr_etiquetas_trad.gml:2 | 73 | Scripts | 0/0 | - | scr_language(:4×66) |
| scr_header | scripts/scr_header/scr_header.gml:1 | 37 | Scripts | 8/2 | objects/obj_header/Alarm_0.gml:3,7,11,15; objects/obj_panel_expand/Create_0.gml:216,218,220,222 | - |
| scr_hspeed | scripts/scr_hspeed/scr_hspeed.gml:3 | 6 | Scripts | 0/0 | - | - |
| scr_init_globals | scripts/scr_init_globals/scr_init_globals.gml:1 | 154 | Scripts | 7/7 | objects/cre_control/Create_0.gml:11; objects/obj_flagpole/Alarm_0.gml:8; objects/obj_goalcard/Alarm_2.gml:8; objects/obj_goalgate/Alarm_1.gml:8; objects/obj_menu_pausa/Other_12.gml:4; objects/obj_persistent/Create_0.gml:109; objects/obj_settings_button/Mouse_4.gml:17 | - |
| scr_insideview | scripts/scr_insideview/scr_insideview.gml:1 | 9 | Scripts | 23/23 | objects/obj_bullebill_base_red_res/Mouse_4.gml:1; objects/obj_bullebill_base_res/Mouse_4.gml:1; objects/obj_cannon_red_res/Mouse_4.gml:1; objects/obj_cannon_res/Mouse_4.gml:1; objects/obj_checkpoint_res/Mouse_4.gml:1; objects/obj_cursor/Mouse_50.gml:2; objects/obj_cursor/Mouse_53.gml:5; objects/obj_firebar_res/Mouse_4.gml:1; objects/obj_ground/Mouse_0.gml:1; objects/obj_ground/Mouse_1.gml:1; objects/obj_ground/Mouse_4.gml:1; objects/obj_mushroom_platform_res/Mouse_4.gml:1; objects/obj_oneway_res/Mouse_4.gml:1; objects/obj_parent_resource/Mouse_0.gml:1; objects/obj_parent_resource/Mouse_1.gml:1; …另 8 个文件 8 处 | - |
| scr_jump | scripts/scr_jump/scr_jump.gml:1 | 29 | Scripts/Sounds | 16/10 | objects/obj_claw/Step_2.gml:93; objects/obj_cloud_lakitu/Step_0.gml:97; objects/obj_clown/Step_0.gml:89,90; objects/obj_mario/Other_12.gml:152,252; objects/obj_mario/Other_14.gml:54,141; objects/obj_mario/Step_0.gml:253,319; objects/obj_marioU/Other_12.gml:124,226; objects/obj_marioU/Step_0.gml:235,288; objects/obj_player_goal_smb2/Step_0.gml:36; objects/obj_slider/Step_0.gml:77 | - |
| scr_language | scripts/scr_language/scr_language.gml:3 | 1039 | Scripts | 241/71 | scripts/scr_etiquetas_trad/scr_etiquetas_trad.gml:4,5,6,7,8,9,10,11…(×66); objects/obj_gb_level/Create_0.gml:15,16,17,18,19,20,21,22…(×16); objects/obj_etiquetas/Create_0.gml:10,11,12,13,14,15,16,17…(×14); objects/cre_control/Draw_0.gml:9,13,51,59,63,91,119,131…(×11); objects/obj_intro_controller/Create_0.gml:9,11,17,20,23,26,29,32…(×9); objects/obj_settings_panel/Create_0.gml:4,5,6,7,8,11,12,16…(×9); objects/obj_menu_pausa/Create_0.gml:74,80,90,113,114,115,116; objects/obj_modo_sonidos_control/Draw_0.gml:5,7,11,13,18; objects/obj_water_level_control/Draw_0.gml:5,7,11,13,25; objects/obj_alert_condicion/Create_0.gml:4,5,6,7; objects/obj_condiciones/Create_0.gml:3,4,5,6; objects/obj_editormanager/Draw_0.gml:12,14,18,25; objects/obj_header/Draw_0.gml:12,15,18,21; objects/obj_autoavance/Other_7.gml:16,27,38; objects/obj_button_notification_aceptar/Mouse_4.gml:9,22,27; …另 56 个文件 77 处 | - |
| scr_link_arrow_jump | scripts/scr_link_arrow_jump/scr_link_arrow_jump.gml:1 | 19 | Scripts/Mario | 3/1 | objects/obj_mario/Step_2.gml:301,309,382 | - |
| scr_link_arrow_swim | scripts/scr_link_arrow_swim/scr_link_arrow_swim.gml:1 | 19 | Scripts/Mario | 3/2 | objects/obj_mario/Other_13.gml:169,171; objects/obj_mario/Step_2.gml:297 | - |
| scr_link_arrow_walk | scripts/scr_link_arrow_walk/scr_link_arrow_walk.gml:1 | 16 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:203 | - |
| scr_load | scripts/scr_load/scr_load.gml:1 | 22 | Scripts | 0/0 | - | - |
| scr_lose_condition | scripts/scr_lose_condition/scr_lose_condition.gml:1 | 17 | Scripts | 4/1 | objects/obj_mario/Other_10.gml:47,86,157,175 | instance_create(:9) |
| scr_mario_cap_fly | scripts/scr_mario_cap_fly/scr_mario_cap_fly.gml:1 | 14 | Scripts/Mario | 4/2 | objects/obj_mario/Other_7.gml:3,19; objects/obj_mario/Step_2.gml:363,369 | - |
| scr_mario_cap_fly_acender | scripts/scr_mario_cap_fly_acender/scr_mario_cap_fly_acender.gml:1 | 13 | Scripts/Mario | 6/3 | objects/obj_mario/Other_12.gml:696,727; objects/obj_mario/Other_7.gml:8,27; objects/obj_mario/Step_2.gml:361,367 | - |
| scr_mario_cap_fly_acender_decender | scripts/scr_mario_cap_fly_acender_decender/scr_mario_cap_fly_acender_decender.gml:1 | 13 | Scripts/Mario | 3/3 | objects/obj_mario/Other_12.gml:720; objects/obj_mario/Other_7.gml:26; objects/obj_mario/Step_2.gml:361 | - |
| scr_mario_cap_fly_decender | scripts/scr_mario_cap_fly_decender/scr_mario_cap_fly_decender.gml:1 | 13 | Scripts/Mario | 5/4 | objects/obj_mario/Other_12.gml:708; objects/obj_mario/Other_7.gml:21; objects/obj_mario/Step_0.gml:37,55; objects/obj_mario/Step_2.gml:361 | - |
| scr_mario_drybones | scripts/scr_mario_drybones/scr_mario_drybones.gml:1 | 260 | Scripts/Mario | 11/4 | objects/obj_doormario/Draw_0.gml:60,62; objects/obj_doormario_exit/Draw_0.gml:60,62; objects/obj_kuribo_drybones/Step_2.gml:35,43,240,272,281; objects/obj_player_warp/Draw_0.gml:62,64 | - |
| scr_mario_drybones_goal | scripts/scr_mario_drybones_goal/scr_mario_drybones_goal.gml:1 | 64 | Scripts/Mario | 1/1 | objects/obj_kuribo_drybones/Step_2.gml:254 | - |
| scr_mario_drybones_jump | scripts/scr_mario_drybones_jump/scr_mario_drybones_jump.gml:1 | 165 | Scripts/Mario | 3/1 | objects/obj_kuribo_drybones/Step_2.gml:19,30,51 | - |
| scr_mario_pull | scripts/scr_mario_pull/scr_mario_pull.gml:1 | 41 | Scripts/Mario | 1/1 | objects/obj_puller/Create_0.gml:1 | - |
| scr_mario_shoe | scripts/scr_mario_shoe/scr_mario_shoe.gml:1 | 178 | Scripts/Mario | 16/4 | objects/obj_doormario/Draw_0.gml:68,70,76,78; objects/obj_doormario_exit/Draw_0.gml:68,70,76,78; objects/obj_kuriboshoe/Step_2.gml:7,15,131,138; objects/obj_player_warp/Draw_0.gml:72,74,80,82 | - |
| scr_mario_shoe_fall | scripts/scr_mario_shoe_fall/scr_mario_shoe_fall.gml:1 | 15 | Scripts/Mario | 1/1 | objects/obj_kuriboshoe/Step_2.gml:23 | - |
| scr_mario_swim_idle | scripts/scr_mario_swim_idle/scr_mario_swim_idle.gml:1 | 248 | Scripts/Mario | 0/0 | - | - |
| scr_mario_yoshi_atack | scripts/scr_mario_yoshi_atack/scr_mario_yoshi_atack.gml:1 | 72 | Scripts/Mario | 1/1 | objects/obj_yoshi2/Other_12.gml:5 | - |
| scr_mario_yoshi_crouch | scripts/scr_mario_yoshi_crouch/scr_mario_yoshi_crouch.gml:1 | 72 | Scripts/Mario | 1/1 | objects/obj_yoshi2/Other_12.gml:12 | - |
| scr_mario_yoshi_goal | scripts/scr_mario_yoshi_goal/scr_mario_yoshi_goal.gml:1 | 64 | Scripts/Mario | 2/2 | objects/obj_player_goal_smw/Draw_0.gml:38; objects/obj_player_goal_smw_castle/Draw_0.gml:29 | - |
| scr_marioclimb | scripts/scr_marioclimb/scr_marioclimb.gml:1 | 321 | Scripts/Mario | 18/9 | objects/obj_brickhelmet/Other_16.gml:14,38; objects/obj_brickhelmet/Step_2.gml:64; objects/obj_helmet/Draw_0.gml:3,18,35; objects/obj_helmet/Other_16.gml:23,67,79; objects/obj_helmet/Step_2.gml:55; objects/obj_helmet_spiny/Other_16.gml:20,56; objects/obj_key_fallow/Step_0.gml:14; objects/obj_mario/Step_2.gml:642; objects/obj_marioU/Step_2.gml:1242,1265,1274,1424 | - |
| scr_mariodead | scripts/scr_mariodead/scr_mariodead.gml:1 | 84 | Scripts/Mario | 1/1 | objects/obj_deadmario/Create_0.gml:1 | - |
| scr_mariodrop | scripts/scr_mariodrop/scr_mariodrop.gml:1 | 288 | Scripts/Mario | 9/4 | objects/obj_mario/Step_2.gml:402,410,436,448,451,463; objects/obj_mariostart_m/Other_10.gml:6; objects/obj_player_goal_smw/Step_2.gml:50; objects/obj_player_goal_smw_castle/Step_2.gml:122 | - |
| scr_marioduck | scripts/scr_marioduck/scr_marioduck.gml:1 | 302 | Scripts/Mario | 8/6 | objects/obj_brickhelmet/Other_23.gml:79,84; objects/obj_cloud_lakitu/Step_2.gml:36; objects/obj_clown/Step_2.gml:21; objects/obj_helmet/Other_23.gml:79,84; objects/obj_mario/Step_2.gml:748; objects/obj_player_goal_smw/Alarm_3.gml:1 | - |
| scr_marioduckhold | scripts/scr_marioduckhold/scr_marioduckhold.gml:1 | 112 | Scripts/Mario | 3/3 | objects/obj_cloud_lakitu/Step_2.gml:25; objects/obj_clown/Step_2.gml:10; objects/obj_mario/Step_2.gml:737 | - |
| scr_mariogoal | scripts/scr_mariogoal/scr_mariogoal.gml:1 | 158 | Scripts/Mario | 4/4 | objects/obj_cap_mario/Other_17.gml:16; objects/obj_player_goal_smb1/Create_0.gml:4; objects/obj_player_goal_smb1/Other_23.gml:11; objects/obj_player_goal_smw/Step_2.gml:15 | - |
| scr_mariohold | scripts/scr_mariohold/scr_mariohold.gml:1 | 255 | Scripts/Mario | 6/5 | objects/obj_cap_mario/Other_16.gml:35; objects/obj_doormario/Draw_0.gml:90; objects/obj_doormario_exit/Draw_0.gml:93; objects/obj_mario/Step_2.gml:628,635; objects/obj_player_warp/Step_2.gml:31 | - |
| scr_mariohold_fall | scripts/scr_mariohold_fall/scr_mariohold_fall.gml:1 | 6 | Scripts/Mario | 0/0 | - | - |
| scr_mariohold_jump | scripts/scr_mariohold_jump/scr_mariohold_jump.gml:1 | 6 | Scripts/Mario | 0/0 | - | - |
| scr_marioidle | scripts/scr_marioidle/scr_marioidle.gml:1 | 268 | Scripts/Mario | 17/15 | objects/obj_doormario/Draw_0.gml:95; objects/obj_doormario_exit/Draw_0.gml:101; objects/obj_mario/Create_0.gml:2; objects/obj_mario/Step_2.gml:114,130; objects/obj_mario_editor/Step_0.gml:76; objects/obj_mario_temp/Create_0.gml:4; objects/obj_mario_transform2/Create_0.gml:55; objects/obj_mariostart_m/Other_10.gml:7; objects/obj_player_goal_smb1/Other_23.gml:24; objects/obj_player_goal_smb3/Step_2.gml:28; objects/obj_player_goal_smw/Alarm_2.gml:7; objects/obj_player_goal_smw/Step_0.gml:54,64; objects/obj_player_goal_smw_castle/Create_0.gml:7; objects/obj_player_goal_smw_castle/Step_2.gml:106; objects/obj_player_warp/Step_2.gml:25 | - |
| scr_mariojump | scripts/scr_mariojump/scr_mariojump.gml:1 | 292 | Scripts/Mario | 8/6 | objects/obj_mario/Step_2.gml:391,455,465; objects/obj_mariostart_m/Other_10.gml:5; objects/obj_player_goal_smb1/Other_23.gml:41; objects/obj_player_goal_smb3/Step_2.gml:18; objects/obj_player_goal_smw/Step_2.gml:52; objects/obj_player_goal_smw_castle/Step_2.gml:124 | - |
| scr_mariojumphold | scripts/scr_mariojumphold/scr_mariojumphold.gml:1 | 33 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:622 | - |
| scr_mariojumpstar | scripts/scr_mariojumpstar/scr_mariojumpstar.gml:1 | 64 | Scripts/Mario | 5/3 | objects/obj_mario/Alarm_10.gml:88,110; objects/obj_mario/Other_12.gml:758; objects/obj_mario/Step_2.gml:377,425 | - |
| scr_mariokick | scripts/scr_mariokick/scr_mariokick.gml:1 | 199 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:680 | - |
| scr_marioride | scripts/scr_marioride/scr_marioride.gml:1 | 70 | Scripts/Mario | 9/6 | objects/obj_doormario/Draw_0.gml:53; objects/obj_doormario_exit/Draw_0.gml:53; objects/obj_player_goal_smw/Draw_0.gml:25,29,43; objects/obj_player_goal_smw_castle/Draw_0.gml:24,34; objects/obj_player_warp/Draw_0.gml:53; objects/obj_yoshi2/Other_12.gml:19 | - |
| scr_mariorun | scripts/scr_mariorun/scr_mariorun.gml:1 | 154 | Scripts/Mario | 3/1 | objects/obj_mario/Step_2.gml:174,216,626 | - |
| scr_mariorunjump | scripts/scr_mariorunjump/scr_mariorunjump.gml:1 | 144 | Scripts/Mario | 2/2 | objects/obj_cap_mario/Other_16.gml:25; objects/obj_mario/Step_2.gml:468 | - |
| scr_marioshoot | scripts/scr_marioshoot/scr_marioshoot.gml:1 | 94 | Scripts/Mario | 8/2 | objects/obj_mario/Step_2.gml:101,154,239,355; objects/obj_marioU/Step_2.gml:213,365,491,855 | - |
| scr_marioshoot_drybones | scripts/scr_marioshoot_drybones/scr_marioshoot_drybones.gml:1 | 88 | Scripts/Mario | 1/1 | objects/obj_kuribo_drybones/Step_2.gml:14 | - |
| scr_marioskid | scripts/scr_marioskid/scr_marioskid.gml:1 | 232 | Scripts/Mario | 6/2 | objects/obj_mario/Step_2.gml:73,108,161,667,763; objects/obj_mario_transform2/Create_0.gml:51 | - |
| scr_marioslide | scripts/scr_marioslide/scr_marioslide.gml:1 | 131 | Scripts/Mario | 2/2 | objects/obj_slider/Create_0.gml:12; objects/obj_slider/Step_0.gml:16 | - |
| scr_marioswim | scripts/scr_marioswim/scr_marioswim.gml:1 | 288 | Scripts/Mario | 6/3 | objects/obj_cap_mario/Other_16.gml:30; objects/obj_mario/Other_13.gml:175,177; objects/obj_mario/Step_2.gml:181,253,313 | - |
| scr_marioswim2 | scripts/scr_marioswim2/scr_marioswim2.gml:1 | 13 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:264 | - |
| scr_marioswim3 | scripts/scr_marioswim3/scr_marioswim3.gml:1 | 13 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:280 | - |
| scr_marioswim_hold_idle | scripts/scr_marioswim_hold_idle/scr_marioswim_hold_idle.gml:1 | 13 | Scripts/Mario | 4/1 | objects/obj_mario/Step_2.gml:489,524,548,564 | - |
| scr_marioswim_idle | scripts/scr_marioswim_idle/scr_marioswim_idle.gml:1 | 13 | Scripts/Mario | 4/1 | objects/obj_mario/Step_2.gml:124,248,272,288 | - |
| scr_marioswimhold | scripts/scr_marioswimhold/scr_marioswimhold.gml:1 | 248 | Scripts/Mario | 11/5 | objects/obj_cap_mario/Other_16.gml:30; objects/obj_mario/Step_2.gml:317,327,529,540,556,616,631; objects/obj_player_goal_smb1/Other_23.gml:36; objects/obj_player_goal_smb3/Step_2.gml:13; objects/obj_player_goal_smw/Step_2.gml:44 | - |
| scr_marioup | scripts/scr_marioup/scr_marioup.gml:1 | 71 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:133 | - |
| scr_mariouphold | scripts/scr_mariouphold/scr_mariouphold.gml:1 | 70 | Scripts/Mario | 1/1 | objects/obj_mario/Step_2.gml:637 | - |
| scr_mariowalk | scripts/scr_mariowalk/scr_mariowalk.gml:1 | 247 | Scripts/Mario | 14/8 | objects/obj_mario/Step_2.gml:112,170,172,197,214,406,432; objects/obj_mario_editor/Step_0.gml:39; objects/obj_mario_transform2/Create_0.gml:53; objects/obj_player_goal_smb1/Other_23.gml:30; objects/obj_player_goal_smb3/Step_2.gml:33; objects/obj_player_goal_smw/Step_2.gml:35; objects/obj_player_goal_smw_castle/Step_2.gml:115; objects/obj_player_warp/Step_2.gml:27 | - |
| scr_mariowarp | scripts/scr_mariowarp/scr_mariowarp.gml:1 | 89 | Scripts/Mario | 7/1 | objects/obj_mario/Step_2.gml:91,144,229,338,346,612,618 | - |
| scr_meteorites_shard | scripts/scr_meteorites_shard/scr_meteorites_shard.gml:1 | 21 | Scripts | 0/0 | - | - |
| scr_meteorites_shard_big | scripts/scr_meteorites_shard_big/scr_meteorites_shard_big.gml:1 | 21 | Scripts | 0/0 | - | - |
| scr_move_contact_object | scripts/scr_move_contact_object/scr_move_contact_object.gml:1 | 14 | Scripts/Sprites | 0/0 | - | - |
| scr_mushroom_platform1_sprites | scripts/scr_mushroom_platform1_sprites/scr_mushroom_platform1_sprites.gml:1 | 162 | Scripts/Sprites | 1/1 | objects/obj_mushroom_platform_res/Step_2.gml:2 | - |
| scr_mushroom_platform2_sprites | scripts/scr_mushroom_platform2_sprites/scr_mushroom_platform2_sprites.gml:1 | 195 | Scripts/Sprites | 1/1 | objects/obj_mushroom_platform_res/Step_2.gml:4 | - |
| scr_mushroom_platform3_sprites | scripts/scr_mushroom_platform3_sprites/scr_mushroom_platform3_sprites.gml:1 | 172 | Scripts/Sprites | 1/1 | objects/obj_mushroom_platform_res/Step_2.gml:6 | - |
| scr_music_link | scripts/scr_music_link/scr_music_link.gml:1 | 18 | Scripts | 16/10 | objects/obj_deadmario/Create_0.gml:26; objects/obj_goalcard/Collision_obj_mario.gml:11; objects/obj_levelmanager/Alarm_10.gml:14; objects/obj_levelmanager/Other_11.gml:9; objects/obj_levelmanager/Other_13.gml:4; objects/obj_levelmanager/Other_5.gml:20; objects/obj_levelmanager/Step_2.gml:357,415,523,531; objects/obj_menu_pausa/Create_0.gml:24,25; objects/obj_menu_pausa/Other_10.gml:22,23; objects/obj_menu_pausa/Other_11.gml:48,49 | - |
| scr_musicalscale | scripts/scr_musicalscale/scr_musicalscale.gml:1 | 286 | Scripts/Sounds | 13/10 | objects/obj_blockbumper/Collision_obj_enemyparent.gml:3; objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml:14; objects/obj_enemyparent/Collision_obj_mario.gml:20,31,46,182; objects/obj_explosion/Collision_obj_enemyparent.gml:3; objects/obj_fire_clown/Collision_obj_bobomb.gml:2; objects/obj_fire_clown/Collision_obj_enemyparent.gml:4; objects/obj_invincibility/Collision_obj_enemyparent.gml:5; objects/obj_shell_held/Collision_obj_enemyparent.gml:14; objects/obj_slider/Collision_obj_enemyparent.gml:3; objects/obj_stomp/Collision_obj_enemyparent.gml:3 | instance_create(:2) |
| scr_musicalscale_SMB | scripts/scr_musicalscale_SMB/scr_musicalscale_SMB.gml:1 | 61 | Scripts/Sounds | 0/0 | - | instance_create(:3) |
| scr_musicalscale_SMB3 | scripts/scr_musicalscale_SMB3/scr_musicalscale_SMB3.gml:1 | 61 | Scripts/Sounds | 4/2 | objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml:8,11; objects/obj_shell_held/Collision_obj_enemyparent.gml:8,11 | instance_create(:3) |
| scr_musicalscale_kick | scripts/scr_musicalscale_kick/scr_musicalscale_kick.gml:1 | 136 | Scripts/Sounds | 3/3 | objects/obj_bowserjr_shell/Collision_obj_enemyparent.gml:17; objects/obj_enemyparent/Collision_obj_mario.gml:29; objects/obj_shell_held/Collision_obj_enemyparent.gml:17 | instance_create(:2) |
| scr_pink_coins | scripts/scr_pink_coins/scr_pink_coins.gml:1 | 112 | Scripts | 2/2 | objects/obj_levelmanager/Other_19.gml:1; objects/obj_levelmanager/Other_20.gml:1 | - |
| scr_play_to_edit | scripts/scr_play_to_edit/scr_play_to_edit.gml:1 | 521 | Scripts/Editor | 1/1 | objects/obj_creator_jugar_editar/Other_13.gml:220 | - |
| scr_powerup_editor | scripts/scr_powerup_editor/scr_powerup_editor.gml:1 | 98 | Scripts | 1/1 | objects/obj_mario_editor/Step_0.gml:2 | - |
| scr_reset_variables | scripts/scr_reset_variables/scr_reset_variables.gml:1 | 33 | Scripts | 1/1 | objects/obj_creator_jugar_editar/Other_13.gml:249 | - |
| scr_resources_get_sprite | scripts/scr_resources_get_sprite/scr_resources_get_sprite.gml:1 | 40 | Scripts/Sprites | 1/1 | objects/obj_creation_preview/Step_1.gml:13 | - |
| scr_restart | scripts/scr_restart/scr_restart.gml:1 | 12 | Scripts | 7/7 | objects/obj_axe_smw/Alarm_3.gml:9; objects/obj_deadmario/Alarm_1.gml:17; objects/obj_flagpole/Alarm_0.gml:12; objects/obj_goalcard/Alarm_2.gml:12; objects/obj_goalgate/Alarm_1.gml:12; objects/obj_hawmask/Alarm_2.gml:7; objects/obj_menu_pausa/Other_11.gml:76 | - |
| scr_return | scripts/scr_return/scr_return.gml:1 | 13 | Scripts | 0/0 | - | - |
| scr_save | scripts/scr_save/scr_save.gml:1 | 23 | Scripts | 0/0 | - | - |
| scr_semisolid_platform1_sprites | scripts/scr_semisolid_platform1_sprites/scr_semisolid_platform1_sprites.gml:1 | 185 | Scripts/Sprites | 1/1 | objects/obj_semisolid_platform1/Step_2.gml:2 | - |
| scr_semisolid_platform2_sprites | scripts/scr_semisolid_platform2_sprites/scr_semisolid_platform2_sprites.gml:1 | 190 | Scripts/Sprites | 1/1 | objects/obj_semisolid_platform1/Step_2.gml:4 | - |
| scr_semisolid_platform3_sprites | scripts/scr_semisolid_platform3_sprites/scr_semisolid_platform3_sprites.gml:1 | 183 | Scripts/Sprites | 1/1 | objects/obj_semisolid_platform1/Step_2.gml:6 | - |
| scr_sidefade | scripts/scr_sidefade/scr_sidefade.gml:1 | 8 | Scripts | 0/0 | - | instance_create(:3) |
| scr_snd_airship | scripts/scr_snd_airship/scr_snd_airship.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:127; objects/obj_bg1/Other_10.gml:130; objects/obj_card_logo/Mouse_4.gml:119; objects/obj_load_guardabot/Other_12.gml:105; objects/obj_load_level/Other_11.gml:130; objects/obj_night_change/Other_11.gml:117 | - |
| scr_snd_autumn | scripts/scr_snd_autumn/scr_snd_autumn.gml:1 | 31 | Scripts/Music/Level music | 5/5 | objects/obj_angrysun_res/Other_11.gml:242; objects/obj_bg1/Other_10.gml:260; objects/obj_card_logo/Mouse_4.gml:234; objects/obj_load_guardabot/Other_12.gml:210; objects/obj_night_change/Other_11.gml:232 | - |
| scr_snd_beach | scripts/scr_snd_beach/scr_snd_beach.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:263; objects/obj_bg1/Other_10.gml:284; objects/obj_card_logo/Mouse_4.gml:255; objects/obj_load_guardabot/Other_12.gml:229; objects/obj_load_level/Other_11.gml:285; objects/obj_night_change/Other_11.gml:253 | - |
| scr_snd_bowserjr_shell | scripts/scr_snd_bowserjr_shell/scr_snd_bowserjr_shell.gml:1 | 17 | Scripts/Sounds | 5/2 | objects/obj_levelmanager/Step_2.gml:16,17,18,19; objects/obj_menu_pausa/Create_0.gml:56 | - |
| scr_snd_break | scripts/scr_snd_break/scr_snd_break.gml:1 | 17 | Scripts/Sounds | 22/12 | objects/obj_blockparent/Alarm_2.gml:148,149; objects/obj_blockparent/Other_25.gml:2,3; objects/obj_bonybeetle/Other_10.gml:1,2; objects/obj_bonybeetle_b/Other_10.gml:1,2; objects/obj_crumblebones/Other_10.gml:1,2; objects/obj_crumblebony/Other_10.gml:1,2; objects/obj_crumblebony_b/Other_10.gml:1,2; objects/obj_drybones/Other_10.gml:1; objects/obj_kuribo_drybones/Step_2.gml:134,184,185; objects/obj_rockparent/Alarm_0.gml:2,3; objects/obj_shell_drybones/Other_10.gml:1; objects/obj_shell_drybones_held/Other_10.gml:1 | - |
| scr_snd_bump | scripts/scr_snd_bump/scr_snd_bump.gml:1 | 17 | Scripts/Sounds | 29/15 | objects/obj_bowser_fire/Collision_obj_helmet.gml:1; objects/obj_bowser_fire/Collision_obj_kuribo_drybones.gml:1; objects/obj_bowser_fire/Collision_obj_shield_left.gml:3; objects/obj_bowser_fire/Collision_obj_shield_right.gml:3; objects/obj_bowserjr_shell/Other_13.gml:40,41; objects/obj_charginchuck/Alarm_0.gml:6,7; objects/obj_fireball/Other_10.gml:2,3; objects/obj_grrrol/Other_13.gml:82,83; objects/obj_grrrol_b/Other_13.gml:82,83; objects/obj_grrrol_new/Other_13.gml:82,83; objects/obj_mario/Step_0.gml:251,254,318,320; objects/obj_marioU/Step_0.gml:233,236,287,289; objects/obj_plantfire/Other_10.gml:1; objects/obj_shell_held/Step_0.gml:43,44; objects/obj_stomp/Create_0.gml:11,12 | - |
| scr_snd_castle | scripts/scr_snd_castle/scr_snd_castle.gml:1 | 34 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:64; objects/obj_bg1/Other_10.gml:58; objects/obj_card_logo/Mouse_4.gml:56; objects/obj_load_guardabot/Other_12.gml:48; objects/obj_load_level/Other_11.gml:58; objects/obj_night_change/Other_11.gml:54 | - |
| scr_snd_clown_damage | scripts/scr_snd_clown_damage/scr_snd_clown_damage.gml:1 | 17 | Scripts/Sounds | 5/4 | objects/obj_clown/Alarm_2.gml:2; objects/obj_clown/Collision_obj_pinchos.gml:3,4; objects/obj_menu_pausa/Other_12.gml:5; scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml:65 | - |
| scr_snd_clown_fire_charge | scripts/scr_snd_clown_fire_charge/scr_snd_clown_fire_charge.gml:1 | 17 | Scripts/Sounds | 4/3 | objects/obj_clown/Step_0.gml:237; objects/obj_clown_fire/Destroy_0.gml:2; objects/obj_clown_fire/Step_1.gml:8,43 | - |
| scr_snd_coin | scripts/scr_snd_coin/scr_snd_coin.gml:1 | 17 | Scripts/Sounds | 10/5 | objects/obj_blockcoin/Create_0.gml:68,69; objects/obj_coin/Other_11.gml:1,2; objects/obj_coin/Other_12.gml:1,2; objects/obj_coin_pow/Collision_obj_mario.gml:3,4; objects/obj_veggiecoin/Create_0.gml:65,66 | - |
| scr_snd_dead | scripts/scr_snd_dead/scr_snd_dead.gml:1 | 21 | Scripts/Sounds | 10/5 | objects/obj_deadmario/Create_0.gml:7; objects/obj_menu_pausa/Create_0.gml:28,29,30,31; objects/obj_menu_pausa/Other_10.gml:20,21; objects/obj_menu_pausa/Other_11.gml:50,51; objects/obj_menu_pausa/Other_12.gml:9 | - |
| scr_snd_desert | scripts/scr_snd_desert/scr_snd_desert.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:192; objects/obj_bg1/Other_10.gml:204; objects/obj_card_logo/Mouse_4.gml:184; objects/obj_load_guardabot/Other_12.gml:164; objects/obj_load_level/Other_11.gml:204; objects/obj_night_change/Other_11.gml:182 | - |
| scr_snd_door_close | scripts/scr_snd_door_close/scr_snd_door_close.gml:1 | 17 | Scripts/Sounds | 6/6 | objects/obj_door/Other_7.gml:26; objects/obj_door_exit/Other_7.gml:26; objects/obj_door_lock/Other_7.gml:18; objects/obj_door_lock_exit/Other_7.gml:18; objects/obj_door_switch/Other_7.gml:11; objects/obj_door_switch_exit/Other_7.gml:11 | - |
| scr_snd_door_open | scripts/scr_snd_door_open/scr_snd_door_open.gml:1 | 17 | Scripts/Sounds | 8/8 | objects/obj_door/Step_0.gml:9; objects/obj_door_exit/Step_0.gml:9; objects/obj_door_lock/Alarm_3.gml:1; objects/obj_door_lock/Step_0.gml:162; objects/obj_door_lock_exit/Alarm_3.gml:1; objects/obj_door_lock_exit/Step_0.gml:161; objects/obj_door_switch/Step_0.gml:13; objects/obj_door_switch_exit/Step_0.gml:13 | - |
| scr_snd_editor_airship | scripts/scr_snd_editor_airship/scr_snd_editor_airship.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:128; objects/obj_bg1/Other_10.gml:131; objects/obj_card_logo/Mouse_4.gml:120; objects/obj_load_level/Other_11.gml:131; objects/obj_night_change/Other_11.gml:118 | - |
| scr_snd_editor_beach | scripts/scr_snd_editor_beach/scr_snd_editor_beach.gml:1 | 17 | Scripts/Music/Editor Music | 0/0 | - | - |
| scr_snd_editor_castle | scripts/scr_snd_editor_castle/scr_snd_editor_castle.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:65; objects/obj_bg1/Other_10.gml:59; objects/obj_card_logo/Mouse_4.gml:57; objects/obj_load_level/Other_11.gml:59; objects/obj_night_change/Other_11.gml:55 | - |
| scr_snd_editor_desert | scripts/scr_snd_editor_desert/scr_snd_editor_desert.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:193; objects/obj_bg1/Other_10.gml:205; objects/obj_card_logo/Mouse_4.gml:185; objects/obj_load_level/Other_11.gml:205; objects/obj_night_change/Other_11.gml:183 | - |
| scr_snd_editor_forest | scripts/scr_snd_editor_forest/scr_snd_editor_forest.gml:1 | 17 | Scripts/Music/Editor Music | 10/5 | objects/obj_angrysun_res/Other_11.gml:151,243; objects/obj_bg1/Other_10.gml:157,261; objects/obj_card_logo/Mouse_4.gml:166,235; objects/obj_load_level/Other_11.gml:157,262; objects/obj_night_change/Other_11.gml:141,233 | - |
| scr_snd_editor_ghost | scripts/scr_snd_editor_ghost/scr_snd_editor_ghost.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:89; objects/obj_bg1/Other_10.gml:89; objects/obj_card_logo/Mouse_4.gml:81; objects/obj_load_level/Other_11.gml:89; objects/obj_night_change/Other_11.gml:79 | - |
| scr_snd_editor_ground | scripts/scr_snd_editor_ground/scr_snd_editor_ground.gml:1 | 17 | Scripts/Music/Editor Music | 10/5 | objects/obj_angrysun_res/Other_11.gml:44,264; objects/obj_bg1/Other_10.gml:32,285; objects/obj_card_logo/Mouse_4.gml:36,256; objects/obj_load_level/Other_11.gml:32,286; objects/obj_night_change/Other_11.gml:34,254 | - |
| scr_snd_editor_mountain | scripts/scr_snd_editor_mountain/scr_snd_editor_mountain.gml:1 | 45 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:304; objects/obj_bg1/Other_10.gml:326; objects/obj_card_logo/Mouse_4.gml:296; objects/obj_load_level/Other_11.gml:329; objects/obj_night_change/Other_11.gml:295 | - |
| scr_snd_editor_sky | scripts/scr_snd_editor_sky/scr_snd_editor_sky.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:174; objects/obj_bg1/Other_10.gml:183; objects/obj_card_logo/Mouse_4.gml:143; objects/obj_load_level/Other_11.gml:183; objects/obj_night_change/Other_11.gml:164 | - |
| scr_snd_editor_snow | scripts/scr_snd_editor_snow/scr_snd_editor_snow.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:226; objects/obj_bg1/Other_10.gml:241; objects/obj_card_logo/Mouse_4.gml:218; objects/obj_load_level/Other_11.gml:242; objects/obj_night_change/Other_11.gml:216 | - |
| scr_snd_editor_underground | scripts/scr_snd_editor_underground/scr_snd_editor_underground.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:50; objects/obj_bg1/Other_10.gml:41; objects/obj_card_logo/Mouse_4.gml:42; objects/obj_load_level/Other_11.gml:41; objects/obj_night_change/Other_11.gml:40 | - |
| scr_snd_editor_underwater | scripts/scr_snd_editor_underwater/scr_snd_editor_underwater.gml:1 | 17 | Scripts/Music/Editor Music | 5/5 | objects/obj_angrysun_res/Other_11.gml:71; objects/obj_bg1/Other_10.gml:68; objects/obj_card_logo/Mouse_4.gml:63; objects/obj_load_level/Other_11.gml:68; objects/obj_night_change/Other_11.gml:61 | - |
| scr_snd_editor_volcano | scripts/scr_snd_editor_volcano/scr_snd_editor_volcano.gml:1 | 17 | Scripts/Music/Editor Music | 0/0 | - | - |
| scr_snd_explode | scripts/scr_snd_explode/scr_snd_explode.gml:1 | 17 | Scripts/Sounds | 6/3 | objects/obj_cannon/Alarm_0.gml:6,7; objects/obj_cannon_red/Alarm_0.gml:6,7; objects/obj_explosion/Create_0.gml:27,28 | - |
| scr_snd_fireball | scripts/scr_snd_fireball/scr_snd_fireball.gml:1 | 21 | Scripts/Sounds | 5/3 | objects/obj_fireball/Create_0.gml:15,16; objects/obj_fireball_b/Create_0.gml:15; objects/obj_fireball_bro/Create_0.gml:15,16 | - |
| scr_snd_forest | scripts/scr_snd_forest/scr_snd_forest.gml:1 | 35 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:150; objects/obj_bg1/Other_10.gml:156; objects/obj_card_logo/Mouse_4.gml:165; objects/obj_load_guardabot/Other_12.gml:147; objects/obj_load_level/Other_11.gml:156; objects/obj_night_change/Other_11.gml:140 | - |
| scr_snd_getcheckpoint | scripts/scr_snd_getcheckpoint/scr_snd_getcheckpoint.gml:1 | 17 | Scripts/Sounds | 4/2 | objects/obj_checkpoint/Collision_obj_mario.gml:1,54; objects/obj_checkpoint/Collision_obj_shell_held.gml:1,54 | - |
| scr_snd_ghost_house | scripts/scr_snd_ghost_house/scr_snd_ghost_house.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:88; objects/obj_bg1/Other_10.gml:88; objects/obj_card_logo/Mouse_4.gml:80; objects/obj_load_guardabot/Other_12.gml:68; objects/obj_load_level/Other_11.gml:88; objects/obj_night_change/Other_11.gml:78 | - |
| scr_snd_ground | scripts/scr_snd_ground/scr_snd_ground.gml:1 | 35 | Scripts/Music/Level music | 7/6 | objects/obj_angrysun_res/Other_11.gml:43; objects/obj_bg1/Other_10.gml:31; objects/obj_card_logo/Mouse_4.gml:35; objects/obj_load_guardabot/Other_12.gml:31; objects/obj_load_level/Other_11.gml:31,261; objects/obj_night_change/Other_11.gml:33 | - |
| scr_snd_hurryup | scripts/scr_snd_hurryup/scr_snd_hurryup.gml:1 | 17 | Scripts/Sounds | 12/8 | objects/obj_levelmanager/Alarm_3.gml:1; objects/obj_levelmanager/Other_15.gml:3,4; objects/obj_levelmanager/Step_2.gml:310; objects/obj_menu_pausa/Create_0.gml:32,33; objects/obj_menu_pausa/Other_10.gml:24,25; objects/obj_menu_pausa/Other_11.gml:52,53; objects/obj_menu_pausa/Other_12.gml:10; scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml:66 | - |
| scr_snd_kick | scripts/scr_snd_kick/scr_snd_kick.gml:1 | 17 | Scripts/Sounds | 117/70 | objects/obj_enemyparent/Collision_obj_blockparent.gml:3,4,14,15; objects/obj_enemyparent_held/Collision_obj_enemyparent.gml:3,9,15; objects/obj_snow_ball/Collision_obj_enemyparent.gml:5,11,17; objects/obj_block_pow_hold/Other_12.gml:16,49; objects/obj_boo/Collision_obj_blockparent.gml:3,4; objects/obj_bullebill_base/Collision_obj_bossparent.gml:7,8; objects/obj_bullebill_base/Collision_obj_enemyparent.gml:17,18; objects/obj_bullebill_base/Collision_obj_enemyparent_held.gml:5,6; objects/obj_cap_mario/Collision_obj_spike_ball.gml:5,6; objects/obj_enemyparent/Collision_obj_mario.gml:115,197; objects/obj_enemyparent_held/Collision_obj_bossparent.gml:3,8; objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml:5,16; objects/obj_gold_explosion/Collision_obj_bossparent.gml:1,2; objects/obj_gold_explosion/Collision_obj_enemyparent.gml:3,4; objects/obj_gold_explosion/Collision_obj_enemyparent_held.gml:3,4; …另 55 个文件 83 处 | - |
| scr_snd_meteorites_break | scripts/scr_snd_meteorites_break/scr_snd_meteorites_break.gml:1 | 17 | Scripts/Sounds | 0/0 | - | - |
| scr_snd_mountain | scripts/scr_snd_mountain/scr_snd_mountain.gml:1 | 33 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:303; objects/obj_bg1/Other_10.gml:325; objects/obj_card_logo/Mouse_4.gml:295; objects/obj_load_guardabot/Other_12.gml:266; objects/obj_load_level/Other_11.gml:328; objects/obj_night_change/Other_11.gml:294 | - |
| scr_snd_oneway | scripts/scr_snd_oneway/scr_snd_oneway.gml:1 | 17 | Scripts/Sounds | 8/4 | objects/obj_onewaygate_bottom/Other_10.gml:1,2; objects/obj_onewaygate_left/Other_10.gml:1,2; objects/obj_onewaygate_right/Other_10.gml:1,2; objects/obj_onewaygate_top/Other_10.gml:1,2 | - |
| scr_snd_pink_coin5 | scripts/scr_snd_pink_coin5/scr_snd_pink_coin5.gml:1 | 10 | Scripts | 0/0 | - | - |
| scr_snd_pink_coins | scripts/scr_snd_pink_coins/scr_snd_pink_coins.gml:1 | 64 | Scripts | 0/0 | - | - |
| scr_snd_pipes | scripts/scr_snd_pipes/scr_snd_pipes.gml:1 | 17 | Scripts/Sounds | 4/2 | objects/obj_player_warp/Other_10.gml:1,2; objects/obj_tuberia_res/Other_11.gml:5,6 | - |
| scr_snd_powerdown | scripts/scr_snd_powerdown/scr_snd_powerdown.gml:1 | 21 | Scripts/Sounds | 23/19 | objects/obj_mario/Other_10.gml:61,97,114,133; objects/obj_window_mario_button/Mouse_4.gml:16,21; objects/obj_SMB2_mushroom_res/Other_13.gml:1; objects/obj_big_pplant_b_res/Other_13.gml:1; objects/obj_bonybeetle_b_res/Other_13.gml:1; objects/obj_boomboom_b_res/Other_13.gml:1; objects/obj_buzzybeetle_b_res/Other_13.gml:1; objects/obj_chomp_b_res/Other_13.gml:1; objects/obj_goomba_b_res/Other_13.gml:1; objects/obj_goombrat_b_res/Other_13.gml:1; objects/obj_grrrol_b_res/Other_13.gml:1; objects/obj_koopa_b_res/Other_13.gml:1; objects/obj_koopa_red_b_res/Other_13.gml:1; objects/obj_muncher_b_res/Other_13.gml:1; objects/obj_podoboo_b_res/Other_13.gml:1; …另 4 个文件 4 处 | - |
| scr_snd_powerup | scripts/scr_snd_powerup/scr_snd_powerup.gml:1 | 23 | Scripts/Sounds | 45/27 | objects/obj_powerupparent/Collision_obj_mario.gml:49,50,72,73,94,95,107,108; objects/obj_SMB2_mushroom/Collision_obj_mario.gml:35,36,46,47,52,53; objects/obj_mushroom/Collision_obj_mario.gml:26,27,45,46; objects/obj_frogsuit/Collision_obj_mario.gml:43,44; objects/obj_hammersuit/Collision_obj_mario.gml:35,36; objects/obj_superflower/Collision_obj_mario.gml:37,38; objects/obj_big_pplant_res/Other_13.gml:1; objects/obj_bonybeetle_res/Other_13.gml:1; objects/obj_boomerangbro_res/Other_13.gml:1; objects/obj_buzzybeetle_res/Other_13.gml:1; objects/obj_cap/Collision_obj_mario.gml:63; objects/obj_chomp_res/Other_13.gml:1; objects/obj_egg_res/Other_13.gml:3; objects/obj_firebro_res/Other_13.gml:1; objects/obj_goomba_res/Other_13.gml:1; …另 12 个文件 12 处 | - |
| scr_snd_pwarning | scripts/scr_snd_pwarning/scr_snd_pwarning.gml:1 | 17 | Scripts/Sounds | 1/1 | objects/obj_pswitch/Other_17.gml:6 | - |
| scr_snd_skid | scripts/scr_snd_skid/scr_snd_skid.gml:1 | 17 | Scripts/Sounds | 21/9 | objects/obj_deadmario/Create_0.gml:28; objects/obj_mario/Other_24.gml:3; objects/obj_mario/Step_2.gml:80,109,164,671,765; objects/obj_marioU/Step_2.gml:59,67,90,1419,1422,1423; objects/obj_menu_pausa/Create_0.gml:50,51; objects/obj_menu_pausa/Other_10.gml:40,41; objects/obj_menu_pausa/Other_11.gml:68,69; objects/obj_menu_pausa/Other_12.gml:18; scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml:63 | - |
| scr_snd_sky | scripts/scr_snd_sky/scr_snd_sky.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:173; objects/obj_bg1/Other_10.gml:182; objects/obj_card_logo/Mouse_4.gml:142; objects/obj_load_guardabot/Other_12.gml:126; objects/obj_load_level/Other_11.gml:182; objects/obj_night_change/Other_11.gml:163 | - |
| scr_snd_snow | scripts/scr_snd_snow/scr_snd_snow.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:225; objects/obj_bg1/Other_10.gml:240; objects/obj_card_logo/Mouse_4.gml:217; objects/obj_load_guardabot/Other_12.gml:195; objects/obj_load_level/Other_11.gml:241; objects/obj_night_change/Other_11.gml:215 | - |
| scr_snd_soplete | scripts/scr_snd_soplete/scr_snd_soplete.gml:3 | 8 | Scripts/Sounds | 6/4 | objects/obj_levelmanager/Other_5.gml:4; objects/obj_soplete_global/Alarm_0.gml:12,13; objects/obj_soplete_invert_global/Alarm_0.gml:12,13; scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml:62 | - |
| scr_snd_spinjump | scripts/scr_snd_spinjump/scr_snd_spinjump.gml:1 | 13 | Scripts/Sounds | 5/4 | objects/obj_claw/Step_2.gml:139; objects/obj_clown/Step_0.gml:108,109; objects/obj_mario/Other_12.gml:184; objects/obj_marioU/Other_12.gml:162 | - |
| scr_snd_spring | scripts/scr_snd_spring/scr_snd_spring.gml:1 | 17 | Scripts/Sounds | 10/5 | objects/obj_spring/Collision_obj_holdparent.gml:16,17; objects/obj_spring/Collision_obj_physicsparent.gml:25,26; objects/obj_spring/Collision_obj_powerupparent.gml:16,17; objects/obj_spring/Step_0.gml:19,20; objects/obj_spring_land/Other_11.gml:4,5 | - |
| scr_snd_sprout | scripts/scr_snd_sprout/scr_snd_sprout.gml:1 | 17 | Scripts/Sounds | 4/4 | objects/obj_noteblock/Other_10.gml:5; objects/obj_noteblock/Other_11.gml:5; objects/obj_powerupsprout/Alarm_0.gml:57; objects/obj_powerupsprout_note/Alarm_0.gml:58 | - |
| scr_snd_starman | scripts/scr_snd_starman/scr_snd_starman.gml:1 | 17 | Scripts/Sounds | 34/16 | objects/obj_levelmanager/Step_2.gml:314,315,324,330,337,338,364,395…(×15); objects/obj_mario_editor/Other_11.gml:2,3; objects/obj_menu_pausa/Create_0.gml:22,23; objects/obj_menu_pausa/Other_10.gml:16,17; objects/obj_menu_pausa/Other_11.gml:44,45; objects/obj_crystalorb/Collision_obj_mario.gml:9; objects/obj_deadmario/Create_0.gml:25; objects/obj_goalcard/Collision_obj_mario.gml:10; objects/obj_invincibility/Alarm_0.gml:1; objects/obj_levelmanager/Alarm_10.gml:12; objects/obj_levelmanager/Other_11.gml:7; objects/obj_levelmanager/Other_13.gml:2; objects/obj_levelmanager/Other_5.gml:18; objects/obj_menu_pausa/Other_12.gml:7; objects/obj_star/Collision_obj_mario.gml:14; …另 1 个文件 1 处 | - |
| scr_snd_stomp | scripts/scr_snd_stomp/scr_snd_stomp.gml:1 | 16 | Scripts/Sounds | 17/8 | objects/obj_charginchuck/Other_11.gml:1,2; objects/obj_enemyparent/Collision_obj_mario.gml:61,74,88,89,125,126; objects/obj_meteorites/Collision_obj_mario.gml:5; objects/obj_meteorites_big/Collision_obj_mario.gml:5; objects/obj_shell/Collision_obj_mario.gml:75,76; objects/obj_spike_ball/Collision_obj_mario.gml:5; objects/obj_spiny_empty/Other_11.gml:5,6; objects/obj_wrench/Other_10.gml:4,5 | - |
| scr_snd_switchalert | scripts/scr_snd_switchalert/scr_snd_switchalert.gml:1 | 17 | Scripts/Sounds | 2/2 | objects/obj_levelmanager/Step_2.gml:306; objects/obj_persistent/Alarm_6.gml:1 | - |
| scr_snd_switchsong | scripts/scr_snd_switchsong/scr_snd_switchsong.gml:1 | 17 | Scripts/Sounds | 42/21 | objects/obj_levelmanager/Step_2.gml:316,317,325,331,339,340,364,395…(×15); objects/obj_coin/Step_2.gml:3,13; objects/obj_flipblock/Step_0.gml:4,13; objects/obj_flipblock_anim/Step_0.gml:3,12; objects/obj_levelmanager/Other_11.gml:5,6; objects/obj_menu_pausa/Create_0.gml:26,27; objects/obj_menu_pausa/Other_10.gml:18,19; objects/obj_menu_pausa/Other_11.gml:46,47; objects/obj_anti_pblock/Step_0.gml:1; objects/obj_cinta/Step_0.gml:1; objects/obj_cinta_switch/Step_0.gml:1; objects/obj_crystalorb/Collision_obj_mario.gml:8; objects/obj_door_switch/Step_0.gml:1; objects/obj_door_switch_exit/Step_0.gml:1; objects/obj_goalcard/Collision_obj_mario.gml:9; …另 6 个文件 6 处 | - |
| scr_snd_thwomp | scripts/scr_snd_thwomp/scr_snd_thwomp.gml:1 | 17 | Scripts/Sounds | 32/12 | objects/obj_NSMBU_bowser/Other_14.gml:30,31; objects/obj_NSMBU_bowserjr/Other_14.gml:21; objects/obj_SMB3_bowser/Other_14.gml:36; objects/obj_axe_smw/Step_0.gml:9; objects/obj_bowserjr/Other_14.gml:22; objects/obj_levelmanager/Alarm_11.gml:5,6; objects/obj_muncher/Other_14.gml:32,33; objects/obj_nube/Collision_obj_thwomp.gml:3; objects/obj_skewertrunk/Other_15.gml:9,10; objects/obj_sledgebro/Step_0.gml:110; objects/obj_thwomp/Step_0.gml:39,40,115,116,176,177; objects/obj_thwomp_b/Step_0.gml:41,42,67,68,133,134,145,146…(×12) | - |
| scr_snd_underground | scripts/scr_snd_underground/scr_snd_underground.gml:1 | 33 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:49; objects/obj_bg1/Other_10.gml:40; objects/obj_card_logo/Mouse_4.gml:41; objects/obj_load_guardabot/Other_12.gml:35; objects/obj_load_level/Other_11.gml:40; objects/obj_night_change/Other_11.gml:39 | - |
| scr_snd_underwater | scripts/scr_snd_underwater/scr_snd_underwater.gml:1 | 31 | Scripts/Music/Level music | 6/6 | objects/obj_angrysun_res/Other_11.gml:70; objects/obj_bg1/Other_10.gml:67; objects/obj_card_logo/Mouse_4.gml:62; objects/obj_load_guardabot/Other_12.gml:52; objects/obj_load_level/Other_11.gml:67; objects/obj_night_change/Other_11.gml:60 | - |
| scr_snd_volcano | scripts/scr_snd_volcano/scr_snd_volcano.gml:1 | 33 | Scripts/Music/Level music | 0/0 | - | - |
| scr_sprite_get_constant | scripts/scr_sprite_get_constant/scr_sprite_get_constant.gml:1 | 573 | Scripts/Sprites | 7/7 | objects/obj_SMB2_mushroom/Collision_obj_mario.gml:24; objects/obj_frogsuit/Collision_obj_mario.gml:15; objects/obj_hammersuit/Collision_obj_mario.gml:7; objects/obj_mario_transform2/Alarm_0.gml:49; objects/obj_pballon/Collision_obj_mario.gml:15; objects/obj_powerupparent/Collision_obj_mario.gml:24; objects/obj_superflower/Collision_obj_mario.gml:7 | - |
| scr_sprite_get_constant_res | scripts/scr_sprite_get_constant_res/scr_sprite_get_constant_res.gml:1 | 571 | Scripts/Sprites | 9/9 | objects/obj_block_hidden_res/Collision_obj_parent_resource.gml:6; objects/obj_block_res/Collision_obj_parent_resource.gml:6; objects/obj_bullebill_base_red_res/Collision_obj_parent_resource.gml:19; objects/obj_bullebill_base_res/Collision_obj_parent_resource.gml:19; objects/obj_checkpoint_res/Collision_obj_parent_resource.gml:6; objects/obj_lakitu_res/Collision_obj_parent_resource.gml:6; objects/obj_noteblock_res/Collision_obj_parent_resource.gml:6; objects/obj_parent_resource/Collision_obj_key_res.gml:21; objects/obj_qblock_res/Collision_obj_parent_resource.gml:6 | - |
| scr_sprite_make_object | scripts/scr_sprite_make_object/scr_sprite_make_object.gml:1 | 531 | Scripts/Sprites | 7/7 | objects/obj_bullebill_base/Other_11.gml:38; objects/obj_bullebill_base/Other_12.gml:38; objects/obj_bullebill_base_red/Other_11.gml:43; objects/obj_bullebill_base_red/Other_12.gml:43; objects/obj_checkpoint/Collision_obj_mario.gml:66; objects/obj_checkpoint/Collision_obj_shell_held.gml:66; objects/obj_lakitu/Alarm_1.gml:40 | instance_create(:7×245) |
| scr_sprite_make_object_rieles | scripts/scr_sprite_make_object_rieles/scr_sprite_make_object_rieles.gml:1 | 531 | Scripts/Sprites | 1/1 | scripts/scr_edit_to_play/scr_edit_to_play.gml:165 | instance_create(:7×245) |
| scr_step_sounds | scripts/scr_step_sounds/scr_step_sounds.gml:1 | 27 | Scripts | 6/1 | objects/obj_marioU/Other_19.gml:30,32,37,39,41,44 | - |
| scr_stop_effect_sounds | scripts/scr_stop_effect_sounds/scr_stop_effect_sounds.gml:1 | 70 | Scripts/Sounds | 3/3 | objects/obj_button_home/Mouse_4.gml:15; objects/obj_creator_jugar_editar/Other_13.gml:221; objects/obj_editor_screen/Other_12.gml:10 | scr_snd_clown_damage(:65), scr_snd_hurryup(:66), scr_snd_skid(:63), scr_snd_soplete(:62), scr_snd_starman(:64) |
| scr_swim | scripts/scr_swim/scr_swim.gml:1 | 17 | Scripts/Sounds | 29/3 | objects/obj_mario/Other_13.gml:76,77,87,88,104,105,118,119…(×17); objects/obj_mario/Other_24.gml:5; objects/obj_marioU/Other_13.gml:57,58,111,156,157,172,173,220…(×11) | - |
| scr_switchsong | scripts/scr_switchsong/scr_switchsong.gml:1 | 17 | Scripts/Music/Level music | 0/0 | - | - |
| scr_tiles_ground | scripts/scr_tiles_ground/scr_tiles_ground.gml:1 | 283 | Scripts | 3/3 | objects/obj_ground/Other_10.gml:1; objects/obj_ground2/Create_0.gml:1; objects/obj_ground3/Create_0.gml:1 | - |
| scr_tiles_ground_start | scripts/scr_tiles_ground_start/scr_tiles_ground_start.gml:1 | 275 | Scripts | 2/2 | objects/obj_ground2/Step_0.gml:1; objects/obj_ground3/Step_0.gml:1 | - |
| scr_toast | scripts/scr_toast/scr_toast.gml:1 | 22 | Scripts | 12/8 | objects/obj_button_notification_aceptar/Alarm_0.gml:8,18; objects/obj_button_notification_aceptar/Mouse_4.gml:9,22,27; objects/obj_button_notification_aceptar/Other_10.gml:224; objects/obj_button_save_changes/Alarm_0.gml:8,18; objects/obj_button_save_changes/Other_10.gml:221; objects/obj_gb_level/Create_0.gml:52; objects/obj_load_level/Other_10.gml:13; objects/obj_rename_button2/Mouse_4.gml:17 | instance_create(:9) |
| scr_verify_pub | scripts/scr_verify_pub/scr_verify_pub.gml:1 | 23 | Scripts/Misc | 0/0 | - | sha1_string_utf8_hmac(:9) |
| scr_viewculling | scripts/scr_viewculling/scr_viewculling.gml:1 | 20 | Scripts/Misc | 0/0 | - | - |
| screen_round | scripts/screen_round/screen_round.gml:5 | 7 | Scripts | 8/1 | objects/obj_mario_pballon/Draw_0.gml:2,2,4,4,9,9,11,11 | - |
| set_keys | scripts/set_keys/set_keys.gml:1 | 9 | Scripts | 7/1 | objects/obj_settings_controls/Mouse_4.gml:4,7,10,13,16,19,22 | instance_create(:2) |
| sha1_string_utf8_hmac | scripts/sha1_string_utf8_hmac/sha1_string_utf8_hmac.gml:1 | 40 | Scripts/Misc | 4/4 | objects/obj_button_notification_aceptar/Other_10.gml:213; objects/obj_button_save_changes/Other_10.gml:213; scripts/LoadJSONFromFile/LoadJSONFromFile.gml:9; scripts/scr_verify_pub/scr_verify_pub.gml:9 | hex_string_byte(:16×2) |
| string_add_zeros | scripts/string_add_zeros/string_add_zeros.gml:1 | 6 | Scripts/Misc | 13/5 | objects/obj_levelmanager/Other_19.gml:23,30,33,43,45; objects/obj_levelmanager/Other_20.gml:8,13,16,25,28; objects/obj_mariostart_m/Draw_0.gml:15; objects/obj_panel_time/Draw_0.gml:6; objects/obj_time/Draw_0.gml:17 | - |
| string_make_width | scripts/string_make_width/string_make_width.gml:1 | 19 | Scripts/Misc | 0/0 | - | - |
| string_split2 | scripts/string_split2/string_split2.gml:1 | 26 | Scripts/Misc | 0/0 | - | - |
| tile_layer_find | scripts/tile_layer_find/tile_layer_find.gml:6 | 103 | Scripts/compatibility/tile | 2/1 | objects/obj_magikoopa/Alarm_2.gml:12,12 | - |
| turn_towards_direction | scripts/turn_towards_direction/turn_towards_direction.gml:1 | 28 | Scripts/Misc | 0/0 | - | - |

调用点为 0 的函数：51 个：__global_object_depths, __init_action, __init_background, __init_global, __init_view, action_end_game, discord_free_app, discord_free_dll, discord_init_app, discord_init_dll, discord_update_presence, discord_webhook, draw_background, draw_background_ext, draw_sprite_autotiled, draw_sprite_autotiled2, draw_text_lang, has_internet, macros, outside_view_modelsizable, scr_NSMBU_penguin_swim, scr_addseparators, scr_bg_control, scr_bg_init, scr_diff, scr_etiq_search, scr_etiquetas_trad, scr_hspeed, scr_load, scr_mario_swim_idle, scr_mariohold_fall, scr_mariohold_jump, scr_meteorites_shard, scr_meteorites_shard_big, scr_move_contact_object, scr_musicalscale_SMB, scr_return, scr_save, scr_sidefade, scr_snd_editor_beach, scr_snd_editor_volcano, scr_snd_meteorites_break, scr_snd_pink_coin5, scr_snd_pink_coins, scr_snd_volcano, scr_switchsong, scr_verify_pub, scr_viewculling, string_make_width, string_split2, turn_towards_direction（0 仅表示按上述规则未检出，不代表一定未使用，见 §6）。

### 5.3 对象内联函数

| 函数 | 位置 |
|---|---|
| _prepare | objects/obj_dcw/Create_0.gml:5 |
| _createURL | objects/obj_dcw/Create_0.gml:18 |
| _log | objects/obj_dcw/Create_0.gml:22 |
| _parse_data | objects/obj_dcw/Create_0.gml:26 |
| destroy | objects/obj_dcw/Create_0.gml:37 |
| change_urlID | objects/obj_dcw/Create_0.gml:48 |
| change_urlToken | objects/obj_dcw/Create_0.gml:61 |
| execute | objects/obj_dcw/Create_0.gml:74 |

### 5.4 脚本中的 #macro / enum

| 种类 | 名称 | 位置 |
|---|---|---|
| macro | DISCORD_APP_ID = `"699637175360421948"` | objects/obj_persistent/Other_2.gml:4 |
| macro | dcw_noone = `"\\u00ad"` | scripts/discord_webhook/discord_webhook.gml:1 |
| macro | cs_small = `0` | scripts/macros/macros.gml:2 |
| macro | cs_big = `1` | scripts/macros/macros.gml:3 |
| macro | cs_fire = `2` | scripts/macros/macros.gml:4 |
| macro | cs_hero = `3` | scripts/macros/macros.gml:5 |
| macro | cs_helice = `-30` | scripts/macros/macros.gml:6 |
| macro | cs_arcon = `-43` | scripts/macros/macros.gml:7 |
| macro | cs_penguin = `-38` | scripts/macros/macros.gml:8 |
| macro | cs_superball = `-50` | scripts/macros/macros.gml:9 |
| macro | cs_mega = `-77` | scripts/macros/macros.gml:10 |
| macro | cs_hen = `-78` | scripts/macros/macros.gml:11 |
| macro | cs_link = `-85` | scripts/macros/macros.gml:12 |
| macro | cs_racoon = `-39` | scripts/macros/macros.gml:13 |
| macro | cs_frog = `-29` | scripts/macros/macros.gml:14 |
| macro | cs_hammer = `-46` | scripts/macros/macros.gml:15 |
| macro | cs_pballoon = `-82` | scripts/macros/macros.gml:16 |
| macro | cs_turnip = `104` | scripts/macros/macros.gml:17 |
| macro | cs_boomerang = `-105` | scripts/macros/macros.gml:18 |
| macro | mario = `0` | scripts/macros/macros.gml:19 |
| macro | luigi = `1` | scripts/macros/macros.gml:20 |
| macro | toad = `2` | scripts/macros/macros.gml:21 |
| macro | toadette = `3` | scripts/macros/macros.gml:22 |
| macro | SMB = `0` | scripts/macros/macros.gml:23 |
| macro | SMB3 = `1` | scripts/macros/macros.gml:24 |
| macro | SMW = `2` | scripts/macros/macros.gml:25 |
| macro | NSMBU = `3` | scripts/macros/macros.gml:26 |
| macro | SMB2 = `4` | scripts/macros/macros.gml:27 |
| enum | e__BG | scripts/__init_background/__init_background.gml:2 |
| enum | e__VW | scripts/__init_view/__init_view.gml:2 |

## 6. 未读懂或不确定的地方


### 6.1 yy 登记的 Collision 事件缺少 `collisionObjectId`，与磁盘 .gml 对不上

下列 object 的 `.yy` 中存在 `eventType`=4 但没有 `collisionObjectId` 字段的事件，磁盘上却有以自身为目标命名的 `Collision_<自身>.gml`。是否为“与自身的碰撞事件”未能从文件确认。

- objects/obj_clown/obj_clown.yy:14（无 collisionObjectId）；磁盘多出的文件：objects/obj_clown/Collision_obj_clown.gml
- objects/obj_enemyparent_held/obj_enemyparent_held.yy:13（无 collisionObjectId）；磁盘多出的文件：objects/obj_enemyparent_held/Collision_obj_enemyparent_held.gml
- objects/obj_parent_resource/obj_parent_resource.yy:10（无 collisionObjectId）；磁盘多出的文件：objects/obj_parent_resource/Collision_obj_parent_resource.gml

另外 §3 中 Collision 事件表对这类事件显示为 `Collision_(yy缺collisionObjectId)`，其数量已计入。

### 6.2 脚本名与所定义函数名不一致（兼容 shim）

下列 4 个脚本的文件名与其中 `function` 名不同，且函数体调用的是与函数同名的名字（`sprite_delete` 等看起来是 GML 内置函数名）。GMS 是否把它当作覆盖内置函数、是否递归，未能在本项目内确认：

- scripts/background_delete/background_delete.gml:4：`function sprite_delete(argument0) {`；函数体 scripts/background_delete/background_delete.gml:6：`sprite_delete(argument0);`
- scripts/background_exists/background_exists.gml:4：`function sprite_exists(argument0) {`；函数体 scripts/background_exists/background_exists.gml:6：`return sprite_exists(argument0);`
- scripts/draw_enable_alphablend/draw_enable_alphablend.gml:3：`function gpu_set_blendenable(argument0) {`；函数体 scripts/draw_enable_alphablend/draw_enable_alphablend.gml:4：`gpu_set_blendenable( argument0 );`
- scripts/draw_set_blend_mode/draw_set_blend_mode.gml:3：`function gpu_set_blendmode(argument0) {`；函数体 scripts/draw_set_blend_mode/draw_set_blend_mode.gml:4：`gpu_set_blendmode( argument0 );`

### 6.3 兼容性/生成性脚本的用途

scripts/ 下有以 `__` 开头的 GMS1→GMS2 导入产物（文件夹 `compatibility`、`action`、`background` 等，见 SMM_WE.yyp 的 Folders），其内部行为未逐个读完：

- scripts/__background_get/__background_get.gml（11 行）
- scripts/__background_get_element/__background_get_element.gml（88 行）
- scripts/__background_get_internal/__background_get_internal.gml（48 行）
- scripts/__background_set/__background_set.gml（14 行）
- scripts/__background_set_element/__background_set_element.gml（192 行）
- scripts/__background_set_internal/__background_set_internal.gml（72 行）
- scripts/__global_object_depths/__global_object_depths.gml（1611 行）
- scripts/__init_action/__init_action.gml（15 行）
- scripts/__init_background/__init_background.gml（24 行）
- scripts/__init_global/__init_global.gml（9 行）
- scripts/__init_view/__init_view.gml（24 行）
- scripts/__view_get/__view_get.gml（32 行）
- scripts/__view_set/__view_set.gml（13 行）
- scripts/__view_set_internal/__view_set_internal.gml（31 行）
- scripts/action_end_game/action_end_game.gml（6 行）
- scripts/action_set_motion/action_set_motion.gml（16 行）

- scripts/__global_object_depths/__global_object_depths.gml:5：`gml_pragma("global", …)`，`gml_pragma` 共 3 处（`grep -rn gml_pragma objects scripts`）：scripts/__global_object_depths/__global_object_depths.gml:5、scripts/__init_action/__init_action.gml:2、scripts/__init_global/__init_global.gml:2；另外 GMS1 兼容的视图访问以 `__view_get((1 << 0), 0)` 形式出现在代码中（例 objects/obj_levelmanager/Step_2.gml:57）；`global.__objectDepths` 用法未追踪到消费者（仅 :1604 的 `asset_get_index(global.__objectNames[i])` 在同文件内）。

### 6.4 动态名称派发（静态检索无法解析调用目标）

下列写法的目标由运行时字符串/变量决定，§2、§5 的“调用/被调用”不包含这些：

**asset_get_index**（regex `\basset_get_index\s*\(`）：

命中 15 行 / 3 个文件。

| 位置 | 代码 |
|---|---|
| objects/obj_load_guardabot/Other_11.gml:123 | `object = asset_get_index(ds_map_find_value(_map3, "object"))` |
| objects/obj_load_guardabot/Other_11.gml:178 | `object = asset_get_index(ds_map_find_value(_map5, "object"))` |
| objects/obj_load_guardabot/Other_11.gml:179 | `sprite = asset_get_index(ds_map_find_value(_map5, "sprite"))` |
| objects/obj_load_guardabot/Other_11.gml:190 | `object = asset_get_index(ds_map_find_value(_map6, "object"))` |
| objects/obj_load_guardabot/Other_11.gml:206 | `object = asset_get_index(ds_map_find_value(_map7, "object"))` |
| objects/obj_load_guardabot/Other_11.gml:214 | `o_objecto.sprite_index = asset_get_index(ds_map_find_value(_map7, "sprite"))` |
| objects/obj_load_guardabot/Other_11.gml:224 | `object = asset_get_index(ds_map_find_value(_map8, "object"))` |
| objects/obj_load_level/Other_10.gml:107 | `object = asset_get_index(ds_map_find_value(_map3, "object"))` |
| objects/obj_load_level/Other_10.gml:163 | `object = asset_get_index(ds_map_find_value(_map5, "object"))` |
| objects/obj_load_level/Other_10.gml:164 | `sprite = asset_get_index(ds_map_find_value(_map5, "sprite"))` |
| objects/obj_load_level/Other_10.gml:175 | `object = asset_get_index(ds_map_find_value(_map6, "object"))` |
| objects/obj_load_level/Other_10.gml:191 | `object = asset_get_index(ds_map_find_value(_map7, "object"))` |
| objects/obj_load_level/Other_10.gml:199 | `o_objecto.sprite_index = asset_get_index(ds_map_find_value(_map7, "sprite"))` |
| objects/obj_load_level/Other_10.gml:209 | `object = asset_get_index(ds_map_find_value(_map8, "object"))` |
| scripts/__global_object_depths/__global_object_depths.gml:1604 | `var objID = asset_get_index( global.__objectNames[i] );` |

**variable_instance_* / variable_global_***（regex `\bvariable_(instance|global)_\w+\s*\(`）：

命中 42 行 / 26 个文件。列出前 20 处，其余按文件计数见下。

| 位置 | 代码 |
|---|---|
| objects/obj_angrysun/Collision_obj_mario.gml:31 | `if (variable_instance_exists(object_index, "key") && key == 1)` |
| objects/obj_angrysun/Collision_obj_mario.gml:65 | `if (variable_instance_exists(object_index, "key") && key == 1)` |
| objects/obj_block_hidden_res/Collision_obj_parent_resource.gml:11 | `if (variable_instance_exists(object_index, "wings") && wings == 1)` |
| objects/obj_block_res/Collision_obj_parent_resource.gml:11 | `if (variable_instance_exists(object_index, "wings") && wings == 1)` |
| objects/obj_cannon/Other_14.gml:19 | `if (variable_instance_exists(object_index, "bouncy") && bouncy == 1)` |
| objects/obj_cannon/Other_14.gml:42 | `else if (variable_instance_exists(object_index, "paracaidas") && paracaidas == 1)` |
| objects/obj_claw/Step_2.gml:209 | `if ((!outside_view()) && (((!instance_exists(hold_obj))) \|\| (variable_instance_exists(hold_obj, "held") && hold_obj.held == 1) \|\| (instance_…` |
| objects/obj_enemyparent/Collision_obj_mario.gml:95 | `if (variable_instance_exists(object_index, "key") && key == 1)` |
| objects/obj_hammerbro/Other_14.gml:29 | `else if (variable_instance_exists(object_index, "paracaidas") && paracaidas == 1)` |
| objects/obj_helmet/Collision_obj_physicsparent.gml:7 | `if (variable_instance_exists(other.object_index, "paracaidas") && other.paracaidas == 1)` |
| objects/obj_helmet/Collision_obj_spike_ball.gml:12 | `if (variable_instance_exists(other.object_index, "paracaidas") && other.paracaidas == 1)` |
| objects/obj_holdparent/Other_13.gml:22 | `if (variable_instance_exists(object_index, "walk") && walk == 1)` |
| objects/obj_jumppiranha/Other_14.gml:39 | `else if (variable_instance_exists(object_index, "paracaidas") && paracaidas == 1)` |
| objects/obj_levelmanager/Other_18.gml:81 | `if ((follow.y + 32) < ((__view_get((1 << 0), 0) + (__view_get((3 << 0), 0) / 2)) - 12) && ((variable_instance_exists(follow, "state") && fol…` |
| objects/obj_levelmanager/Other_18.gml:112 | `if ((variable_instance_exists(follow, "state") && follow.state == 3) \|\| (variable_instance_exists(follow, "fly_cap") && follow.fly_cap > 0) …` |
| objects/obj_levelmanager/Other_18.gml:128 | `else if (((variable_instance_exists(follow, "walljump_ex") && follow.walljump_ex == 1) \|\| (variable_instance_exists(follow, "doublejump") &&…` |
| objects/obj_levelmanager/Other_18.gml:133 | `else if (follow.y >= ((__view_get((1 << 0), 0) + (__view_get((3 << 0), 0) / 2)) + 9) && follow.y < ((room_height - (__view_get((3 << 0), 0) …` |
| objects/obj_levelmanager/Step_2.gml:57 | `if ((follow.y + 32) < (room_height - __view_get((3 << 0), 0)) && variable_instance_exists(follow, "state") && follow.state < 2 && lock_lock …` |
| objects/obj_levelmanager/Step_2.gml:113 | `if ((follow.y + 32) < (room_height - __view_get((3 << 0), 0)) && variable_instance_exists(follow, "state") && follow.state < 2 && lock_lock …` |
| objects/obj_muncher/Other_14.gml:18 | `if (variable_instance_exists(object_index, "bouncy") && bouncy == 1)` |

其余按文件：objects/obj_levelmanager/Other_18.gml(4); objects/obj_powerupsprout/Alarm_2.gml(4); objects/obj_powerupsprout_note/Alarm_1.gml(4); objects/obj_angrysun/Collision_obj_mario.gml(2); objects/obj_cannon/Other_14.gml(2); objects/obj_levelmanager/Step_2.gml(2); objects/obj_muncher/Other_14.gml(2); objects/obj_physicsparent/Other_14.gml(2); objects/obj_powerupsprout/Alarm_1.gml(2); objects/obj_waddlewing/Other_14.gml(2); objects/obj_block_hidden_res/Collision_obj_parent_resource.gml(1); objects/obj_block_res/Collision_obj_parent_resource.gml(1); objects/obj_claw/Step_2.gml(1); objects/obj_enemyparent/Collision_obj_mario.gml(1); objects/obj_hammerbro/Other_14.gml(1); objects/obj_helmet/Collision_obj_physicsparent.gml(1); objects/obj_helmet/Collision_obj_spike_ball.gml(1); objects/obj_holdparent/Other_13.gml(1); objects/obj_jumppiranha/Other_14.gml(1); objects/obj_noteblock_res/Collision_obj_parent_resource.gml(1); objects/obj_NSMBU_boomboom/Other_14.gml(1); objects/obj_NSMBU_boomboom_b/Other_14.gml(1); objects/obj_qblock_res/Collision_obj_parent_resource.gml(1); objects/obj_rocangrejo/Other_14.gml(1); objects/obj_shell_held/Other_14.gml(1); objects/obj_yoshi_abandon/Other_14.gml(1)

**event_perform / event_perform_object**（regex `\bevent_(perform|perform_object)\s*\(`）：

命中 1 行 / 1 个文件。

| 位置 | 代码 |
|---|---|
| objects/obj_bossparent/Step_0.gml:1 | `event_perform_object(obj_enemyparent, ev_step, ev_step_normal)` |

**object_* 查询函数**（regex `\bobject_\w+\s*\(`）：

命中 27 行 / 19 个文件。列出前 20 处，其余按文件计数见下。

| 位置 | 代码 |
|---|---|
| objects/obj_block_pow_hold/Other_14.gml:93 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_button_notification_aceptar/Other_10.gml:82 | `ds_map_add(_map6, "object", object_get_name(object_index))` |
| objects/obj_button_notification_aceptar/Other_10.gml:97 | `ds_map_add(_map, "object", object_get_name(object_index))` |
| objects/obj_button_notification_aceptar/Other_10.gml:150 | `ds_map_add(_map5, "object", object_get_name(object_index))` |
| objects/obj_button_notification_aceptar/Other_10.gml:168 | `ds_map_add(_map7, "object", object_get_name(object_index))` |
| objects/obj_button_notification_aceptar/Other_10.gml:188 | `ds_map_add(_map8, "object", object_get_name(object_index))` |
| objects/obj_button_save_changes/Other_10.gml:82 | `ds_map_add(_map6, "object", object_get_name(object_index))` |
| objects/obj_button_save_changes/Other_10.gml:97 | `ds_map_add(_map, "object", object_get_name(object_index))` |
| objects/obj_button_save_changes/Other_10.gml:150 | `ds_map_add(_map5, "object", object_get_name(object_index))` |
| objects/obj_button_save_changes/Other_10.gml:168 | `ds_map_add(_map7, "object", object_get_name(object_index))` |
| objects/obj_button_save_changes/Other_10.gml:188 | `ds_map_add(_map8, "object", object_get_name(object_index))` |
| objects/obj_editormanager/Alarm_2.gml:22 | `if object_is_ancestor(object_index, obj_parent_resource)` |
| objects/obj_enemyfrozen/Other_14.gml:72 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_holdparent/Other_14.gml:84 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_parent_resource/Collision_obj_parent_resource.gml:1 | `if (pos_cal == 1 && other != id && object_get_parent(other.object_index) != obj_parent_sounds)` |
| objects/obj_physicsparent/Other_14.gml:87 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_player_goal_parent/Other_14.gml:62 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_pswitch/Other_14.gml:80 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_rocangrejo/Other_14.gml:72 | `if (block && (object_get_parent(object_index) == obj_holdparent \|\| object_get_parent(object_index) == obj_enemyparent_held))` |
| objects/obj_shell_drybones/Other_14.gml:64 | `if (block && (object_get_parent(object_index) == 40 \|\| object_get_parent(object_index) == 103))` |

其余按文件：objects/obj_button_notification_aceptar/Other_10.gml(5); objects/obj_button_save_changes/Other_10.gml(5); objects/obj_block_pow_hold/Other_14.gml(1); objects/obj_editormanager/Alarm_2.gml(1); objects/obj_enemyfrozen/Other_14.gml(1); objects/obj_holdparent/Other_14.gml(1); objects/obj_parent_resource/Collision_obj_parent_resource.gml(1); objects/obj_physicsparent/Other_14.gml(1); objects/obj_player_goal_parent/Other_14.gml(1); objects/obj_pswitch/Other_14.gml(1); objects/obj_rocangrejo/Other_14.gml(1); objects/obj_shell_drybones/Other_14.gml(1); objects/obj_shell_drybones_held/Other_14.gml(1); objects/obj_shell_held/Other_14.gml(1); objects/obj_snow_ball/Other_14.gml(1); objects/obj_waddlewing/Other_14.gml(1); objects/obj_yoshi_abandon/Other_14.gml(1); scripts/instance_create/instance_create.gml(1); scripts/object_get_depth/object_get_depth.gml(1)

**argument[n]/argument_count**（regex `\bargument\s*\[|\bargument_count\b`）：

命中 14 行 / 5 个文件。

| 位置 | 代码 |
|---|---|
| scripts/draw_circle_colour_precise/draw_circle_colour_precise.gml:2 | `draw_circle_colour(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5])` |
| scripts/draw_circle_colour_precise/draw_circle_colour_precise.gml:3 | `draw_set_circle_precision(argument[6])` |
| scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:16 | `if (argument[8] == 0 && argument[6] == 1 && argument[7] == 1)` |
| scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:18 | `draw_sprite_ext(argument[0], argument[1], argument[2], argument[3], argument[6], argument[7], argument[8], argument[9], argument[10]);` |
| scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:24 | `matrix_set(matrix_world, matrix_build(argument[2]-sprite_get_xoffset(sprite_index)+argument[4], argument[3]-sprite_get_yoffset(sprite_index)…` |
| scripts/draw_sprite_custom_origin/draw_sprite_custom_origin.gml:27 | `draw_sprite_ext(argument[0], argument[1], sprite_get_xoffset(sprite_index)-argument[4], sprite_get_yoffset(sprite_index)-argument[5], 1, 1, …` |
| scripts/init_shake/init_shake.gml:6 | `obj_levelmanager.shake_long = argument[0]` |
| scripts/scr_move_contact_object/scr_move_contact_object.gml:2 | `for (i = 0; i < argument[1]; i++)` |
| scripts/scr_move_contact_object/scr_move_contact_object.gml:4 | `if (place_meeting(lengthdir_x(i, argument[0]), lengthdir_y(i, argument[0]), argument[2]) \|\| i == argument[1])` |
| scripts/scr_move_contact_object/scr_move_contact_object.gml:6 | `x += lengthdir_x(i, argument[0])` |
| scripts/scr_move_contact_object/scr_move_contact_object.gml:7 | `y += lengthdir_y(i, argument[0])` |
| scripts/set_keys/set_keys.gml:3 | `ID.key = argument[0]` |
| scripts/set_keys/set_keys.gml:4 | `ID.keyText = argument[1]` |
| scripts/set_keys/set_keys.gml:5 | `ID.keyDefault = argument[2]` |

**script_execute(未解析)**（regex `\bscript_execute\s*\(`）：

命中 0 行 / 0 个文件。

| 位置 | 代码 |
|---|---|

**event_inherited()**（regex `event_inherited\s*\(`）：346 行 / 342 个文件；按继承链调用父事件，目标取决于 §2.1 继承树，不展开。

**event_user(n)**（regex `event_user\s*\(`）：2048 行，涉及 890 个文件。user event 号与含义的对应关系分散在各 object 的 `Other_10`…`Other_25`，未汇总。

**instance_create 的 object 参数不是字面 `obj_*`**（regex `\binstance_create(_\w+)?\s*\([^,]*,[^,]*,\s*(?!obj_)[\w.\[\]]+\s*[,)]`，可能含误匹配）：

命中 72 行 / 56 个文件。列出前 15 处，其余按文件计数见下。

| 位置 | 代码 |
|---|---|
| objects/obj_ahh_or/Other_10.gml:1 | `my_object = instance_create(x, y, object)` |
| objects/obj_aplausos_or/Other_10.gml:1 | `my_object = instance_create(x, (y - 8), object)` |
| objects/obj_bebe_or/Other_10.gml:1 | `my_object = instance_create(x, y, object)` |
| objects/obj_big_pplant/Other_10.gml:1 | `instance_create_depth(x,y,0,obj_big_plant_dead);` |
| objects/obj_big_pplant_b/Other_10.gml:1 | `instance_create_depth(x,y,0,obj_big_plant_b_dead);` |
| objects/obj_bocina_or/Other_10.gml:1 | `my_object = instance_create(x, y, object)` |
| objects/obj_bombilla_or/Other_10.gml:1 | `my_object = instance_create(x, (y - 16), object)` |
| objects/obj_chisporreo_or/Other_10.gml:1 | `my_object = instance_create(x, y, object)` |
| objects/obj_cursor/Other_11.gml:23 | `with (instance_create((floor((mouse_x / 16)) * 16), (floor((mouse_y / 16)) * 16), global.select_resource))` |
| objects/obj_destello_or/Other_10.gml:1 | `my_object = instance_create(x, y, object)` |
| objects/obj_doormario_exit/Alarm_0.gml:8 | `with (instance_create(x, y, type_mario))` |
| objects/obj_editormanager/Step_1.gml:90 | `instance_create(((__view_get((0 << 0), 0) + __view_get((2 << 0), 0)) - 40), (__view_get((1 << 0), 0) + 8), obj_zoomclose)` |
| objects/obj_efecto_musica_bonus/Alarm_0.gml:1 | `instance_create_depth(x, y, 0, obj_bonus_trail)` |
| objects/obj_egg_hatch/Collision_obj_mario.gml:16 | `instance_create((x - 1), (y + 16), yosh)` |
| objects/obj_enemyfrozen/Alarm_5.gml:56 | `object = instance_create(x, (y - 2), enemy)` |

其余按文件：objects/obj_load_guardabot/Other_11.gml(5); objects/obj_load_level/Other_10.gml(5); objects/obj_yoshi2/Other_10.gml(4); objects/obj_mario/Alarm_10.gml(3); objects/obj_galoomba2_b/Other_11.gml(2); objects/obj_galoomba_b/Other_11.gml(2); scripts/instance_create/instance_create.gml(2); objects/obj_ahh_or/Other_10.gml(1); objects/obj_aplausos_or/Other_10.gml(1); objects/obj_bebe_or/Other_10.gml(1); objects/obj_big_pplant/Other_10.gml(1); objects/obj_big_pplant_b/Other_10.gml(1); objects/obj_bocina_or/Other_10.gml(1); objects/obj_bombilla_or/Other_10.gml(1); objects/obj_chisporreo_or/Other_10.gml(1); objects/obj_cursor/Other_11.gml(1); objects/obj_destello_or/Other_10.gml(1); objects/obj_doormario_exit/Alarm_0.gml(1); objects/obj_editormanager/Step_1.gml(1); objects/obj_efecto_musica_bonus/Alarm_0.gml(1); objects/obj_egg_hatch/Collision_obj_mario.gml(1); objects/obj_enemyfrozen/Alarm_5.gml(1); objects/obj_enemyfrozen/Other_10.gml(1); objects/obj_error_or/Other_10.gml(1); objects/obj_floruga/Create_0.gml(1); objects/obj_frozenmario/Destroy_0.gml(1); objects/obj_fuegos_or/Other_10.gml(1); objects/obj_golpe_gato_or/Other_10.gml(1); objects/obj_ground/Other_13.gml(1); objects/obj_mario/Alarm_7.gml(1) …

### 6.5 Other 事件编号≥60 的种类

以下 object 有 `eventType`=7 且 `eventNum`≥60 的事件（GMS 中该区间对应 Async 事件，但“编号→具体种类（HTTP/对话框/社交等）”未在项目内验证）。按 eventNum 统计：60: 1；63: 7；70: 1。

- Other_60（1 个 object）：objects/obj_persistent/Other_60.gml
- Other_63（7 个 object）：objects/obj_iname/Other_63.gml, objects/obj_input/Other_63.gml, objects/obj_input_desc/Other_63.gml, objects/obj_input_rename/Other_63.gml, objects/obj_lun/Other_63.gml, objects/obj_rename/Other_63.gml, objects/obj_rename_input/Other_63.gml
- Other_70（1 个 object）：objects/obj_persistent/Other_70.gml

例：objects/obj_persistent/Other_70.gml:15 在该事件里读取 `async_load[? "user_id"]` 并调用 `sprite_add(np_get_avatar_url(...))`，来源为 NekoPresence 扩展回调（extensions/NekoPresence/NekoPresence.gml:1），确切事件语义未确认。

### 6.6 扩展、DLL 与平台分支

- extensions/NekoPresence/NekoPresence.gml 仅 4 行，以 `#define np_get_avatar_url` 形式（GMS1 风格）定义；`np_initdiscord`/`np_update`/`np_setpresence` 等函数的实现在 DLL（NekoPresence.dll、NekoPresence_x64.dll、libNekoPresence.dylib、libnekopresence.so）中，未反汇编，无法确认其行为。调用点：
  - objects/obj_persistent/Other_3.gml:3：`np_update();`
  - objects/obj_persistent/Other_70.gml:11：`np_setpresence_timestamps(date_current_datetime(), 0, false);`
  - objects/obj_persistent/Other_70.gml:12：`np_setpresence_more("Small image text", "Large image text", false);`
  - objects/obj_persistent/Other_70.gml:15：`sprite_add(np_get_avatar_url(async_load[? "user_id"], async_load[? "avatar"]), 1, false, false, 0, 0);`
- scripts/discord_init_dll/discord_init_dll.gml:2 通过 `external_define("discord-rpc-main.dll", …)` 调用 DLL；仓库内未发现 `discord-rpc-main.dll` 文件（`find . -iname "discord-rpc*"`）：未找到
- datafiles/D3DX9_43.dll 被 SMM_WE.yyp 登记为 IncludedFile（SMM_WE.yyp:345），.gml 中没有任何引用（`grep -rn D3DX9`），用途未确认。
- extensions/folderPick 目录只有 AndroidSource/ 与 folderPick.yy；.gml 中是否调用其函数未逐一核对。options/extensions/ 下还有 DTG.json、Extension2.json、MyAppPermissions.json、inputTextEx.json，对应扩展不在 extensions/ 目录内（yyp 仅登记 2 个 extension），归属未确认。
- 平台分支 `os_type/os_browser/os_device`：14 行，例 objects/obj_persistent/Other_2.gml:2（`os_type != os_android`）。
- objects/obj_persistent/Other_2.gml:4 在事件代码内部写 `#macro DISCORD_APP_ID`（位于 `if` 块内），宏的作用域/生效时机未确认。

### 6.7 存档/关卡文件格式未完整读完

- 关卡文件经 `LoadJSONFromFile`（scripts/LoadJSONFromFile/LoadJSONFromFile.gml:1，内部为 buffer_load + json_decode）读入，得到 ds_map；根键 `MAIN`、子键 `AJUSTES` 等，见 objects/obj_load_level/Other_10.gml:6-9。该文件 474 行，各键的完整列表与取值含义未逐键整理。
- 保存端：objects/obj_button_save_changes/Other_10.gml（`json_encode` + `SaveStringToFile`），objects/obj_button_notification_aceptar/Other_10.gml（同类）。两者是否生成相同结构未做 diff。
- `global.directorio` 由 `global.directorio_temp + "/"` 赋值（objects/obj_persistent/Create_0.gml:132 等），`global.directorio_temp` 的取值来源未追踪。
- 设置文件 `Settings_new.dat`：按行读写 22 个字段（objects/obj_persistent/Other_2.gml 的 `file_text_read_string`，写入端 objects/obj_persistent/Other_17.gml），字段顺序/含义未逐行核对。
- 关卡中的 object 通过名字字符串经 `asset_get_index` 还原（§6.4），因此“关卡可用的 object 全集”无法由静态检索得出。

### 6.8 代码风格与来源

GML 文本呈反编译/自动格式化风格：行首集中 `var` 声明（如 objects/obj_load_level/Other_10.gml:1）、多处冗余括号（如 objects/obj_cheepcheep2/Step_0.gml:104）、`if cond` 不带括号。是否为反编译产物、原始注释是否丢失无法从仓库判断。README.md:3 写明项目基于 Andoyt 版本的 Super Mario Maker World Engine。

### 6.9 options 中与行为相关但影响未验证的设置

- options/main/options_main.yy:6 `option_collision_compatibility`=true：影响碰撞检测语义的细节未验证。
- options/main/options_main.yy:9 `option_game_speed`=60：代码中 `room_speed` 的使用见 §3.4，运行时是否被代码修改（`game_set_speed`）见该节命中。

### 6.10 Draw 事件与图层、depth 的关系

rooms/*.yy 的实例层均为按 depth 切分的 `Compatibility_Instances_Depth_<n>` 层（§4），object 自身的 depth 由代码赋值还是 `__global_object_depths`（scripts/__global_object_depths/__global_object_depths.gml:5）初始化，未确认两者之间的覆盖关系。

### 6.11 无调用点的脚本

§5.2 按静态规则未检出调用点的函数共 51 个：__global_object_depths, __init_action, __init_background, __init_global, __init_view, action_end_game, discord_free_app, discord_free_dll, discord_init_app, discord_init_dll, discord_update_presence, discord_webhook, draw_background, draw_background_ext, draw_sprite_autotiled, draw_sprite_autotiled2, draw_text_lang, has_internet, macros, outside_view_modelsizable, scr_NSMBU_penguin_swim, scr_addseparators, scr_bg_control, scr_bg_init, scr_diff, scr_etiq_search, scr_etiquetas_trad, scr_hspeed, scr_load, scr_mario_swim_idle, scr_mariohold_fall, scr_mariohold_jump, scr_meteorites_shard, scr_meteorites_shard_big, scr_move_contact_object, scr_musicalscale_SMB, scr_return, scr_save, scr_sidefade, scr_snd_editor_beach, scr_snd_editor_volcano, scr_snd_meteorites_break, scr_snd_pink_coin5, scr_snd_pink_coins, scr_snd_volcano, scr_switchsong, scr_verify_pub, scr_viewculling, string_make_width, string_split2, turn_towards_direction。其中是否由 DnD、扩展回调、字符串名、`gml_pragma("global", …)` 自动执行（scripts/__init_action/__init_action.gml:2、scripts/__init_global/__init_global.gml:2、scripts/__global_object_depths/__global_object_depths.gml:5）调用，未确认。

### 6.12 文本/语言表

用户可见文本主要通过 `scr_language(n)`（scripts/scr_language/scr_language.gml，约 1039 行）按数字索引取串；调用点很多（§5.1）。其内部分支结构与语言列表未逐项读取。资源与变量命名混用西班牙语/意大利语/英语（如 `global.directorio`、`global.apariencia`、scripts/scr_bg_init/scr_bg_init.gml:1 的意大利语注释）。

### 6.13 以 `_res` 结尾的 object

名称含 `_res` 的 object 共 173 个（`ls objects | grep -c _res`），大量位于 Objects/Editor Res Objects（149 个，§1.5）。其与同名去掉 `_res` 的游戏内 object 之间是否一一对应、editor 如何使用（例：rooms/rm_editor/InstanceCreationCode_inst_186C6.gml 中 `obj = obj_goomba_res`）未整理；scripts/scr_sprite_make_object*.gml、scripts/scr_edit_to_play 的相关逻辑未逐行读。

## 附：风险标记类别汇总与所用正则

命中数 = 满足任一子正则的 **行数**（已去注释、字符串内容置空）；涉及文件数 = 含命中的 .gml 文件数。扫描范围 objects/ scripts/ rooms/ extensions/ 下全部 5011 个 .gml。事件级补充（Alarm/Collision/Draw/Async 事件文件）见 §3 各节，未计入下表。

| 风险标记类别 | 命中数 | 涉及文件数 | 子正则 |
|---|---|---|---|
| with / other | 7971 | 1677 | `\bwith\s*\(`<br>`\bother\b` |
| alarm | 2303 | 1086 | `\balarm\s*\[`<br>`\balarm_(get\|set)\b` |
| 碰撞函数 | 2207 | 438 | `\b(place_meeting\|place_free\|place_empty\|place_snapped)\s*\(`<br>`\b(instance_place\|instance_place_list\|instance_position\|instance_position_list\|position_meeting\|position_empty)\s*\(`<br>`\bcollision_(point\|rectangle\|circle\|line\|ellipse)\w*\s*\(`<br>`\b(move_contact_solid\|move_contact_all\|move_outside_solid\|move_outside_all\|move_bounce_solid\|move_bounce_all)\s*\(`<br>`\b(distance_to_object\|distance_to_point\|instance_nearest\|instance_furthest\|tilemap_get_at_pixel\|tile_layer_find\|tilemap_\w+\|place_snapped\|mp_\w+\|physics_\w+)\s*\(` |
| 按帧计时 | 2098 | 1065 | `\b(room_speed\|game_get_speed\|game_set_speed\|delta_time\|current_time\|get_timer\|fps\|fps_real)\b`<br>`\b(image_speed\|animation_end)\b`<br>`\b\w*(timer\|time\|cnt\|count\|wait\|delay\|frame\|cooldown\|tempo\|tiempo)\w*\s*(\+\+\|--\|[+-]=)\|(\+\+\|--)\s*\w*(timer\|time\|cnt\|count\|wait\|delay\|frame\|cooldown\|tempo\|tiempo)\w*` |
| 自定义绘制 | 1983 | 452 | `\bdraw_\w+\s*\(`<br>`\b(gpu_\w+\|draw_set_blend_mode\w*\|draw_set_alpha\|draw_set_colour\|draw_set_color\|draw_set_font)\b` |
| surface / shader | 97 | 43 | `\bsurface_\w+`<br>`\bshader_\w+`<br>`\bapplication_surface\w*` |
| global | 9266 | 2037 | `\bglobal\.\w+`<br>`\bglobalvar\b` |
| ds_* | 598 | 19 | `\bds_(map\|list\|grid\|stack\|queue\|priority)_\w+` |
| 存档 | 184 | 20 | `\b(file_\w+\|ini_\w+\|buffer_\w+\|json_\w+\|directory_\w+\|game_save\w*\|game_load\w*\|get_open_filename\w*\|get_save_filename\w*\|working_directory\|program_directory\|temp_directory\|LoadJSONFromFile\|SaveStringToFile\|zip_\w+\|base64_\w+)\b`<br>`\b(?!game_)\w*(save\|load)\w*\s*\(` |
| 异步 | 44 | 21 | `\b(http_\w+\|network_\w+\|async_load\|get_string_async\|get_integer_async\|get_login_async\|show_message_async\|get_open_filename_ext\|audio_\w*async\w*\|buffer_async_group\w*\|url_open\|steam_\w+)\b` |
| 视图 | 1275 | 320 | `\b(view_\w+\|camera_\w+\|window_\w+\|display_\w+\|room_set_view\w*\|room_set_camera\|__view_get\|__view_set\|__view_set_internal\|gui_\w+\|browser_\w+)\b` |
| 音频 | 2598 | 872 | `\b(audio_\w+\|sound_\w+)\b` |

复核方式示例（Git Bash，约等价，不含去注释）：`grep -rnE "\bwith\s*\(" objects scripts rooms --include=*.gml | wc -l`。精确口径以生成脚本的去注释规则为准。