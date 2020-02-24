extends KinematicBody2D
class_name Player

export var max_speed = Vector2(300.0, 300.0)
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
	# Allows developers to teleport upward with the "Up" or "W" keys
	# TODO: Remove this if statement for final release!
	if Input.is_action_just_pressed("move_up"):
		position.y -= 300
	
	direction = Vector2 (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 1.0
	)
	
	velocity = max_speed * direction
	
	velocity.y += gravity * delta
	#velocity.y = min(velocity.y, max_speed.y)
	
	velocity = move_and_slide(velocity)
	
	print_debug(velocity)
