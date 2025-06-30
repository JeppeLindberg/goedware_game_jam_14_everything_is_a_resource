extends AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var main = get_node('/root/main')
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	play("eat")
	if !audio_stream_player_2d.playing:
		audio_stream_player_2d.play()
	Global.add_score(Global.active_items)
