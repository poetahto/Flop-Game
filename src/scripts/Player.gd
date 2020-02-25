extends KinematicBody2D
class_name Player

export var max_speed = Vector2(500.0, 300.0)
export var gravity: = 10.0

# The X value shows the direction a player should be moving as a float,
# ranging from -1 to 1. The Y value is always zero.
var direction: Vector2

# The X and Y values represent the pixels per second that the player will
# move in the corresponding direction.
var velocity: = Vector2.ZERO

# This function is run once every frame at a constant rate: be sure to multiply
# 
func _physics_process(delta: float) -> void:
	
	direction = Vector2 (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 1.0
	)
	
	_update_animation()
	
	velocity = max_speed * direction
	
	#velocity.y += gravity * delta
	#velocity.y = min(velocity.y, max_speed.y)
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _update_animation() -> void:
	if is_on_floor() and get_node("Player Animation").get_animation() == "Falling":
		max_speed.x = 150
		get_node("Player Animation").set_animation("Idle")
		get_node("Player Collider Falling").set_disabled(true)
		get_node("Player Collider Idle").set_disabled(false)
		
	elif !is_on_floor() and get_node("Player Animation").get_animation() == "Idle":
		max_speed.x = 400
		get_node("Player Animation").set_animation("Falling")
		get_node("Player Collider Idle").set_disabled(true)
		get_node("Player Collider Falling").set_disabled(false)
	
