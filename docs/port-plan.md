# OpenWE 移植计划（GMS 2023.11 → Godot 4.7.2）

> 状态：定稿（2026-11-10）。§9 的事项已全部拍板，其中两项因原版未实测而标为 UNVERIFIED。
> 依据：`docs/inventory.md`（Sonnet 整理）+ 本文 §1 的抽查。路径均相对 `original/openwe-ref/`。
> 本文是移植规则的唯一依据（见 CLAUDE.md）。规则与原版行为冲突时，以原版行为为准并回来改本文。

## 0. 已拍板的决定

| 项 | 决定 |
|---|---|
| 范围 | 游玩运行时 + 关卡编辑器。登录、在线关卡（rm_course_world）、Discord webhook、NekoPresence 不移植，入口留桩 |
| 方式 | 先做一层 GMS 语义兼容层，再把每个 object 的每个事件 1:1 翻成同名方法，保持原结构 |
| 文件 | 关卡 JSON 与原版互通（读、写）；设置文件改用 Godot `ConfigFile`，不兼容 `Settings_new.dat` |
| 引擎 | Godot 4.7.2，GDScript 静态类型 |
| Godot 路径 | `C:\!application\tools\Godot\Godot_v4.7.2-stable_win64.exe`（不在 PATH 里；CLAUDE.md 说的 `godot --headless` 一律用这个完整路径执行） |
| 平台 | 只做 Windows 桌面，`os_android` 分支和 folderPick 不翻 |
| 窗口 | 基准 384×216，整数倍放大，最近邻，可切全屏 |
| 版本管理 | 在 `C:\Working\openwe` 建 git 仓库，忽略 `original/`，每批一个提交 |
| 资源导入 | 一次性 Python 脚本放 `tools/`，只读 `original/`，只写 `port/` |

规模（清单 §1）：811 个 object、294 个脚本、10 个 room、4645 个 sprite、707 个 sound、3 个 shader，共 138630 行 GML。

## 1. 清单抽查结果

抽查了 5 个高风险标记，并回原文件核对。清单陈述的事实全部准确；发现 1 处漏追踪、2 处风险没有被点明。

| # | 清单内容 | 核对 | 结论 |
|---|---|---|---|
| 1 | §3.4 `room_speed/current_time/fps…` 27 行 / 22 文件 | 全工程重新检索，27 行 / 22 文件 | 准确。但清单没点明：`current_time` 是墙上时钟，见风险 R3 |
| 2 | §6.1 `obj_clown.yy:14` 的 Collision 事件缺 `collisionObjectId` | yy 第 14 行确实没有该字段（其他事件写的是 `null` 或具体对象）；`Collision_obj_clown.gml` 用 `other.x/other.y` 把自己弹开 | 准确。从文件名和代码看是“与同类碰撞”，但属推断，见 §9 Q7 |
| 3 | §6.4 `obj_bossparent/Step_0.gml:1` 的 `event_perform_object(obj_enemyparent, ev_step, ev_step_normal)` | 原文一致 | 准确。跨继承链直接调祖父事件，翻译规则见 §3.3 |
| 4 | §1.1/§6.9 `option_collision_compatibility=true`、`option_game_speed=60` | `options/main/options_main.yy:6,9` 一致 | 准确。决定了碰撞方案必须按旧版整数包围盒语义做（§5） |
| 5 | §6.4 `obj_shell_drybones/Other_14.gml:64` 用数字 `40`、`103` 比较 `object_get_parent` | 原文一致；`obj_shell_drybones_held` 同样；其余 16 个同构文件写的是 `obj_holdparent`、`obj_enemyparent_held` | 准确。数字含义无法从仓库确定，见 §9 Q3 |

补充发现：

