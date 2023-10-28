extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_2d_area_entered)


func tween_collect(percent: float, start_pos: Vector2):
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	
	global_position = start_pos.lerp(player.global_position, percent)


func collect():
	GameEvents.emit_experience_orb_collected(1)
	queue_free()


func disable_col():
	collision_shape_2d.disabled = true


func on_area_2d_area_entered(_area: Area2D) -> void:
	Callable(disable_col).call_deferred()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, .5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite_2d, "scale", Vector2.ZERO, .15)\
	.set_delay(.35)
	tween.chain()
	tween.tween_callback(collect)
