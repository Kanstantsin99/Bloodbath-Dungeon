extends Node

const MAX_RANGE = 150

@export var axe_ability: PackedScene
@onready var timer = $Timer

var damage = 10


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
	
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if !foreground_layer:
		return
	
	
	var axe_instance = axe_ability.instantiate() as AxeAbility
	foreground_layer.add_child(axe_instance)
	axe_instance.hitbox_component.damage = damage