- **清单漏追踪**：§6.3 说 `global.__objectDepths` 没找到消费者。实际链路是 `__global_object_depths.gml:1602-1606` 把它转成 `global.__objectID2Depth` → `object_get_depth.gml:8-9` 读取 → `instance_create.gml:6-7` 用它当新实例的 depth。`instance_create` 有 3581 处调用，所以这张表（795 条赋值，覆盖 750 个现存 object；其余 61 个 object 的 depth 为 0）就是所有实例的初始 depth 来源。解析结果在 `port/tables/object_depths.json`。这同时回答了 §6.10。
- **数字资源 ID**：共三处。上面的 40/103；`obj_load_level/Other_10.gml:221` 的 `object == 590`（guardabot 读取端同一位置写的是 `obj_door_switch_res`）；`rooms/rm_template/InstanceCreationCode_inst_186AD.gml:2` 的 `levelmusic = 109`（具体哪个 sound 不确定）。rm_editor 实例创建代码里的 `obj_draw = 117` 之类不是资源 ID，是卡片 sprite 的帧号（第 0 批已确认，见 `docs/batch0-notes.md`）。
- **原版疑似 bug**：`variable_instance_exists(object_index, "key")` 这类写法（清单 §6.4，26 个文件）第一个参数传的是 object 而不是实例，见 §9 Q4。
- `objects/obj_physicsparent/Step_0.gml` 只有 6 行：算 `swimming` 后调 `event_user(3)`、`event_user(4)`。user event 在这个工程里就是“虚函数”，物理和落地判定在 `Other_13/Other_14` 里，子类覆盖它们。

## 2. 总体结构

```
port/
  project.godot
  gm/            兼容层（autoload `GM`、基类 `GMObject`、碰撞、绘制、音频、视图）
  globals/       autoload `G`：原版全部 global.* 变量，逐个声明类型
  objects/       一个 object 一个 .gd，文件名与原名相同（obj_koopa.gd）
  scripts/       一个 GML 脚本一个静态函数，按原文件夹归到若干 .gd
  rooms/         每个 room 一个 .tscn + 实例表
  assets/        由导入脚本从 original/ 生成，不手改
  tables/        生成的数据表：object 清单、depth 表、名字→资源映射
  tests/         兼容层的 headless 测试
tools/           一次性导入/生成脚本（读 original/，只写 port/）
```

原则：不使用 Godot 的物理引擎、`AnimatedSprite2D` 自动播放、`Timer`、各节点自己的 `_process`。所有游戏逻辑由 `GM` 在一个固定 tick 里按 GMS 的事件顺序驱动。这样原版代码里对“同一帧内先后顺序”的依赖才不会丢。

## 3. 概念映射

### 3.1 资源与对象

| GMS | Godot | 说明 |
|---|---|---|
| object | `class_name obj_xxx extends <父类>` 的脚本，根基类 `GMObject extends Node2D` | 继承关系照搬 yy 的 `parentObjectId` |
| instance | 节点，创建时登记到 `GM` 的实例表 | 实例表按创建顺序保存，另按 object（含后代）建索引 |
| `instance_create(x,y,obj)` | `GM.instance_create(x, y, obj_xxx)` | depth 取自 `tables/object_depths`（来源见 §1） |
| `instance_destroy()` | `GM.instance_destroy(self)` | 立刻触发 Destroy 事件并从索引移除，节点在 tick 结束时 `queue_free` |
| `instance_deactivate_*` / `activate_*` | 实例表上的 `active` 标记 | 未激活的实例不跑事件、不参与碰撞、`with`/`instance_exists` 找不到。原版用法：`obj_levelmanager/Step_2.gml:164-167`、`obj_editormanager/Alarm_2.gml` |
| `asset_get_index(name)` / `object_get_name` | `tables/` 里的名字↔资源双向表 | 关卡文件靠它还原实例（清单 §6.7） |
| room | 一个场景 + 实例列表，`GM.room_goto()` 负责 Room End / Room Start 事件 | `obj_persistent` 是唯一 persistent 对象，挂在 autoload 下 |
| depth | `z_index = -depth` | GMS 的 depth 越小越靠前。超出 Godot z_index 范围的背景层单独处理 |
| sprite | 图集 + 元数据（原点、帧数、包围盒、遮罩类型、播放速度） | 由导入脚本生成；精确遮罩另出每帧位图 |
| `global.x` | `G.x`（autoload，逐个声明类型） | 9266 处引用，变量清单由脚本从原码抽取 |
| `ds_map/ds_list` | `Dictionary` / `Array` | 只在 19 个文件里用，基本都是关卡读写 |
| `#macro` / `enum` | `const` / `enum` | 清单 §5.4 |

### 3.2 事件 → 方法

