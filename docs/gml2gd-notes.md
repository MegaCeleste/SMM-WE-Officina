# gml2gd.py 说明（port-plan §7 的 1b）

> 2026-11-10，Opus 子代理编写。脚本：`tools/gml2gd.py`。规则依据：`docs/port-plan.md` §3.2、§3.3。
> 草稿只写到 `port/_draft/`（已加进 `.gitignore`，目录里放了空的 `.gdignore`，Godot 不扫描）。草稿要逐个核对、处理完全部 `# TODO-GML:` 后才能移到 `port/objects/`、`port/scripts/`。

## 1. 用法

一律用 `tools/.venv/Scripts/python.exe` 运行（不要用裸 `python`）。

```
tools/.venv/Scripts/python.exe tools/gml2gd.py object obj_koopa [obj_xxx …] [--chain]
tools/.venv/Scripts/python.exe tools/gml2gd.py script scr_xxx [scr_yyy …]
tools/.venv/Scripts/python.exe tools/gml2gd.py stats
```

- `object`：读 `original/openwe-ref/objects/<名>/*.gml` 的全部事件，输出 `port/_draft/objects/<名>.gd`。`--chain` 会把父类链上的 object 一起转出来（父类在前）。
- `script`：输出 `port/_draft/scripts/<名>.gd`。
- `stats`：把 811 个 object 和 294 个脚本全部转一遍，不写文件，打印统计。

每次运行都要预扫描全工程（约 9 秒），因为实例变量的类型要看子类，判断“兼容层没有的内置常量”要看全工程有没有人把同名标识符当实例变量赋值过。

## 2. 实现结构

1. **词法分析** `lex()`：数字（`$FF`、`0x`、`.5`）、字符串（`"…"` 带 GMS2 转义、`@"…"`、`'…'`）、标识符、运算符（含 `[| [? [# [@ [$`）、`//` 与 `/* */` 注释（保留下来）、`#region/#endregion`（变注释）、`#macro`（独立的记号）。每个记号记下“前面是否换行”，用来判断没有分号的语句在哪里结束。
2. **语法分析** `Parser`：递归下降。语句：块、`if/else`（可带 `then`）、`while`、`do…until`、`for(;;)`（容忍 `for (…; i++;)` 这种多一个分号的写法）、`repeat`、`switch/case/default`、`with`、`return`、`exit`、`break`、`continue`、`var a, b = 1`、`globalvar`、`enum`、`function`、`#macro`、赋值（`= += -= *= /= %= &= |= ^= <<= >>=`）、调用、`++/--`。表达式按 GML 优先级：`?:`、`??`、`|| or`、`^^ xor`、`&& and`、`| ^ &`、`== != <> =`（表达式里的单个 `=` 一律是比较）、`< <= > >=`、`<< >>`、`+ -`、`* / div % mod`、一元 `! not - ~ +`、前后缀 `++ --`、`.成员`、`[i]`、`[i, j]`、访问器、调用、数组字面量。后缀的 `(`、`[`、`++` 不跨行连接（反编译代码里不跨行，这样“上一行末尾的标识符 + 下一行的 `(…)`”不会被误认成调用）。
3. **全工程预扫描** `Proj`：
   - 资源名取自 `port/gm/a.gd` 的全部 `const`；脚本函数名取自全部脚本里的 `function 名(`；宏、枚举取自全工程的 `#macro`、`enum`；global 变量名和大致类型取自 `port/tables/globals.json`。
   - 兼容层 API **自动扫描** `port/gm/gm_object.gd`（实例方法、内置变量）和 `gm.gd ← gm_input ← gm_audio ← gm_draw ← gm_base`（`GM.` 下的函数、变量、常量），带形参名、形参类型、默认值、返回类型。没有手写函数表。
   - 每个 object 的每个事件：哪些实例变量被赋值（及右值的粗略类型）、哪些在 Create 里赋值、哪些只读；被当成实例用过的名字（取成员、`with` 目标）。
4. **发射** `Emitter`：一个事件一个方法；表达式发射时同时推出静态类型（num/int/bool/str/inst/arr/void/unk），用于决定字面量写法、条件写法和要不要标 TODO。

