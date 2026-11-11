# OpenWE 移植计划（GMS 2023.11 → Godot 4.7.2）

> 状态：定稿（2026-11-10）；同日第 1 批完成后按实现修订了 §3–§6 和 UNVERIFIED 清单。§9 的事项已全部拍板，未实测的行为集中列在 UNVERIFIED 清单里。
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
  gm/            兼容层（autoload `GM`、基类 `GMObject`、碰撞、绘制、音频、视图、资源名常量 `A`）
  globals/       autoload `G`（g.gd，tools/gen_g.py 由 tables/globals.json 生成）：原版全部 global.* 变量，逐个声明类型
  objects/       一个 object 一个 .gd，文件名与原名相同（obj_koopa.gd）
  scripts/       一个原版脚本资源一个 .gd（文件名同资源名），里面是 `static func 函数名(me: GMObject, …)`；
                 scr.gd（class_name Scr，tools/gen_scr.py 生成）是门面：全部宏、枚举，和每个已移植函数的转发，
                 调用处一律写 `Scr.函数名(self, …)`。（第 2 批定：没有按文件夹合并，便于逐个核对）
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
| 资源名（`obj_koopa`、`spr_koopa`、`snd_coin`、`rm_logo`…） | `A.obj_koopa` 这样的 int 常量（`port/gm/a.gd`，脚本生成） | 和 GML 一样，资源就是编号。编号是 yyp 顺序，不是 GMS 运行时编号。object、sprite、sound、room 各自从 0 起 |
| object | `port/objects/obj_xxx.gd`，写 `extends "res://objects/<父类>.gd"`，没有父类的写 `extends GMObject`；**不写 `class_name`** | 根基类 `GMObject extends Node`（不是 Node2D：绘制不走节点，见 §6）。继承关系照搬 yy。`GM` 按编号懒加载脚本，没移植的 object 用空壳顶替并报一次警告 |
| instance | `GMObject` 节点，创建时登记到 `GM` 的实例表 | 实例表按创建顺序保存，另按 object（含后代）建索引。“实例 id”就是对象引用，`noone` 对应 `null` |
| `instance_create(x,y,obj)` | `GM.instance_create(x, y, A.obj_xxx)` | depth 取自 `tables/object_depths`（来源见 §1）。room 里摆放的实例 depth 取所在图层的 depth |
| 函数的 `obj` 参数 | `Variant`：int（object 编号，含后代）、`GMObject`（单个实例）、`GM.all`、`GM.noone` 或 `null` | 碰撞查询、`with_list`、`instance_exists` 等都这样 |
| `instance_destroy()` | `instance_destroy()`（实例方法）；销毁别的实例用 `GM.instance_destroy(inst)` | 立刻触发 Destroy 事件并从索引移除，节点在 tick 结束时 `queue_free` |
| `instance_deactivate_*` / `activate_*` | 实例表上的 `active` 标记 | 未激活的实例不跑事件、不参与碰撞、`with`/`instance_exists` 找不到。原版用法：`obj_levelmanager/Step_2.gml:164-167`、`obj_editormanager/Alarm_2.gml` |
| `asset_get_index(name)` / `object_get_name` | `GM.asset_get_index(name)` 返回编号，查不到返回 -1 | 关卡文件靠它还原实例（清单 §6.7） |
| room | 一个场景 + 实例列表，`GM.room_goto()` 负责 Room End / Room Start 事件 | `obj_persistent` 是唯一 persistent 对象，挂在 autoload 下 |
| depth | `GMObject.depth`，`GM` 按 depth 分桶，每 tick 从大到小画 | 不用 `z_index`，所以没有范围限制。相同 depth 按加入顺序画（UNVERIFIED U11） |
| sprite | int 编号；元数据在 `GM.sprites[编号]`（`GMSprite`），贴图是横向条带 | 精确遮罩由 `tools/gen_masks.py` 生成到 `tables/masks.bin` |
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
| Other_10…25 | `_user_0()`…`_user_15()` | `event_user(n)`：n 为字面量时直接调 `_user_n()`，否则调 `GMObject.event_user(n)` |
| Other_4 / Other_5 | `_room_start()` / `_room_end()` | |
| Other_2 / Other_3 | `_game_start()` / `_game_end()` | |
| Other_7 | `_animation_end()` | |
| Other_0 / Other_40 / Other_8 | `_outside_room()` / `_outside_view_0()` / `_path_end()` | Outside View 0 只在 `GM.view_enabled` 且 `GM.view_visible[0]` 为真时触发；Path End 等路径在第 7 批实现 |
| Draw_0 / Draw_64 | `_gm_draw()` / `_gm_draw_gui()` | 没有 Draw 事件的 object 走默认的 `draw_self` |
| Mouse_n / KeyPress_n | `_mouse_n()` / `_keypress_n()` | n 就是 GMS 的事件号（Mouse_4 = 左键按下，Mouse_53 = 全局左键按下；KeyPress_13 = 回车）。由 `GM` 在输入阶段派发 |

