# 主要父类的 user event 含义表

> 第 0 批产物。路径相对 `original/openwe-ref/`。`event_user(n)` 对应文件 `Other_(10+n).gml`（n=0…15 ↔ Other_10…Other_25）。
> 移植时按 port-plan §3.2 翻成 `_user_n()`。
> 调用点由脚本静态扫描得到（先去注释和字符串，再按 `with (X) { … }` / `with (X) 单句` 判定调用目标），扫描结果存在临时文件中，没有入库；结论里的数字是扫描数，样例行号都人工核对过。
> 动态目标（`with (other.id)`、`with (col_one_left)` 这类变量）只有在 `Collision_<目标>.gml` 里的 `other` 能确定类型，其他变量目标没有归属，所以“调用点”一栏不是完整清单。

## 0. 总体规律

- 继承链（yy 的 parentObjectId）：`obj_deactivation → obj_physicsparent → {obj_enemyparent → obj_deactenemyparent, obj_bossparent; obj_holdparent → obj_enemyparent_held; obj_powerupparent}`；`obj_solid → obj_blockparent`；`obj_parent_save → obj_parent_resource`；`obj_mario`、`obj_levelmanager`、`obj_editormanager` 没有父类。
- **同一个编号在不同继承树里含义不同**。例如 physicsparent 树里 user 3/4 是“水平/垂直碰撞”，levelmanager 里 user 3 是“停止所有音乐”。
- 父类定义的 user event 多数被子类**整体覆盖且不调用 `event_inherited()`**：全工程 1039 个 `Other_10…Other_25` 文件里只有 5 个调用 `event_inherited()`（`obj_1up/Other_13.gml:3`、`obj_SMB2_mushroom/Other_13.gml:37`、`obj_beachkoopa/Other_12.gml:3`、`obj_ground/Other_12.gml:27`、`obj_mushroom/Other_13.gml:37`）。
- 有的父类调用了自己没有定义、只由子类定义的编号（如 `obj_blockparent` 调 `event_user(0)`，`Other_10` 只在子类里）。GMS 中对没有该事件的实例调用 `event_user` 什么也不做。

## 1. obj_physicsparent（父：obj_deactivation）

Step：`Step_0.gml:1-4` 算 `swimming`，`:5` 调 `event_user(3)`，`:6` 调 `event_user(4)`。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 3 | `Other_13.gml`（50 行） | 水平碰撞：向左/右撞到 `obj_solid`、`obj_physicssolid`、`obj_solidphy`、`obj_thwomp`、`obj_bullebill_base`、`obj_enemyparent_held`、单向门时反向 `hspeed`，并用 `while … x--/x++` 把自己推出墙；碰到单向门时 `with (门) { rot = 1; event_user(0) }`（:7-19） | 自身 `Step_0.gml:5`；子类 Step 共 43 处自调（如 `obj_SMB_bowser/Step_0.gml:50`、`obj_block_pow_hold/Step_0.gml:103`） |
| 4 | `Other_14.gml`（99 行） | 垂直碰撞与重力：落到 `obj_solidtop`/`obj_physicssolid` 时对齐顶面（:1-11），站在地面/斜坡（`obj_slopeparent` 精确查询，:15）时 `gravity = 0`，否则按降落伞/水中/普通设重力和最大下落速度（:47-64）；向上撞顶时推出、触发单向门、对 `obj_blockparent` 调 `event_user(2)`（仅父类是 holdparent/enemyparent_held 的对象，:86-94）；掉出房间或掉进岩浆则销毁（:98-99）；最后调 `event_user(14)`（:100） | 自身 `Step_0.gml:6`；子类 43 处自调 |
| 14 | `Other_24.gml`（16 行） | 站在 `obj_platform_parent`（移动平台/熔岩升降台）上时跟随平台移动 | `Other_14.gml:100`；子类 25 处（如 `obj_SMB_bowser/Other_14.gml:100`） |

physicsparent 自己没有定义 0/1/2/5–13/15，但整棵树的子类大量使用它们（见各子类父表）。

## 2. obj_enemyparent（父：obj_physicsparent）

