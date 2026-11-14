# 原版关卡文件格式（.swe）

> 第 0 批产物。路径相对 `original/openwe-ref/`，`文件:行` 为 1 起始行号。
> 只陈述从代码读出的事实；读不出的地方标 **不确定**。

## 1. 文件外层

| 项 | 内容 | 证据 |
|---|---|---|
| 扩展名 | `.swe` | `objects/obj_button_notification_aceptar/Other_10.gml:215`、`objects/obj_guardabot/Create_0.gml:29`（`file_find_first(global.directorio + "*.swe")`） |
| 目录 | `global.directorio`（见 §6） | `objects/obj_button_save_changes/Other_10.gml:215` |
| 写入 | `json_encode(mundo)` → `string_replace_all(_string, ".000000", "")` → `base64_encode` → 末尾拼接 `sha1_string_utf8_hmac(global.drez, base64串)` → `SaveStringToFile` | `objects/obj_button_save_changes/Other_10.gml:210-215` |
| 读取 | `buffer_load` + `buffer_read(buffer_string)`；取最后 40 个字符为期望哈希，其余为 base64 串；重算 HMAC，相等才 `base64_decode` + `json_decode`，否则返回 `0` | `scripts/LoadJSONFromFile/LoadJSONFromFile.gml:4-18` |
| HMAC 密钥 | `global.drez = "2559F35097-2021"` | `objects/obj_persistent/Create_0.gml:115` |
| HMAC 输入 | **base64 之后**的字符串（不是 JSON 原文） | `objects/obj_button_save_changes/Other_10.gml:213`、`scripts/LoadJSONFromFile/LoadJSONFromFile.gml:9` |
| 结尾字节 | `SaveStringToFile` 建 `string_byte_length+1` 字节的 buffer 并 `buffer_write(buffer_string)`，buffer_string 会写入结尾的 0 字节，所以文件末尾多 1 个 `\0` | `scripts/SaveStringToFile/SaveStringToFile.gml:5-7` |

**不确定**：
- `sha1_string_utf8_hmac` 返回的十六进制是大写还是小写。读取端用 `==` 逐字比较（`LoadJSONFromFile.gml:10`），大小写不对原版会拒收。仓库里没有任何 `.swe` 样本可以核对（`find . -iname "*.swe"` 为空）。需要一个原版生成的关卡文件来确认。
- `json_encode` 对实数的格式：代码把 `".000000"` 替换为空（`Other_10.gml:211`），说明原版输出整数值时带 6 位小数；非整数（如 `water_level_speed` 的 0.2）会被写成什么样子（`0.2` 还是 `0.200000`），从代码看不出来。该替换也会作用于字符串值（如 `description`）里出现的 `.000000`。
- `LoadJSONFromFile` 校验失败返回 `0`，`obj_load_level/Other_10.gml:6-9` 不检查直接 `ds_map_find_value(mundos, "MAIN")`，原版此时的行为不确定（`obj_load_guardabot/Other_11.gml:8` 则有检查）。

## 2. JSON 结构总览

```
{
  "MAIN": {
    "AJUSTES":     [ {设置} ],          // 恰好 1 个元素，读取端只读下标 0
    "SUELO":       [ {地面}, ... ],
    "DECORACION":  [ {装饰}, ... ],
    "NIVEL":       [ {普通物件}, ... ],
    "TUBERIAS":    [ {水管}, ... ],
    "CANNON":      [ {炮台}, ... ],
    "PLATAFORMAS": [ {平台类}, ... ],
    "PUERTAS":     [ {门}, ... ]
  },
  "SUB1": { "AJUSTES": [] }             // 写入但无人读取
}
```

