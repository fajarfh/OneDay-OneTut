extends Node2D

#var posisi : Vector2
@onready var character_body_2d = $CharacterBody2D
@onready var label = $Label

@export var curve_this : Curve
@export var max_damage : float = 1000
@export var hit_scan_range : float = 100

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				print(event.position)
				var final_damage = count_damage(event.position, character_body_2d.position)
				label.text = str("Damage: ", round(final_damage[0]),"\n","Jarak: ",round(final_damage[1]))
				label.position = Vector2(event.position.x, event.position.y + 50)
				

func count_damage(click_pos: Vector2, plane_pos:Vector2)->Array[float]:
	var distance = (click_pos-plane_pos).length()
	var damage = max_damage * curve_this.sample(distance/hit_scan_range)
	return [damage,distance]
	
