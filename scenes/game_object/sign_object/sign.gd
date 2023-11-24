extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var label: Label = $Label


func _ready() -> void:
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_exited)
	area_2d.input_event.connect(on_input_event)


func on_body_entered(body):
	if !body is Player:
		return
	
	label.visible = true


func on_body_exited(body):
	if !body is Player:
		return
	
	label.visible = false


func on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		print("You pressed E")
