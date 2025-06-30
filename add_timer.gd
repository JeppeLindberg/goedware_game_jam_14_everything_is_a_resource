extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func reset():
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		visible = false
		Global.set_gametime(5.0)
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
