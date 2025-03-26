extends Control

@onready var effects = $"../effects"
@onready var option_button = $OptionButton

func _ready():
	for item in effects.get_children():
		option_button.add_item(item.name)


func _on_option_button_item_selected(index):
	for i in range(effects.get_child_count()):
		if index == i:
			effects.get_child(i).show()
		else:
			effects.get_child(i).hide()
