extends BaseUpgrade
class_name ScaleUpgrade

@export var scale_multiplier: float = 2.0
@export var timer: float = 2.0

var init_scale: Vector2

func apply_upgrade(char:CharacterBody2D):
	init_scale = char.scale
	char.scale *= scale_multiplier
	print("terpanggil")
	
func reset(char:CharacterBody2D):
	char.scale = init_scale
	
