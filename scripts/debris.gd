extends RigidBody2D

var layer: int
var force_to_add: Vector2

@export var possible_sprites: Array[Texture2D]

@onready var shape = get_node('shape')
@onready var sprite = get_node('sprite')

func _ready() -> void:
	add_to_group('debris')
	layer = collision_layer
	sprite.texture = possible_sprites[randi_range(0, len(possible_sprites) - 1)];

func disable_collision():
	shape.disabled = true
	freeze = true

func enable_collision():
	shape.disabled = false
	freeze = false
