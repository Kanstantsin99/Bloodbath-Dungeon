extends Node

signal dungeon_entered

@onready var player: CharacterBody2D = %Player
@onready var tile_map: TileMap = $World/TileMap


func _ready() -> void:
	player.health_bar.visible = false
