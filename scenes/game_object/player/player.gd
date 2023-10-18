extends CharacterBody2D

const ACCELERATION_SMOOTHING = 5

@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_component: Node = $HealthComponent
@onready var health_bar: ProgressBar = $HealthBar

@export var speed: int = 100
var number_colliding_bodies = 0


func _ready() -> void:
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	update_health_display()


func _process(_delta: float) -> void:
	var direction = get_direction()
	var target_velocity = direction * speed
	if direction:
		velocity = velocity.lerp(target_velocity, 1 - exp(-_delta * ACCELERATION_SMOOTHING))
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()


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


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed():
	update_health_display()