## 3. 已实现的规则

### 3.1 文件与声明

- 文件头：`extends "res://objects/<父类>.gd"`（父类取自 `objects.json`），没有父类写 `extends GMObject`。不写 `class_name`。
- 事件 → 方法名按 port-plan §3.2：`Create_0→_create`、`Destroy_0→_destroy`、`CleanUp_0→_cleanup`、`Step_1/0/2→_step_begin/_step/_step_end`、`Alarm_n→_alarm_n`、`Other_10…25→_user_0…15`、`Other_0→_outside_room`、`Other_2/3→_game_start/_game_end`、`Other_4/5→_room_start/_room_end`、`Other_7→_animation_end`、`Other_8→_path_end`、`Other_40→_outside_view_0`、`Draw_0→_gm_draw`、`Draw_64→_gm_draw_gui`、`Mouse_n→_mouse_n`、`KeyPress_n→_keypress_n`、`Collision_objX→_collision_objX(other: GMObject)`。事件方法都写 `-> void`。异步事件（`Other_60/63/70` 等）输出 `_async_NN()`，整个事件体原样注释掉并写 `pass  # TODO-GML: 异步事件`。表外的事件输出 `_<类型>_<n>()` 并标 `未知事件`（全工程目前没有）。
- 方法顺序：Create、Destroy、CleanUp、Step（begin/normal/end）、Alarm、Collision、Other、Draw、Mouse、KeyPress。每个方法上一行是来源注释 `# from objects/obj_koopa/Step_0.gml`。
- **实例变量声明**：收集本 object 全部事件里赋值过的、不是局部、不是内置、不是 global 的名字，按首次出现顺序声明：
  - 在 Create 里赋值过、且本 object 的赋值全是数值（字面量或数值表达式）、且本 object 及所有子类的赋值里没有字符串/实例/noone/数组、且这个名字在全工程从没被当成实例用过 → `var foo: float = 0.0`；
  - 同样条件但全是字符串 → `var foo: String = ""`；
  - 其余（不确定、只在别的事件里赋值、赋过 `-4`/`noone`、当实例用过）→ `var foo = null`。
  - **父类链上已声明的不再声明**（先对父类链做同样的收集）。
  - 赋值来自别的 object 时也算：`with (obj_x) { foo = … }`、`with (instance_create(…, obj_x)) { foo = … }`、碰撞事件里的 `other.foo = …`（`other` 是碰撞目标）和 `with (other)`、`obj_x.foo = …`，都给 obj_x 声明 `foo`（否则 obj_x 的实例在 GDScript 里没有这个成员，运行时报错）。例：`obj_enemyparent/Create_0.gml` 用 `with (obj_enemyparent)` 给所有敌人设 `hardness`、`stomp`…，这些变量现在声明在 obj_enemyparent。
  - 只读不写、父类链也没声明的名字：如果是资源/脚本/内置就按规则处理；否则仍声明成 `var foo = null` 并标 TODO：`仅子类赋值(foo)`（子类里才赋值）、`疑似缺失资源(spr_xxx)`（像资源名但 a.gd 里没有）、`内置实例变量缺失(path_position)`（GML 内置但 GMObject 没有）、`未声明标识符(foo)`。
  - 和 Node/Object 成员（`name`、`ready`、`get`…，清单是从 Godot 4.7.2 的 ClassDB 导出的）、GDScript 关键字/类型名（`int`…）、生成代码用到的名字（`GM`、`A`、`G`、`Scr`、`GMObject`…）撞名的实例变量改名加 `_v`（声明行标 `改名(ready)`；所有引用处包括 `other.ready` 一起改）。局部变量只在撞关键字时改名。

### 3.2 名字

