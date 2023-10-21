extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)


func _apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func _pick_upgrades(quantity: int) -> Array[AbilityUpgrade]:
	var chosen_upgrades = upgrade_pool.duplicate()
	chosen_upgrades.shuffle()
	chosen_upgrades.slice(0, quantity)
	
	return chosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade):
	_apply_upgrade(upgrade)


func on_level_up(current_level: int):
	var chosen_upgrades = _pick_upgrades(2)
	
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
