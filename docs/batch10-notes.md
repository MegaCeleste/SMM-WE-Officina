# 第 10 批：菜单与流程

9a 的流畅度和视觉验收仍单独未完成。

## 当前实现

- `obj_persistent` 使用 `user://settings.cfg` 的 Godot `ConfigFile` 保存和读取原版列出的设置字段，不读取 `Settings_new.dat`。缺失的字段沿用原版首次启动默认值；原版写 `name_user`、读 `name_users` 的不对称保留。写入错误会报警告。
- 游客入口、名称输入与确认、标题控制器和游玩／编辑入口、Game Over、片尾及返回按钮、暂停与恢复、设置面板及其语言、声音、角色、窗口、按键等控件已移植。`scr_language` 已在第 2 批移植。
- 本地关卡列表、关卡详情和游玩、编辑、删除、关闭按钮已移植。列表在关卡目录中枚举 `.swe` 文件；保留源码最多创建 99 个卡片的逻辑，界面按原版显示 `/90`。
- 补齐标题／关卡读入会用到的 `obj_bganimator`。真实渲染中从编辑器切至片尾曾发现相机保留已释放的跟随目标；`gm.gd` 现在在读取目标类型前检测失效实例。
- 原工程引用但没有资源的 `obj_bl`、`obj_skip_control` 和 `spr_settings_button_big_hover` 按既有缺失资源处理方式跳过。Android、在线登录及幕布特效仍按计划排除或留待后续；`obj_curtainin`、`obj_lighting` 仍是第 11 批空壳。

## 原版数量显示

用户提供的原版 **9/90** 和 **11/90** 截图显示：单数字与双数字使用不同的横向位置；用户也确认 3.5.1 可保存 90 个关卡。`obj_guardabot` 按数量作数值判断，分别使用源码中的 x=310 和 x=306；源码先转字符串再与数字比较，此处移植差异标 `# PORT`。之前围绕这处显示细节反复询问是不必要的，本批已按用户提供的画面实现。

## 验证与限制

Godot 运行时的 APPDATA/LOCALAPPDATA 均重定向至工作区 `scratch/`。`--headless --quit` 正常退出 0；全量 `check_load` 加载 1023 个 objects/scripts 文件，日志未发现脚本编译错误。专项：设置读写 24 项、设置界面 12 项、游客至标题／编辑器 14 项、暂停 7 项、片尾／Game Over 6 项、关卡详情 7 项通过；真实鼠标事件驱动的游客→标题→本地列表→选关→游玩→暂停离开→列表→标题及滚轮、刷新和删除流程 26 项通过；另验证隔离目录下 90 个文件创建 90 张卡片。回归：`test_main` 224、`test_boot` 57、`test_level` 32、`test_editor -- 2` 52 项通过。部分进程退出时仍有既有 ObjectDB／资源未释放诊断，不能把退出码 0 解释为没有诊断。

`tests/shot_batch10.tscn` 使用真实 OpenGL 渲染器输出标题、标题菜单、编辑器设置面板和片尾截图。初次从编辑器进片尾时出现已释放相机目标错误；修复后重新运行，四张截图均输出且日志无该脚本错误，主会话看过标题、设置、片尾。`tests/shot_guardabot.tscn` 输出 9、11 张卡片与滚动后画面，主会话对照用户的原版截图检查三列排布及数量位置。没有对原版完整流程逐帧对照，也没有穷举所有设置分支。

独立入口：

```powershell
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_guest.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_settings_ui.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_pause.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_gb_detail.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_batch10_flow.tscn
& 'C:\!application\tools\Godot\Godot_v4.7.2-stable_win64_console.exe' --headless --path port res://tests/test_guardabot_capacity.tscn
```

运行写入设置和关卡的测试前必须重定向用户目录到空的测试目录；测试会拒绝覆盖已有的同名文件。在线登录和在线关卡仍按计划不移植；幕布转场、`obj_lighting` 等第 11 批特效仍是空壳。已有 9a 抖动／流畅度问题仍待继续处理。
