class_name ActorController
extends Node

var actor:ActorClass

var movement_command:= MovementCommand.new()
var jump_command:= JumpCommand.new()

func _init(actor: ActorClass):
	self.actor = actor
	
