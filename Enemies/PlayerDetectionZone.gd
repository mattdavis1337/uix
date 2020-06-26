extends Area2D

var player = null

signal player_near(player)
signal player_gone(player)

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	if(body.name == "Player"):
		emit_signal("player_near", body)
		player = body


func _on_PlayerDetectionZone_body_exited(body):
	if(body.name == "Player"):
		emit_signal("player_gone", body)
		player = null
