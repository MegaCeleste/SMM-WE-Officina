extends Node2D
## 启动入口：进入第一个 room（rm_logo，yyp 里 room 顺序的第一个）。
## 之后的一切由 GM 的 tick 驱动（port-plan §2、§4）。


func _ready() -> void:
	GM.game_start(A.rm_logo)
