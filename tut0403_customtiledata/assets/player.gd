extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

var max_speed: float = 500
var acel:Vector2

func _physics_process(delta):

	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx = Input.get_axis("move_left", "move_right")
	if directionx:
		velocity.x = directionx
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directiony = Input.get_axis("move_up", "move_down")
	if directiony:
		velocity.y = directiony
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	velocity = velocity.normalized() * SPEED
		
	var tile_speed = get_tile_data(&"tile_speed")
	var speed_change = get_tile_data(&"speed_change")
	
	if tile_speed && tile_speed > 0.0:
		velocity *= tile_speed

	if speed_change:
		velocity += speed_change

	
	if velocity.length() != 0.0:
		sprite_2d.animation = "walk"
		if velocity.x > 0:
			sprite_2d.flip_h = false
		elif velocity.x < 0:
			sprite_2d.flip_h = true
			
		if tile_speed && tile_speed > 0.0:
			sprite_2d.speed_scale = tile_speed
		else:
			sprite_2d.speed_scale = 1.0
	else:
		sprite_2d.animation = "idle"
	
	print(velocity.length())
	
		
	move_and_slide()

func get_tile_data(data_name: StringName) -> Variant:
	var tilemaps := get_tree().get_nodes_in_group(&"tilemap")
	tilemaps.reverse()
	
	for map in tilemaps:
		var ret = _get_data_from_tilemap(data_name, map)
		if ret != null:
			return ret
	
	return null

func _get_data_from_tilemap(data_name: StringName, tilemap: TileMapLayer) -> Variant:
	var cell : Vector2i = tilemap.local_to_map(position)
	var data : TileData = tilemap.get_cell_tile_data(cell)
	if data:
		var tile_data = data.get_custom_data(data_name)
		if tile_data:
			return tile_data
		
	return null
