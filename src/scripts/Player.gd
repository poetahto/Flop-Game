extends KinematicBody2D
class_name Player

export var max_speed = Vector2(500.0, 300.0)
export var gravity: = 10.0

onready var player_animation = get_node("Player Animation");
onready var player_collider_falling = get_node("Player Collider Falling")
onready var player_collider_idle = get_node("Player Collider Idle")

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
	
	if(direction.x != 0):
		if(direction.x <= 0): player_animation.set_flip_h(true)
		if(direction.x >= 0): player_animation.set_flip_h(false)
	
	if is_on_floor() and direction.x == 0 and player_animation.get_animation() != "Idle":
		max_speed.x = 150
		player_animation.set_animation("Idle")
		player_collider_falling.set_disabled(true)
		player_collider_idle.set_disabled(false)
		
	elif is_on_floor() and direction.x != 0 and player_animation.get_animation() != "Walking":
		max_speed.x = 150
		player_animation.set_animation("Walking")
		player_collider_falling.set_disabled(true)
		player_collider_idle.set_disabled(false)
	
	elif !is_on_floor() and player_animation.get_animation() != "Falling":
		max_speed.x = 400
		player_animation.set_animation("Falling")
		player_collider_idle.set_disabled(true)
		player_collider_falling.set_disabled(false)