写入：`objects/obj_button_save_changes/Other_10.gml:195-209`。`SUB1` 只在两个保存端出现（全工程检索 `SUB1` 仅 `obj_button_save_changes/Other_10.gml:209`、`obj_button_notification_aceptar/Other_10.gml:209`），读取端不读。
所有列表元素都是 ds_map（`ds_list_mark_as_map`），所以 JSON 里是对象数组。GMS 的 ds_map 无序，键顺序不必保持。

## 3. 各层的键

列说明：W = 写入位置（两个保存端行号相同，只写 `obj_button_save_changes/Other_10.gml`，差异见 §4）；R1 = `objects/obj_load_level/Other_10.gml`（编辑器载入）；R2 = `objects/obj_load_guardabot/Other_11.gml`（游玩载入）。

### 3.1 MAIN.AJUSTES[0]（关卡设置）

| 键 | 类型 | 写入值（W 行） | 读取（R1 行 / R2 行）与校验 | 含义 |
|---|---|---|---|---|
| `user` | 字符串 | `global.my1`（37） | R1:10 不等于 `global.my1` 时拒绝载入（toast `scr_language(96)`）；R2:25 只要求键存在，R2:32 相等时才设 `global.save_changes`/`last_level` | 作者名。`global.my1` 来自设置文件（`obj_persistent/Other_2.gml:62`）或登录输入（`obj_bl2/Mouse_4.gml:5`） |
| `etiqueta1` | 数 | `global.etiqueta1_temp`（38） | R1:65 → `global.etiqueta1_temp`；R2 不读 | 标签 1（编号）。另一保存端写 `global.etiqueta1`，见 §4 |
| `etiqueta2` | 数 | `global.etiqueta2_temp`（39） | R1:66；R2 不读 | 标签 2 |
| `apariencia` | 数 0–3 | `global.apariencia`（40） | R1:23-25 / R2:37-39，超范围随机 `choose(0,1,2,3)` | 画风：SMB=0、SMB3=1、SMW=2、NSMBU=3（`scripts/macros/macros.gml:23-26`） |
| `entorno` | 字符串 | `global.bg_level`（41） | R1:26-28 / R2:40-42，不在 13 个合法值内则改为 `"ground"` | 场景：ground underground castle underwater desert ghost airship sky forest snow beach fall mountain |
| `cronometro` | 数 | `obj_levelmanager.leveltime`（42） | R1:34-36 → `obj_levelmanager.leveltime`；R2:46-48 → `global.timer`；>500 或 <10 改为 300 | 时间限制 |
| `autoavance` | 数 0–3 | `global.autoavance`（43） | R1:38-40 / R2:60-62，超范围为 0 | 自动卷轴速度档：R2 中 1/2/3 对应 `velocidad` 0.5/1/1.5（`obj_load_guardabot/Other_11.gml:316-357` 的 switch） |
| `modo_noche` | 数 0/1 | `global.modo_noche`（44） | R1:29-31 / R2:43-45，非 0/1 改为 0 | 夜间模式 |
| `ground2` | 数 | `obj_ground2.y`（45） | R1:41-45 / R2:86-90：设 `obj_ground2.y`，`size_y = (432 - y) / 16` | 起点地面高度 |
| `ground3_x` | 数 | `obj_ground3.x`（46） | R1:48 / R2:93 | 终点地面 x |
| `ground3_y` | 数 | `obj_ground3.y`（47） | R1:49-50 / R2:94-95 | 终点地面 y |
| `size` | 数 | `room_width`（48） | R1:52-56 / R2:97-101：>9216 取 9216；<384 取 **496** | 关卡宽度（像素）。注意下限判断用 384、赋值用 496，原文如此 |
| `water_level` | 数 | `obj_card_bout.pos_y`（49） | R1:59（仅 `obj_card_bout` 存在时）；R2:102 → 自身 `pos_y` | 水位/岩浆高度 |
| `water_level_limit` | 数 | `obj_card_bout.pos_y_limit`（50） | R1:60；R2:103 | 水位上限 |
| `water_level_speed` | 数 0.2/0.5/0.8 | `global.water_speed`（51） | R1:61-63；R2:104-106，其他值改 0.2 | 水位速度 |
| `date` | 字符串 `DD/MM/YY…` | 由 `current_day/month/year` 拼成（15-27, 52） | R1/R2 不读；`objects/obj_gb_level/Create_0.gml:77` 读来显示 | 保存日期。年份分支 `current_year < 10` 实际不会成立，所以是 4 位年份 |
| `time` | 字符串 `HH:MM` | （28-36, 53） | `obj_gb_level/Create_0.gml:78` | 保存时间 |
| `condiciones` | 数 0/1 | `global.condiciones`（54） | R1:67,71-72 / R2:63 起 | 是否有过关条件 |
| `condiciones_type` | 数 | `global.condiciones_type`（55） | R1:68,73-77：**只要 type 或 object 不为 0，两者都被重置为 0** | 条件类型。R2:63-75 的处理与 R1 相同。按代码字面，任何非 0 的 type/object 读回后都变成 0（原文如此，**不确定**是否有意） |
| `condiciones_object` | 数 | `global.condiciones_object`（56） | R1:69,73-77 | 条件对象。**不确定**：存的是什么编号（object 序号？）未追踪 |
| `condiciones_count` | 数 0–3 | `global.condiciones_count`（57） | R1:70,78-79 | 条件数量 |
| `ds_s` | 数 0/1 | `global.sounds_level`（58） | R1:80-83 / R2:76-77，**可缺省**（`ds_map_exists`） | 是否含音效方块 |
| `meteorites` | 数 0/1 | `global.meteoritos`（59） | R1:84-87 / R2:80-81，可缺省 | 陨石 |
| `description` | 字符串 | `global.desc`（60） | R1:88-89 / R2:84-85，可缺省 | 关卡描述 |