Step：`Step_0.gml` 不调用 `event_inherited()`，自己算 `swimming`（:1-4）后依次调 `event_user(2)`、`(3)`、`(4)`（:5-7），再处理朝向和岩浆（:8-47）。user 3/4 用的是继承自 physicsparent 的 `Other_13/Other_14`。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | `Other_10.gml`（17 行，自带注释 “Default enemy death script”） | 默认死亡：创建 `obj_enemy_dead`，复制 sprite/帧/朝向，按 `other` 的位置或速度给它 ±1 的 hspeed，然后 `instance_destroy()`。注意它读 `other`，所以只在碰撞事件或 `with` 里调用时才有意义 | 自身 `Collision_obj_mario.gml:22,33,48`、`Collision_obj_blockparent.gml:8,16`；`Other_15.gml:1`；外部 `with (other.id)` 66 处（如 `obj_bones_yoshi/Collision_obj_enemyparent.gml:7`），`with (obj_enemyparent)` 3 处（`obj_block_pow_active/Alarm_0.gml:22,27`，`obj_mario/Other_18.gml:14`） |
| 1 | `Other_11.gml`（`exit`） | 被踩的钩子，默认什么都不做；子类覆盖（如 `obj_koopa/Other_11.gml`、`obj_galoomba/Other_11.gml`） | 自身 `Collision_obj_mario.gml:82,91,119,192,201`；`with (other.id)` 3 处（如 `obj_fireball/Collision_obj_bobomb.gml:5`） |
| 2 | `Other_12.gml`（75 行） | 与其他敌人/`obj_enemyparent_held` 重叠时按中心位置分开（:1-16）；按 object 和是否在水中把 `hspeed` 逐步减到上限（:17-73） | 自身 `Step_0.gml:5`；子类 13 处（如 `obj_buzzybeetle/Step_0.gml:34`） |
| 5 | `Other_15.gml` | 直接调 `event_user(0)`（:1） | 自身 `Collision_obj_blockparent.gml:6`；`with (other.id)` 5 处（如 `obj_spinner/Collision_obj_enemyparent.gml:12`、`obj_blockbumper/Collision_obj_enemyparent.gml:5`） |
| 6 | `Other_16.gml`（12 行） | 走到平台边缘时掉头（`gravity == 0` 且不在斜坡上，前方脚下无 `obj_solidtop`/实体时反转 `hspeed`） | 子类 Step 14 处（如 `obj_beachkoopa_red/Step_0.gml:3`、`obj_drybones/Step_0.gml:8`） |

子类还使用 7、8、9、14、15（仅子类定义），例：`event_user(9)` 由 `obj_block_pow_active/Alarm_0.gml:18` 对 `with (obj_enemyparent)` 调用；`event_user(14)` 由 `obj_hammerbro/Other_14.gml:49` 等自调。

## 3. obj_deactenemyparent（父：obj_enemyparent）

只有 yy，没有任何事件文件（`objects/obj_deactenemyparent/` 下只有 `.yy`），全部继承 obj_enemyparent。全工程代码里没有直接引用这个名字（除 depth 表 `__global_object_depths.gml:198,994`），它只作为继承节点存在；子类有 `obj_koopa`、`obj_galoomba` 等（yy 的 parentObjectId）。名字里的 “deact” 与休眠的关系**不确定**（休眠逻辑用的是祖先 `obj_deactivation`，见 port-plan §5 第 6 条）。

## 4. obj_holdparent（父：obj_physicsparent，可被玩家拿起的物体）

