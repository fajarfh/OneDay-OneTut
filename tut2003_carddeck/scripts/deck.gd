extends Node2D

var player_deck = ['six_d','six_d','six_d','six_d','six_d','six_d']
var remaining_card = player_deck.size()

#@export var hand_count = 8
@export var card_scene_res: PackedScene
@export var draw_speed: float = 0.1

@onready var card_manager = $"../card_manager"
@onready var player_hand = $"../player_hand"
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@onready var rich_text_label = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	rich_text_label.text = str(remaining_card) 

func draw_card():
	#print("draw")
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	if player_deck.size() == 0:
		collision_shape_2d.disabled = true
		sprite_2d.visible = false
		visible = false
	
	remaining_card = player_deck.size()
	rich_text_label.text = str(remaining_card)
	
	var new_card = card_scene_res.instantiate()
	card_manager.add_child(new_card)
	new_card.name = "card_" + str(remaining_card)
	new_card.position = position
	#new_card.start_index = i+1
	player_hand.add_card_to_hand(new_card, draw_speed)
