extends CharacterBody2D

var speed:float = 100.0
var accel:float = 5.0
var moving:bool = false

@onready var nav = $NavigationAgent2D
@onready var sprite_2d = $Sprite2D

func _physics_process(delta: float) -> void:
	
	
	if moving:
		var dir = Vector3()
		dir = nav.get_next_path_position() - global_position
		dir = dir.normalized()
		
		if dir.x > 0:
			sprite_2d.flip_h = false
		
		elif dir.x < 0:
			sprite_2d.flip_h = true
		
		velocity = velocity.lerp(dir*speed,accel*delta)
		
		move_and_slide()
		
		#if velocity == Vector2.ZERO:
			

func move_to_a_point(target_post:Vector2):
	
	var old_target = nav.target_position
	if NavigationServer2D.map_get_iteration_id(nav.get_navigation_map()):
		nav.target_position = target_post
		if nav.is_target_reachable():
			moving = true
		else:
			nav.target_position = old_target
			if nav.is_target_reached():
				moving = false
	


func _on_navigation_agent_2d_target_reached():
	moving = false
