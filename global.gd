extends Node

var score : int = 0
var active_items : int
var gametime : float

func reset():
	score = 0

func add_score(amount : int) -> void:
	score += amount


func get_score() -> int:
	return score


func set_gametime(amount : float) -> void:
	gametime = amount
