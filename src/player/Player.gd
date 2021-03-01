extends KinematicBody2D

const GRAVITY = 10
const FRICTION = 0.3
const MAX_SPEED = 150

var velocity:Vector2 = Vector2.ZERO
var acceleration:int = 10
var jump_strength:int = 250

func _ready():
	CameraControllerWithDevTools.set_current_camera($Camera2D)
	pass # Replace with function body.

func _physics_process(delta):
	_get_unhandled_input()
		
	velocity = move_and_slide(velocity, Vector2.UP)

func _get_unhandled_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -MAX_SPEED)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, MAX_SPEED)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION)	
		
	velocity.y += GRAVITY		

	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = -jump_strength	
