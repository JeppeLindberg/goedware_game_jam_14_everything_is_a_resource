extends Node2D

var mouse_pos: Vector2
var vacuum_on: bool

@export var shot_prefab: PackedScene

@onready var main = get_node('/root/main')
@onready var vacuum_point = get_node('vacuum_point')
@onready var world = get_node('/root/main/world')

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
		if vacuum_on:
			shoot()

		vacuum_on = false;

	vacuum_point.set_vacuum_on(vacuum_on)

func shoot():
	var debris = main.get_children_in_group(vacuum_point, 'debris')
	if len(debris) == 0:
		return

	var new_shot = shot_prefab.instantiate()
	new_shot.global_position = vacuum_point.global_position
	new_shot.scale = Vector2.ONE
	
	world.add_child(new_shot)
	var shoot_velocity = 500.0

	for debris_node in debris:
		debris_node.reparent(new_shot)

	new_shot.apply_force((mouse_pos - global_position) * shoot_velocity)

	var attach = main.get_children_in_group(vacuum_point, 'attach')
	for attach_node in attach:
		attach_node.queue_free()



