extends Sprite2D

var TEXTURE_VARRIATION_ARRAY: Array = [
	preload("res://assets/environment/blood/blood_stain_0.png"),
	preload("res://assets/environment/blood/blood_stain_1.png")
]

func _ready() -> void:
	variate_texture()


func variate_texture():
	if TEXTURE_VARRIATION_ARRAY.size() > 1:
		var texture_id = randi() % TEXTURE_VARRIATION_ARRAY.size()
		var choisen_texture: Texture = TEXTURE_VARRIATION_ARRAY[texture_id]
		texture = choisen_texture
