extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}
#var upgrade_pool: WeightedTable = WeightedTable.new()
#var upgrade_axe = preload("res://resources/upgrades/axe.tres")
#var upgrade_axe_damage = preload("res://resources/upgrades/axe_damage.tres")
#var upgrade_sword_rate = preload("res://resources/upgrades/sword_rate.tres")
#var upgrade_sword_damage = preload("res://resources/upgrades/sword_damage.tres")


func _ready() -> void:
#	upgrade_pool.add_item(upgrade_axe, 10)
#	upgrade_pool.add_item(upgrade_sword_rate, 10)
#	upgrade_pool.add_item(upgrade_sword_damage, 10)
	
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
	
#	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


#func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
#	if chosen_upgrade.id == upgrade_axe.id:
#		upgrade_pool.add_item(upgrade_axe_damage, 10)


func _filter_and_pick_upgrades(quantity: int) -> Array[AbilityUpgrade]:
	var filtered_upgrades = upgrade_pool.duplicate()

	filtered_upgrades = filtered_upgrades.filter(func (upgrade: AbilityUpgrade): 
		if !current_upgrades.has(upgrade.id):
			return true
		return current_upgrades[upgrade.id]["quantity"] < upgrade.max_quantity
	)
	if filtered_upgrades.size() < quantity:
		quantity = filtered_upgrades.size()
	elif filtered_upgrades.size() == 0:
		return filtered_upgrades

	filtered_upgrades.shuffle()
	filtered_upgrades = filtered_upgrades.slice(0, quantity)

	return filtered_upgrades
	
#	var chosen_upgrade = upgrade_pool.pick_item()


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