| GML | 输出 |
|---|---|
| 局部变量（`var`） | 原名。GML 的 `var` 是函数作用域，GDScript 是块作用域：在内层块里声明、却在块外用到的（或在两个兄弟块里各声明一次的），在函数开头提升成 `var 名`（注释“局部变量提升”），原处改成赋值；同一作用域里重复的 `var` 改成赋值 |
| GMObject 的内置变量（`x`、`hspeed`、`alarm`…） | 原名（`with` 里加 `inst.`） |
| 资源名（object/sprite/sound/room/path/shader） | `A.<名>` |
| `global.x` | `G.x` |
| GM 的常量（`c_white`、`vk_left`、`fa_center`…）、GML 内置全局变量且 GM 里有（`room`、`room_width`、`current_time`、`mouse_x`、`keyboard_string`、`view_enabled`…） | `GM.<名>`（`room_speed` 也是 `GM.room_speed`） |
| GML 内置全局变量/常量但 GM 里没有（`os_type`、`application_surface`、`bm_normal`…） | `GM.get(&"<名>")` + `兼容层没有变量(<名>)`；被赋值时整条注释掉 |
| `self`、`id` | `self`（`with` 里是 `inst`） |
| `other` | 碰撞事件里是参数 `other`；`with` 块里是外层的 `self`（嵌套时是外层的 `inst`）；其余位置 `GM.get(&"other")` + `other来源不定` |
| `noone` / `all` | `GM.noone` / `GM.all`（见 §4） |
| `true/false/undefined/pi/infinity/NaN` | `true/false/null/PI/INF/NAN` |
| 宏 | `Scr.<名>`（占位，见 §4） |
| 枚举 `e__VW.XView` | `Scr.e__VW.XView`（占位） |
| `argument0…15`、`argument[n]`、`argument_count` | 脚本里是形参（见 §3.6）；object 事件里整条注释掉，标 `argument` |
| 实例变量 | 原名（`with` 里 `inst.`，脚本里 `me.`） |

### 3.3 表达式

