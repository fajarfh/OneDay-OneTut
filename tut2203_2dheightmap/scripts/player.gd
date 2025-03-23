extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = 100.0

@onready var sprite_2d = $sprite_player
@onready var tilemap:TileMapLayer = get_tree().current_scene.find_child("TileMapLayer")
#@onready var animation_player = $AnimationPlayer

var acel:Vector2
var attacking:bool = false
#var idle_stat = true
var needle = 1
var init_pos


var is_jumping:bool = false:
	set(value):
		is_jumping = value
		if value:
			%State.text = "air"
		else:
			%State.text = "land"

var floors:int = 0:
	set(value):
		floors = value
		%Floor.text = str(value)

var height:int = 0:
	set(value):
		height = value
		z_index = value
		%Height.text = str(value)

var z_pos:float = 0:
	set(value):
		z_pos = value
		%ZPost.text = str("%.2f" % value)

func update_tile():
	#var tiledata = tilemap.get_cell_tile_data(tilemap.local_to_map(position))
	#if tiledata:
		#floors = tiledata.get_custom_data(&"height")
	
	return _get_data_from_tilemap(&"height", tilemap)
	
func jump():
	if Input.is_action_just_pressed("jump"):
		if is_jumping == false:
			height += 1
			#init_pos = position.y
			velocity.y = -JUMP_VELOCITY
		is_jumping = true

func in_air():
	if is_jumping:
		velocity.y += 9.8
		if velocity.y >= 0.8*JUMP_VELOCITY:
			#velocity.y = 0
			is_jumping = false
			height -=1
		velocity.x = Input.get_axis("move_left","move_right")*0.75*SPEED
		
		if floors == height:
			is_jumping = false
			#velocity = Vector2.ZERO

func _physics_process(_delta):
	
	if update_tile() != null:
		floors = update_tile()
		#print(floors)
		
	#update_tile()
		
	
	z_pos = position.y

	attacking = Input.is_action_pressed("attack")
	
	var directionx = Input.get_axis("move_left", "move_right")
	if !is_jumping:
		if directionx && !attacking:
			velocity.x = directionx
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directiony = Input.get_axis("move_up", "move_down")
	if !is_jumping:
		if directiony && !attacking && !is_jumping:
			velocity.y = directiony
			needle = directiony
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			needle = 0
	if !is_jumping:	
		velocity = velocity.normalized() * SPEED
			
	if !is_jumping:	
		if floors < height:
			is_jumping = true
			#height = floors
	
	jump()
	in_air()
	
	move_and_slide()

func get_tile_data(data_name: StringName) -> Variant:
	var tilemaps := get_tree().get_nodes_in_group(&"tilemap")
	tilemaps.reverse()
	
	for map in tilemaps:
		var ret = _get_data_from_tilemap(data_name, map)
		if ret != null:
			return ret
	
	return null

func _get_data_from_tilemap(data_name: StringName, tile_map: TileMapLayer) -> Variant:
	var cell : Vector2i = tile_map.local_to_map(position)
	var data : TileData = tile_map.get_cell_tile_data(cell)
	if data:
		var tile_data = data.get_custom_data(data_name)
		if tile_data != null:
			return tile_data
		
	return null

func end_attack()-> void:
	attacking = false
