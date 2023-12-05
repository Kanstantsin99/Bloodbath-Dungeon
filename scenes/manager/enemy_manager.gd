extends Node

const SPAWM_RADIUS = 350

@export var rat_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var difficulty_manager: DifficultyManager
var base_spawn_time: float
var enemy_table = WeightedTable.new()

@onready var timer: Timer = $Timer



func _ready() -> void:
	timer.start()
	enemy_table.add_item(rat_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	difficulty_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return Vector2.ZERO
	
	
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Vector2.ZERO
	
	for i in 4:
		spawn_position = player.global_position + (random_dir * SPAWM_RADIUS)
		var additional_check_offset = random_dir * 20
		
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		
		if result.is_empty():
			return spawn_position
		else:
			random_dir = random_dir.rotated(PI/2)
		return null


func on_timer_timeout() -> void:
	timer.start()
	
	var spawn_position = get_spawn_position()
	if !spawn_position:
		return
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return
	
	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	
	enemy.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = arena_difficulty * .1 / 30 # each 30 sec base_spawn_time - 0.1 
	time_off = min(time_off, .8)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 30:
		enemy_table.add_item(wizard_enemy_scene, 5)