缺省值：`ds_s`、`meteorites`、`description` 缺省时读取端保留全局变量原值（R1 会把不合法的 `sounds_level`/`meteoritos` 归 0）。其余键缺省时 `ds_map_find_value` 返回 `undefined`，原版随后的比较会怎样（如 `undefined > 3`）**不确定**。

### 3.2 MAIN.SUELO[]（地面块）

写入：`with (obj_ground)`，含后代 `obj_slopes`、`obj_ground_slope`（W:62-73）。读取：R1:92-102 / R2:108-118，一律 `instance_create(0,0,obj_ground)`。

| 键 | 类型 | 写入 | 读取 |
|---|---|---|---|
| `x_pos` | 数 | `x`（69） | `x` 与 `x_draw`（R1:97,99） |
| `y_pos` | 数 | `y`（70） | `y` 与 `y_draw`（R1:98,100） |
| `index` | 数 | `image_index`（71） | `image_index`（R1:101） |

**不确定**：`obj_slopes`/`obj_ground_slope` 是 `obj_ground` 的子类（yy 的 parentObjectId），`with (obj_ground)` 会把它们也写进 SUELO，但读回来都变成 `obj_ground`。另外 `obj_slopes` 也满足 NIVEL 的写入条件（W:92 只排除 `object_index == obj_ground`），而读取端 NIVEL 显式跳过 `obj_slopes`（R1:108）。保存时场上是否真的存在 `obj_slopes` 实例、斜坡如何往返，需要读编辑器放置逻辑（`objects/obj_cursor/Other_11.gml:13-15`、`objects/obj_creator_jugar_editar/Alarm_3.gml:6-8`）后再定。

### 3.3 MAIN.DECORACION[]（装饰）

写入：`with (obj_decoracion_parent)`（含 obj_decoracion_1…4）（W:74-88）。读取：R1:159-170 / R2:174-185。

