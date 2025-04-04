extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#@onready var sprite_2d = $Sprite2D
@onready var sprite_player = $sprite_player

var max_speed: float = 500
var acel:Vector2
var attacking:bool = false:
	set(new):
		if new == true and attacking == false:
			flash_effect()
		attacking = new
		
var tile_speed:float = 1.0

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#if !attacking:
	attacking = Input.is_action_pressed("attack")
	
	var directionx = Input.get_axis("move_left", "move_right")
	if directionx && !attacking:
		velocity.x = directionx
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directiony = Input.get_axis("move_up", "move_down")
	if directiony && !attacking:
		velocity.y = directiony
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	velocity = velocity.normalized() * SPEED
		
	if get_tile_data(&"tile_speed"): 
		tile_speed = get_tile_data(&"tile_speed")
	else:
		tile_speed = 1.0	
		
	var speed_change = get_tile_data(&"speed_change")
	
	if tile_speed && tile_speed > 0.0:
		velocity *= tile_speed

	if speed_change:
		velocity += speed_change

	#print(velocity.length())
		
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

func end_attack()-> void:
	if !Input.is_action_pressed("attack"):
		attacking = false

func flash_effect():
	sprite_player.material.set_shader_parameter("flash_modifier", 0.6)
	await get_tree().create_timer(0.1).timeout
	sprite_player.material.set_shader_parameter("flash_modifier", 0.0)
	
