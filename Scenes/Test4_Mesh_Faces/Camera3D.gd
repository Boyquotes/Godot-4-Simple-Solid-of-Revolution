extends Camera3D
@export var speed = 1



func _input(_event) -> void:
	
	if Input.is_action_pressed("w"):
		position.z -= speed
	elif Input.is_action_pressed("s"):
		position.z += speed

	if Input.is_action_pressed("d"):
		position.x -= speed
	elif Input.is_action_pressed("a"):
		position.x += speed
		
	if Input.is_action_pressed("space"):
		position.y += speed
	elif Input.is_action_pressed("ctrl"):
		position.y -= speed
	
	if Input.is_action_pressed("e"):
		rotate_y(speed)
	elif Input.is_action_pressed("q"):
		rotate_y(-speed)