| 键 | 类型 | 写入 | 读取 |
|---|---|---|---|
| `object` | 字符串（object 名） | `object_get_name(object_index)`（82） | `asset_get_index` → `instance_create`（R1:163,165） |
| `x_pos` / `y_pos` | 数 | `x` / `y`（83-84） | `x` / `y`（不设 `x_draw`） |
| `sprite` | 字符串（sprite 名） | `sprite_get_name(sprite_index)`（85） | `asset_get_index` → `sprite_index`（R1:164,168） |
| `index` | 数 | `image_index`（86） | `image_index`（R1:169） |

### 3.4 MAIN.NIVEL[]（普通物件）

写入：`with (obj_parent_resource)`，排除 `obj_tuberia_res, obj_cannon_res, obj_cannon_red_res, obj_semisolid_platform1, obj_mushroom_platform_res, obj_vine_res, obj_pokey_res, obj_bullebill_base_red_res, obj_bullebill_base_res, obj_platform_res, obj_platform_blue_res, obj_puente_res, obj_door_res, obj_door_exit_res, obj_door_switch_res, obj_door_switch_exit_res, obj_door_lock_res, obj_door_lock_exit_res, obj_firebar_res, obj_ground`（W:90-111）。
读取：R1:103-126 / R2:119-142，`asset_get_index(object)` 后，若不在排除表里才创建。读取端排除表与写入端的差异：读取端**没有** `obj_firebar_res`，**多了** `obj_cinta_res`、`obj_cinta_on_res`、`obj_slopes`（R1:108；R2:124 同集合，仅顺序不同）。

| 键 | 类型 | 写入（W 行） | 读取（R1 行） |
|---|---|---|---|
| `object` | 字符串 | `object_get_name(object_index)`（97） | 107 |
| `x_pos` / `y_pos` | 数 | `x` / `y`（98-99） | `x`、`y`、`x_draw`、`y_draw`（111-114） |
| `sprout` | 数 | `sprout`（100） | 115 |
| `progresivo` | 数 | `progresivo`（101） | 117 |
| `wings` | 数 | `wings`（102） | 118 |
| `rotacion` | 数 | `rotacion`（103） | 119 |
| `direct_t` | 数 | `direct_t`（104） | 116 |
| `paracaidas` | 数 | `paracaidas`（105） | 120 |
| `key` | 数 | `key`（106） | 121 |
| `inup` | 数 | `inup`（107） | 122 |
| `modo_water` | 数 | `modo_water`（108） | 123 |
| `s_scaley` | 数 | `s_scaley`（109） | 124 |

这些字段是 `obj_parent_resource` 系的实例变量，各自含义要到第 9 批读 `_res` object 时再定（**不确定**）。

**不确定**：`obj_cinta_res`/`obj_cinta_on_res`（传送带）会被写进 NIVEL（写入端不排除），但读取端在 NIVEL 中跳过它们，其他列表也不读它们——按代码字面，传送带保存后无法读回。是否有别的机制，没查到（全工程对 `obj_cinta_res` 的引用见 `scripts/scr_edit_to_play/scr_edit_to_play.gml:1646-1656`、`objects/obj_cinta_res/Other_15.gml:2`、`objects/obj_cinta_on_res/Other_15.gml:2`）。

### 3.5 MAIN.TUBERIAS[]（水管）

写入：`with (obj_parent_resource)` 中 `object_index == obj_tuberia_res && warp != 2`（W:112-141）。读取：R1:127-158 / R2:143-172，一律创建 `obj_tuberia_res`。

