extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.set_gametime(5.0)
		queue_free()
