extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if animated_sprite_2d.animation != "jump":
			animated_sprite_2d.play("jump")
	else:
		if animated_sprite_2d.animation != "idle":
			animated_sprite_2d.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Rigidbody"):
		body.collision_layer = 1
		body.collision_mask = 1


func _on_area_2d_body_exited(body):
	if body.is_in_group("Rigidbody"):
		body.collision_layer = 2
		body.collision_mask = 2
