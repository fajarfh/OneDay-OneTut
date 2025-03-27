class_name HumanController
extends ActorController

func _physics_process(_delta)->void:
	var movement_input = Input.get_axis("ui_left", "ui_right")
	movement_command.execute(actor, MovementCommand.Params.new(movement_input))
	
	if Input.is_action_just_pressed("ui_accept"):
		jump_command.execute(actor)
