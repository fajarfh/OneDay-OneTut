extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $sprite_player
#@onready var animation_player = $AnimationPlayer

var max_speed: float = 500
var acel:Vector2
var attacking:bool = false
var tile_speed:float = 1.0
#var idle_stat = true
var needle = 1

var frame_mirror_dict: Dictionary = {
	0:1, 1:0, 2:3, 3:2,
	4:13, 5:12, 6:7, 7:6,
	8:9, 9:8, 10:11, 11:10,
	12:5, 13:4, 14:15, 15:14,
	16:17, 17:16, 18:19, 19:18
}

var mirror_frame = frame_mirror_dict[0]

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
		#if velocity.y == 0:
		needle = directiony
			#if directiony < 0:
				
				#animation_player.play("idle_back")
			#elif directiony > 0:
				#animation_player.play("idle_front")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		needle = 0
	
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

	
	#if velocity.length() != 0.0:
		#sprite_2d.animation = "walk"
		#if velocity.x > 0:
			#sprite_2d.flip_h = false
		#elif velocity.x < 0:
			#sprite_2d.flip_h = true
			
		#if tile_speed && tile_speed > 0.0:
			#sprite_2d.speed_scale = tile_speed
		#else:
			#sprite_2d.speed_scale = 1.0
	#else:
		#sprite_2d.animation = "idle"
	
	#print(velocity.length())
	
	#idle_stat = !velocity.length()
	#print(sprite_2d.frame)
	
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
	attacking = false


#func get_mirror_frame():
	#if


func _on_sprite_player_frame_changed():
	mirror_frame = frame_mirror_dict[sprite_2d.frame]
