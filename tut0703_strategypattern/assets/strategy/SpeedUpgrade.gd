extends BaseUpgrade
class_name SpeedUpgrade

@export var speed_multiplier: float = 2.0
@export var timer: float = 5.0
var init_speed: float

func apply_upgrade(char:CharacterBody2D):
	init_speed = char.speed
	char.speed *= speed_multiplier
	
func reset(char:CharacterBody2D):
	char.speed = init_speed
