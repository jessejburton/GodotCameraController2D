extends Node
class_name CameraController

onready var timer = Timer.new()
onready var movement_tween = Tween.new()
onready var rotation_tween = Tween.new()

export var max_angle = 15
export var max_offset = 10
export var max_shake = 1
export var is_shake_locked:bool = true
export var is_use_noise:bool = true
export var is_use_tween:bool = true
export var is_use_rotation:bool = true
export var is_use_offset:bool = true

var current_camera:Camera2D = null
var current_shake:float = 0.0
var shake_speed:float = 0.05
var cool_down_speed:float = 0.5

var noise = OpenSimplexNoise.new()
var noise_offset = 0

func _ready():
	randomize()
	noise.seed = randi()
	noise.octaves = 3
	noise.period = 20.0
	noise.persistence = 0.5
	
	add_child(timer)
	add_child(movement_tween)
	add_child(rotation_tween)
	
	timer.connect("timeout", self, "_on_ShakeTimer_timeout")
	timer.wait_time = shake_speed
	
	movement_tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	rotation_tween.connect("tween_all_completed", self, "_on_tween_all_completed")	

func _process(delta):	
	if current_shake > 0:
		_screen_shake_loop()

func set_current_camera(camera:Camera2D):
	current_camera = camera
	current_camera.rotating = true

# SCREEN SHAKE
func _move_camera_to(position:Vector3):
	if is_use_tween:
		if is_use_offset:
			movement_tween.interpolate_property(
				current_camera, 
				"offset", 
				current_camera.offset, 
				Vector2(position.x, position.y), 
				shake_speed, 
				Tween.TRANS_SINE, 
				Tween.EASE_OUT, 
				0
			)
			movement_tween.start()	
		if is_use_rotation:
			rotation_tween.interpolate_property(
				current_camera, 
				"rotation_degrees", 
				current_camera.rotation_degrees, 
				position.z, 
				shake_speed, 
				Tween.TRANS_SINE, 
				Tween.EASE_OUT, 
				0
			)
			rotation_tween.start()	
		else:
			current_camera.rotation_degrees = position.z	
	else:
		if is_use_offset:
			current_camera.offset.x = position.x
			current_camera.offset.y = position.y
		if is_use_rotation:
			current_camera.rotation_degrees = position.z	
		else:
			current_camera.rotation_degrees = 0				
		timer.start()

func shake_screen(shake:float):
	current_shake = clamp(current_shake + shake, 0, max_shake)
	_move_camera_to(_get_random_position())

func _screen_shake_loop():
	if !is_shake_locked:
		if current_shake > 0.01:
			current_shake = lerp(current_shake, 0, cool_down_speed)
		else:
			current_shake = 0

func _get_random_position():
	if is_use_noise:
		noise_offset += 30
		noise.seed = noise.seed + 1
		var angle = max_angle * current_shake * noise.get_noise_1d(noise_offset)
		
		noise_offset += 30
		noise.seed = noise.seed + 1		
		var offsetx = max_offset * current_shake * noise.get_noise_1d(noise_offset)	
		
		noise.seed = noise.seed + 1		
		var offsety = max_offset * current_shake * noise.get_noise_1d(noise_offset)
		return Vector3(offsetx, offsety, angle)
	else:
		var angle = max_angle * current_shake * rand_range(-1,1)
		var offsetx = max_offset * current_shake * rand_range(-1,1)
		var offsety = max_offset * current_shake * rand_range(-1,1)
		return Vector3(offsetx, offsety, angle)
		
func _on_tween_all_completed():
	if current_shake > 0:
		_move_camera_to(_get_random_position())

func _on_ShakeTimer_timeout():
	if current_shake > 0:
		_move_camera_to(_get_random_position())
