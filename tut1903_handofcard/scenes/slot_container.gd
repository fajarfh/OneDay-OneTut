extends Node2D

@export var slot_count = 4
@export var slot_scene_res:PackedScene

@export var slot_width = 50
@export var slot_position = 100

var slots = []
var center_screen_x

@onready var camera_2d = $"../Camera2D"

func _ready():
	center_screen_x = (camera_2d.get_viewport_rect().size.x/camera_2d.zoom.x) * 0.5
	
	for i in range(slot_count):
		var new_slot = slot_scene_res.instantiate()
		add_child(new_slot)
		new_slot.name = "slot_" + str(i)
		add_card_to_hand(new_slot)
	update_slot_positions()
	
func add_card_to_hand(slot):
	if slot not in slots:
		slots.insert(0,slot)
		
func update_slot_positions():
	for i in range(slot_count):
		print("kelo")
		var new_position = Vector2(calculate_slot_position(i),slot_position)
		slots[i].position = new_position
		
func calculate_slot_position(index):
	var total_width = (slots.size()-1) * slot_width
	var x_offset = center_screen_x + (index * slot_width - total_width * 0.5)
	return x_offset
	
