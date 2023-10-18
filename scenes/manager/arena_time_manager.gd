extends Node

const DIFFICULTY_INTERVAL = 5

@export var end_screen_scene: PackedScene
var arena_difficulty = 0
var previous_time = 0

@onready var timer = $Timer


func _ready() -> void:
	previous_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)

func _process(delta: float) -> void:
	var next_time_target = timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
