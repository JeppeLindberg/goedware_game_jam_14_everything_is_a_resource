extends StaticBody2D

@export var object_data : DestructibleObjectResource
var local_data : DestructibleObjectResource
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	local_data = object_data.duplicate()
	sprite_2d.texture = local_data.sprite
	sprite_2d.scale = local_data.sprite_scale
	collision_shape_2d.shape.size = local_data.collision_size

func hp_drain() -> void:
	if local_data.health > 0:
		local_data.health -= 5
		#flash object red?
	else:
		#spawn explosion?
		queue_free()
