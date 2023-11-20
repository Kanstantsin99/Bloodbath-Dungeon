extends CanvasLayer


var options_scene = preload("res://scenes/ui/options_menu.tscn")
var is_closing = false

func _ready() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("default")
	%ResumeButton.pressed.connect(on_resume_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitToMenuButton.pressed.connect(on_quit_to_menu_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") && !is_closing:
		close()
		get_tree().root.set_input_as_handled()


func close():
	if is_closing:
		return
	
	if owner.has_node("OptionsMenu"):
		return
	
	
	is_closing = true
	$AnimationPlayer.play_backwards("default")
	
	await $AnimationPlayer.animation_finished
	
	get_tree().paused = false
	queue_free()


func on_resume_pressed():
	close()


func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_instance = options_scene.instantiate()
	owner.add_child(options_instance)
	options_instance.back_pressed.connect(on_back_pressed.bind(options_instance))


func on_quit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")


func on_quit_pressed():
	get_tree().quit()


func on_back_pressed(options_instance: Node):
	options_instance.queue_free()