- 数字：默认写成浮点（`2` → `2.0`）。保持整数的地方：数组下标、`alarm[n]` 的 n、`event_user(n)` 的 n、`repeat` 次数、传给兼容层 `int` 形参的字面量、和 int 类型的东西（`A.` 资源编号、`sprite_index`、`object_index` 等）做运算/比较/赋值的字面量、match 的分支（subject 是 int 时）。十六进制 `$FF` → `0xFF`（int）。
- 兼容层 `bool` 形参（`prec`、`notme`、`outline`…，从签名自动得知）：实参是 0/1 字面量 → `false/true`；是 bool 表达式 → 原样；是数值 → 原样 + `bool实参`。给 bool 内置变量（`visible`、`persistent`）赋 0/1 → `false/true`。bool 和 0/1 字面量比较（`visible == 1`）→ `visible == true`；bool 和别的数比较或参与算术（`0.1 * keyboard_check(k)`）→ `float(…)` 包起来（GML 的布尔就是 0/1，语义不变；不这样写是编译错误）。
- 兼容层函数形参名是 `me` 而 GML 没传的（`instance_deactivate_all(notme)`）自动补 `self`（port-plan §3.2 末段）。实参个数和签名对不上的整条注释掉，标 `参数个数(函数名)`。
- 运算符：`&& and` → `and`，`|| or` → `or`，`! not` → `not`，`^^` → 两边条件的 `!=`，`<>` → `!=`，`div` → `GM.gm_div(a, b)`，`mod`/`%` → `GM.gm_mod(a, b)`，`%=` → `a = GM.gm_mod(a, b)`，三元 → `b if c else d`。位运算 `& | ^ << >> ~`（及 `&=` 等）→ `int(a) & int(b)` 并标 `位运算`（GML 转整数的取整方式没核实）。输出时按 GDScript 的优先级补括号（GDScript 的比较运算比位运算松，和 C 不同），原代码里的括号保留；`if/while/with/match` 头部最外层的括号去掉。
- 数学函数：`round→GM.gm_round`、`sign→GM.gm_sign`、`string→GM.string`、`abs/floor/ceil/sqrt/sin/cos/clamp/lerp/power → absf/floorf/ceilf/sqrt/sin/cos/clampf/lerpf/pow`，`min/max` → `minf/maxf`，多于 2 个参数时嵌套。
- 其余内置函数：GMObject 的实例方法（`collision_*`、`place_meeting`、`instance_place`、`position_meeting`、`instance_position`、`motion_*`、`move_*`、`draw_self`、`event_user`、无参的 `instance_destroy()`）原样调用，`with` 里加 `inst.`，脚本里加 `me.`；`GM` 里有的 → `GM.<名>(…)`（带参数的 `instance_destroy(other)` 也是 `GM.instance_destroy(other)`）；都没有的 → `GM.call(&"<名>", …)` + `兼容层没有函数(<名>)`（这样能编译，名字也保留着）。
- 脚本函数调用 → `Scr.<名>(self, 参数…)`（`with` 里第一个参数是 `inst`，脚本里是 `me`）。把脚本名当值用（`sprite_index != scr_xxx`）整条注释掉，标 `脚本引用`。
- `==`/`!=` 一边是带非零小数部分的常量（`hspeed == 0.3`）→ `GM.eq(a, b)` / `not GM.eq(a, b)`（§3.3 第 6a 条）。
- 和 `noone` 比较：另一边静态类型是实例（返回 GMObject 的函数、全部赋值都来自这类函数的局部变量）→ `== null` / `!= null`（GDScript 里 `GMObject == int` 是编译错误）；否则 `== GM.noone`。实例和字面量 `-4` 比较同样写 `null`。实例和数值变量比较 → 整条注释掉，标 `实例与数值比较`。
- 条件位置（`if/while/until/for` 条件、`&& || !` 的操作数、三元条件）：比较、逻辑、返回 bool 的函数原样；静态类型是实例的 → `(…) != null`，`!` 实例 → `== null`；其余（裸变量、数值表达式）保留原样并标 `真值判断`。局部变量的静态类型：所有赋值都来自返回 GMObject 的函数时算实例（`var solid_dead = collision_rectangle(…)` 之后的 `if (solid_dead and …)` 写成 `solid_dead != null and …`）。
- 访问其他实例的成员：`other.foo`、`inst.foo`、`self.foo` 原样输出（GDScript 对 GMObject 上不存在的成员只给 unsafe 警告，不报错）。`obj_x.foo` 读取 → `GM.instance_find(A.obj_x, 0).foo` + `obj.var访问`；写入整条注释掉（GML 的 `obj_x.foo = v` 是给全部实例赋值）。在数值/字符串上取成员（原版的 `object_index.wings`）整条注释掉，标 `非实例取成员`。
- 下标：`a[i]` → `a[i]`，`a[i, j]` → `a[i][j]`，`list[| i]` → `list[i]`，`map[? k]` 读 → `map.get(k)`、写 → `map[k] = v`，`[#`、`[$` 整条注释掉。给非内置数组的元素赋值标 `数组写入`（GML 数组会自动扩展、未赋值的变量也会自动变成数组，GDScript 不会）。浮点下标在 Godot 4.7.2 运行时可用（已实测）。
- 表达式内的 `++/--`、结构体字面量、`??`、动态调用（调用变量、`script_execute`）整条注释掉。返回 void 的兼容层函数的返回值被使用时整条注释掉，标 `void返回值`。

### 3.4 语句

