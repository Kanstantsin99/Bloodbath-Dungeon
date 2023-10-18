extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemies = [1,2,3]
	if !enemies:
		print("There is no enemies here")
	else:
		print("An enemy is here")