| 键 | 类型 | 写入 | 读取（R1 行） |
|---|---|---|---|
| `x_pos` / `y_pos` | 数 | `x` / `y` | `x`、`y`、`x_draw`、`y_draw`（132-135） |
| `size` | 数 | `size` | 136 |
| `rotacion` | 数 | `rotacion` | `rotacion`（137）；R1 另设 `R`（138），R2 不设 |
| `direct_t` | 数 | `direct_t` | 139 |
| `scalex` | 数 | `s_scalex` | `s_scalex`（140） |
| `color` | 数 | `color` | 141 |
| `mask` | 数 | `plant` | `plant`（142）（键名与变量名不同） |
| `xscale` / `yscale` | 数 | `image_xscale` / `image_yscale` | 143-144 |
| `warp` | 数 | `warp` | 只有存在该键才读以下 `t_*`（145-157） |
| `t_x_pos` `t_y_pos` `t_size` `t_rotacion` `t_direct_t` `t_s_scalex` `t_color` `t_xscale` `t_yscale` | 数 | 同名变量（131-139） | 同名变量（148-156） |

`warp == 2` 的水管不写入；从 `t_*` 字段看，它们应该是传送水管的另一端，由 `warp` 水管在运行时生成（推断，**不确定**）。

### 3.6 MAIN.CANNON[]（炮台）

写入：`object_index == obj_cannon_res || obj_cannon_red_res`（W:142-159）。读取：R1:171-186 / R2:186-201。

| 键 | 类型 | 写入 | 读取 |
|---|---|---|---|
| `object` | 字符串 | `object_get_name` | `asset_get_index` |
| `x_pos` / `y_pos` | 数 | `x` / `y` | `x`、`y`、`x_draw`、`y_draw` |
| `direct` | 数 | `direct` | `direct` |
| `down` / `up` / `left` / `right` | 数 | `d` / `u` / `l` / `r` | `d` / `u` / `l` / `r`（键名与变量名不同） |

### 3.7 MAIN.PLATAFORMAS[]（平台类）

写入：`obj_semisolid_platform1, obj_mushroom_platform_res, obj_vine_res, obj_platform_res, obj_platform_blue_res, obj_puente_res, obj_pokey_res, obj_bullebill_base_red_res, obj_bullebill_base_res, obj_firebar_res`（W:160-179）。读取：R1:187-204 / R2:202-219。

| 键 | 类型 | 写入 | 读取 |
|---|---|---|---|
| `object` | 字符串 | `object_get_name` | `asset_get_index` |
| `x_pos` / `y_pos` | 数 | `x` / `y` | `x`、`y`、`x_draw`、`y_draw` |
| `sprite` | 字符串 | `sprite_get_name(sprite_index)` | `asset_get_index` → `sprite_index` |
| `color` | 数 | `color` | `color` |
| `depth` | 数 | `depth` | `depth`（覆盖 `instance_create` 给的默认 depth） |
| `width` / `height` | 数 | `size_x` / `size_y` | `size_x` / `size_y` |
| `direct_t` | 数 | `direct_t` | `direct_t` |
| `wings` | 数 | `wings` | `wings` |

### 3.8 MAIN.PUERTAS[]（门）

写入：`obj_door_res, obj_door_switch_res, obj_door_lock_res`（W:180-194）。读取：R1:205-226 / R2:220-241，每种最多读 4 个（`limit_door_1/2/3 < 4`，计数器初值在 `obj_load_level/Create_0.gml:21-23`、`obj_load_guardabot/Create_0.gml:5-7`）。

| 键 | 类型 | 写入 | 读取 |
|---|---|---|---|
| `object` | 字符串 | `object_get_name` | `asset_get_index` |
| `x_pos` / `y_pos` | 数 | `x` / `y` | `x`、`y`、`x_draw`、`y_draw` |
| `door_x` / `door_y` | 数 | `door_x` / `door_y` | `door_x` / `door_y` |

出口门 `obj_door_exit_res` 等不保存（W:92 排除，又不在 PUERTAS 的写入条件里），由入口门的 `door_x/door_y` 推出（推断，**不确定**）。

计数分支：R1:221 写的是 `else if (object == 590)`，R2:236 对应位置写的是 `else if (object == obj_door_switch_res)`。所以 590 应是 `obj_door_switch_res` 的某种旧编号；`__global_object_depths.gml:1393` 的 `global.__objectNames[590] = "obj_door_switch_res"` 与之吻合，但 yyp 顺序里 590 是 `obj_bt_gb_close`。移植时按 `obj_door_switch_res` 翻译（结构证据充分，但仍属推断）。