- `++/--` 作语句 → `+= 1.0`（目标是 int 时 `+= 1`）。`exit` → `return`。事件里的 `return 值` → `return` + `事件返回值`。
- `var a = 1, b` → 逐个 `var`。
- `if / else if` → `if / elif / else`。
- `while` 原样；`do … until c` → `while true:` … `if c: break`（体内有属于它的 `continue` 时标 `do-until含continue`，因为 continue 会跳过条件判断）。
- `for (init; cond; step)` → `init` + `while cond:` … `step`；体内属于这个 for 的 `continue` 前面自动补一份 `step`，所以增量语句仍会执行。
- `repeat (n)` → `for _rep in range(n):`（嵌套时 `_rep2`…）；n 不是整数字面量时写 `range(int(n))` 并标 `repeat计数`。
- `with (X)` → `for inst in GM.with_list(X):`，嵌套 `inst2`、`inst3`；`inst` 与本函数局部变量或本类实例变量撞名时前面加 `_`。
- `switch` → `match`：连续的空 case 合并成 `a, b:`；case 体末尾的 `break` 去掉；以 `return/exit/continue` 结尾的不算贯穿；非空且不以这些结尾的贯穿 → 整个 switch 注释掉，标 `switch贯穿`；case 体里（不在内层循环中）还有别的 `break` → 整个 switch 注释掉，标 `switch内break`（GDScript 的 match 里 `break` 是跳出外层循环）。`default` 挪到最后写 `_:`。分支：数字字面量按 subject 的类型写成 `0.0` 或 `0`；字符串；`A.`、`Scr.` 宏、`GM.` 常量、`Scr.枚举.成员`。**GDScript 的 match 区分 int 和 float**（已实测：`match 1.0` 不匹配分支 `1`），所以 subject 类型不确定（未声明类型的变量、脚本参数）或和分支类型不一致时标 `match类型`。
- `event_inherited()` → `super._xxx()`（碰撞事件 `super._collision_objX(other)`）；父类链上没有这个事件时删掉，留注释 `# event_inherited(): 父类无此事件`。`event_user(n)`：n 是整数字面量且本类或父类链有 `_user_n` → `_user_n()`；否则 `event_user(n)`（GMObject 的方法，会查子类）；`with` 里 `inst.event_user(n)`；n 不是字面量 → `event_user(int(n))`。`event_perform_object` 整条注释掉。
- `#macro`（object 里）→ 注释；`enum`、嵌套 `function`、`globalvar` 在 object 里整条注释掉。
- 注释：自成一行的注释原位输出，行尾注释接在对应语句行尾，`#region` 变成注释。整条注释掉的语句输出成若干 `# GML: 原文` 行 + `pass  # TODO-GML: 原因`（必须有 `pass`，否则可能留下空块）。

### 3.5 脚本

- 一个脚本文件一个 `.gd`，`extends RefCounted`；每个 `function f(a, b)` → `static func f(me: GMObject, a = null, b = null):`（有默认值的照写）。函数体里隐含 self 的实例变量、内置变量、实例方法都加 `me.`，`self` → `me`，脚本里读写实例变量标 `脚本内实例变量`（这些变量必须在调用者的类里存在）。
- 不声明形参却用 `argument0…` 的（GMS2.3 允许，如 `scr_language`）自动补成可选形参。用了 `argument[n]` 或 `argument_count` 的 → `(me: GMObject, ...argument: Array)`，具名形参在函数开头用 `argument[i]` 取出。
- `#macro` → 文件顶部 `const 名 = 值`（数字写成浮点，见 §4）；`enum` → 文件顶部 `enum`。函数外的顶层语句放进 `static func _toplevel(me)` 并标 `脚本顶层代码`（目前没有）。

## 4. 占位约定（还没定，主会话决定后改脚本即可）

> 第 2 批已定：`Scr.` 和 `G.` 不再是占位，组织方式见 port-plan §2、§3.3 第 11–14 条（`port/scripts/scr.gd` 门面 + 每个脚本一个文件；`port/globals/g.gd`）。`noone` 和 `obj_x.foo` 写入仍未定。

- **`Scr.<名>(self, …)`**：脚本调用。port-plan §2 说脚本“按原文件夹归到若干 .gd”，但没定类名和组织方式，所以先统一写成 `Scr.` 前缀、第一个参数传调用者实例。宏写成 `Scr.<宏名>`、枚举写成 `Scr.<枚举>.<成员>`，也都是占位。宏的数字值输出成浮点常量（`const cs_big = 1.0`），因为它们主要和 float 的 global 比较、做 match 分支；如果要当数组下标用需要 `int()`。
- **`G.x`**：global 变量（port-plan §3.1）。match 分支按 G 的变量是 float 来写（globals.json 里 number 类型的），G 的实际声明类型和这里不一致时 match 会静默不匹配。
- **`GM.noone`**：`noone` 一律写 `GM.noone`（int -4），不标 TODO。只有“另一边静态上就是 GMObject”时写 `null`（不这样写编译不过）。注意：兼容层里“没有实例”是 `null`，所以 `var c = collision_rectangle(…)` 存进**未声明类型**的变量后再写 `c != GM.noone`，运行时 `null != -4` 为真，语义反了；实例变量里赋值的 `-4`（如 `mebelow = -4`）也照原样输出成 `-4.0`。复核时要逐个处理。
- **`GM.get(&"other")`**：不在碰撞事件、也不在 with 里的 `other`（主要是 user event 里，被碰撞事件或 `with` 调用时由调用方决定）。兼容层没有“当前 other”的概念，这样写能编译、运行时为 null。
- **`GM.get(&"名")` / `GM.call(&"名", …)`**：兼容层没有的内置变量/函数，保留原名，能编译。

