extends CanvasLayer

func _ready():
	update_shake_strength(0)

func update_shake_strength(value:float):
	$ProgressBar.value = value

func set_shake_lock(value:bool):
	$MarginContainer/VBoxContainer/ShakeLock/CheckBox.pressed = value

func set_use_noise(value:bool):
	$MarginContainer/VBoxContainer/Noise/CheckBox.pressed = value

func set_use_tween(value:bool):
	$MarginContainer/VBoxContainer/Tween/CheckBox.pressed = value
	
func set_use_rotation(value:bool):
	$MarginContainer/VBoxContainer/Rotation/CheckBox.pressed = value
	
func set_use_offset(value:bool):
	$MarginContainer/VBoxContainer/Offset/CheckBox.pressed = value

func _on_ShakeLock_toggled(button_pressed):
	get_parent().is_shake_locked = button_pressed

func _on_Noise_toggled(button_pressed):
	get_parent().is_use_noise = button_pressed

func _on_Tween_toggled(button_pressed):
	get_parent().is_use_tween = button_pressed
	
func _on_Rotation_toggled(button_pressed):
	get_parent().is_use_rotation = button_pressed
	
func _on_Offset_toggled(button_pressed):
	get_parent().is_use_offset = button_pressed
