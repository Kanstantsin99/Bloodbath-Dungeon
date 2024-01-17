extends TextEdit
signal text_entered


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_accept'):
		_on_sound_button_pressed()

func _on_sound_button_pressed() -> void:
	DialogueEvents.player_name = text
	var dir = DirAccess.open("res://dialogs/portraits/")
	text_entered.emit()
