extends Node2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var texture: Texture2D = preload("res://dialogs/portraits/sign.png")

@onready var actionable_component: Area2D = $ActionableComponent


func _ready() -> void:
	$Sprite2D.texture = texture
	actionable_component.dialogue_resource = dialogue_resource
	actionable_component.dialogue_start = dialogue_start

