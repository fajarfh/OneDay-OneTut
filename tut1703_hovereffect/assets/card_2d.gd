extends Node2D

signal hovered
signal hovered_off

func _ready():
	
	get_parent().connect_card_signals(self)
	
func _on_area_2d_mouse_entered():
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited():
	hovered_off.emit(self)