Step：`Step_0.gml` 自己处理被拿起（`held`）、被玩家踩着走等，不调 `event_inherited()`。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 1 | `Other_11.gml`（空） | 空钩子 | 自身 `Collision_obj_blockparent.gml:12`、`Collision_obj_mario.gml:8`；子类 `obj_enemyparent_held/Step_2.gml:62`、`obj_shell_drybones/Collision_obj_mario.gml:6` |
| 2 | `Other_12.gml`（69 行） | 放下/扔出：按住下键时轻放（:1-20）；SMW 画风按上键向上抛（:21-39）；否则踢出，调 `with (obj_mario) event_user(7)`（踢的动作，:50-51）并给出速度（:40-66）；末尾修正斜坡穿插 | 自身 `Step_2.gml:92`（松手时）；子类 `obj_enemyparent_held/Step_2.gml:122`、`obj_link_bomb/Step_2.gml:25`。（`Other_14.gml:89` 的 `event_user(2)` 在 `with (block)` 内，调的是方块的 user 2，不是这个） |
| 3 | `Other_13.gml`（46 行） | 水平碰撞（physicsparent 版的变体：撞墙后 `direct` 取反，有 `walk` 变量时反向否则停下） | 子类 Step 8 处（如 `obj_block_pow_hold/Step_0.gml:103`、`obj_link_bomb/Step_0.gml:17`）。holdparent 自己的 Step 不调用 |
| 4 | `Other_14.gml`（94 行） | 垂直碰撞（physicsparent 版的变体：落地弹跳 `bouncy` 并减速，向上撞到 block 时 `with (block) event_user(2)`，:83-91） | 子类 Step 8 处（同上） |
| 5 | `Other_15.gml`（12 行） | 被击飞：`vspeed = -(3 - 1.5*swimming)`，按 `other` 的位置/速度给 ±0.6 的 hspeed | `with (other.id)` 4 处（`obj_cap_mario/Collision_obj_holdparent.gml:13`、`obj_link_arrow/Collision_obj_enemyparent_held.gml:4`、`obj_link_arrow/Collision_obj_link_bomb.gml:2`、`obj_spinner/Collision_obj_enemyparent_held.gml:4`） |

## 5. obj_enemyparent_held（父：obj_holdparent，可拿起的敌人：龟壳、雪球、栗子等）

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | `Other_10.gml`（15 行） | 死亡：如在手上则解除玩家的 `holding`，创建 `obj_enemy_dead`，销毁自己 | 自身多个碰撞事件（如 `Collision_obj_fireball.gml:3`、`Collision_obj_explosion.gml:3`、`Collision_obj_bossparent.gml:4`）；`with (other.id)` 26 处（如 `obj_bones_yoshi/Collision_obj_shell.gml:5`） |
| 7 | `Other_17.gml` | 调 `event_user(0)` | 自身 `Collision_obj_blockparent.gml:5`；`with (other.id)` 3 处（`obj_spinner/Collision_obj_shell.gml:4`、`obj_cap_mario/Collision_obj_holdparent.gml:8`、`obj_helmet/Collision_obj_physicsparent.gml:13`） |

其余编号继承 holdparent（1、2、3、4、5）与 physicsparent（14）。`Step_2.gml:62,122,194` 分别调 1、2、14。

## 6. obj_blockparent（父：obj_solid，可顶的方块）

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | （父类未定义，子类定义） | 方块被触发后的内容（出金币/道具等），例：`obj_block/Other_10.gml` | 父类自调：`Other_11.gml:4`、`Other_12.gml:4`、`Other_13.gml:5`、`Step_0.gml:30,49,58`、`Alarm_2.gml:9,37`；`with (other.id)` 14 处（如 `obj_gold_explosion/Collision_obj_blockparent.gml:14`） |
| 1 | `Other_11.gml` | 被顶（向上）：`ready = 1; vspeed = -2; alarm[0] = 4`，调 user 0 | `with (other.id)` 6 处（如 `obj_link_arrow/Collision_obj_blockparent.gml:18`、`obj_explosion/Collision_obj_onoffblock.gml:4`） |
| 2 | `Other_12.gml` | 同上，`alarm[0] = 5` | 物体从下方撞击：`obj_physicsparent/Other_14.gml:92`、`obj_holdparent/Other_14.gml:89` 的 `with (block)`；另有 `with (block)` 形式 15 处（如 `obj_SMB3_bowser/Step_0.gml:65`） |
| 3 | `Other_13.gml` | 被从上方砸（向下）：`downwards = 1; vspeed = 2; alarm[3] = 5`，调 user 0 | `with (other.id)` 5 处（`obj_groundpount/Collision_obj_blockparent.gml:11,45,56,61` 等）；`with (ground_block)` 5 处 |
| 15 | `Other_25.gml`（79 行） | 碎裂：播放碎块音效，按画风创建 4 个 `obj_shard` | `with (ground_block) event_user(15)` 1 处；其余调用点未静态解析（**不确定**） |

