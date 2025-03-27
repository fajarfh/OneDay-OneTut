class_name ActorClass
extends CharacterBody2D

var _horizontal_input: float = 0.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var skin: AnimatedSprite2D
var _controller_container : Node
var _controller : ActorController
var from_sky:bool = false
var force_stop:bool = false

signal epic_landing

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if force_stop:
			velocity.x = 0
		
		from_sky = true
		if skin.animation != "jump":
			skin.play("jump")
	else:
		if from_sky:
			from_sky = false
			epic_landing.emit()
		if skin.animation != "idle":
			skin.play("idle")
			
	if velocity.x > 0:
		skin.flip_h = true
	elif velocity.x < 0:
		skin.flip_h = false
	
	move_and_slide()

func move(value:float)->void:

	_horizontal_input = value
	
	if _horizontal_input:
		velocity.x = _horizontal_input * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.x = 0

func jump()->void:
	velocity.y = JUMP_VELOCITY

func set_controller(controller: ActorController)->void:
	for child in _controller_container.get_children():
		child.queue_free()
	
	force_stop = false
		
	_controller = controller
	_controller_container.add_child(_controller)

func delete_controller()->void:
	for child in _controller_container.get_children():
		child.queue_free()