`GMObject` 基类不声明任何事件方法。`GM` 在某个 object 第一次实例化时扫描它有哪些事件方法（含继承来的），没有的事件不派发。所以方法名必须严格按上表写；父类没有某个事件时不能写 `super._xxx()`（GML 里那是空操作，翻译时直接去掉）。

内置函数放在两处：以实例自身为主语的（`collision_rectangle`、`place_meeting`、`instance_place`、`position_meeting`、`motion_set`、`motion_add`、`move_towards_point`、`move_snap`、`event_user`、`draw_self`、`instance_destroy`）是 `GMObject` 的方法，在事件方法里直接按 GML 原样调用；其余全部是 `GM.` 下的同名函数（`GM.instance_create`、`GM.audio_play_sound`、`GM.draw_sprite_ext`、`GM.keyboard_check`…）。GML 里隐含 self 的全局函数多带一个参数：`instance_deactivate_all(notme)` → `GM.instance_deactivate_all(notme, self)`。
| Other_60/63/70（异步） | 60、70 不移植；63（文本输入对话框）换实现，见 §9 Q10 | |

### 3.3 语法翻译规则

1. 一个事件文件翻成一个方法，语句顺序、变量名（含西班牙语/意大利语名字）原样保留，不重构、不合并、不“顺手修 bug”。原版明显的 bug 照搬并加 `# ORIG-BUG:` 注释。
2. `event_inherited()` → `super._xxx()`。`event_perform_object(objP, ev_step, ev_step_normal)` → 直接调用该祖先类的方法实现。
3. `with (X) { … }` → `for inst in GM.with_list(X): …`，块内的隐式 self 全部改写成 `inst.`，块内的 `other` 改写成外层的 `self`。`with_list` 在进入时取快照，顺序为创建顺序。
4. 碰撞事件里的 `other` → 方法参数 `other`。
5. 数值：GML 只有双精度实数。GDScript 的整数相除会截断，所以**凡参与算术的变量一律声明为 `float`**，字面量写成 `2.0`；只有数组下标、枚举、计数循环变量用 `int`。
6. `round()` → `GM.gm_round()`（GML 是四舍六入五成双，Godot 不是）。`div` → `GM.gm_div`，`mod` → `GM.gm_mod`，`sign` → `GM.gm_sign`，`string()` → `GM.string()`（整数值不带小数，其余两位小数），`string_*`（GML 字符串下标从 1 开始）、`lengthdir_*`、`point_direction`、`choose`、`random*` 等统一走 `GM.` 下的同名函数，不直接用 Godot 内置函数替代。`abs/floor/ceil/min/max/sqrt/sin/cos/clamp/lerp/power` 用 Godot 的 `absf/floorf/ceilf/minf/maxf/sqrt/sin/cos/clampf/lerpf/pow`。
6a. GML 的实数比较带容差：`a == b` 是 `|a - b| <= 0.00001`，`a < b` 是 `a - b < -0.00001`（原版 `math_set_epsilon(0.00001)`，也是默认值）。GDScript 的浮点比较是精确的。翻译时默认用 GDScript 的精确比较；两边都是整数值（计数器、状态号、帧号常量）时两者没有区别。**一边是逐帧累加出来的小数、另一边是小数常量的 `==`/`!=`**（如 `hspeed == 0.3`）必须写成 `GM.eq(a, b)` / `not GM.eq(a, b)`。见风险 R15。
7. 真值：GML 里 `if (inst)`、`if (x)` 以 `> 0.5` 为真，`noone` 是 -4。返回实例的函数在 Godot 侧返回 `GMObject` 或 `null`，条件写成 `!= null`；数值条件写成显式比较。GML 的 `prec`、`notme`、`loop` 这类 0/1 实参翻成 `false`/`true`。
8. `variable_instance_exists(inst, "name")` → `GM.variable_instance_exists(inst, "name")`，含义是“这个类声明了该变量，并且已经赋过值（不是 null）”。因此：在 `_create()` 里赋值的实例变量照常声明类型和初值；**只在别的事件里才第一次赋值的实例变量声明成不带类型、初值 `null`**（`var key = null`），这样它在赋值前“不存在”。原版 `variable_instance_exists(object_index, "key")` 的写法按 Q4 传 `self`。
8a. 访问别的实例的变量（`other.vspeed`、`inst.key`）：内置变量直接访问；object 自己的变量因为没有 `class_name`，静态类型查不到，把实例放进不带类型的局部变量再访问（`var o = other` 后 `o.key`），或用 `inst.get("key")` / `inst.set("key", v)`。
9. 内置变量 `x y hspeed vspeed speed direction gravity friction image_index image_speed image_xscale image_yscale image_angle image_alpha sprite_index mask_index depth visible xstart ystart xprevious yprevious bbox_* alarm[]` 都是 `GMObject` 的属性，名字不变。`hspeed/vspeed` 与 `speed/direction` 的联动照 GMS 实现。
10. 每个翻译出的方法头部写一行来源注释：`# from objects/obj_koopa/Step_0.gml`。
11. 数组写入：GML 数组越界写入会自动扩展，GDScript 不会。可能越界的 `a[i] = v` 写成 `GM.aset(a, i, v)`；数组变量声明成 `Array = []`（GML 里给未赋值的变量写下标会自动建数组）。二维的先 `GM.aset(a, i, [])` 再写内层。
12. G 的类型：number → float、string → String、bool → bool、字体/资源 → int、array/ds_list → Array，其余不带类型（规则在 tools/gen_g.py）。GML 读未赋值的 global 会报错，移植版都有初值，不会报。
13. 原版脚本里有 4 个和内置函数同名的函数（`sprite_delete`、`sprite_exists`、`gpu_set_blendenable`、`gpu_set_blendmode`，在 background_delete.gml 等 GMS 生成的脚本里），调用的是内置函数，写 `GM.`。转换脚本已按此处理。
14. 脚本的 static func 若声明 `-> Variant`，结尾补 `return null`（GML 走到结尾返回 undefined）。

