extends Control
@onready var countdown: RichTextLabel = $gameplay/VBoxContainer/Countdown
@onready var score: RichTextLabel = $gameplay/VBoxContainer/Score
@onready var timer: Timer = $gameplay/VBoxContainer/Countdown/Timer
@onready var gameplay:Control = get_node('gameplay')
@onready var post_game:Control = get_node('post_game')
@onready var player = get_node('/root/main/world/player')
var start_wait_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_wait_time = timer.wait_time
	Global.add_to_timer.connect(_on_time_added)
	timer.start()
	gameplay.visible = true
	post_game.visible = false

func reset():
	Global.reset()
	timer.wait_time = start_wait_time
	timer.start()
	player.accept_input = true
	gameplay.visible = true
	post_game.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = "Score: " + str(Global.get_score())
	countdown.text = "Time Left: " + str(snapped(timer.time_left, 0.01))

func _on_timer_timeout() -> void:
	player.accept_input = false
	gameplay.visible = false
	post_game.visible = true
	post_game.add_score(Global.get_score())

func _on_time_added(amount : float) -> void:
	var current_time_left = timer.time_left
	timer.stop()
	timer.set_wait_time(current_time_left + amount)
	timer.start()