| GMS 事件 | 方法名 | 备注 |
|---|---|---|
| Create_0 | `_create()` | 由 `instance_create` 调用，不用 `_ready` |
| Destroy_0 / CleanUp_0 | `_destroy()` / `_cleanup()` | |
| Step_1 / Step_0 / Step_2 | `_step_begin()` / `_step()` / `_step_end()` | |
| Alarm_n | `_alarm_n()` | |
| Collision_objX | `_collision_objX(other: GMObject)` | |
| Other_10…25 | `_user_0()`…`_user_15()` | `event_user(n)` → `GM.event_user(self, n)`，n 为字面量时直接调方法 |
| Other_4 / Other_5 | `_room_start()` / `_room_end()` | |
| Other_2 / Other_3 | `_game_start()` / `_game_end()` | |
| Other_7 | `_animation_end()` | |
| Draw_0 / Draw_64 | `_gm_draw()` / `_gm_draw_gui()` | 没有 Draw 事件的 object 走默认的 `draw_self` |
| Mouse_* / KeyPress_* | `_mouse_n()` / `_keypress_n()` | 由 `GM` 在输入阶段派发 |
| Other_60/63/70（异步） | 60、70 不移植；63（文本输入对话框）换实现，见 §9 Q10 | |

### 3.3 语法翻译规则

1. 一个事件文件翻成一个方法，语句顺序、变量名（含西班牙语/意大利语名字）原样保留，不重构、不合并、不“顺手修 bug”。原版明显的 bug 照搬并加 `# ORIG-BUG:` 注释。
2. `event_inherited()` → `super._xxx()`。`event_perform_object(objP, ev_step, ev_step_normal)` → 直接调用该祖先类的方法实现。
3. `with (X) { … }` → `for inst in GM.with_list(X): …`，块内的隐式 self 全部改写成 `inst.`，块内的 `other` 改写成外层的 `self`。`with_list` 在进入时取快照，顺序为创建顺序。
4. 碰撞事件里的 `other` → 方法参数 `other`。
5. 数值：GML 只有双精度实数。GDScript 的整数相除会截断，所以**凡参与算术的变量一律声明为 `float`**，字面量写成 `2.0`；只有数组下标、枚举、计数循环变量用 `int`。
6. `round()` → `GM.gm_round()`（GML 是四舍六入五成双，Godot 不是）。`div`、`mod`、`sign`、`string_*`（GML 字符串下标从 1 开始）等统一走 `GM.` 下的同名函数，不直接用 Godot 内置函数替代。
7. 真值：GML 里 `if (inst)`、`if (x)` 以 `> 0.5` 为真，`noone` 是 -4。返回实例的函数在 Godot 侧返回 `GMObject` 或 `null`，条件写成 `!= null`；数值条件写成显式比较。
8. `variable_instance_exists(inst, "name")` → `"name" in inst`。因此实例变量必须在 `_create()` 赋值处才出现，不能提前在类体里全部声明默认值——具体做法等 Q4 定了再写死。
9. 内置变量 `x y hspeed vspeed speed direction gravity friction image_index image_speed image_xscale image_yscale image_angle image_alpha sprite_index mask_index depth visible xstart ystart xprevious yprevious bbox_* alarm[]` 都是 `GMObject` 的属性，名字不变。`hspeed/vspeed` 与 `speed/direction` 的联动照 GMS 实现。
10. 每个翻译出的方法头部写一行来源注释：`# from objects/obj_koopa/Step_0.gml`。

## 4. 时间系统

**固定 60 tick，逐帧推进，不用 delta。** 原版 `option_game_speed=60`，没有任何 `game_set_speed`、`delta_time`（已全工程检索），alarm、`image_speed`、`hspeed += 0.015` 这类逐帧累加遍布 1000 多个文件，改成 delta 时间等于重写。

实现：`physics_ticks_per_second = 60`，`GM._physics_process` 每次执行一个 GMS step；渲染不做插值。掉帧时游戏变慢而不是跳帧（与 GMS 一致），并限制单帧最多补的 tick 数。

每个 tick 内的顺序（GMS 的固定顺序，实现后用测试锁住）：

1. 记录 `xprevious/yprevious`
2. Begin Step
3. Alarm：每个 `alarm[n] > 0` 的减 1，减到 0 时触发并置 -1（`alarm = 0` 的边界行为见 §9 Q6）
4. 键盘、鼠标事件
5. Step
6. 内置运动：`friction`、`gravity` 作用于速度，然后 `x += hspeed; y += vspeed`
7. Collision 事件
8. End Step
9. 动画推进 `image_index += image_speed × sprite 播放速度`，越界时触发 Animation End
10. Draw（按 depth 从大到小），再 Draw GUI