## 4. 两个保存端的比较

`objects/obj_button_save_changes/Other_10.gml`（238 行，“保存修改”，覆盖已有文件）与 `objects/obj_button_notification_aceptar/Other_10.gml`（228 行，“另存为新关卡”）逐行 diff 结果：**JSON 结构同构**，第 1–214 行除 38–39 行外完全一致。差异：

| 行（save_changes / aceptar） | save_changes | aceptar |
|---|---|---|
| 38–39 / 38–39 | `etiqueta1/2` 取 `global.etiqueta1_temp/2_temp` | 取 `global.etiqueta1/2` |
| 215 / 215 | 写到 `global.directorio + global.save_changes` | 写到 `global.directorio + obj_input.new_texto + ".swe"` |
| 216 / 216–217 | `global.last_level = global.save_changes` | `global.save_changes = global.last_level = new_texto + ".swe"` |
| — / 219–220 | — | `global.etiqueta1_temp = global.etiqueta1`（及 2） |
| 221 / 224 | toast `scr_language(95)` | toast `scr_language(90)` |
| 224–236 / 227–228 | 通知 `obj_panel_save_load` 的 user event 0，复位 `obj_robot` | 销毁 `obj_window_alert` |

调用链：两者都由各自的 `Alarm_0` 调 `event_user(0)`（`obj_button_save_changes/Alarm_0.gml:11`，aceptar 的 `Alarm_0.gml` 同构），Alarm_0 由 `Mouse_4` 设置为 12 帧后（`obj_button_save_changes/Mouse_4.gml:13`；aceptar 的 `Mouse_4.gml` 在新文件名不存在时设置）。Alarm_0 在 `obj_arrow_lock` 可见时拒绝保存（`Alarm_0.gml:3-8`）。

附带发现：`obj_button_save_changes/Mouse_4.gml:9` 调 `file_delete(global.save_changes)`，传的是不带目录的文件名，与写入路径 `global.directorio + global.save_changes` 不同（原版疑似 bug，**不确定**其实际效果）。

## 5. 两个读取端的比较

`objects/obj_load_level/Other_10.gml`（245 行）：编辑器载入，由 `obj_levelmanager/Other_4.gml:1-2` 在 `room == rm_editor` 时创建 `obj_load_level`，其 `Other_4.gml:1-2`（Room Start）调 `event_user(0)`。
`objects/obj_load_guardabot/Other_11.gml`（426 行）：游玩载入，放在 `rm_guardabot_play`、`rm_title` 的房间实例里（`rooms/*/…yy` 中的 `obj_load_guardabot`），其 `Other_4.gml:4-7` 在 `global.nm_play == 0` 时调 `event_user(1)`，否则调 `event_user(4)`（`Other_14.gml` 是空文件）。

键的读取集合相同（除 R2 不读 `etiqueta1/2`），各列表的字段完全相同（除 TUBERIAS 的 `R`）。差异：

