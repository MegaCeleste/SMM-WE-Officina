extends GMObject
var tag: String = ""


func rec(ev: String) -> void:
	TLog.lines.append("%s:%s" % [tag, ev])
