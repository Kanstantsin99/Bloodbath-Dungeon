extends Node

@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial
var hit_flash_tween: Tween 


func _ready() -> void:
	health_component.damaged.connect(on_damaged)
	sprite.material = hit_flash_material


func on_damaged():
	if hit_flash_tween != null && hit_flash_tween.is_valid(): 
		hit_flash_tween.kill()
	
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_precent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_precent", 0.0, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)