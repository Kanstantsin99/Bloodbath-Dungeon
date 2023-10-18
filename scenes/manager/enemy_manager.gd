extends Node

const SPAWM_RADIUS = 350

@export var basic_enemy_scene: PackedScene
@export var difficulty_manager: DifficultyManager
var base_spawn_time: float

@onready var timer: Timer = $Timer



func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	difficulty_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func on_timer_timeout() -> void:
	timer.start()
	
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_dir * SPAWM_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = arena_difficulty * .1 / 12
	time_off = min(time_off, .7)
	timer.wait_time = base_spawn_time - time_off
