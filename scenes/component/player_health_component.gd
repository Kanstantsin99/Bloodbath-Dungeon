extends Node
class_name PlayerHealthComponent

signal died
signal healed
signal damaged
signal health_changed

@export var max_health := 10:
	set = set_max_health
var health = max_health:
	set = set_health,
	get = get_health


func _ready() -> void:
	GameEvents.health_potion_collected.connect(on_health_potion_collected)


func set_max_health(new_value: int) -> void:
	var difference = new_value - max_health
	max_health = new_value
	health += difference


func set_health(new_health: float) -> void:
	if new_health < health:
		damaged.emit()
	if health == 0:
		died.emit()
		owner.queue_free()
	
	health = clamp(new_health, 0, max_health)
	health_changed.emit()


func get_health() -> float:
	return health 


func get_health_percent():
	if max_health <= 0:
		return
	return min(health / max_health, 1)


func on_health_potion_collected(number: float):
	set_health(get_health() + number)
	healed.emit()
