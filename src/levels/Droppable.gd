extends TileMap
class_name Droppable

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_down"):
		set_collision_layer_bit(2, false)
		set_collision_layer_bit(3, true)
