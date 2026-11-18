# 第 11 批：特效与收尾

- `obj_lighting` 在夜间鬼屋和水下按原 Step 事件更新遮罩。保留玩家过场对象的判断顺序，以及原版的半径、亮度和偏移。表面在 Room End 或对象销毁时释放。
- `obj_curtainin` 和 `obj_curtainout` 保留原版幕布半径、Alarm 和后续淡入的 room 目标。标题、门和水管仍走原有创建路径。关幕对象保留原 Create 的截图，并在 CleanUp 释放。圆形绘制辅助脚本照原文在绘制当前圆后才更新精度。
- 离屏 SubViewport 将灰度和逻辑 alpha 分别存入 R、G 通道，用 GPU 乘法实现遮罩上的 `bm_subtract`。遮罩跟随显示相机铺满视野，遮罩内容仍按原版 Step 坐标生成。这里提供本批遮罩所需的 surface 行为，通用 RGBA surface 和跨次绘制累积仍未实现。[GameMaker 混合模式](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Drawing/GPU_Control/gpu_get_blendmode.htm) · [Godot CanvasItem shader](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/canvas_item_shader.html)
- POW 冲击波继续由 `obj_block_pow_active` 触发，只作用于应用表面，绘制 GUI 淡入和调试字样之前重置 shader。保留原 shader 取样方向使用像素单位 `mouse_pos` 的公式。`Shader3` 使用绘制纹理实现模糊，源码中没有调用，测试场景单独验证。
- 登录按钮保留按钮绘制及空点击事件，标题的在线关卡选项保留为离线占位。`rm_course_world` 保留为占位房间。登录、Discord 和 NekoPresence 继续按 §0 排除。

## 验证

`tests/test_batch11.tscn` 可在 headless 下验证事件、在线占位和资源释放，在 OpenGL 下额外验证照明亮度、幕布遮罩、插值后视野边缘、POW 折射和模糊像素。专项也载入样本关卡切换昼夜，并验证离开房间时的释放。用真实渲染器检查了夜间样本截图。

- Godot 4.7.2 `--headless --quit` 正常退出。全量加载检查覆盖 1028 个对象和脚本文件。特效专项在 headless 下通过 22 项，在 OpenGL 下通过 30 项。已有原生分辨率和插值画面的 OpenGL 对照也通过。
- 基础和游玩回归通过，包括兼容层 224 项、启动 57 项、关卡 32 项、玩家 191 项、道具 734 项、机关 1076 项、Boss 240 项和 Boss 伤害 218 项。
- 四种画风分别跑完全部敌人组，共 2072 轮和 2500 项断言，零失败。
- 编辑器四种画风各通过 52 项，编辑器资源通过 1368 项。游客、暂停、设置、设置界面、结尾、本地关卡详情、90 关卡容量以及本地菜单流程均通过。部分既有测试退出时仍报告资源未释放。

尚未与 Windows 3.5.1 原版逐帧对照。第 9a 批的全屏和流畅度验收仍待完成。其他已知缺口包括 `obj_platform_help` 的专属事件和关闭的本地重命名入口。
