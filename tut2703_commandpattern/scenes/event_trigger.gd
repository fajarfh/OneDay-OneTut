extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var npc = $"../NPC"

var body_temp : PlayerClass

func _on_body_entered(body):
	#print("ga masuk")
	if body is PlayerClass:
		print("masuk")
		body_temp = body
		body.delete_controller()
		body.force_stop = true
		var ai_control = AIController.new(npc)
		ai_control.connect("movement_end", callable_end)
		npc.set_controller(ai_control)
		#queue_free()

func callable_end():
	body_temp.set_controller(HumanController.new(body_temp))
	npc.force_stop = true
	npc.delete_controller()
	queue_free()
