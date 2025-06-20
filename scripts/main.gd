extends Node2D

@export_flags_2d_physics var basic_layer

@onready var world = get_node('/root/main/world')

func get_nodes_in_shape(collider, transform, collision_mask = 0, motion = Vector2.ZERO):
	var shape = PhysicsShapeQueryParameters2D.new()
	shape.shape = collider.shape;
	shape.transform = transform
	shape.collide_with_areas = false
	if collision_mask != 0:
		shape.collision_mask = collision_mask
	else:
		shape.collision_mask = basic_layer
	if motion != Vector2.ZERO:
		shape.motion = motion
	var collisions = world.get_world_2d().direct_space_state.intersect_shape(shape);
	if collisions == null:
		return([])
	
	var nodes = []
	for collision in collisions:
		var node = collision['collider']
		nodes.append(node)
	return nodes
