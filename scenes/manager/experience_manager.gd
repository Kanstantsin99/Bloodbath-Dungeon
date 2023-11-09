class_name ExperienceManager
extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience = 0
var current_level: int = 1
var target_experience = 1


func _ready() -> void:
	GameEvents.experience_orb_collected.connect(on_experience_orb_collected)


func increment_experience(number: float):
	current_experience += number
	experience_updated.emit(min(current_experience, target_experience), target_experience)
	
	while current_experience >= target_experience:
		current_level += 1
		current_experience -= target_experience
		target_experience += TARGET_EXPERIENCE_GROWTH
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)


func on_experience_orb_collected(number: float):
	increment_experience(number)