同一阶段内，实例按创建顺序执行。阶段中途新建的实例是否参加本 tick 剩余阶段，按 GMS 行为实现并写测试。

其他计时相关：

- `current_time`：9 种敌人的降落伞摆动用 `(current_time - startTime) / room_speed`（如 `obj_koopa/Step_0.gml:73`）。方案见 §9 Q5。
- `global.ms += 1000 / room_speed`（`obj_levelmanager/Step_2.gml:2`）：`room_speed` 给常量 60。
- `fps` 只用于调试显示。
- sprite 自带的播放速度（yy 里的 `playbackSpeed`/类型）由导入脚本读出来写进元数据，不能假设都是 1。

## 5. 碰撞方案

**不用 Godot 物理，自己实现 GMS 的碰撞查询。** 理由：原版 2207 处碰撞调用里 1922 处是 `collision_rectangle(bbox_left, bbox_bottom-1, bbox_right, bbox_bottom+1, obj, prec, notme)` 这种按像素偏移的即时查询，返回实例 id，再读它的 `yprevious`、`bbox_top`。全工程没有 `move_contact_*`、没有 solid 对象（811 个 yy 的 `solid` 全为 false）、没有物理世界。Godot 的 `move_and_slide`/`Area2D` 是下一帧才生效的信号模型，边界取整也不同，对不上。

要素：

1. **包围盒**：每个实例由 `mask_index`（没有则 `sprite_index`）的遮罩矩形 + 原点 + `image_xscale/yscale/angle` + 位置算出 `bbox_left/top/right/bottom`。因为开了 collision compatibility，按旧版语义：包围盒取整、右/下边界为闭区间（宽 16 的方块 `bbox_right = bbox_left + 15`）。这一条是整个方案的地基，第 1 批里先写测试；有原版可运行环境的话用原版实测校准（§9 Q2）。
2. **查询函数**：`collision_rectangle/point/line/circle`、`place_meeting`、`instance_place`、`position_meeting`、`instance_position`、`distance_to_object`、`instance_nearest`，签名与 GML 相同，`obj` 参数接受类（含后代）、单个实例或 `all`。
3. **精确遮罩**：`prec=1` 的调用和 `place_meeting`/碰撞事件需要逐像素判断。sprite 的 `collisionKind` 分布为 0:3179、1:626、2:710、4:124、5:6（各编号对应的形状在第 0 批对照 GMS 文档确认）。只给实际被用作遮罩的 sprite 生成位图。斜坡（`obj_slopeparent`，用 `prec=1` 查询）是第一个验证对象。
4. **空间索引**：统一网格（格子 32px），实例移动或换遮罩时更新。未激活实例不进索引。先求正确，性能在垂直切片后再测。
5. **Collision 事件**（527 个事件 / 179 个 object）：tick 的第 7 步，对每个有碰撞方法的实例，按目标 object 查重叠实例，逐个调用 `_collision_objX(other)`。双方都有事件则各触发一次。
6. **视野外休眠**：`obj_deactivation` 的 205 个后代靠 `instance_deactivate_object` + `instance_activate_region` 开关，直接用 §3.1 的 `active` 标记实现，区域判断用包围盒。

## 6. 绘制、视图、音频、输入

- **绘制**：435 个 object 有自定义 Draw。`GMObject._draw()` 里调 `_gm_draw()`；`draw_sprite_ext`、`draw_text`、`draw_rectangle`、`draw_set_alpha/colour/font` 做成 `GM` 下的同名函数，内部用 `CanvasItem.draw_*` + 变换。每 tick 对可见实例 `queue_redraw()`。
- **shader / surface**（97 行 / 43 文件）：3 个 shader 手工改写成 Godot shader；`sha_blendreplace`（玩家和头盔类绘制用）优先。`application_surface` 截图（暂停、淡入）用 `SubViewport`/屏幕纹理替代。`obj_lighting`、冲击波放在特效批次。
- **视图**：所有 room 的 `enableViews=False`，视图由代码通过 `__view_get/__view_set` 和 `camera_*` 控制（1275 行）。`GM` 提供一个 view 0，映射到一个 `Camera2D`；`__view_get((n<<0), 0)` 的编号按 `scripts/__view_get` 的枚举翻译成具名访问。基准分辨率 384×216，整数倍放大，最近邻过滤（原版 `interpolate_pixels=False`）。
- **音频**：2598 处 `audio_*`。`GM.audio_play_sound(snd, priority, loop)` 返回句柄，支持 `audio_is_playing/stop/pause/sound_pitch/gain`；用一个 `AudioStreamPlayer` 池。原版只有一个 audio group。
- **输入**：键位存在 `global.*` 里用 `keyboard_check(global.abajo)` 读取；`GM.keyboard_check*` 接 GMS 的 vk 码并映射到 Godot keycode。手柄只在 2 个文件里出现。鼠标（493 行）主要是编辑器和菜单，`mouse_x/mouse_y` 给房间坐标。
- **随机**：原版从不调 `randomize()`，GMS 每次启动种子相同。Godot 侧用固定种子的 `RandomNumberGenerator`，不追求与 GMS 数列一致。

