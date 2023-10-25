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


func _filter_and_pick_upgrades(quantity: int) -> Array[AbilityUpgrade]:
	var filtered_upgrates = upgrade_pool.duplicate()
	
	filtered_upgrates = filtered_upgrates.filter(func (upgrade: AbilityUpgrade): 
		if !current_upgrades.has(upgrade.id):
			return true
		return current_upgrades[upgrade.id]["quantity"] < upgrade.max_quantity
	)
	if filtered_upgrates.size() < quantity:
		quantity = filtered_upgrates.size()
	elif filtered_upgrates.size() == 0:
		return filtered_upgrates
		
	filtered_upgrates.shuffle()
	filtered_upgrates.slice(0, quantity)
	
	return filtered_upgrates


func on_level_up(_current_level: int):
	var chosen_upgrades = _filter_and_pick_upgrades(2)
	if !chosen_upgrades:
		return
	
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	_apply_upgrade(upgrade)
