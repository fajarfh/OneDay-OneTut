class_name MovementCommand
extends Command

class Params:
	var input: float
	#var skin: AnimatedSprite2D
	
	#func _init(input: float, skin: AnimatedSprite2D)->void:
	func _init(input: float)->void:
	
		self.input = input
		#self.skin = skin

func execute(actor:ActorClass, data: Object = null)-> void:
	if data is Params:
		#actor.move(data.input,data.skin)
		actor.move(data.input)	
		