子类使用的 4、5、10（如 `obj_noteblock/Step_0.gml:47`、`obj_noteblock/Other_14.gml:88`、`obj_flipblock/Create_0.gml:117`）只在子类定义。`obj_noteblock/Alarm_1.gml:3` 是 `event_user(downwards)`——编号来自变量（`downwards` 是 0/1），翻译时不能直接转成固定方法名。

## 7. obj_powerupparent（父：obj_physicsparent，道具）

Step：`Step_0.gml:23-27` 在 `(wings == 0 || paracaidas == 1) && object_index != obj_propellershroom` 时调 `event_user(3)`、`(4)`。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 3 | `Other_13.gml`（47 行） | 水平碰撞：火花/超级花撞墙停下，其他反向 | 自身 `Step_0.gml:25`；`obj_link/Step_0.gml:19` |
| 4 | （继承 physicsparent `Other_14`） | 垂直碰撞与重力 | 自身 `Step_0.gml:26`；`obj_link/Step_0.gml:20` |

子类覆盖 user 3 时有 3 个调用了 `event_inherited()`（`obj_mushroom/Other_13.gml:37`、`obj_1up/Other_13.gml:3`、`obj_SMB2_mushroom/Other_13.gml:37`）。

## 8. obj_bossparent（父：obj_physicsparent）

Step：`Step_0.gml:1` `event_perform_object(obj_enemyparent, ev_step, ev_step_normal)`——直接执行 obj_enemyparent 的 Step（不是自己的父类），即 swimming + user 2/3/4；之后处理 `inv`、`cooldown`（:2-16）。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 1 | `Other_11.gml`（`exit`） | 受伤钩子，默认空；子类覆盖（如 `obj_boomboom/Other_11.gml`，注释 “Default hurt script”） | 自身碰撞事件 28 处（如 `Collision_obj_fireball.gml:11,16`、`Collision_obj_enemyparent_held.gml:13,18`）；`with (other.id)` 2 处 |
| 2 | `Other_12.gml`（10 行） | 与其他 boss 重叠时分开 | 经 `event_perform_object` 进入的 obj_enemyparent Step（`obj_enemyparent/Step_0.gml:5`）——此时 `event_user(2)` 按实例派发，执行的是 bossparent 自己的 `Other_12`（GMS 语义如此理解，**不确定**，需要实测 `event_perform_object` 内的 `event_user` 是按实例还是按指定 object 派发） |
| 6 | `Other_16.gml`（46 行） | 走到边缘或尖刺/食人花上方时掉头（记录 `prevhspeed`） | `obj_SMW_bowser/Step_0.gml:43` |
| 15 | `Other_25.gml`（21 行） | 按画风播放 boss 落地/撞击音效 | 自身碰撞事件（`Collision_obj_fireball.gml:3`、`Collision_obj_enemyparent_held.gml:5` 等）共 17 处自调 |

user 0（死亡）沿用 obj_enemyparent 吗？**不是**：bossparent 的父类是 physicsparent，不是 enemyparent，所以 enemyparent 的 `Other_10` 不被继承；bossparent 自身碰撞事件调用的 `event_user(0)`（如 `Collision_obj_fireball.gml:19`）由各 boss 子类定义（如 `obj_boomboom/Other_10.gml`）。user 3/4/14 继承 physicsparent。

## 9. obj_parent_resource（父：obj_parent_save，编辑器里摆放的 `_res` 物件）

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 2 | `Other_12.gml`（6 行） | 删除：橡皮擦模式时播放音效；不与 `obj_erase` 重叠则 `instance_destroy()` | 自身 `Mouse_0.gml:6`、`Mouse_1.gml:6`；自身 `Collision_obj_parent_resource.gml:7,12` 的 `with (other.id)`；外部 `with (other.id)` 10 处（如 `obj_arrow_lock/Collision_obj_parent_resource.gml:7`） |
| 4 | `Other_14.gml`（13 行） | 切换翅膀：`wings` 0↔1，去掉时生成 `obj_wings_dead` | `obj_angrysun_res/Other_11.gml:314`；其余调用来自变量目标，未解析（**不确定**） |

父类自调但只在子类定义的：0（`Alarm_0.gml:45`、`Mouse_4.gml:25`、`Mouse_7.gml:8`），5（`Alarm_0.gml:91`）；`scripts/scr_edit_to_play/scr_edit_to_play.gml` 对 `obj_ground`、`obj_slopes`、各平台 `_res` 调 `event_user(3)` 15 处（编辑→游玩时把 `_res` 换成游戏对象，推断）。

