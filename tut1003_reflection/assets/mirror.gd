class_name Mirror
extends Node2D

@export var character:CharacterBody2D
@export var offset: Vector2 = Vector2.ZERO
@export var fade_rate: float = 0.002
@onready var reflect = $reflection_sprite

func _process(_delta):
	var dist_y := character.global_position.y - global_position.y

	reflect_post(dist_y)
	reflect.frame = character.mirror_frame
	
	fade_mirrot(dist_y)


func reflect_post(dist):
	reflect.global_position = Vector2(
		character.global_position.x,
		global_position.y - dist
	) + offset
	
func fade_mirrot(dist):
	reflect.modulate.a = 0.9 - dist * fade_rate
