class_name AIController
extends ActorController

var _init_time:int = 0
var jump_direction = -1
var jump_count = 0
var jump_limit = 3

signal movement_end

func _ready():
	print("start")
	_init_time = Time.get_ticks_msec()
	actor.connect("epic_landing", after_land)
	
func _physics_process(_delta) -> void:
	var current_time = Time.get_ticks_msec() - _init_time
	if current_time < 500:
		movement_command.execute(actor, MovementCommand.Params.new(-1.0))
	else:
		if jump_count < jump_limit:
			jump_command.execute(actor)
			movement_command.execute(actor, MovementCommand.Params.new(jump_direction))
		else:
			actor.velocity = Vector2(0.0,0.0)
			movement_end.emit()
		
func after_land():
	jump_direction *= -1
	jump_count += 1
	