## 7. 移植批次与顺序

顺序原则：先地基后内容；沿继承树自上而下，父类先于子类；每批结束时游戏能启动并且比上一批多一块可见内容。每批完成后按 CLAUDE.md 跑 `godot --headless` 检查报错，并在本文末尾的进度表里登记。

| 批 | 内容 | 完成标准 |
|---|---|---|
| 0 准备 | Godot 工程骨架；导入脚本（sprite/sound/font → `port/assets` + 元数据）；生成 object 清单表、depth 表、名字映射、global 变量清单；补读清单没读完的部分：关卡 JSON 全部键（`obj_load_level/Other_10.gml` 245 行；474 行的是管背景和音乐的 `Other_11.gml`）、两个保存端是否同构、`scr_edit_to_play`/`scr_play_to_edit`、各父类 user event 0–15 的含义表 | 空工程 headless 无报错；表生成可重复；本文 §3 的 user event 含义表补齐 |
| 1 兼容层 | §3–§6 的 `GM`、`GMObject`、tick 循环、alarm、内置运动、碰撞查询与事件、休眠、depth、视图、绘制函数、音频、输入、room 切换 | `tests/` 里事件顺序、alarm、包围盒取整、精确遮罩、`with` 顺序等测试全过 |
| 1b 转换脚本 | `tools/gml2gd.py`：GML → GDScript 机械转换。输入一个 object 的全部事件文件或一个脚本文件，输出按 §3.2、§3.3 规则生成的 `.gd` 草稿。能确定的语法（`with`、`event_inherited`、`event_user`、`argumentN`、`global.`、`var`、运算符、资源名、`instance_create` 等兼容层函数名）直接转；转不了或有歧义的地方原样保留并标 `# TODO-GML:`，不猜。草稿不直接进 `port/`，由模型逐个核对后才算完成 | 拿第 3 批的 `obj_galoomba`、`obj_koopa`、`obj_blockparent` 试转：输出能通过 GDScript 解析，`# TODO-GML:` 之外的部分与手工翻译逐行一致；统计全工程的 `# TODO-GML:` 比例 |
| 2 启动链 | `obj_persistent`（去掉 Discord 和设置文件部分）、rm_logo、rm_intro | 启动后播完 logo 和 intro |
| 3 垂直切片 | `obj_levelmanager`、`obj_load_level`、地面/实心/单向平台/斜坡、`obj_blockparent` 与砖块/问号块、`obj_deactivation`、`obj_physicsparent`、`obj_enemyparent`、`obj_deactenemyparent`、`obj_galoomba`、`obj_koopa`+壳、金币、蘑菇、`obj_mario`（小/大两种状态）、相机、死亡与重开 | 能载入一个原版关卡文件，走、跳、踩怪、顶砖、吃蘑菇、死亡重开 |
| 4 玩家补全 | Objects/Main/Player 34 个：全部变身、`obj_marioU`、耀西、鞋、过关/进水管/门的过场 object；`scr_mario*` 脚本 | 四种画风下玩家动作齐全 |
| 5 方块、道具、收集物 | Blocks 26、Collectables 42、`obj_powerupparent` 系、`obj_holdparent` 系 | |
| 6 敌人 | 按文件夹分小批：Land → Castle → Airship → Underwater/Beach → Desert/Forest/Snow/Sky/Ghost/Underground，共约 90 个；每小批 10–20 个 | 每小批配一个测试关卡 |
| 7 机关与平台 | Interactive/Special 95、Platforms 12、Goals 18、Others 19、Collisions 8、Decorations 12；路径（5 个 path）、粒子 | |
| 8 Boss | Enemies/Boss 20（`obj_bossparent` 系） | |
| 9 编辑器 | `obj_editormanager`、`obj_parent_resource` + 173 个 `_res` object、UI/Editor 64、编辑↔游玩切换脚本、保存（`obj_button_save_changes`）、音效方块（Editor Sounds 46） | 新建关卡→摆放→试玩→保存→重新载入；保存的文件原版结构一致 |
| 10 菜单与流程 | rm_title（背景里跑一个关卡，所以排在游玩之后）、设置（ConfigFile）、暂停、rm_gameover、rm_credito、rm_guardabot（本地关卡列表）、`scr_language` 文本表 | 从启动到进关卡再退回的完整流程 |
| 11 特效与收尾 | `obj_lighting`、冲击波 shader、幕布转场；在线功能入口留桩；全量回归；清理 | |

