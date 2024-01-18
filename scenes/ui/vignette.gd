extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	GameEvents.player_damaged.connect(on_player_damaged)
	GameEvents.player_healed.connect(on_player_healed)


func on_player_damaged():
	animation_player.play("hit")


func on_player_healed():
	animation_player.play("healing")
