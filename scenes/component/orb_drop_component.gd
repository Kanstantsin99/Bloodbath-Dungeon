extends Node

@export_range(0, 1) var drop_procent: float = .5
@export var health_component: Node
@export var orb_scene: PackedScene


func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_died)


func on_died():
	if randf() > drop_procent:
		return
	
	if !orb_scene:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var orb_intance = orb_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(orb_intance)
	orb_intance.global_position = spawn_position
