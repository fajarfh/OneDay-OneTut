extends Control

@onready var key_transition = $KeyTransition
var togglin = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if togglin:
		key_transition.get_node("AnimationPlayer").play("swipein")
		togglin = false
	else:
		key_transition.get_node("AnimationPlayer").play("swipeout")
		togglin = true
