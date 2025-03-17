extends Node2D
const COLLISION_MASK_LAYER = 1

var dragged_card
var screen_size
var drag_start = true
var mouse_dist
var is_top_stack

@export var card_scaling: Vector2 = Vector2(0.02,0.02)
var origin_scale = Vector2.ONE

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
				start_drag(card)
		else:
			finish_drag()

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_LAYER
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#print(result[0].collider.get_parent().name)
		return get_highest_z(result)
	return null

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	print("hovered")
	if !is_top_stack:
		is_top_stack = true
		highlight_card(card,true)

func on_hovered_off_card(card):
	if !dragged_card:
		print("hovered_off")
		highlight_card(card,false)
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered,true)
		else:
			is_top_stack = false

func highlight_card(card, hovered):
	if hovered:
		card.scale = origin_scale + card_scaling
		card.z_index = 2
	else:
		card.scale = origin_scale
		card.z_index = 1
	

func get_highest_z(cards):
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	for i in range (1,cards.size()):
		var current_card = cards[i].collider.get_parent()
		var current_z_index = current_card.z_index
		
		if current_z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_z_index
	
	return highest_z_card
	
func start_drag(card):
	dragged_card = card
	dragged_card.scale = origin_scale

func finish_drag():
	if dragged_card:
		dragged_card.scale = origin_scale + card_scaling
		dragged_card = null


		