## 4. 时间系统

**固定 60 tick，逐帧推进，不用 delta。** 原版 `option_game_speed=60`，没有任何 `game_set_speed`、`delta_time`（已全工程检索），alarm、`image_speed`、`hspeed += 0.015` 这类逐帧累加遍布 1000 多个文件，改成 delta 时间等于重写。

实现：`physics_ticks_per_second = 60`，`GM._physics_process` 每次执行一个 GMS step；渲染不做插值。掉帧时游戏变慢而不是跳帧（与 GMS 一致），并限制单帧最多补的 tick 数。

每个 tick 内的顺序。第 1 批实现时对照了 GameMaker 官方开源的 HTML5 runner 源码（`GameMaker_DoAStep`、`HandleAlarm`、`UpdatePositions`、`UpdateImages`、`HandleCollision`），以它为准，并用 `port/tests` 锁住。它与最初的计划有两处不同：动画推进在 tick 最前面而不是最后；alarm 只有在 object 有对应事件时才走时。

1. 锁存输入（这一步的“刚按下/刚松开”）
2. 记录 `xprevious/yprevious`；动画推进 `image_index += image_speed × sprite 播放速度`；越界时减去（或加上）帧数并触发 Animation End
3. Begin Step
4. Alarm：只处理有对应事件的 alarm。值先截断成整数，`>= 0` 则减 1；减完恰好等于 0 时触发，之后停在 0，下一步变成 -1。所以 `alarm[n] = 0` 不触发
5. KeyPress 事件、鼠标事件
6. Step
7. 内置运动：先 `friction` 再 `gravity` 作用于速度，然后 `x += hspeed; y += vspeed`
8. Outside Room / Outside View 事件
9. Collision 事件
10. End Step
11. 释放已销毁的实例；相机跟随；Draw（按 depth 从大到小），再 Draw GUI

