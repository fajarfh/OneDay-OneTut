class_name NPCClass
extends ActorClass

func _ready()->void:
	skin = $AnimatedSprite2D
	_controller_container = $ControllerContainer

func _on_area_2d_body_entered(body):
	if body.is_in_group("Rigidbody"):
		body.collision_layer = 1
		body.collision_mask = 1

func _on_area_2d_body_exited(body):
	if body.is_in_group("Rigidbody"):
		body.collision_layer = 2
		body.collision_mask = 2
