extends Node

@export var end_screen_scene: PackedScene
var pause_menu = preload("res://scenes/ui/pause_menu.tscn")

@onready var level_manager: Node = $LevelManager


func _ready() -> void:
	level_manager.child_entered_tree.connect(on_level_loaded)
	GameEvents.player_died.connect(on_player_died)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_instance = pause_menu.instantiate()
		add_child(pause_instance)
		pause_instance.set_owner(self)
		get_tree().root.set_input_as_handled()


func on_level_loaded(level: Node):
	var player = level.get_tree().get_first_node_in_group("player")
	if !player:
		return
	
	player.health_component.died.connect(on_player_died)


func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()


func on_dungeon_entered(body):
	ScreenTransition.transition()
	
