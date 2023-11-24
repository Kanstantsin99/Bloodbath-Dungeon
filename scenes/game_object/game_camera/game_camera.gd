extends Camera2D
 
var target_position = Vector2.ZERO
 
func _ready():
	make_current()
 
 
func _physics_process(delta):
	acquire_target()
	global_position = global_position.lerp(target_position , 1.0 - exp(-delta * 20))
 
 
func acquire_target():
	target_position = owner.global_position
