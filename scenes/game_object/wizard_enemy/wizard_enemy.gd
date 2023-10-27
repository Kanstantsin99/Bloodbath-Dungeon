extends CharacterBody2D


@onready var visuals: Node2D = $Visuals
@onready var velocity_component: Node = $VelocityComponent


func _process(_delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale.x = move_sign