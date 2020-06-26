extends KinematicBody2D


onready var animationPlayer = $AnimationPlayer
var playerNear = false setget set_playerNear
var handUp = false setget set_handUp
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_handUp(value):
	print("handUp: " + str(value))
	if(handUp == value):
		return

	handUp = value
	if handUp == true:
		animationPlayer.play("WaveHand")
		timer.start(2)
	elif handUp == false:
		animationPlayer.play_backwards("WaveHand")

func set_playerNear(value):
	print("playerNear: " + str(value))
	
	if(playerNear == value):
		return
		
	playerNear = value;
	
	if playerNear == true:
		set_handUp(true)
	elif playerNear == false:
		set_handUp(false)
		
func _on_PlayerDetectionZone_player_near(player):
	set_playerNear(true)

func _on_PlayerDetectionZone_player_gone(player):
	set_playerNear(false)

func _on_Timer_timeout():
	set_handUp(false)
