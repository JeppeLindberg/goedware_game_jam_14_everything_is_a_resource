extends Node2D

var vacuum_on: bool
var prev_seconds: int = 0

@export var vacuum_force = 2.0

@onready var suck_shape = get_node('suck_shape')
@onready var attach_shape = get_node('attach_shape')
@onready var main = get_node('/root/main')
@onready var center = get_node('center')
@onready var sprite = get_node('sprite')

@export_flags_2d_physics var attach_layer: int
@export_flags_2d_physics var suck_layer: int

func set_vacuum_on(new_vacuum_on):
	vacuum_on = new_vacuum_on

func _process(_delta: float) -> void:
	if get_parent().global_transform.get_scale().x < 0:
		scale.x = -1
	else:
		scale.x = 1

	sprite.visible = vacuum_on

func _physics_process(_delta: float) -> void:
	if vacuum_on:		
		var nodes = main.get_nodes_in_shape(attach_shape, global_transform, attach_layer)

		for node in nodes:
			if node.is_in_group('debris'):
				node.disable_collision()
				center.add_debris(node)

		nodes = main.get_nodes_in_shape(suck_shape, global_transform, suck_layer)
		
		for node in nodes:
			if node.is_in_group('debris'):
				node.apply_force((global_position - node.global_position) * vacuum_force)
			if node.is_in_group('Destructible'):
				node.apply_force((global_position - node.global_position) * vacuum_force / 2.0)
				if prev_seconds != int(main.seconds()):
					node.hp_drain(1)
				
	
	prev_seconds = int(main.seconds())
			
