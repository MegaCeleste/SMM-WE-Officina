# 第 9 批：编辑器

## 范围

核对 295 个 object，其中新增 289 个、复核前批已有的 6 个；共 1421 个事件方法。新增 30 个脚本文件，并重生成 `port/scripts/scr.gd`。包括编辑器控制器与光标、全部编辑器资源及音效资源、46 个编辑器音效相关对象、62 个 UI/Editor 对象（保存按钮和试玩切换控制器另由主会话处理）、保存对话框和依赖父类。

补齐原版资源事件创建的 `obj_modelsizable`、玩家轨迹 `obj_player_trail`、编辑器菜单关闭按钮。菜单里的设置、个人资料和房间间的完整菜单流程仍属于后续批次；第 9 批的独立试玩入口是 `tests/play_editor.tscn`。

三个 Terra 子代理按复杂资源、简单资源与音效、编辑器 UI 分组核对。子代理用量耗尽后，主会话接手剩余的水管、太阳、可伸缩平台与桥，以及简单资源尾组，并做集成、源码抽查和验证。子代理对三个主控制器作了部分独立交叉审查；没有把未完成的交叉审查当成完整独立审查。

## 已定的行为

- 用户决定使用源码长键名保存；3.5.1 缩写键名继续只作读取兼容，不保证新文件可供 3.5.1 exe 使用。
- 用户决定：Room Start 内创建的新实例也收到本次 Room Start，接通 `obj_levelmanager → obj_load_level` 的载入链。兼容层只调整房间初始化的派发；tick 中各阶段的快照规则不变。见移植计划 U23，尚未对照 Windows 原版动态实测。
- `port/rooms/rm_editor.gd` 安装房间实例创建代码。来自 `.yy` 的初始视图设置在实例 Create 之前应用；包括 view 0 的初始 y=216，避免编辑器一开始只看到关卡上空、看不到地面和编辑器 Mario。

## 兼容层

- 固定字节缓冲区的本批所需子集：alignment=1，u8、UTF-8 text/string、seek-start、SHA1、保存和释放。`SaveStringToFile`、`sha1_string_utf8_hmac`、`hex_string_byte` 保持原脚本的计算步骤，HMAC 使用已知测试向量核对。
- `json_encode` 使用双精度完整精度输出；保留原保存端随后移除 `.000000` 的语句。base64、文件删除和视图 surface id 读写也已接入。
- `instance_change` 保留节点引用、创建序号及变量，更新 object 索引、祖先索引、事件表、sprite、mask、visible、persistent；不触发事件时不运行 Create/Destroy。用于 SMB2 蘑菇资源在其他画风下转为普通蘑菇资源。依据 [GameMaker-HTML5 的 instance_change_RELEASE](https://github.com/YoYoGames/GameMaker-HTML5/blob/develop/scripts/functions/Function_Instance.js) 与 [SetObjectIndex](https://github.com/YoYoGames/GameMaker-HTML5/blob/develop/scripts/yyInstance.js)，没有在 Windows runner 做最小实验。
- 动态折线路径 `path_add`、`path_add_point`，复用既有路径长度和插值实现。
- 派发阶段快照前复核实例是否仍有该事件，避免其他实例在本阶段调用 `instance_change` 后，旧快照调用新类型不存在的方法；新增实例的阶段边界规则保持原样。
- 无效 object 编号创建实例会明确报错并返回 null，避免 GDScript 的负数组下标把 noone 错当作某个真实对象。

## 验证入口

Godot 可执行文件仍使用移植计划指定的 4.7.2；`_console.exe` 是同目录的控制台版本，便于收集日志。测试期间 APPDATA/LOCALAPPDATA 重定向到工作区 scratch，未写入用户的实际游戏存档。

```powershell
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_editor.tscn -- 2
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_editor_resources.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --path port res://tests/play_editor.tscn -- 2
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --path port res://tests/shot_editor.tscn -- C:\Working\openwe\scratch\b9_shots_final
```

`test_editor` 使用真实 rm_editor、鼠标输入、试玩按钮、保存对话框和 Alarm 链，验证新建、摆放、试玩、返回、保存、覆盖、自动重载；各专用列表均放入实际对象，并检查源码字段。另验证 HMAC 向量、buffer 释放、动态路径及 instance_change 的引用、变量与索引。

`test_editor_resources` 对 171 种资源的四种画风各执行 Create、Step、Draw 冒烟检查，共 1368 项。它不验证动作与原版完全一致。`shot_editor` 使用真实 Vulkan 渲染，四种画风各保存编辑器、选材面板、保存对话框和六页资源预览，共 36 张；主会话查看截图。

旧 `test_items` 直接创建冰冻敌人时，现按原版 `obj_snowball/Collision_obj_enemyparent` 补上 `enemy/sprite/index`，避免未配置的 enemy=-4 落入错误的资源编号；游戏对象行为没有为迁就测试修改。

编辑器往返测试四种画风各 52 项全过，均正常退出 0，包含重载后的水管、炮台、半实心平台和门进入试玩再返回的转换。独立 Python 读取实际保存文件，复核结尾空字节、SHA1-HMAC、MAIN/SUB1、八个数据区和每条记录的源码键名；覆盖保存也保留屏外平台与门。编译检查加载的 970 个文件均无脚本编译错误，其中一个不属于本批范围的在线排行榜 scrollbar4 草稿随后移除，最终 objects/scripts 共 969 个文件，已逐名确认均在检查日志中。

最终 headless、编译检查和回归结果登记在移植计划进度表。已有的退出资源泄漏提示仍可能出现：编辑器测试前一轮曾报告 10 个 ObjectDB 实例、3 个资源未释放，最终一轮 SMW 报告 4 个实例、1 个资源；均无运行脚本错误。不能把正常退出码 0 当作完全没有退出诊断。第 3 批缺口 ④ 中的 view surface id 读写已补，其余矩阵变换与 timeline_running 等部分仍未补齐。

旧敌人整组回归四种画风各 518 个用例，共 2072 个用例、2500 项检查全部通过，无脚本错误。汇总后数分钟仍停留在退出清理，手动中止，未确认该整组进程的正常退出码；没有把手动中止记作退出 0。其余本批与旧回归均正常退出 0。最终 `--quit` 也退出 0，同时仍报告 4 个 ObjectDB 实例、2 个资源未释放。

## 保留的原文差异与边界

- 传送带会写进 NIVEL，但原读取端排除传送带；斜坡地面在 SUELO 中读回为普通 ground。继续照搬已记录的保存/读取不对称，没有自行修复。
- Rails 对象在 Create 开头销毁自己，后续语句仍执行；预览中不要求它出现可见精灵。
- 资源转换保留原文的卡片目标差异和字段拼写，例如大 Goomba/Thwomp 转换时的普通卡片目标、蛋的 `pararacidas`、Boomerang Bro 切冰兄弟时卡片仍指火兄弟。背景切换保留水下白天重复写 img_pinchos、漏写 img_cloud 的原文。
- 平台和炮台从资源事件得到的外写字段，门符号、属性窗口、卡片及玩家轨迹字段已核对声明。后续批次仍须按计划规则复核从空壳变为真实对象后的外写字段。
- 没有与 3.5.1 原版做动态试玩或互存文件对照；主菜单、设置、在线入口与最终特效依原计划留到后批。
