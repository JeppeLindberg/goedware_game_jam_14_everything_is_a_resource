extends RigidBody2D

@export var object_data : DestructibleObjectResource
var local_data : DestructibleObjectResource
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var small_debris_prefab: PackedScene
@onready var world = get_node('/root/main/world')
@onready var main = get_node('/root/main')

var small_debris_to_emit = 0
var last_flash_time = -1.0

func reset():
	queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	local_data = object_data.duplicate()
	sprite_2d.texture = local_data.sprite
	sprite_2d.scale = local_data.sprite_scale
	if randf() < 0.5:
		sprite_2d.scale = sprite_2d.scale * Vector2(-1, 1)
	collision_shape_2d.shape.size = local_data.collision_size

func hp_drain(damage) -> void:
	var prev_health = local_data.health
	
	if local_data.health > 0:
		local_data.health -= damage
		sprite_2d.modulate = Color(10,10,10,10)
		last_flash_time = main.seconds()

	small_debris_to_emit += (prev_health/5) - (max(local_data.health/5, 0))

	if local_data.health <= 0:
		#spawn explosion?
		queue_free()

func _process(_delta: float) -> void:	
	if last_flash_time + 0.07 < main.seconds():
		sprite_2d.modulate = Color(1,1,1,1)

	for i in range(small_debris_to_emit):
		emit_small_debris()
	small_debris_to_emit = 0;

func emit_small_debris():
	var new_debris = small_debris_prefab.instantiate()
	world.add_child(new_debris)
	new_debris.global_position = global_position
	new_debris.linear_velocity = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * (randf() * 300 + 300)
	
	
