class_name Player
extends CharacterBody2D


var number_colliding_bodies = 0
var base_speed = 0

@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_component: Node = $PlayerHealthComponent
@onready var health_bar: ProgressBar = $HealthBar
@onready var abilities: Node = $Abilities
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: Node = $VelocityComponent
@onready var hit_audio_player_component: AudioStreamPlayer2D = $HitAudioPlayerComponent
@onready var actionable_finder: Area2D = $Direction/ActionableFinder


func _ready() -> void:
	base_speed = velocity_component.max_speed
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	health_component.died.connect(on_player_died)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_health_display()


func _process(_delta: float) -> void:
	var direction = get_direction()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	if direction:
		animation_player.play("walk")
	else:
		animation_player.stop()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return


func get_direction() -> Vector2:
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	return Vector2(direction_x, direction_y).normalized()


func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	
	health_component.damage(1)
	damage_interval_timer.start()


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_body_entered(_other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(_other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	GameEvents.emit_player_damaged()
	update_health_display()
	hit_audio_player_component.play()


func on_player_died():
	GameEvents.emit_player_died()


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, _current_upgrades: Dictionary):
	if ability_upgrade is Ability:
		abilities.add_child(ability_upgrade.ability_controller_scene.instantiate())
	elif ability_upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (base_speed * _current_upgrades["player_speed"]["quantity"] * .1)