任何一个阶段里调用了 `room_goto`，本步剩余阶段全部跳过（包括 Draw）；换完 room 后在同一帧里立刻再跑一个完整的 step。

同一阶段内，实例按创建顺序执行（UNVERIFIED U4）。阶段进行中新建的实例不参加本阶段，从下一个阶段起参加；内置运动阶段例外，它不看创建时间，所以 Step 里新建的实例当步就会移动。销毁立刻触发 Destroy 和 CleanUp 事件，实例从此查不到，节点在第 11 步释放。

其他计时相关：

- `current_time`：9 种敌人的降落伞摆动用 `(current_time - startTime) / room_speed`（如 `obj_koopa/Step_0.gml:73`）。方案见 §9 Q5。
- `global.ms += 1000 / room_speed`（`obj_levelmanager/Step_2.gml:2`）：`room_speed` 给常量 60。
- `fps` 只用于调试显示。
- sprite 自带的播放速度（yy 里的 `playbackSpeed`/类型）由导入脚本读出来写进元数据，不能假设都是 1。

## 5. 碰撞方案

**不用 Godot 物理，自己实现 GMS 的碰撞查询。** 理由：原版 2207 处碰撞调用里 1922 处是 `collision_rectangle(bbox_left, bbox_bottom-1, bbox_right, bbox_bottom+1, obj, prec, notme)` 这种按像素偏移的即时查询，返回实例 id，再读它的 `yprevious`、`bbox_top`。全工程没有 `move_contact_*`、没有 solid 对象（811 个 yy 的 `solid` 全为 false）、没有物理世界。Godot 的 `move_and_slide`/`Area2D` 是下一帧才生效的信号模型，边界取整也不同，对不上。

要素：

