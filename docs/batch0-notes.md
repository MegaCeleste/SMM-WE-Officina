# 第 0 批笔记

> 路径相对 `original/openwe-ref/`（`port/…`、`tools/…` 除外）。统计由 `tools/analyze_batch0.py` 生成，可重复运行。
> 标 **不确定** 的地方需要你拍板或用原版实测。

## 1. collisionKind 与 bboxMode

### 1.1 编号含义

| 字段 | 值 | 含义 | 本工程 sprite 数 |
|---|---|---|---|
| collisionKind | 0 | Precise（精确，全部帧合成一张遮罩） | 3179 |
| | 1 | Rectangle（矩形，不随旋转） | 626 |
| | 2 | Ellipse（椭圆） | 710 |
| | 3 | Diamond（菱形） | 0 |
| | 4 | Precise Per Frame（逐帧精确） | 124 |
| | 5 | Rectangle with rotation（随旋转的矩形） | 6 |
| bboxMode | 0 | Automatic（按不透明像素自动） | 3637 |
| | 1 | Full image（整张图） | 146 |
| | 2 | Manual / User defined（手动） | 862 |

依据：
- bboxMode 0/1/2：GMS 手册 `sprite_collision_mask` 的 `bboxmode` 参数明确写 0=automatic、1=full image、2=user defined（[GMS 2.2 手册镜像](https://dobby233liu.github.io/gms2.2docs/source/_build/3_scripting/4_gml_reference/sprites/sprite_collision_mask.html)；第三方 yy 解析库 [yy-typings 的 BBoxMode](https://docs.rs/yy-typings/0.5.0/yy_typings/sprite_yy/enum.BBoxMode.html) 顺序一致）。可信。
- collisionKind：官方手册只给出 `bboxkind_*` 常量名，没有给 .yy 里的数字。上表的数字来自第三方库 yy-typings 的 `CollisionKind` 枚举声明顺序（Precise, Rectangle, Ellipse, Diamond, PrecisePerFrame, RotatedRectangle，`#[repr(u8)]` 未写显式值；[文档](https://docs.rs/yy-typings/0.5.0/yy_typings/sprite_yy/enum.CollisionKind.html)）。形状名称与 GameMaker 官方博客（2.1.5 碰撞遮罩介绍）列出的编辑器选项一致。**数字对应关系属第三方来源，未经官方文档确认，标为不确定**；旁证：本工程 collisionKind=2 的 710 个 sprite 全部是 bboxMode=2（见下表），与“椭圆需手动框”无矛盾但也不能证明。
- “Precise 是所有帧合成一张遮罩、Precise Per Frame 才逐帧”：来自 GMS 2.3 编辑器的行为认知（对应 `sprite_collision_mask` 的 `sepmasks` 参数），**不确定**，以后用原版实测（可并入 port-plan 的 UNVERIFIED 清单）。

组合分布 (collisionKind, bboxMode)：(0,0) 3155、(0,2) 24、(1,0) 355、(1,1) 146、(1,2) 125、(2,2) 710、(4,0) 123、(4,2) 1、(5,0) 4、(5,2) 2。`collisionTolerance` 全部为 0。
collisionKind=5 的 6 个 sprite：`spr_NSMBU_decoracion_1…4`、`spr_NSMBU_decoracion_3_night`、`spr_NSMBU_decoracion_4_night`（装饰物）。

### 1.2 实际被用作碰撞遮罩的 sprite

来源：object yy 的 `spriteId`/`spriteMaskId`，以及代码里赋给 `mask_index`、`sprite_index` 的 sprite 字面量（`tools/analyze_batch0.py`，明细在 `port/tables/mask_sprites.json`）。

| 集合 | sprite 数 | 0 Precise | 1 Rect | 2 Ellipse | 4 PerFrame | 5 RotRect |
|---|---|---|---|---|---|---|
| 被引用（object sprite/mask + 代码 mask_index/sprite_index 赋值） | 1767 | 796 | 298 | 587 | 80 | 6 |
| 其中“可能参与碰撞”（object 的 mask；无 mask 的 object 的 sprite；赋给 mask_index；赋给无 mask 或目标不明的 sprite_index） | 1563 | 739 | 280 | 471 | 67 | 6 |
| 仅看 object yy（mask，或无 mask 时的 sprite） | 502 | 230 | 90 | 165 | 17 | 0 |

“可能参与碰撞”且为 Precise（0/4）的 sprite 共 806 个、合计 5375 帧——这是要生成精确遮罩位图的上限。
局限：代码里 `mask_index`/`sprite_index` 共 4069 次赋值，其中 725 次右值不是 sprite 字面量（脚本返回值如 `scr_mario_*()`、变量），没有计入；另外实例是否真的参与“精确”查询要看调用处的 `prec` 参数，本统计没有区分。所以上表是静态近似，偏大也偏小，**不能当作精确清单**。建议第 1 批遮罩生成按“collisionKind ∈ {0,4} 且被引用”的 806 个 sprite 先做，运行时遇到未生成的再报警告。

## 2. 运行时 `solid` 赋值

全工程（objects/ scripts/ rooms/ extensions/ 共 5011 个 .gml，去注释和字符串后）检索内置变量 `solid` 的赋值（`solid =`、`x.solid =`，排除 `physolid`、`semisolid` 等变量名和 `==` 比较）：**0 处**。结合 811 个 object yy 的 `solid` 全为 false（`port/tables/objects.json`），原版不使用内置 solid。`move_contact_solid` 等依赖 solid 的函数也没有使用（清单 §3.3）。

## 3. 代码中的数字常量

### 3.1 `obj_draw = 117` 等（rm_editor 的 12 个 `obj_card_item` 实例）

- 实例创建代码：`rooms/rm_editor/InstanceCreationCode_inst_186C2.gml:1-5`（`obj = obj_pswitch_res; value = 0; x_pos = 38; obj_draw = 117; bg_color = 3`）等 12 个文件，实例都是 `obj_card_item`（`port/tables/rooms.json`）。
- 用法：`objects/obj_card_item/Draw_0.gml:45` `draw_sprite(sprite_card, obj_draw, …)`，`sprite_card` 按画风取 `spr_cards_SMB/SMB3/SMW/NSMBU`（`objects/obj_card_item/Create_0.gml:1-15`，`Step_0.gml:13-22`；编辑音效时 `spr_cards_sounds`，`Step_0.gml:5`）。`bg_color` 同理是 `spr_card_top` 的帧号（`Draw_0.gml:46`）。
- **结论：`obj_draw` 是 `spr_cards_*` 的子图编号（sprite 帧号）**。核对：把 `spr_cards_SMW` 的第 117/128/116/94/69/96/46/17/64/93/106/72 帧切出来，依次是 P 开关、弹簧、食人花、乌龟、栗子、蘑菇、金币、石块、砖块、问号块、尖刺、草地——与各实例的 `obj` 一一对应。四套卡片 sprite 帧数为 234/234/234/235（`port/tables/sprites.json`），117 等都在范围内。
- 同类：`objects/obj_load_level/Create_0.gml:2-19` 的 `img_ground = 72`、`img_block = 64` 等，以及 `obj_load_level/Other_12.gml` 按场景改写的 `img_*`（如雪地 `img_ground = 84`，`Other_12.gml:14`；雪地夜间 85，`:3`）也是这套卡片的帧号，被 `obj_angrysun_res/Other_14.gml:153-183`、`obj_bg1/Other_11.gml:164-191` 赋给 `obj_draw`/`obj_draw_sonidos`。
- 疑点：`objects/obj_card_item/Mouse_4.gml:3` 写 `obj_draw == obj_soplete_invert_global`，把帧号和 object 比较。GMS 里 object 是编号，这个比较的实际结果取决于 `obj_soplete_invert_global` 的运行时编号（yyp 顺序为 298，旧 depth 表下标为 84，第 84 帧是雪地地面）。**不确定**是否原版 bug，移植时需要你定。

### 3.2 `levelmusic = 109`（rm_template）

- `rooms/rm_template/InstanceCreationCode_inst_186AD.gml:2`，实例是 `obj_levelmanager`（`port/tables/rooms.json`）。实例创建代码在 Create 之后执行，会覆盖 `obj_levelmanager/Create_0.gml:47` 的 `levelmusic = snd_SMB_music_ground`。
- 用法：`levelmusic` 当 sound 用——`obj_levelmanager/Alarm_0.gml:4` `audio_play_sound(levelmusic, 1, true)`，`Other_4.gml:3-6`、`Step_2.gml:312-360` 等。所以 109 是**sound 资源编号**。
- 但是哪个 sound **不确定**：yyp 顺序第 109 个 sound 是 `snd_atack_leaf`（`port/tables/asset_names.json`），不是音乐；GMS 运行时资源编号与 yyp 顺序的关系仓库内无法确认（见 §3.3）。另外代码里没有 `rm_template` 的引用（全工程检索 `rm_template` 只出现在 room order，`SMM_WE.yyp` 的 RoomOrderNodes 第 4 项），这个 room 是否会被进入也**不确定**。

### 3.3 其他数字 object 编号

| 位置 | 原文 | 结构上应为 | 旧 depth 表下标对应名 | yyp 顺序对应名 |
|---|---|---|---|---|
| `objects/obj_shell_drybones/Other_14.gml:64`（及 `_held`） | `object_get_parent(object_index) == 40 \|\| … == 103` | `obj_holdparent`、`obj_enemyparent_held`（16 个同构文件，port-plan Q3） | 40=`obj_buzzybeetle_b`、103=`obj_charginchuck`（`__global_object_depths.gml:844,907`） | 40=`obj_rails`、103=`obj_physicssolid` |
| `objects/obj_load_level/Other_10.gml:221` | `else if (object == 590)` | `obj_door_switch_res`（`obj_load_guardabot/Other_11.gml:236` 同位置写的是名字） | 590=`obj_door_switch_res`（`__global_object_depths.gml:1393`） | 590=`obj_bt_gb_close` |

所以数字既不对应 yyp 顺序，也不总对应旧 depth 表下标（590 对得上，40/103 对不上）。数字来源**不确定**。port-plan §1 说全工程这类数字“范围很小”，但它没有列出 `object == 590` 这一处（检索式只覆盖 `object_index/sprite_index == 数字`）。

## 4. sprite 播放速度

`playbackSpeedType`：0 = 每秒帧数（FPS），1 = 每游戏帧的帧数（依据：GMS 2.3 sprite 编辑器的 “Frames per second / Frames per game frame” 选项，yy-typings 同名字段；数字对应 **未经官方文档确认**）。

| (type, speed) | sprite 数 |
|---|---|
| (1, 1.0) | 4415 |
| (0, 15.0) | 168 |
| (0, 30.0) | 51 |
| (0, 1.0) | 4 |
| (0, 12.0) | 1 |
| (0, 0.0) | 1 |
| (1, 0.25) | 1（`bg_overworld_nubes`，59 帧） |
| (1, 1.05) | 1（`spr_NSMBU_toad_small_ground_idle`） |
| (1, 1.1) | 1（`spr_NSMBU_toad_small_idle`） |
| (1, 2.0) | 1（`spr_NSMBU_ninji_jump`，1 帧） |
| (1, 7.0) | 1（`spr_NSMBU_charginchuck_jump`，13 帧） |

不是“每游戏帧 1 帧”的共 **230** 个，其中帧数 > 1（会实际影响动画）的 36 个：30 FPS 27 个、15 FPS 5 个、type 1 非 1.0 的 4 个（明细可由 `port/tables/sprites.json` 过滤得到）。在 60 tick 下，FPS 型的每 tick 推进量 = speed / 60（15 FPS → 0.25，30 FPS → 0.5），实际动画速度还要乘实例的 `image_speed`（port-plan §4 第 9 步）。这一换算按 GMS 文档语义，**未实测**。

## 5. 导入异常

### 5.1 sprite（`port/tables/import_report_sprites.json`，12 条）

- `spr_NSMBU_pow_explode`（yy 32×32，15 帧）：第 1、2、3、5、6、7、8、9、11… 共 12 帧的 PNG 尺寸是 16/8/4/3/12 像素，不是 32×32（`layers/` 下的图同样大小）。导入时按左上角贴进 32×32 的格子。GMS 对尺寸不一致的帧怎么处理（左上对齐、居中还是缩放）**不确定**。用到它的地方：`objects/obj_block_pow_active/Create_0.gml:19`。
- 其余检查全部通过：4645 个 sprite 都有 yy、帧 PNG 齐全、全部 RGBA、只有 1 个图层、sequence 只有 1 条帧轨且关键帧顺序与 `frames` 一致、每帧 Length=1、无 events/moments、`type` 全部为 0（位图）、nineSlice 都未启用。最宽的条带 `spr_NSMBU_big_pplant_b` 13104 px，未超过 16384。

### 5.2 sound（`port/tables/import_report_sounds.json`，6 条）

- 原工程 707 个音频中多数**没有扩展名**（yy 的 `soundFile` 就是无扩展名的名字），导入时按文件头识别：ogg 668、wav 36、mp3 3，输出时补扩展名（Godot 按扩展名选导入器）。
- 6 个文件扩展名是 `.wav` 但内容是 Ogg：`snd_NSMBU_erupcion`、`snd_NSMBU_volcanic_rocks`、`snd_NSMBU_rocks_break`、`snd_SMB_link_itemappear`、`snd_goomba_stomped`、`snd_SMB_clear_castle_link`，按 `.ogg` 输出。
- Godot 导入时对 13 个 ogg 报警告 `Invalid comment in Ogg Vorbis file "", should contain '=': "Sony Ogg Vorbis 1.0 Final"`：`snd_NSMBU_clawin/clawout`、`snd_SMB3_clawin/clawout`、`snd_SMB_clawin/clawout`、`snd_SMB_link_itemappear`、`snd_clawout`、`snd_skewer1…5`。这是文件元数据注释格式问题，不影响导入（Godot 照常生成 .import）；没有改动音频数据。

### 5.3 object（`port/tables/import_report_objects.json`，4 条）

- 3 个碰撞事件缺 `collisionObjectId`：`obj_clown`、`obj_enemyparent_held`、`obj_parent_resource`，磁盘上均有 `Collision_<自身>.gml`，按“目标是自身”记录并标 `collision_target_inferred: true`（port-plan Q7）。
- `obj_dcw` 有 26 个 object variables（`properties`：url、embed_* 等，Discord webhook 用），已原样写入表；该 object 不移植。
- yy 登记的事件与磁盘 .gml 完全对应（无缺文件、无多余文件），共 4702 个 .gml，与清单一致。

### 5.4 depth 表（`port/tables/object_depths.json`）

- `__global_object_depths.gml` 实际有 **795** 条 `__objectDepths[i]` 赋值，下标 0–796，缺 439、701（port-plan §1 写的是“797 项”，那是数组长度）。
- 3 行没有分号（`:780-782`，下标 774–776），已兼容。
- `obj_smoke` 出现两次（下标 322 与 776，depth 都是 -2）。
- 下标 777 的注释写 `obj_SMB2_mushroom_res`，`__objectNames[777]` 是 `"obj_SMB2_mushroom"`（`:783` vs `:1579`），以名字数组为准。
- 表中有、yyp 中没有的名字 44 个（`obj_bt_pub`、`obj_nm_*` 在线关卡界面、`obj_DSM_*` 等），原版 `asset_get_index` 返回 -1 被跳过（`__global_object_depths.gml:1604-1605`）。
- yyp 中有、表中没有的 object 61 个（`obj_slopes`、`obj_waddlewing`、`obj_ninji`、各 `_b` 变体等），按 `object_get_depth` 逻辑 depth 为 0（`scripts/object_get_depth/object_get_depth.gml:7-11`）。
  补充：`global.__objectID2Depth[objID] = …` 是按运行时 object 编号写入的稀疏数组，未赋值的空位在 GMS 中为 0（GMS 数组扩容时空位填 0 的行为是手册所述，**未实测**），结果与“返回 0”一致。

### 5.5 room（`port/tables/rooms.json`，2 条）

- `rm_editor.yy` 的 `creationCodeFile` 指向 `${project_dir}/rooms/rm_editor/RoomCreationCode.gml`，磁盘上**没有这个文件**。原版编译时是报错还是当作空，**不确定**；按空处理。
- `rm_template` 的资源层 `Compatibility_Tiles_Depth_9` 有一个图块 `inst_989680`，`spriteId` 为 null，`u0..v1 = 832,848,112,128`（16×16）。GMS1 导入遗留，引用的图块集已丢失；**不确定**原版运行时是否画出东西。
- 10 个 room 共 54 个实例；只有 rm_editor（13 个）和 rm_template（1 个）有实例创建代码。

### 5.6 global 变量（`port/tables/globals.json`）

- 276 个名字，11504 次引用（9266 行，与清单的 9266 一致——清单按行计）。
- 类型推断：number 159、string 14、array 9、font 11、bool 3、ds_list 1、不确定 79。“不确定”多数是“已识别的赋值都是数，另有赋值来自局部变量/函数返回”，表里给了 `likely_type` 字段。`first_assignment` 按文件路径字典序取第一处，不是运行时先后。

## 6. 与 port-plan / inventory 不一致的事实

| 文档说法 | 实际 | 证据 |
|---|---|---|
| port-plan §7 第 0 批、清单 §6.7：`obj_load_level/Other_10.gml` 474 行 | Other_10 是 245 行；474 行的是 `Other_11.gml`（背景/音乐设置，不含 JSON 读取） | `wc -l objects/obj_load_level/*.gml` |
| port-plan §1：depth 表 797 项 | 795 条赋值，数组长度 797（缺下标 439、701），1 个重名 | §5.4 |
| port-plan §1：数字资源 ID 只有 40/103、109、obj_draw | 另有 `obj_load_level/Other_10.gml:221` 的 `object == 590`；`obj_draw` 实为 sprite 帧号不是资源 ID | §3 |
| 清单 §6.7：`global.directorio` 由 `directorio_temp + "/"` 赋值（`obj_persistent/Create_0.gml:132`） | 那是 Android 分支；Windows 分支 `:137-138` 两者都是 `working_directory + "Niveles\\"` | `docs/level-format.md` §6 |
| 清单 §6.3：`global.__objectDepths` 无消费者 | port-plan 已更正，此处确认 `instance_create.gml:6-7` → `object_get_depth.gml:8-9` 链路属实 | — |
| 清单未提：音频多数无扩展名、6 个 `.wav` 实为 ogg | 见 §5.2 | |

## 7. 工程设置说明

`port/project.godot`：视口 384×216，`stretch/mode="viewport"`，`stretch/aspect="keep"`，`scale_mode="integer"`，`default_texture_filter=0`（Nearest），`physics_ticks_per_second=60`，`max_physics_steps_per_frame=8`（单帧最多补 8 个 tick，即 Godot 默认值，port-plan §4 要求“限制单帧最多补的 tick 数”，具体数值你可改）。窗口初始大小设为 3 倍（1152×648）。**全屏切换**需要代码（第 1 批的 GM 输入层），本批没写。主场景是占位的 `port/main.tscn`（一个空 Node2D），只为让 `--quit` 能运行。
渲染器保持 Godot 默认（未指定 gl_compatibility），像素对齐（snap_2d_*）也未开启——这两项 port-plan 没有规定，留给第 1 批决定。
