extends Node2D

@export var card_width = 50
@export var hand_y_position = 300
@export var default_card_speed = 0.1

var player_hand = []
var center_screen_x

#@onready var camera_2d = $"../Camera2D"
@onready var card_manager = $"../card_manager"

# Called when the node enters the scene tree for the first time.
func _ready():
	center_screen_x = (get_viewport_rect().size.x) * 0.5
	#print(center_screen_x)
	
func add_card_to_hand(card, speed):
	if card not in player_hand:
		player_hand.insert(0,card)
		update_hand_positions(speed)
	else:
		animate_card_to_post(card,card.start_post, default_card_speed)
	
func update_hand_positions(speed):
	for i in range(player_hand.size()):
		var new_position = Vector2(calculate_card_position(i),hand_y_position)
		var card = player_hand[i]
		card.start_post = new_position
		card.start_index = i
		animate_card_to_post(card, new_position, speed)
		
func calculate_card_position(index):
	var total_width = (player_hand.size()-1) * card_width
	var x_offset = center_screen_x + (index * card_width - total_width * 0.5)
	return x_offset
	
func animate_card_to_post(card, new_post, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_post, speed)

func remove_card(card):
	if card in player_hand:
		#print(card.start_index)
		player_hand.erase(card)
		update_hand_positions(default_card_speed)

func return_card(card):
	#print(card.start_index)
	if card not in player_hand:
		player_hand.insert(card.start_index, card)
		update_hand_positions(default_card_speed)
	#print(card.start_index)
	