1. **包围盒**：每个实例由 `mask_index`（没有则 `sprite_index`）的遮罩矩形 + 原点 + `image_xscale/yscale/angle` + 位置算出 `bbox_left/top/right/bottom`。因为开了 collision compatibility，按旧版语义：包围盒取整、右/下边界为闭区间（宽 16 的方块 `bbox_right = bbox_left + 15`）。公式取自 HTML5 runner 的 `Compute_BoundingBox`（compatibility 分支）：`left = round(x + xscale × (spr_left − xorigin))`，`right = round(left + xscale × 宽) − 1`，`round` 是四舍六入五成双；`left > right` 时交换（负缩放）；有旋转时走另一组公式。没有 sprite 也没有 mask 的实例包围盒退化成一个点，不参与任何碰撞。查询的边界条件也照 runner：矩形查询命中的条件是 `x1 < bbox_right + 1` 且 `x2 >= bbox_left`（纵向同理）。全部写在 `port/gm/gm_object.gd`、`gm_collision.gd`，测试在 `port/tests/test_main.gd`。
2. **查询函数**：`collision_rectangle/point/line/circle`、`place_meeting`、`instance_place`、`position_meeting`、`instance_position`、`distance_to_object`、`instance_nearest`，签名与 GML 相同，`obj` 参数接受类（含后代）、单个实例或 `all`。
3. **精确遮罩**：`prec=1` 的调用和 `place_meeting`/碰撞事件需要逐像素判断。sprite 的 `collisionKind` 分布为 0:3179、1:626、2:710、4:124、5:6（各编号对应的形状在第 0 批对照 GMS 文档确认）。只给实际被用作遮罩的 sprite 生成位图。斜坡（`obj_slopeparent`，用 `prec=1` 查询）是第一个验证对象。
4. **空间索引**：统一网格（格子 16px，一块地砖正好一格），实例移动或换遮罩后在下一次查询前重新入格。休眠实例留在网格里，查询时按 `active` 标记跳过（原版每 tick 都把几百个实例休眠再唤醒，进出网格太贵）。同时命中多个实例时返回创建最早的（UNVERIFIED U7）。
5. **Collision 事件**（527 个事件 / 179 个 object）：tick 的第 9 步。对每个有碰撞事件的实例 a（创建顺序），按目标 object 找与它重叠的实例 b（恒为精确判定），先调用 a 的 `_collision_objX(b)`，紧接着调用 b 对 a 的碰撞事件（如果有）；同一对实例的同一个事件每 tick 只触发一次。a 的事件里把 b 销毁了，b 的事件仍然触发（HTML5 runner 如此）。细节未实测，见 UNVERIFIED U5。
6. **视野外休眠**：`obj_deactivation` 的 205 个后代靠 `instance_deactivate_object` + `instance_activate_region` 开关，直接用 §3.1 的 `active` 标记实现，区域判断用包围盒。
7. **精确遮罩的来源**：yy 的 `collisionKind` 0（Precise，全部帧合成一张）、4（逐帧）、2（椭圆）、3（菱形）在运行时都是“精确遮罩”，1（矩形）只看包围盒，5（随旋转的矩形，6 个装饰 sprite）暂按包围盒处理。椭圆的栅格化规则是自定的（UNVERIFIED U6）。
8. **性能**（`port/tests/bench.tscn`，编辑器版二进制，导出的发行版会更快）：3000 个静止实例 + 200 个每步做 6 次矩形查询的移动实例，约 14 ms/tick，其中 1200 次查询占 7.4 ms（约 6 µs 一次）。预算是 16.7 ms。第 3 批用真实的玩家和敌人再测；不够的话查询部分是首要优化对象。

## 6. 绘制、视图、音频、输入

