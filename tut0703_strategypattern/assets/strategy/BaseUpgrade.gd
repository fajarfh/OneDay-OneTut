extends Resource

class_name BaseUpgrade

@export var texture:Texture2D = preload("res://assets/strategy/tes1.tres")
@export var upgrade_text:String = "Upgrade"


func apply_upgrade(char:CharacterBody2D):
	pass

func reset(char:CharacterBody2D):
	pass