批次内的工作单位是“一个 object”：转换脚本出草稿 → 对照原文件全部事件核对、处理 `# TODO-GML:` → headless 检查 → 在测试关卡里看一眼。第 2、3 批的 object 仍由主会话手工翻译或逐行核对，用来校准转换脚本。

**模型分工**（Q14）：主会话负责兼容层、转换脚本、垂直切片、玩家，以及所有批次的抽查和验收。Opus 子代理负责第 5–9 批里逻辑较重的 object 的核对。Sonnet 子代理负责逻辑简单的 object（`_res` 编辑器资源、装饰、音效方块、简单收集物）的核对和测试关卡搭建。Haiku 子代理只做不需要判断的事：跑脚本、统计、按固定格式整理清单、headless 检查并汇总报错。子代理的产出一律要过 headless 检查，主会话按比例抽查后才登记完成；子代理遇到不确定的原版行为必须上报，不许猜。一个 object 依赖尚未移植的 object 时，先建只有类名和父类的空壳，不留悬空引用。

## 8. 主要风险与应对

| # | 风险 | 应对 |
|---|---|---|
| R1 | 包围盒取整和闭区间语义实现错一个像素，所有落地/贴墙判定都会错，且表现为零星的“偶尔穿墙” | 第 1 批用测试锁定；斜坡、单向平台各做专项场景；尽早拿到原版运行环境做数值对照（Q2） |
| R2 | 同一 tick 内的执行顺序与 GMS 不同（实例顺序、事件阶段、中途创建/销毁） | 顺序集中在 `GM` 一处实现，写测试；禁止 object 脚本使用 `_process`/`_physics_process`/信号 |
| R3 | `current_time` 是墙上时钟，降落伞摆角 `image_angle` 会随之变化，而 `image_angle` 在 GMS 里会旋转碰撞遮罩 | 先确认这 9 种敌人的遮罩是否受角度影响；时钟来源按 Q5 |
| R4 | GDScript 整数除法、`round`、真值判断与 GML 不同，翻译时静默出错 | §3.3 第 5–7 条写死；兼容层提供同名函数；每批抽查 |
| R5 | 数字资源 ID（40/103、590、`levelmusic=109`）含义不明 | 40/103 按 Q3；590 按 guardabot 读取端的同位置代码当作 `obj_door_switch_res`；`levelmusic=109` 待移植 rm_template 时再定 |
| R14 | 关卡文件不是纯 JSON：base64(JSON) + 40 位 SHA1-HMAC + 结尾 `\0`，校验不过原版拒收；保存端和读取端还有不对称（传送带、斜坡地面读不回来） | 格式见 `docs/level-format.md`；用原版 3.5.1 存出的关卡文件做读写对照 |
| R6 | 动态派发：`asset_get_index` 还原关卡对象、`instance_create(x,y,变量)`（72 处）、`variable_instance_exists`（42 处） | 名字映射表由脚本从 yyp 生成，保证 811 个名字都有条目（未移植的指向空壳并在载入时报警告） |
| R7 | 代码是反编译风格，没有注释，user event 编号含义靠读 | 第 0 批先整理父类的 user event 含义表；读不懂的按 CLAUDE.md 停下来问 |
| R8 | 规模：13.8 万行，其中 `obj_mario`+`obj_marioU` 共 6739 行、`scr_edit_to_play` 等巨型脚本 | 垂直切片（第 3 批）先验证兼容层够用再铺开；巨型文件按事件拆开逐个翻；每批有可见产出 |
| R9 | 4645 个 sprite / 7 万个文件的导入和精确遮罩生成 | 一次性脚本，输出可重复生成；只为被用作遮罩的 sprite 生成位图 |
| R10 | `sprite 播放速度`、`image_speed` 默认值、`mask` 继承等“yy 里的默认值”被忽略 | object 清单表把 yy 里的 sprite、mask、visible、persistent、parent 全部带出来，基类按表初始化 |
| R11 | 3 个 shader 和 `application_surface` 用法没有直接对应物 | 放到最后一批，核心玩法不依赖它们；`sha_blendreplace` 例外，第 4 批处理 |
| R12 | 许可：原工程是 AGPL-3.0 | 移植版是衍生作品，同样按 AGPL-3.0 发布；`port/` 里放 LICENSE |
| R13 | 没有原版运行环境，边界行为只能按文档实现 | §9 的 UNVERIFIED 清单集中登记；这些行为只在兼容层一处实现，实测结果不同时改一处即可 |

