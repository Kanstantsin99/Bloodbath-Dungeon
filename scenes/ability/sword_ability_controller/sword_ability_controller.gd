extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene
@onready var timer = $Timer

var damage = 5
var base_wait_time: float

func _ready() -> void:
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	base_wait_time = timer.wait_time

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		if enemy.global_position.distance_squared_to(
		player.global_position) < pow(MAX_RANGE, 2):
			return true
		else:
			return false
		)
		
	if !enemies:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var distantce_a = a.global_position.distance_squared_to(player.global_position)
		var distantce_b = b.global_position.distance_squared_to(player.global_position)
		return distantce_a < distantce_b
	)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = (enemies[0].global_position - sword_instance.global_position).normalized()
	sword_instance.look_at(enemy_direction)


func on_ability_upgrade_added(upgrade, current_upgrades):
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .5
	timer.wait_time = max(base_wait_time * (1 - percent_reduction), .15)
	timer.start()
	print(timer.wait_time)
