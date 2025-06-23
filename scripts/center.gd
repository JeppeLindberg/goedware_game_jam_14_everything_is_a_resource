extends Node2D

@export var attach_template: PackedScene

func add_debris(node):
	var new_attach = attach_template.instantiate()
	add_child(new_attach)
	new_attach.position = Vector2.ZERO
	new_attach.rotation_degrees = randf() * 360.0
	node.reparent(new_attach)


func _process(delta: float) -> void:
	if get_child_count() > 0:
		Global.active_items = get_child_count()
