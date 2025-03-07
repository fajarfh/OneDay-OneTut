extends BaseUpgrade
class_name JumpUpgrade

@export var jump_multiplier: float = 2.0
@export var timer: float = 5.0

var init_jump: float

func apply_upgrade(char:CharacterBody2D):
	init_jump = char.jump_velocity
	char.jump_velocity *= jump_multiplier
	
func reset(char:CharacterBody2D):
	char.jump_velocity = init_jump
