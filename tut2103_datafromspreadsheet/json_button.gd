extends Button

var button_id

signal info(data)

func _on_pressed():
	info.emit(button_id)
	
