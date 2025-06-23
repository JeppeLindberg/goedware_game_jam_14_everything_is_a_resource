extends Node

var score : int = 0
var active_items : int

func add_score(amount : int) -> void:
	score += amount


func get_score() -> int:
	return score
