extends RigidBody2D

var movement_direction: Vector2

@export var movement_speed : float

@onready var gun = get_node('gun')




func _physics_process(delta):
	handle_controls(delta)

	linear_velocity = movement_direction * movement_speed

	
func handle_controls(_delta):
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	movement_direction = input.normalized()