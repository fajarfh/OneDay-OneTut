extends Node2D

@export var anim_tree : AnimationTree
@onready var player = $".."

var last_dir : Vector2 = Vector2.ZERO

func _ready():
	if !anim_tree.active:
		anim_tree.active = true

func _physics_process(_delta)->void:
	
	var idle = !player.velocity
	
	#print(player.velocity)
	#print(player.velocity.length())
	#print(idle)
	#print(player.needle)
	
	if !idle:
		last_dir = player.velocity.normalized()
	
	if last_dir.y == 0 and player.needle != 0:
		last_dir.y += player.needle
		
	anim_tree.set("parameters/PlayerTree/Idle/blend_position",last_dir)
	anim_tree.set("parameters/PlayerTree/Walk/blend_position",last_dir)
	anim_tree.set("parameters/PlayerTree/Attack/blend_position",last_dir)
	
	anim_tree.set("parameters/TimeScale/scale",player.tile_speed)
