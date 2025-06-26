extends Node2D


@onready var world = get_node('/root/main/world')
@onready var player = get_node('/root/main/world/player')
@export var car: PackedScene
@export var washing_machine: PackedScene
@export var small_debris: PackedScene
@export var timer: PackedScene

@export var objects_to_spawn = 10.0
@export var spawns_per_second = 2.0

var tickets = []


func _process(delta: float) -> void:
	objects_to_spawn += delta * spawns_per_second;

	if tickets == []:
		populate_tickets()

	if objects_to_spawn >= 1.0:
		var ticket = tickets.pop_front()
		var new_node = null
		if ticket == 'car':
			new_node = car.instantiate()
		if ticket == 'washing_machine':
			new_node = washing_machine.instantiate()
		if ticket == 'small_debris':
			new_node = small_debris.instantiate()
		if ticket == 'timer':
			new_node = timer.instantiate()
		world.add_child(new_node)
		new_node.global_position = get_spawn_pos()

		objects_to_spawn -= 1.0

func populate_tickets():
	for i in range(1):
		tickets.append('car')
	for i in range(1):
		tickets.append('washing_machine')
	for i in range(7):
		tickets.append('small_debris')
	for i in range(2):
		tickets.append('timer');
	tickets.shuffle()

func get_spawn_pos():
	var child_pos = []
	for child in get_children():
		if child.global_position.distance_to(player.global_position) > 300.0:
			child_pos.append(child.global_position)
	
	child_pos.shuffle()
	return child_pos.pop_front()
