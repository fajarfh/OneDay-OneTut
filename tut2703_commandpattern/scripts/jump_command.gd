class_name JumpCommand
extends Command

#class Params:
	##var input: float
	#var skin: AnimatedSprite2D
	#
	#func _init(skin: AnimatedSprite2D)->void:
		#self.skin = skin

#func execute(actor:ActorClass, data: Object = null)-> void:
func execute(actor:ActorClass, data: Object = null)-> void:
	#if data is Params:
		#actor.jump(data.skin)
	if actor.is_on_floor():
		actor.jump()
	