## 5. 统计结果（`gml2gd.py stats`，2026-11-10）

- 输入：811 个 object（全部事件）+ 294 个脚本。
- 输出总行数：**128547**；带 `# TODO-GML:` 的行：**6772（5.27%）**；其中整条注释掉的语句留下的 `# GML:` 原文行 4960 行（不计入 TODO 行数，每条只有一行 `pass  # TODO-GML:`）。
- 解析失败：**0**（第一次跑时 `objects/obj_floruga/Create_0.gml:79` 的 `for (i=1; i<=amount_previous; i++;)` 失败，已支持）。转换器异常：0。

TODO 类别（一行里同一类只计一次；全部 25 类）：

| 次数 | 类别 | 说明 |
|---:|---|---|
| 3768 | obj.var访问 | `obj_x.foo` 读（写入整条注释掉） |
| 1111 | 兼容层没有函数 | 见下表 |
| 543 | 真值判断 | 条件是裸变量/数值 |
| 453 | other来源不定 | user event 等里的 `other` |
| 314 | 数组写入 | 非内置数组元素赋值 |
| 180 | 位运算 | |
| 134 | 兼容层没有变量 | `os_type`、`application_surface`、`current_day`… |
| 120 | 脚本内实例变量 | 脚本读写调用者的实例变量 |
| 108 | match类型 | match 的 subject/分支类型不确定或不一致 |
| 86 | 改名 | `ready`→`ready_v`（77）、`get`→`get_v`（6）、`int`→`int_v` |
| 60 | switch内break | |
| 49 | switch贯穿 | |
| 31 | 疑似缺失资源 | 代码里引用、但 yyp 里没有的资源名（如 `obj_superado_bg`、`spr_SMB2_*`） |
| 15 | 未声明标识符 | |
| 9 | 异步事件 | |
| 8 | 嵌套函数 | object 事件里的 `function` |
| 6 | 仅子类赋值 | 父类读、子类才赋值的变量 |
| 6 | void返回值 | `__view_set_internal` 里 `__res = view_set_*(…)` |
| 5 | 内置实例变量缺失 | `path_*` 等 |
| 3 | 非实例取成员 | 原版 `object_index.wings` |
| 2 | repeat计数 | |
| 1 | 字符串与数字比较 | |
| 1 | event_perform | `obj_bossparent/Step_0.gml` |
| 1 | switch非常量case | |
| 1 | 脚本引用 | |

兼容层没有的函数（前 20，按出现次数）：`ds_map_find_value` 219、`ds_map_add` 176、`ds_list_size` 34、`file_text_read_string` 29、`file_text_readln` 29、`file_text_write_string` 29、`file_text_writeln` 29、`ds_map_create` 23、`shader_set` 22、`shader_reset` 22、`ds_list_create` 20、`ds_list_find_value` 19、`virtual_key_add` 18、`ds_map_add_list` 18、`ds_list_add` 17、`ds_list_mark_as_map` 16、`ds_map_exists` 12、`virtual_key_delete` 9、`layer_background_get_sprite` 9、`base64_encode` 9。其后是 surface、粒子、buffer、path、`get_string_async`、`array_length_1d`、`is_undefined` 等，大多属于第 7/9/11 批的范围。

## 6. 验收记录