- **绘制**：435 个 object 有自定义 Draw。Draw 事件在 tick 的最后一个阶段里执行（GMS 的顺序，每 tick 恰好一次），所以不走节点的 `_draw()`：`GM` 持有一个世界 canvas item 和一个 GUI canvas item，每 tick 清空，`draw_sprite_ext`、`draw_text`、`draw_rectangle` 等 `GM` 下的同名函数直接往里写 `RenderingServer` 绘制命令。`draw_set_alpha/colour/font/halign/valign` 是全局状态，跨事件保留。没有 Draw 事件的实例画默认的 `draw_self`，画在视野外的直接跳过。颜色是 GML 的 `0xBBGGRR` 整数。字体：`font_add`（ttf）和 `font_add_sprite_ext`（原版的数字字体全是这种）。
- **application_surface**（第 2 批实现）：世界层画进一个 SubViewport，它的纹理就是 `application_surface`，大小由 `surface_resize` 决定（原版设成 768×432，相机 384×216 放大 2 倍画进去）。原版调了 `application_surface_draw_enable(false)`，由 obj_persistent 的 Draw GUI 用 `draw_surface_stretched` 自己把它画到屏幕上，所以 `port_y`（屏幕震动）照原样生效。GUI 坐标按 `display_set_gui_size` 映射到整个 384×216 画面。因为最终画面仍是 384×216（§0 的决定），原版 2 倍 surface 上的半像素细节看不到。截图（`sprite_create_from_surface`，换 room 时的淡出）取 SubViewport 上一帧的图像，headless 下是全黑图。
- **room 图层**（第 2 批实现，`port/gm/gm_layer.gd`）：room 的背景图层（纯色或 sprite，平铺/拉伸/滚动）按 depth 和实例混排绘制；`layer_*` 和 `layer_background_*` 实现了 GMS 生成的 `__background_*` 兼容脚本用到的全部函数（原版 1098 处 `__background_set` 都走这些脚本）。asset 图层（图块）只建空图层，内容第 3 批画。
- **shader / surface**（97 行 / 43 文件）：3 个 shader 手工改写成 Godot shader；`sha_blendreplace`（玩家和头盔类绘制用）优先。`application_surface` 截图（暂停、淡入）用 `SubViewport`/屏幕纹理替代。`obj_lighting`、冲击波放在特效批次。
- **视图**：所有 room 的 `enableViews=False`，视图由代码通过 `__view_get/__view_set` 和 `camera_*` 控制（1275 行）。`GM` 提供一个 view 0，映射到一个 `Camera2D`；`__view_get((n<<0), 0)` 的编号按 `scripts/__view_get` 的枚举翻译成具名访问。基准分辨率 384×216，整数倍放大，最近邻过滤（原版 `interpolate_pixels=False`）。
- **音频**：2598 处 `audio_*`。`GM.audio_play_sound(snd, priority, loop)` 返回句柄，支持 `audio_is_playing/stop/pause/sound_pitch/gain`；用一个 `AudioStreamPlayer` 池。原版只有一个 audio group。
- **输入**：键位存在 `global.*` 里用 `keyboard_check(global.abajo)` 读取；`GM.keyboard_check*` 接 GMS 的 vk 码并映射到 Godot keycode。手柄只在 2 个文件里出现。鼠标（493 行）主要是编辑器和菜单，`mouse_x/mouse_y` 给房间坐标。
- **随机**：原版在 `obj_persistent/Create_0.gml:5` 调了 `randomise()`（英式拼写，最初检索 `randomize` 时漏了），所以每次启动的随机数列都不同。Godot 侧 `GM.randomise()` 用 `RandomNumberGenerator.randomize()`，不追求与 GMS 数列一致；测试里用 `GM.random_set_seed()`。
- **测试**：`godot --headless --path port res://tests/test_main.tscn`，全过时退出码 0。性能基准：`res://tests/bench.tscn`。

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
| R13 | 没有 GameMaker，边界行为无法做最小实验 | 第 1 批改为对照官方开源的 HTML5 runner 源码实现（比文档精确得多，但它不是 Windows runner，两者可能有差异）；§9 的 UNVERIFIED 清单集中登记仍未确认的点；这些行为只在兼容层一处实现，结论不同时改一处即可 |
| R15 | GML 的实数比较带 0.00001 的容差，GDScript 是精确比较。逐帧累加的小数和常量做 `==` 时会不相等 | §3.3 第 6a 条；转换脚本对“小数常量参与的 `==`/`!=`”自动生成 `GM.eq`；试玩时发现“状态切不过去”一类问题先查这里 |
| R16 | GDScript 的速度：一次碰撞查询约 6 µs，一个 Mario 类的 object 每步可能有几十次 | §5 第 8 条的基准；第 3 批实测；转换脚本可以把同一表达式里的多个 `bbox_*` 读取合并；最后手段是把查询核心改写成 C++ 扩展 |

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

“依据”一栏：**源码** = 照 GameMaker 官方开源的 HTML5 runner（github.com/YoYoGames/GameMaker-HTML5）实现，但没有在 Windows runner 上实测；**假设** = 没有资料，自己定的。

