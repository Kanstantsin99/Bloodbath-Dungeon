extends Area2D

const BALOON = preload("res://dialogs/balloon_portraits.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@onready var label: Label = $Label


func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)


func action() -> void:
	var baloon = BALOON.instantiate()
	get_tree().current_scene.add_child(baloon)
	baloon.start(dialogue_resource, dialogue_start)


func on_body_entered(body):
	if !body is Player:
		return
	
	label.visible = true


func on_body_exited(body):
	if !body is Player:
		return
	
	label.visible = false
