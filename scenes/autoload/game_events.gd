extends Node


signal experience_orb_collected(number: float)
signal health_potion_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged
signal player_healed
signal player_died
signal dungeon_entered


func shut_down():
	get_tree().quit()


func emit_experience_orb_collected(number: float):
	experience_orb_collected.emit(number)


func emit_health_potion_collected(number: float):
	health_potion_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damaged():
	player_damaged.emit()


func emit_player_healed():
	player_healed.emit()


func emit_player_died():
	player_died.emit()


func emit_dungeon_entered():
	dungeon_entered.emit()