| 项 | 当前实现 | 依据 | 最小实验（有 GameMaker 时跑） |
|---|---|---|---|
| U1 包围盒取整与闭区间（§5 第 1 条） | 四舍六入五成双，右/下为闭区间 | 源码 | 16×16 sprite 放在 x=10.5，打印 `bbox_left/right` |
| U2 `alarm[n] = 0`（Q6） | 不触发；没有事件的 alarm 不走时 | 源码 | Create 里 `alarm[0] = 0`，Alarm 0 里 `show_debug_message` |
| U3 `variable_instance_exists(object_index, …)`（Q4） | 等同于检查自身 | 假设 | 在 `obj_koopa` 里对有 `key` 变量的实例打印该表达式 |
| U4 同一阶段内各实例的执行顺序（§4） | 创建顺序 | 假设。HTML5 runner 的 Begin Step/Step/End Step 是按创建顺序的**逆序**执行的，Alarm 和 Collision 是正序；Windows runner 没有资料 | 两个实例在 Step 里各打印一行 |
| U4b 阶段进行中新建的实例 | 不参加本阶段，参加之后的阶段；当步会移动 | 源码 | Step 里创建实例，在其 Step、End Step 里打印 |
| U5 Collision 事件的细节（§5 第 5 条） | 见 §5。实例同时有“对父类 X”和“对 X 的子类 Y”两个碰撞事件、对方是 Y 时，两个都触发（原版有 304 组这样的 object/目标组合，如 `obj_tongue_blue` 对 `obj_holdparent` 和 `obj_pswitch`） | 配对和先后顺序是源码；“两个都触发”是假设 | A 有对父、对子两个碰撞事件，各打印一行，与子类实例重叠 |
| U6 椭圆遮罩的形状（710 个 sprite） | 包围盒内，像素中心落在内接椭圆里的算实心 | 假设 | 椭圆遮罩的 sprite 用 `collision_point` 逐像素扫一遍打印 |
| U7 查询同时命中多个实例时返回哪个 | 创建最早的 | 假设（新版 runner 用空间索引，顺序不明） | 两个重叠实例，打印 `collision_rectangle` 返回的 id |
| U8 `move_snap` 正好在半格时的舍入 | 用 GML 的 `round`（五成双） | 假设 | `x = 8; move_snap(16, 16)` 后打印 x |
| U9 没有 sprite 的实例是否触发 Animation End | 不触发 | 假设。HTML5 runner 会每步都触发 | 无 sprite 的 object 加 Animation End 事件打印 |
| U10 `keyboard_key_press` 之后同一步内 `keyboard_check_pressed` | 按住状态立刻生效，“刚按下”下一步生效 | 假设 | Step 里先 `keyboard_key_press` 再打印 `keyboard_check_pressed` |
| U11 相同 depth 的实例谁画在上面 | 后创建（或后改 depth）的在上 | 假设 | 两个同 depth 的重叠实例截图 |
| U12 相同 depth 的图层谁在上面；同 depth 的背景图层和实例 | room 图层列表里靠前的（编辑器里靠上的）画在上面；同 depth 时先画背景图层再画实例 | 假设。rm_intro 的 Compatibility_Background_0（换成 bg_lg 后）和 Compatibility_Colour 同 depth，按此规则 bg_lg 盖住黄色底，与登录界面的意图一致 | 3.5.1 原版看 intro 结束后的登录界面背景 |
| U13 背景图层的动画速度和滚动时机 | userdefinedAnimFPS 为假时用 sprite 自己的速度；图层按 hspeed/vspeed 滚动在 Draw 之前做 | 假设 | 有动画的背景 sprite 计帧 |

U4、U5、U7 最可能影响手感。它们各自只在兼容层的一处实现，结论不同时改一处即可。没有 GameMaker 也可以间接判断：第 3 批起对照 3.5.1 原版试玩，出现“先后顺序”类的差异时优先查这三项。

## 10. 进度表

