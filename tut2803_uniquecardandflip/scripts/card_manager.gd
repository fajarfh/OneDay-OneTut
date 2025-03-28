extends Node2D
const COLLISION_MASK_CARD = 5
const COLLISION_MASK_SLOT = 2

var dragged_card : CardObject
var screen_size
var drag_start = true
var mouse_dist
var is_top_stack
var origin_scale = Vector2.ONE
var slot_detected:Node2D
var mask_detected


@export var card_scaling: Vector2 = Vector2(0.02,0.02)
@export var default_card_speed = 0.1

@onready var player_hand = $"../player_hand"
@onready var input_manager = $"../input_manager"

func _ready():
	screen_size = get_viewport_rect().size
	input_manager.connect("left_mouse_click", on_left_clicked)
	input_manager.connect("left_mouse_release", on_left_released)
	

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

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#print(result[0].collider.get_parent().name)
		return get_highest_z(result)
	return null

func raycast_check_for_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#print(result[0].collider.get_parent().name)
		return result[0].collider.get_parent()
	return null

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)
	card.connect("slot_alter_found", slot_detect)
	card.connect("slot_alter_reset", slot_reset)


func on_hovered_over_card(card):
	#print("hovered")
	if !is_top_stack:
		is_top_stack = true
		highlight_card(card,true)

func on_hovered_off_card(card):
	if !dragged_card:
		#print("hovered_off")
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
	dragged_card.z_index = 5
	player_hand.remove_card(card)

func finish_drag():
	if dragged_card:
		dragged_card.scale = origin_scale + card_scaling
		
		var card_slot_found : CardSlot = raycast_check_for_slot()
		#var card_slot_alter = check_slot_card_collision(dragged_card)
		var card_slot_alter : CardSlot = slot_detected
		
		if not card_slot_found and card_slot_alter:
			card_slot_found = card_slot_alter
		#print(card_slot_found)
		if card_slot_found and not card_slot_found.occupied:
			#print("huh")
			#player_hand.remove_card(dragged_card)
			var new_position = card_slot_found.position
			#dragged_card.position = card_slot_found.position
			animate_card_to_post(dragged_card, new_position, default_card_speed)
			#dragged_card.get_node("Area2D/CollisionShape2D").disabled = true
			#dragged_card.area_2d.process_mode = Node.PROCESS_MODE_DISABLED
			#dragged_card.area_2d.monitorable = false
			#dragged_card.area_2d.monitoring = false
			#dragged_card.collision_shape_2d.set_deferred("disabled", true)
			
			dragged_card.area_2d.collision_mask = 0
			
			#card_slot_found.occupied = dragged_card
		#elif not card_slot_found and card_slot_found.occupied == dragged_card:
			#card_slot_found.occupied = null
			card_slot_found.occupied = true
			card_slot_found.occupying_card = dragged_card
		else:
			#player_hand.add_card_to_hand(dragged_card)
			player_hand.return_card(dragged_card)
		
		dragged_card.z_index = 1

		dragged_card = null

func animate_card_to_post(card, new_post, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_post, speed)
	card.z_index = 10
		

func check_slot_card_collision(card:Node2D):
	var area2d:Area2D = card.get_node("Area2D")
	var areas = area2d.get_overlapping_areas()

	if areas.size() > 0:
		#print(result[0].collider.get_parent().name)
		return areas[0].get_parent()
	return null

func slot_detect(slot, mask):
	mask_detected = mask
	#print(mask_detected)
	if mask_detected != COLLISION_MASK_CARD:
		slot_detected = slot
	else:
		slot_detected = null
		
	
func slot_reset(slot):
	slot_detected = null

func on_left_clicked():
	pass
	
func on_left_released():
	#print("lepas")
	if dragged_card:
		finish_drag()
