extends TextEdit
signal text_entered


func _on_sound_button_pressed() -> void:
	DialogueEvents.player_name = text
	text_entered.emit()
