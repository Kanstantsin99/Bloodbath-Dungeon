extends Node

var array: Array[int] = [1, 2, 3]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Array befor assigning :" + str(array))
	var new_array = array
	print("New array befor changing :" + str(new_array))
	new_array[1] = 5
	print("New array after changing :" + str(new_array))
	
	print("Array after changing :" + str(array))




