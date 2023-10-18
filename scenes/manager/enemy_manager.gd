extends Node

const SPAWM_RADIUS = 350

@export var basic_enemy_scene: PackedScene


func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_dir * SPAWM_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position