## 9. 拍板记录（2026-11-10）

| # | 问题 | 决定 |
|---|---|---|
| Q1 | Godot 路径 | 见 §0 |
| Q2 | 原版能否运行做对照 | 未确认有可运行的原版。默认按 GMS 文档实现，凡依赖未实测边界行为的地方在代码里标 `# UNVERIFIED:`，并登记到下面的 UNVERIFIED 清单。以后有原版运行环境时逐条实测 |
| Q3 | `obj_shell_drybones(_held)/Other_14.gml:64` 的 `40`、`103` | 当作 `obj_holdparent`、`obj_enemyparent_held`（与其余 16 个同构文件一致） |
| Q4 | `variable_instance_exists(object_index, "key")` | 按“检查自身实例是否有该变量”实现。UNVERIFIED |
| Q5 | 降落伞摆动的 `current_time` | 改成由 tick 推算：`GM.current_time = tick × 1000 / 60` |
| Q6 | `alarm[n] = 0` | 按“不触发”实现（alarm 减到 0 的那一步才触发，设为 0 后下一步减成 -1）。UNVERIFIED |
| Q7 | 清单 §6.1 缺 `collisionObjectId` 的 3 个事件 | 按“与自身同类（含后代）碰撞”处理 |
| Q8 | 窗口 | 见 §0 |
| Q9 | 平台 | 见 §0 |
| Q10 | `get_string_async` 系统对话框 | 换成游戏内输入框 |
| Q11 | git | 见 §0 |
| Q12 | 资源导入脚本 | 见 §0 |
| Q2 补 | 原版运行环境 | 用户有 SMMWE V3.5.1 原版 exe，可以做试玩对照和存关卡样本；没有 GameMaker，UNVERIFIED 清单里的最小实验仍然跑不了 |
| Q13 | 是否写 GML→GDScript 机械转换脚本 | 写，放在第 1 批之后（§7 的 1b）。目的是省额度 |
| Q14 | 子代理用哪些模型 | 可以用 Opus、Sonnet、Haiku，由主会话按任务难度分配，分工见 §7 |

### UNVERIFIED 清单

| 项 | 当前实现假设 | 最小实验（有原版环境时跑） |
|---|---|---|
| U1 包围盒取整与闭区间（§5 第 1 条） | 旧版语义：取整，右/下为闭区间 | 16×16 sprite 放在 x=10.5，打印 `bbox_left/right` |
| U2 `alarm[n] = 0`（Q6） | 不触发 | Create 里 `alarm[0] = 0`，Alarm 0 里 `show_debug_message` |
| U3 `variable_instance_exists(object_index, …)`（Q4） | 等同于检查自身 | 在 `obj_koopa` 里对有 `key` 变量的实例打印该表达式 |
| U4 阶段中途新建的实例是否参加本 tick 剩余阶段（§4） | 参加之后的阶段，不补跑已过的阶段 | Step 里创建实例，在其 End Step 里打印 |

## 10. 进度表

| 批 | 状态 | headless 检查 | 备注 |
|---|---|---|---|
| 0 | 完成（2026-11-10） | `--import`、`--quit` 均无错误，退出码 0 | Opus 子代理执行，主会话复核。产物：`tools/`、`port/tables/`、`port/assets/`、`docs/level-format.md`、`docs/user-events.md`、`docs/batch0-notes.md`。遗留的“不确定”条目记在这三份文档里 |
| 1 | 未开始 | – | |
| 1b | 未开始 | – | |
