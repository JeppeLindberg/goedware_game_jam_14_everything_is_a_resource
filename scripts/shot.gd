extends RigidBody2D

@onready var debug_spawner = get_node('/root/main/debug_spawner')
@onready var world = get_node('/root/main/world')
@onready var main = get_node('/root/main')

var drop_children = []



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var collision_point = state.get_contact_collider_position(i)
		debug_spawner.spawn(collision_point)
		var debris_children = main.get_children_in_group(self, 'debris')
		var children_to_drop = int(len(debris_children)/2.0) + 1
		for j in range(len(debris_children)):
			if j < children_to_drop:
				drop_children.append(debris_children[j])
		

func _physics_process(_delta: float) -> void:
	if len(drop_children) != 0:
		var debris = drop_children.pop_front()
		debris.reparent(world)
		debris.enable_collision(Vector2(randf_range(-1,1), randf_range(-1,1)) * 10000.0)

		if len(main.get_children_in_group(self, 'debris')) <= 0:
			queue_free()
			return


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Destructible"):
		body.hp_drain()
