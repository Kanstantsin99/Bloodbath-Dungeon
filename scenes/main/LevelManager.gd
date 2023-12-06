extends Node

var main_hub_scene = preload("res://scenes/levels/main_hub.tscn")
var dungeon_scene = preload("res://scenes/levels/dungeon.tscn")


func _ready() -> void:
	var main_hub_instance = main_hub_scene.instantiate()
	add_child(main_hub_instance)
	MusicPlayer.set_music("res://assets/audio/village.mp3")
	GameEvents.dungeon_entered.connect(on_dungeon_entered)


func create_dungeoun_instance():
	var dungeon_instance = dungeon_scene.instantiate()
	add_child(dungeon_instance)


func on_dungeon_entered():
	$MainHub.queue_free()
	MusicPlayer.set_music("res://assets/audio/Asking Questions.mp3")
	call_deferred("create_dungeoun_instance")