## 10. obj_mario（无父类；子类 obj_marioU）

`Other_1x` 里多数带原作者的 `/// @description` 注释，下表“作用”直接引用。Step：`Step_0.gml:91-117` 按 `isswim` 与 `state` 派发：陆上 state 3→user 4、4→user 5、其他→user 2；水中 state 3→user 4、其他→user 3。

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | `Other_10.gml`（186 行） | “Hurt Mario”：受伤（骑耀西时先下耀西，调 user 6） | 自身 `Step_0.gml:126` 等（碰到尖刺）；`with (other.id)` 29 处（敌人/Boss 的 `Collision_obj_mario`，如 `obj_SMB_bowser/Collision_obj_mario.gml:29`）；`with (obj_mario)` 4 处 |
| 1 | `Other_11.gml`（30 行） | “Make Mario bounce off of something”：踩到东西后弹起 | `with (other.id)` 35 处（如 `obj_enemyparent/Collision_obj_mario.gml:26-27`）；`with (obj_mario)` 14 处（如 `obj_koopa/Other_11.gml:4`） |
| 2 | `Other_12.gml`（770 行） | “Mario's default step event”：陆上主状态机 | `Step_0.gml:102` |
| 3 | `Other_13.gml`（402 行） | “Mario's swimming step event” | `Step_0.gml:114` |
| 4 | `Other_14.gml`（152 行） | “Mario's climbing step event” | `Step_0.gml:96,111` |
| 5 | `Other_15.gml`（15 行） | “Mario's wall climbing + wall jumping step event” | `Step_0.gml:99` |
| 6 | `Other_16.gml`（17 行） | “Give Mario temporary invincibility”：`invincible = 1`，alarm[1] 闪烁，alarm[3]=120 结束 | 自身 `Other_10.gml:9,38,81,94,163,180`；`with (obj_mario)` 2 处（`obj_invincibility/Alarm_0.gml:10`、`obj_mario_transform2/Destroy_0.gml:51`） |
| 7 | `Other_17.gml`（12 行） | “Make Mario kick something”：踢的动画 | `with (obj_mario)` 16 处（如 `obj_holdparent/Other_12.gml:25,51`）；`with (other.id)` 1 处 |
| 8 | `Other_18.gml`（40 行） | 重落地震动：播放音效，`obj_levelmanager.alarm[11] = 1`，对屏幕内着地的敌人 `dead_h = 1; event_user(0)`，对 boomboom 等 | 自身 `Step_0.gml:38,56`（降落状态落地） |
| 14 | `Other_24.gml`（11 行） | “Stop these sounds from playing” | 自身 `Destroy_0.gml:1` |
| 15 | `Other_25.gml`（22 行） | “Reset some variables”：落地时复位飞行/旋转/二段跳等状态 | 自身 `Step_0.gml:51,60,67`、`Other_12.gml:445,463`；`with (obj_mario)` 8 处（如 `obj_noteblock/Step_0.gml:36`）；`with (other.id)` 3 处 |

`obj_marioU` 覆盖 11、12、13，并定义 19（`obj_marioU/Other_19.gml`，由 `obj_marioU/Step_2.gml:14` 调用 `event_user(9)`）；均不调 `event_inherited()`。

