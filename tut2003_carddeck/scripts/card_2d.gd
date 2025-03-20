extends Node2D

signal hovered
signal hovered_off

signal slot_alter_found
signal slot_alter_reset

var start_post
var start_index

func _ready():
	
	get_parent().connect_card_signals(self)
	
func _on_area_2d_mouse_entered():
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited():
	hovered_off.emit(self)


func _on_area_2d_area_entered(area:Area2D):
	slot_alter_found.emit(area.get_parent(), area.collision_mask)


func _on_area_2d_area_exited(area):
	slot_alter_reset.emit(area.get_parent())
