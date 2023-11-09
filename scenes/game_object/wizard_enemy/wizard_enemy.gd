extends CharacterBody2D


var is_moving: bool = false

@onready var visuals: Node2D = $Visuals
@onready var velocity_component: Node = $VelocityComponent
@onready var hurtbox_component: Area2D = $HurtboxComponent
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $HitAudioPlayerComponent


func _ready() -> void:
	hurtbox_component.hit.connect(on_hit)


func _process(_delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale.x = move_sign


func set_is_moving(moving: bool):
	is_moving = moving


func on_hit():
	audio_stream_player_2d.play()
