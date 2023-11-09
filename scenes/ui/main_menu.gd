extends CanvasLayer

var options_scene = preload("res://scenes/ui/options_menu.tscn")

func _ready() -> void:
	$%PlayButton.pressed.connect(on_play_pressed)
	$%OptionsButton.pressed.connect(on_options_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)

func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_back_pressed)


func on_quit_pressed():
	get_tree().quit()


func on_back_pressed():
	get_tree().get_first_node_in_group("options").queue_free()
