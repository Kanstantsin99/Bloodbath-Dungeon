extends Node2D

@export var health_component: Node
@export var sprite: Sprite2D
@export var death_sound: AudioStream

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	$GPUParticles2D.texture = sprite.texture
	audio_stream_player_2d.stream = death_sound
	health_component.died.connect(on_died)


func on_died():
	if owner == null || not owner is Node2D:
		return
		
	var spawn_position = owner.global_position
	
	var entities = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	
	global_position = spawn_position
	$AnimationPlayer.play("default")
	audio_stream_player_2d.play()
