@tool
extends Area2D

@export var label: Label
@export var sprite: Sprite2D
@export var upgrade: BaseUpgrade:
	set(val):
		upgrade = val
		need_update = true


var need_update:bool = false

func _ready():
	sprite.texture = upgrade.texture
	label.text = upgrade.upgrade_text
	
func _process(delta):
	if Engine.is_editor_hint():
		if need_update:
			sprite.texture = upgrade.texture
			label.text = upgrade.upgrade_text
			need_update = false
			
			

func _on_body_entered(body):
	if body is CharacterBody2D:
		body.upgrades.append(upgrade)
		upgrade.apply_upgrade(body)
		body.new_upgrade = upgrade
		queue_free()
	
