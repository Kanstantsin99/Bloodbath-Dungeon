extends AudioStreamPlayer

@onready var timer: Timer = $Timer


func _ready() -> void:
	set_music()
	finished.connect(on_finished)
	$Timer.timeout.connect(on_timer_timeout)


func set_music(audio_path: String = "res://assets/audio/menu_audio.mp3"):
	var audio = load(audio_path)
	stream = audio
	play()



func on_finished():
	$Timer.start()


func on_timer_timeout():
	play()


