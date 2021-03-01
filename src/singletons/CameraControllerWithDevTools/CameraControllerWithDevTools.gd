extends CameraController

func _ready():
	$ShakeControls.set_shake_lock(is_shake_locked)
	$ShakeControls.set_use_noise(is_use_noise)
	$ShakeControls.set_use_tween(is_use_tween)
	$ShakeControls.set_use_rotation(is_use_rotation)
	$ShakeControls.set_use_offset(is_use_offset)

func _process(delta):	
	if Input.is_action_pressed("increase_camera_shake"):
		shake_screen(0.1)
		
	if Input.is_action_pressed("decrease_camera_shake"):
		shake_screen(-0.1)	
		
	if Input.is_action_just_pressed("small_shake"):
		shake_screen(0.25)	

	if Input.is_action_just_pressed("medium_shake"):
		shake_screen(0.5)
		
	if Input.is_action_pressed("large_shake"):
		shake_screen(1)	
		
	$ShakeControls.update_shake_strength(current_shake*100)	

