extends BaseUpgrade
class_name RageUpgrade

@export var rage_color: Color = Color.RED
@export var timer: float = 5.0
var init_color: Color

func apply_upgrade(char:CharacterBody2D):
	init_color = char.color_change
	char.modulate = rage_color
	
func reset(char:CharacterBody2D):
	char.modulate = init_color
