extends Node2D


@export var spawn:Node2D
@export var end_area:Area2D

signal pindah_ah()


func _on_area_2d_body_entered(_body):
	await get_tree().create_timer(2.0).timeout
	
	pindah_ah.emit()
