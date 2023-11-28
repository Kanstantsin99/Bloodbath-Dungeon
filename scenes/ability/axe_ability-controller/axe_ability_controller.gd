extends Node

const MAX_RANGE = 150

var base_damage = 10
var additional_damage_percent = 1
var base_wait_time: float

@export var axe_ability: PackedScene
@onready var timer = $Timer


func _ready() -> void:
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	base_wait_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
	
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if !foreground_layer:
		return
	
	
	var axe_instance = axe_ability.instantiate() as AxeAbility
	foreground_layer.add_child(axe_instance)
	axe_instance.hitbox_component.damage = base_damage * additional_damage_percent


func on_ability_upgrade_added(upgrade, current_upgrades):
	if upgrade.id == "axe_rate":
		var percent_reduction = current_upgrades["axe_rate"]["quantity"] * .1
		timer.wait_time = max(base_wait_time * (1 - percent_reduction), .10)
		timer.start()
	elif upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * .15)
