extends Button

@export var sound: AudioStream


func _ready() -> void:
	pressed.connect(on_pressed)
	$AudioStreamPlayer.stream = sound


func on_pressed():
	$AudioStreamPlayer.play()