1. **能否编译**：`gml2gd.py object obj_galoomba obj_koopa obj_blockparent --chain` 转出 9 个文件（`obj_deactivation → obj_physicsparent → obj_enemyparent → obj_deactenemyparent → obj_koopa/obj_galoomba`，`obj_solidtop → obj_solid → obj_blockparent`），复制到临时的 `port/_draft_check/objects/`，`extends` 路径改成 `res://_draft_check/objects/…`，另放 `class_name G`、`class_name Scr` 的桩（只含用到的 7 个 global、9 个脚本函数，不带类型），用一个场景逐个 `load()`：9 个全部编译通过，日志里没有任何 `SCRIPT ERROR`。（注意：`load()` 在编译失败时也可能返回非空，判断要看日志。）
   - 额外做了一次全量检查：811 个 object + 294 个脚本的草稿全部放进去 `load()`。修完下面列的问题后，除 `_outside_room` 撞名（见 §7 第 1 条，检查时临时改名绕开）外，**1105 个文件全部无编译错误**。全量检查中发现并已修掉的编译错误类别：`bool == float`（`visible == 1`）、`float * bool`（`0.1 * keyboard_check(…)`）、`Cannot find member "x" in base "float"`（被当实例用的变量被声明成 float：`returndoor`、`obj`）、`String > float`、`int != Callable`（脚本名当值用）、`Identifier "argument0" not declared`（不声明形参直接用 argument0 的脚本）、`Cannot get return value of call … returns void`。
   - 验完已删除 `port/_draft_check/`，并重新 `--import` 刷新了类缓存；`git status` 里 `port/` 下没有残留，`port/project.godot` 没有改动。
2. **人工逐行核对**（`obj_galoomba/Step_0.gml`、`obj_galoomba/Other_11.gml`、`obj_koopa/Step_0.gml`）发现并已修掉的转换错误：`if/with/match` 头部多了一层括号（`GM.with_list((…))`）；`imheld.alarm[5] = 120` 被误标“数组写入”；`instance_destroy(other)` 被当成参数个数不对（应走 `GM.instance_destroy`）；`with (obj_enemyparent) { hardness = 0 … }` 赋的变量没有声明在目标 object 上（兄弟类会在运行时报 “Invalid set”）；`var solid_dead = collision_rectangle(…)` 之后的 `if (solid_dead and …)` 标了真值判断而不是写 `!= null`。核对后三个事件除下面几处外与手工翻译一致：
   - `obj_koopa/Step_0.gml`：`obj_lava_water.y`（4 处）→ `GM.instance_find(A.obj_lava_water, 0).y`，标 `obj.var访问`，需确认“第一个实例”的语义；`with (instance_create(…, obj_enemyparent_lava)) { direct = other.direct }` 里的 `direct` 现在由脚本声明在 `obj_enemyparent_lava` 上，转换 obj_enemyparent_lava 时要核对。
   - `obj_galoomba/Step_0.gml`：没有 TODO；`cambio_gombaya` 只在 Step/Alarm 里赋值，声明成 `var cambio_gombaya = null`，第一次读到时是 null（GML 里读未赋值变量本身就报错，行为一致）。
   - `obj_galoomba/Other_11.gml`：没有 TODO；`with (instance_create(…, obj_galoomba_hold)) { key = other.key … }` 同上，`key`、`direct` 要在 obj_galoomba_hold 侧核对。
   - 三个 object 里共同的待复核点：`mebelow = -4` 输出成 `-4.0`（noone 的数值写法）；user event 里的 `other`（`GM.get(&"other")`）；`match G.apariencia` 依赖 G 把 `apariencia` 声明成 float。
3. **工程没被弄坏**：`Godot --headless --path port res://tests/test_main.tscn` → `tests: 221 checks, 0 failed`，退出码 0。

## 7. 需要主会话决定

