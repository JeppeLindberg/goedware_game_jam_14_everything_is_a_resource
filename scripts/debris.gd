extends RigidBody2D

var layer: int

func _ready() -> void:
	add_to_group('debris')
	layer = collision_layer

func disable_collision():
	collision_layer = 0
	freeze = true

