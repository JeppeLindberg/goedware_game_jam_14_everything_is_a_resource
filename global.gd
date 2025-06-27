extends Node

var score : int = 0
var active_items : int

signal add_to_timer(time : float)

func add_score(amount : int) -> void:
	score += amount


func get_score() -> int:
	return score


func set_gametime(amount : float) -> void:
	add_to_timer.emit(amount)
