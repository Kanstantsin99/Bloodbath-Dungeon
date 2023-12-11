extends CanvasLayer

@onready var options_scene = preload("res://scenes/ui/options_menu.tscn")
@onready var v_box_container: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer
@onready var new_game_box: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/NewGameBox


func _ready() -> void:
	$%PlayButton.pressed.connect(on_play_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)


func on_play_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	v_box_container.visible = false
	new_game_box.visible = true
	await %PlayerName.text_entered
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_instance = options_scene.instantiate()
	get_tree().get_root().add_child(options_instance)
	options_instance.back_pressed.connect(on_back_pressed)


func on_quit_pressed():
	get_tree().quit()


func on_back_pressed():
	get_tree().get_first_node_in_group("options").queue_free()
