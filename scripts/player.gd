extends RigidBody2D

var movement_direction: Vector2
var mouse_pos: Vector2
var mouse_world_pos: Vector2

@export var movement_speed : float

@onready var gun = get_node('gun')
@onready var main = get_node('/root/main')
@onready var sprite:AnimatedSprite2D = get_node('sprite')
@onready var accept_input = false

var starting_pos


func _ready() -> void:
	starting_pos = global_position

func reset():
	global_position = starting_pos

func _physics_process(delta):
	handle_controls(delta)

	if movement_direction == Vector2.ZERO:
		sprite.animation = 'default'
	else:
		sprite.animation = 'walk'

	linear_velocity = movement_direction * movement_speed

func _input(event: InputEvent) -> void:
	if not accept_input:
		return;

	if event is InputEventMouse:
		mouse_pos = event.position

func _process(_delta: float) -> void:
	mouse_world_pos = get_viewport().get_canvas_transform().affine_inverse() * mouse_pos

	if mouse_world_pos.x < global_position.x:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1;
	
func handle_controls(_delta):
	if not accept_input:
		movement_direction = Vector2.ZERO

		if Input.is_action_just_pressed('reset'):
			main.reset();

		return
		
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	movement_direction = input.normalized()
