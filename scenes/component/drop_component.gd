extends Node

@export_range(0, 1) var drop_procent: float = .5
@export var health_component: HealthComponent
@export var orb_scene: PackedScene
@export var health_scene: PackedScene
var drop_table = WeightedTable.new()


func _ready() -> void:
	drop_table.add_item(health_scene, 1)
	drop_table.add_item(orb_scene, 10)
	health_component.died.connect(on_died)


func on_died():
	if randf() > drop_procent:
		return
	
	if !orb_scene || !health_scene:
		return
	
	if not owner is Node2D:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var drop_intance = drop_table.pick_item().instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(drop_intance)
	drop_intance.global_position = spawn_position