| 批 | 状态 | headless 检查 | 备注 |
|---|---|---|---|
| 0 | 完成（2026-11-10） | `--import`、`--quit` 均无错误，退出码 0 | Opus 子代理执行，主会话复核。产物：`tools/`、`port/tables/`、`port/assets/`、`docs/level-format.md`、`docs/user-events.md`、`docs/batch0-notes.md`。遗留的“不确定”条目记在这三份文档里 |
| 1 | 完成（2026-11-10） | `--quit` 无输出、退出码 0；`tests/test_main.tscn` 221 项检查全过（headless 和真实渲染器各跑过一次） | 产物：`port/gm/`（`gm.gd` 及其继承链 `gm_input ← gm_audio ← gm_draw ← gm_base`、`gm_object.gd`、`gm_class.gd`、`gm_collision.gd`、`gm_sprite.gd`、生成的 `a.gd`）、`port/tests/`、`tools/gen_runtime.py`、`tools/gen_masks.py`。行为对照了 HTML5 runner 源码，§3–§6、UNVERIFIED 清单已按实现更新。**没做的**：path（`path_start` 等，第 7 批）、粒子（第 7 批）、surface 和 shader（第 11 批）、room 的背景图层和图块（第 2 批）、`instance_change`（3 处调用，用到时做）、`audio_sound_gain` 的渐变、文件读写（第 3/9 批）。**没验证的**：画面没有人眼看过，只确认了绘制调用不报错 |
| 2 | 完成（2026-11-11） | `--quit` 无输出、退出码 0；`tests/test_main.tscn` 221 项全过；新增 `tests/test_boot.tscn`（启动链，57 项）全过；真实渲染器录 1000 帧（Movie Maker）人眼看过 logo、淡出截图、intro（龟壳）、标题落下、登录界面背景 | 产物：`port/globals/g.gd`（`tools/gen_g.py`）、`port/scripts/scr.gd`（`tools/gen_scr.py`）、11 个脚本（scr_language、scr_init_globals、init_shockwave、scr_snd_switchalert、`__background_*` 6 个、background_create_from_surface）、8 个 object（obj_persistent、obj_logo_c、obj_intro_controller、obj_mario_intro、obj_shell_intro、obj_thwomp_intro、obj_goomba_intro、obj_btn_social）、`main.gd` 启动入口。兼容层新增 `gm_layer.gd`（图层）、`gm_system.gd`（系统/日期/窗口/application_surface/截图/shader 空实现），继承链变成 `gm ← gm_input ← gm_audio ← gm_system ← gm_layer ← gm_draw ← gm_base`。修了第 1 批的一个 bug：实例在“待重新入格”时被销毁，节点释放后碰撞网格 flush 访问已释放对象（headless 测试在同一帧内跑完所以没发现）。obj_persistent 去掉了设置文件读写（固定走“无设置文件”的默认值）、Discord、Android 分支。intro 结束后进入登录界面（rm_intro 里），按钮 object（obj_login_control、obj_btn_invitado、obj_btn_iniciar、obj_cursor、obj_version）是空壳，第 10 批处理。转换脚本：认识新的兼容层文件、4 个和内置函数同名的脚本；全工程 TODO 比例 5.27% → 5.08%。**仍未定**：`noone`/`null` 的统一规则、`obj_x.foo = v` 的写入（第 3 批第一次大量出现时定）；`working_directory` 暂为 `user://`（第 3/9 批定文件读写时再定） |
| 1b | 完成（2026-11-10） | 草稿 1105 个文件逐个 `load()` 无编译错误；`tests/test_main.tscn` 221 项全过 | Opus 子代理写，主会话抽查。`tools/gml2gd.py`（用法和局限见 `docs/gml2gd-notes.md`）。全工程试转 128547 行，带 `# TODO-GML:` 的 6772 行（5.27%），解析失败 0。草稿输出到 `port/_draft/`（不入库）。**只验证了能编译，没验证运行行为**；脚本类草稿没有逐行核对。遗留给第 2、3 批定的事：`Scr.`（脚本怎么组织）和 `G.`（global 变量类型）目前是占位；`noone` 与 `null` 的统一规则；`obj_x.foo` 读写（3768 行 TODO，GML 语义是读第一个实例、写全部实例，转换脚本还没按此生成）；ds_map/ds_list/文件函数（1111 行 TODO）怎么映射 |
