extends KinematicBody2D


enum {
	IDLE,
	WANDER
}

var state = IDLE
var velocity = Vector2.ZERO

export var ACCELERATION = 100
export var MAX_SPEED = 20
export var FRICTION = 200
export var moveVector = Vector2.ZERO

onready var wander_controller = $TurtleWanderController
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var distanceMoved = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	state = IDLE
	wander_controller.start_wander_timer(rand_range(1,5))

func _physics_process(delta):	
	match state:
		IDLE: 
			stop_moving(delta)
			
			if wander_controller.get_time_left() == 0:
				wander_controller.choose_target_position()
				state = WANDER			
		WANDER:
			accelerate_towards_point(wander_controller.target_position, delta)			
			
			if global_position.distance_to(wander_controller.target_position) <= MAX_SPEED * delta:
				print('arrived')
				wander_controller.start_wander_timer(rand_range(1,5))
				state = IDLE
						
	velocity = move_and_slide(velocity)
	
func accelerate_towards_point(point, delta):
	moveVector = global_position.direction_to(point).normalized()
	animationTree.set("parameters/Walk/blend_position", moveVector)
	animationState.travel("Walk")
	velocity = velocity.move_toward(moveVector * MAX_SPEED, ACCELERATION * delta)
	
func stop_moving(delta):
	animationTree.set("parameters/Idle/blend_position", moveVector)
	if velocity != Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		animationState.travel("Idle")
	
	
func update_wander():
	print("update wander")
	state = pick_random_state([IDLE, WANDER])
	#wander_controller.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
