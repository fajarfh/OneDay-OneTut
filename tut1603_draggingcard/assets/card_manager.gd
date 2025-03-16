extends Node2D

const COLLISION_MASK_LAYER = 1

var dragged_card
var screen_size
var drag_start = true
var mouse_dist

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta) -> void:
	if dragged_card:
		var mouse_pos = get_global_mouse_position()
		
		if drag_start:
			drag_start = false
			mouse_dist = mouse_pos - dragged_card.position
			
		var new_card_pos = mouse_pos - mouse_dist
		
		dragged_card.position = Vector2(
			clamp(new_card_pos.x, 0, screen_size.x),
			clamp(new_card_pos.y, 0, screen_size.y)
		)
	else:
		drag_start = true

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var card = raycast_check_for_card()
			if card:
				dragged_card = card
		else:
			dragged_card = null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_LAYER
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		print(result[0].collider.get_parent().name)
		return result[0].collider.get_parent()
	return null
