extends Node

signal dungeon_entered

@onready var player: CharacterBody2D = %Player


func _ready() -> void:
	%DungeonEntrance.body_entered.connect(on_dungeon_entered)
	player.health_bar.visible = false


func on_dungeon_entered(body):
	ScreenTransition.transition()
	dungeon_entered.emit()
	
