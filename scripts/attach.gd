extends Node2D

@onready var move_towards = get_node('move_towards')
@onready var rotation_speed = randf() * 30 + 10
@onready var debris_rotation_speed = randf() * 10 + 10

var debris

func _ready() -> void:
	move_towards.position = move_towards.position * (randf()*0.5 + 0.5)
	if randf() < 0.5:
		debris_rotation_speed *= -1;

func _process(delta):
	if debris == null:
		for child in get_children():
			if child != move_towards:
				debris = child

	if debris != null:
		debris.position = lerp(debris.position, move_towards.position, delta)
		debris.rotation_degrees = debris.rotation_degrees + debris_rotation_speed * delta
	
	rotation_degrees += delta * rotation_speed
