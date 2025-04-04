extends CharacterBody2D


var speed:float = 300.0
var jump_velocity:float = -400.0
var scale_change:float = 1.0
var color_change:Color = Color.WHITE

var upgrades : Array[BaseUpgrade] = []
var new_upgrade: BaseUpgrade:
	set(new_one):
		new_upgrade = new_one
		count_normal(new_upgrade)

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
		velocity.y = jump_velocity
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if velocity.x > 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = false

	move_and_slide()

func count_normal(upgrade:BaseUpgrade):
	await get_tree().create_timer(upgrade.timer).timeout
	upgrade.reset(self)
