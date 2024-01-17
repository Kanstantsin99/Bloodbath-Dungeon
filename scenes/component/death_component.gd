extends Node2D

@export var health_component: Node
@export var sprite: Sprite2D
@export var death_sound: AudioStream
var body1: AtlasTexture
var body2: AtlasTexture

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var blood_stain: Sprite2D = $BloodStain


func _ready() -> void:
	cut_sprite()
	$GPUParticles2DLeft.texture = body1
	$GPUParticles2DRight.texture = body2
	audio_stream_player_2d.stream = death_sound
	health_component.died.connect(on_died)


func cut_sprite() -> void:
	body1 = AtlasTexture.new()
	body1.atlas = sprite.texture
	body1.region = Rect2(0, 0, 8, 16)
	body2 = AtlasTexture.new()
	body2.atlas = sprite.texture
	body2.region = Rect2(8, 0, 8, 16)


func on_died():
	if owner == null || not owner is Node2D:
		return
	
	var spawn_position = owner.global_position
	
	var blood = get_tree().get_first_node_in_group("blood_layer")
	get_parent().remove_child(self)
	blood.add_child(self)
	
	global_position = spawn_position
	$AnimatedSprite2D.play("default")
	audio_stream_player_2d.play()
	$GPUParticles2DLeft.emitting = true
	$GPUParticles2DRight.emitting = true
	blood_stain.visible = true


func _queue_free():
	$AnimationPlayer.queue_free()
	body1 = null
	body2 = null
	$GPUParticles2DLeft.queue_free()
	$GPUParticles2DRight.queue_free()
	$GPUParticles2DBlood.queue_free()
	audio_stream_player_2d.queue_free()
