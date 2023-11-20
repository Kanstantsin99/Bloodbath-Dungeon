class_name SoundButton
extends Button


@export var sound: AudioStream = preload("res://assets/audio/click_0.wav")


func _ready() -> void:
	button_down.connect(on_button_down)
	$AudioStreamPlayer.stream = sound


func on_button_down():
	$AudioStreamPlayer.play()