1. **`_outside_room` 撞名**：`GMObject` 有内部变量 `var _outside_room: bool`（`gm_object.gd:40`），而 §3.2 规定 Outside Room 事件的方法名也是 `_outside_room()`。子类定义这个方法是编译错误（`Member "_outside_room" is not a function`），影响 7 个 object（`obj_fishbone`、`obj_thwomp_intro`、`obj_parent_resource`（及其 173 个 `_res` 子类）、`obj_decoracion_parent`、`obj_lava_lift`、`obj_coinchain`、`obj_shell_intro`）。需要改兼容层的变量名或改 §3.2 的方法名。脚本照 §3.2 输出。
2. **`event_user` 的写法**：§3.2 表里写 `event_user(n)` → `GM.event_user(self, n)`，但兼容层没有 `GM.event_user`，实际是 `GMObject.event_user(n)`（任务说明也按实例方法）。脚本按实例方法输出；§3.2 那句需要改。同理 §3.1 写 `instance_destroy()` → `GM.instance_destroy(self)`，脚本按任务说明输出无参的实例方法 `instance_destroy()`（两者等价）。
3. **`other` 的来源**：453 行 TODO。user event（如 `obj_enemyparent/Other_10.gml` 默认死亡脚本）读 `other`，它取决于调用方（碰撞事件、with）。兼容层需要一个“当前 other”（例如 GM 在派发碰撞事件和执行 with 时维护一个 `GM.other`），否则这些地方只能逐个手改。如果兼容层加了 `var other`，草稿里的 `GM.get(&"other")` 不用改就能工作。
4. **`obj_x.foo`（通过 object 名访问第一个实例）**：3768 行，是最大的 TODO 来源。如果确认语义是“第一个（创建最早的）活动实例”，可以去掉这条 TODO，读取直接写 `GM.instance_find(A.obj_x, 0).foo`；写入 `obj_x.foo = v` 是给全部实例赋值，可以机械地写成 `for inst in GM.with_list(A.obj_x): inst.foo = v`。目前写入是整条注释掉。
5. **`noone` 与 `null`**：兼容层“没有实例”是 `null`，GML 是 -4。存在未声明类型变量里的实例和 `GM.noone` 比较会得到错误结果（见 §4）。是否让转换脚本把“全工程只被赋过实例或 noone 的变量”统一用 `null`（`-4`/`noone` 赋值也写 `null`）？这需要定规则。
6. **数组自动扩展**（314 行）、**位运算的取整方式**（180 行）：要不要在兼容层提供辅助函数（如 `GM.array_set(arr, i, v)`）由脚本直接生成。
7. **ds_map / ds_list / 文件读写**：`ds_map_find_value`、`ds_map_add` 等 400 多处（关卡读写），兼容层没有。port-plan §3.1 说 ds_map/ds_list 对应 Dictionary/Array，但没定函数形式；定了以后脚本可以直接映射。
8. **match 的类型严格**：GDScript 的 match 区分 int/float。G 变量的实际声明类型、宏常量用 int 还是 float，会决定 108 处 `match类型` 能否去掉。
9. 第一次在 Create 里赋数值、但在别处可能存别的类型的实例变量会被声明成 `float`；如果别的 object 通过未知目标（`with (变量)`）给它赋实例或字符串，运行时会报错。这种情况脚本查不到。

## 8. 已知局限

- 预扫描是“名字级”的：不知道 `with (变量)`、`变量.foo = …` 的目标是哪个 object，这些赋值不会触发目标 object 的声明。
- 类型推断很粗：未声明类型的变量、脚本参数、`other.foo` 都是“不确定”，条件里的真值判断只对“返回 GMObject 的函数”和这类局部变量自动处理。
- 原代码里的注释保留，但位置按行号近似（复合语句头部行尾的注释接在头部行尾；`}` 后面的注释挪到下一条语句前）。
- 被整条注释掉的语句内部如果有注释，只保留在 `# GML:` 原文里。
- 没有实现：`event_perform_object`（1 处）、`??`、结构体、`new`、`try`、`delete`（全工程实际代码里基本没有）、`#` 开头的颜色字面量。
- 脚本的 `static func` 里 `me` 写成 `GMObject` 类型；如果有脚本在没有实例的上下文里调用（`Scr.f(null, …)`），读 `me.xxx` 会在运行时出错。
- 草稿的 `extends "res://objects/<父类>.gd"` 要求父类先移入 `port/objects/`，所以要沿继承树自上而下移入（port-plan §7）。
