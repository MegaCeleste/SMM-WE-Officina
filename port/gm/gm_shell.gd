extends GMObject
## 还没移植的 object 的空壳（port-plan R6）。和 GML 实例一样可以被写入任意变量：
## 别的 object 往它上面写的自定义变量存在 _props 里，读没写过的变量得到 0.0（_get 返回 null 会被 Godot 当成“没有这个属性”而报错；
## 真正的 object 会在 Create 里给这些变量赋初值，空壳没有 Create，只能给个占位值）。

var _props: Dictionary = {}


func _set(property: StringName, value: Variant) -> bool:
	_props[property] = value
	return true


func _get(property: StringName) -> Variant:
	return _props.get(property, 0.0)
