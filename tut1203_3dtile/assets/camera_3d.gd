extends Camera3D

var SPEED = 0.05

func _process(_delta) -> void:
	
	
	var directionx = Input.get_axis("ui_left", "ui_right")
	if directionx:
		rotation_degrees.y -= directionx
		
	
	var directionz = Input.get_axis("ui_up", "ui_down")
	if directionz:
		position += directionz * basis.z * SPEED
	
	
