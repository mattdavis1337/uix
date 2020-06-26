extends Node2D

export(int) var wander_range = 32

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func ready():
	choose_target_position()

func choose_target_position():
	print('choosing new position')
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = global_position + target_vector
	
	return target_position
	
func get_time_left():
	return timer.time_left

func start_wander_timer(duration):
	print('starting wander timer')
	timer.start(duration)

func _on_Timer_timeout():
	print('wander time up')
	choose_target_position()
