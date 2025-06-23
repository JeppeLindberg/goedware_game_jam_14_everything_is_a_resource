extends Control
@onready var countdown: RichTextLabel = $MarginContainer/VBoxContainer/Countdown
@onready var score: RichTextLabel = $MarginContainer/VBoxContainer/Score
@onready var timer: Timer = $MarginContainer/VBoxContainer/Countdown/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = "Score: " + str(Global.get_score())
	countdown.text = "Time Left: " + str(snapped(timer.time_left, 0.01))


func _on_timer_timeout() -> void:
	pass # Display Score? Go to main menu?