| 方面 | R1 obj_load_level | R2 obj_load_guardabot |
|---|---|---|
| 文件校验 | 无（`Other_10.gml:6-9`） | `mundos == 0`、无 `MAIN`、无 `AJUSTES`、空列表或无 `user` 时 `room_goto(rm_guardabot)`（`Other_11.gml:8-30`） |
| 作者校验 | 作者 ≠ `global.my1` 时拒绝（10-20） | 不拒绝，仅相同作者时记录 `save_changes/last_level`（32-36） |
| `cronometro` | → `obj_levelmanager.leveltime`（34-36） | → `global.timer`（46-48），并 `with (obj_levelmanager)` 调 user event 5、设 alarm[2]（49-59） |
| `water_level*` | → `obj_card_bout`，需该实例存在（57-64） | → 自身 `pos_y/pos_y_limit`（102-106） |
| `etiqueta1/2` | 读（65-66） | 不读 |
| 主题设置 | 读完设置后 `event_user(1)`、`event_user(2)`（90-91）：`Other_11` 背景+音乐，`Other_12` 编辑器卡片图标帧号 | `event_user(2)`（107）：`Other_12` 背景+音乐 |
| 门计数 | `object == 590`（221） | `object == obj_door_switch_res`（236） |
| 载入后 | `ds_map_destroy` + `instance_destroy`（227-228） | 相机锁、`scr_edit_to_play()`、按画风换 `obj_marioU`、检查点、自动卷轴、天气生成器、过关条件提示、背景滚动速度，再 `instance_destroy`（243-426） |
| 文件不存在 / 未指定 | `leveltime = 300`，`event_user(1)(2)`，销毁（230-246） | `room == rm_title` 时 `event_user(5)`（`Other_15.gml:1-3`：随机画风/场景/夜间，`entorno[irandom_range(0, 11)]` 不会选到下标 12 的 mountain）（422-426） |

第三个读取者：`objects/obj_gb_level/Create_0.gml:49-131` 在本地关卡列表里读预览信息（`user date time entorno modo_noche apariencia etiqueta1 etiqueta2 condiciones* description`）。

## 6. `global.directorio` / `global.directorio_temp` 的取值

| 平台 | 赋值 | 证据 |
|---|---|---|
| Windows（`os_type != os_android`） | `global.directorio_temp = working_directory + "Niveles\\"`；`global.directorio = working_directory + "Niveles\\"`；`global.directorio_temporal = working_directory + "temp\\"` | `objects/obj_persistent/Create_0.gml:135-140` |
| Android | `global.directorio_temp = getDire1("SMM_WE")`，`global.directorio = directorio_temp + "/"` | `objects/obj_persistent/Create_0.gml:129-134`；两个保存端开头重复一次（`obj_button_save_changes/Other_10.gml:6-10`） |

`getDire1` 是扩展 `folderPick` 的函数（`extensions/folderPick/folderPick.yy:25-27`），只用于 Android，不移植。Windows 端保存前若目录不存在则 `directory_create`（`obj_button_save_changes/Other_10.gml:1-5`）。
清单 §6.7 说 `global.directorio` 由 `directorio_temp + "/"` 赋值（`Create_0.gml:132`），那只是 Android 分支；Windows 分支两者都直接等于 `working_directory + "Niveles\\"`。

