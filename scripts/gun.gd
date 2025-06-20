extends Node2D

var mouse_pos: Vector2
var vacuum_on: bool

@onready var vacuum_point = get_node('vacuum_point')

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouse_pos = event.position
	
func _process(_delta: float) -> void:
	if mouse_pos.x < global_position.x:
		scale.x = -1
		look_at(global_position + (global_position - mouse_pos))
	else:
		scale.x = 1;
		look_at(mouse_pos)

	if Input.is_action_pressed('vacuum_on'):
		vacuum_on = true;
	else:
		vacuum_on = false;

	vacuum_point.set_vacuum_on(vacuum_on)


	

