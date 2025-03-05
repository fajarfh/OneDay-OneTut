extends Node2D

@onready var character_body_2d = $CharacterBody2D
@onready var polygon_2d = $Polygon2D
@onready var animation_player = $Polygon2D/AnimationPlayer

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				print(event.position)
				#get_world_2d().
				character_body_2d.move_to_a_point(event.position)
				polygon_2d.position = event.position
				animation_player.play("blink")
	
