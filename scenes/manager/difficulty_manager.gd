class_name DifficultyManager
extends Node


signal arena_difficulty_increased(arena_difficulty: int)

var arena_difficulty: int = 0

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	arena_difficulty += 1
	arena_difficulty_increased.emit(arena_difficulty)

