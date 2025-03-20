extends Node2D

const COLLISION_MASK_CARD = 5
const COLLISION_MASK_DECK = 8

@onready var card_manager = $"../card_manager"
@onready var deck = $"../deck"

signal left_mouse_click
signal left_mouse_release

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			left_mouse_click.emit()
			raycast_at_cursor()
		else:
			left_mouse_release.emit()


func raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_collision_mask = result[0].collider.collision_mask
		#print(result_collision_mask)
		
		if result_collision_mask == COLLISION_MASK_CARD:
			var card_found = result[0].collider.get_parent()
			if card_found:
				card_manager.start_drag(card_found)
		elif result_collision_mask == COLLISION_MASK_DECK:
			deck.draw_card()
