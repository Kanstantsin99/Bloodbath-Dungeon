extends Node

signal dungeon_entered


func _ready() -> void:
	%DungeonEntrance.body_entered.connect(on_dungeon_entered)


func on_dungeon_entered(body):
	dungeon_entered.emit()
	