**不确定**：GMS 在 Windows 上 `working_directory` 读写的实际目录（安装目录还是 `%LOCALAPPDATA%\<游戏名>\` 沙盒）取决于运行时与打包方式，仓库内无法确认；移植时用户关卡目录的位置需要你定。

## 附：用原版 3.5.1 样本核对的结果（2026-11-10）

样本：`docs/samples/3.5.1level1.swe`（用户用社区下载的 SMMWE V3.5.1 保存，13577 字节）。

- 文件结构与本文一致：base64(JSON) + 40 位十六进制 + 1 个结尾 `\0`。
- HMAC 是 **小写** 十六进制。用源码里的密钥 `2559F35097-2021` 对 base64 串算 HMAC-SHA1，与文件末尾的 40 位完全相同。所以 3.5.1 的密钥和算法与这份源码一致，§1 的“大小写不确定”已解决。
- JSON 顶层键是 `S0`、`SB1`；`S0` 下是 `S1`–`S8`。整数值不带小数点（`"xx":704`），非整数按 17 位有效数字输出（样本里出现了 `0.20000000000000001`）。写关卡时要照这个数字格式输出，原版才认。
- Windows 上原版的关卡目录是 `%LOCALAPPDATA%\SMM_WE\Niveles\`（GMS 的 `working_directory` 在 Windows 上是可写的存档目录，不是 exe 所在目录）。同目录上一级还有 `Settings351.dat`、`dsm_351.dat`。
- 样本里没有传送带和斜坡，§“保存/读取不对称”那两条还没有样本可对。

## 附 2：3.5.1 键名 ↔ 源码键名对照（第 3 批，**推断，未经 3.5.1 源码确认**）

`original/` 的源码比 3.5.1 旧，读写的是 §2–§3 的长键名；3.5.1 的文件用的是缩写键名，源码按原样会拒收（没有 `MAIN`）。移植版在 `GM.swe_load_json`（`port/gm/gm_system.gd` 的 `SWE_SECTIONS`/`SWE_KEYS`）里读入时翻回长键名，之后走 1:1 翻译的读取代码。对照表按名字和各段顺序推断：

| 3.5.1 | 源码 | | 3.5.1 | 源码 |
|---|---|---|---|---|
| `S0` / `SB1` | `MAIN` / `SUB1` | | `S1`…`S8` | `AJUSTES` `SUELO` `DECORACION` `NIVEL` `TUBERIAS` `CANNON` `PLATAFORMAS` `PUERTAS` |
| `xx` `yy` `ID` `i` `spr` | `x_pos` `y_pos` `object` `index` `sprite`（各段通用） | | | |

- AJUSTES：`label_1/2`→`etiqueta1/2`，`gamestyle`→`apariencia`，`gametheme`→`entorno`，`timer`→`cronometro`，`autoscroll`→`autoavance`，`nightmode`→`modo_noche`，`start_y`→`ground2`，`goal_x/goal_y`→`ground3_x/ground3_y`，`wl`/`wl_limit`/`wl_speed`→`water_level`/`_limit`/`_speed`，`conditions`→`condiciones`，`t_/o_/c_conditions`→`condiciones_type/_object/_count`，`mtrs`→`meteorites`，`desc`→`description`；`user` `size` `date` `time` `ds_s` 不变。
- NIVEL：`progress`→`progresivo`，`rot`→`rotacion`，`dir`→`direct_t`，`parachute`→`paracaidas`，`w_mode`→`modo_water`，`scl`→`s_scaley`；`sprout` `wings` `key` `inup` 不变。
- TUBERIAS：`sz`→`size`，`rot`→`rotacion`，`dir`→`direct_t`，`sclx`→`scalex`，`clr`→`color`，`msk`→`mask`，`xscl/yscl`→`xscale/yscale`，`wrp`→`warp`，`t_sz` `t_rot` `t_dir` `t_s_sclx` `t_clr` `t_xscl` `t_yscl`→对应的 `t_*` 长名；`t_x_pos` `t_y_pos` 不变。
- PLATAFORMAS：`clr`→`color`，`dph`→`depth`，`wth/hht`→`width/height`，`dir`→`direct_t`。PUERTAS：`dr_x/dr_y`→`door_x/door_y`。
- CANNON：样本里是空的，除通用键外没有对照（`direct`、`down/up/left/right` 的缩写未知）。
- 源码里没有、读入后被忽略的 3.5.1 字段：AJUSTES 的 `t`；NIVEL 的 `air` `pinkcoin` `fire` `claw` `rock` `energy` `sierra` `bumper` `ice` `can_complement`；PLATAFORMAS 的 `air` `pinkcoin` `fire` `key` `rock` `energy` `parachute` `ice`。这些对应 3.5.1 比源码多出来的功能，移植版不支持。
- 写关卡（第 9 批，用户已定，2026-11-14）：使用仓库源码长键名（`MAIN`、`AJUSTES`、`apariencia` 等），继续兼容读取 3.5.1 缩写文件；不承诺保存结果可被 3.5.1 exe 打开。保存仍走原版两个事件的八个列表、base64、HMAC-SHA1 和结尾空字节；测试覆盖各列表的记录及保存后自动重载。
