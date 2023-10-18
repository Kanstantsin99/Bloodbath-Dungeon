extends CharacterBody2D

@export var speed: int = 50

@onready var health_component: HealthComponent = $HealthComponent


func _process(_delta: float) -> void:
	var dir_to_player = get_direcion_to_player()
	velocity = dir_to_player * speed
	move_and_slide()


func get_direcion_to_player() -> Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return (player_node.global_position - global_position).normalized()
	else:
		return Vector2.ZERO