## 11. obj_levelmanager（无父类）

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | `Other_10.gml`（5 行） | 销毁所有 `obj_mario` 与 `obj_autoscroll` | `Other_4.gml:34-35`（`with (obj_checkpoint)` 内的 `with (other.id)`，即对 levelmanager 自己，随后在检查点生成新 mario） |
| 1 | `Other_11.gml`（13 行） | P 开关开始：`switchon = 1`，换 P 开关音乐 | `with (obj_levelmanager)` 2 处（`obj_pswitch/Other_16.gml:14-18`、`obj_pswitch/Other_17.gml:12`） |
| 2 | `Other_12.gml`（16 行） | 金币 ↔ 翻转砖互换（P 开关效果） | 未找到静态调用点（**不确定**） |
| 3 | `Other_13.gml`（6 行） | 停止关卡音乐、无敌星、N64、Link、P 开关音乐 | `with (obj_levelmanager)` 8 处（如 `obj_deadmario/Create_0.gml:20`、`obj_goalcard/Collision_obj_mario.gml:28`、`obj_axe_smw/Alarm_1.gml:4`） |
| 5 | `Other_15.gml`（6 行） | 时间 1–100 时播放 “hurry up” | 自身 `Other_4.gml:48`；`with (obj_levelmanager)` 2 处（`obj_load_guardabot/Other_11.gml:54`、`obj_mariostart/Alarm_1.gml:4`） |
| 6 | `Other_16.gml`（19 行） | 选择镜头跟随对象 `follow`（mario → 过关对象 → 门 → …） | `Step_2.gml:41` |
| 7 | `Other_17.gml`（28 行） | 镜头以速度 6 移向 mario | `Step_2.gml:101,145` |
| 8 | `Other_18.gml`（142 行） | 镜头边界与纵向跟随规则（读 `follow.state` 等） | `Step_2.gml:92,148` |
| 9 | `Other_19.gml`（49 行） | HUD 绘制（SMB/SMB3/SMW 画风） | `Draw_0.gml:6` |
| 10 | `Other_20.gml`（32 行） | HUD 绘制（NSMBU 画风） | `Draw_0.gml:4` |
| 11 | `Other_21.gml`（185 行） | 背景视差滚动（按画风/场景设 `__background_set(e__BG.X/Y, …)`） | `Step_2.gml:157` |

levelmanager 没有 `Other_14`。`KeyPress_13.gml:15-16`、`Other_4.gml:53-54`、`Other_5.gml:32-33` 里的 `event_user(2..5)` 在 `with (obj_persistent)` 块内，调用的是 obj_persistent 的 user event（触屏控制，Android 用）。

## 12. obj_editormanager（无父类）

| n | 文件 | 作用 | 调用点 |
|---|---|---|---|
| 0 | `Other_10.gml`（350 行） | 冻结场上物体：对 physicsparent、holdparent 等 `speed = 0; gravity = 0; image_speed = 0` …（开头 :1-12） | 未找到静态调用点（**不确定**） |
| 2 | `Other_12.gml`（331 行） | 进入试玩：`instance_activate_all()`，恢复敌人动画并设 alarm[10] 等 | `obj_creator_jugar_editar/Alarm_2.gml:1-2`（`with (obj_editormanager)`） |
| 3 | `Other_13.gml`（441 行） | 回到编辑：`instance_activate_all()`，销毁游玩中生成的 physicsparent 实例（保留两种终点），清理无敌星、道具出芽等 | `obj_creator_jugar_editar/Alarm_1.gml:1-2`；自身 `Step_0.gml:73` |

`Other_10/12/13` 的完整语义需要在第 9 批逐行读（三个文件共 1122 行），这里只读了开头。

## 13. 子类覆盖时是否调用 event_inherited（抽查）

| 子类（父） | 覆盖的 user event | 是否 `event_inherited()` | 备注 |
|---|---|---|---|
| obj_koopa（obj_deactenemyparent） | 0、1、5、7 | 都不调 | `Step_0.gml` 也不调 `event_inherited()`，自己在 `:21-23` 调 user 2/3/4，`:64` 调 7 |
| obj_galoomba（obj_deactenemyparent） | 0、1、5、7 | 都不调 | `Step_0.gml:1` 调 `event_inherited()`（走 enemyparent 的 Step） |
| obj_shell_held（obj_enemyparent） | 0、1、3、4、5 | 都不调 | 3/4 是完整重写的碰撞（`Other_13.gml` 46 行、`Other_14.gml` 81 行） |
| obj_mushroom（obj_powerupparent） | 3 | 调，`Other_13.gml:37`，在条件分支内 | `Step_0.gml:1` 也调 |
| obj_boomboom（obj_bossparent） | 0、1、7 | 都不调 | |
| obj_block（obj_blockparent） | 0 | 不调（父类没有 user 0） | |
| obj_marioU（obj_mario） | 1、2、3，新增 9 | 都不调 | |

结论：翻译时绝大多数 `_user_n()` 是完全覆盖；只有上面 §0 列出的 5 处要生成 `super._user_n()`。
