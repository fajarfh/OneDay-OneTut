extends CharacterBody2D


const max_speed = 400.0
var acel : Vector2
#var friction


func _physics_process(delta):
	
	#if get_tile_data(&"speed_change") != null:
		#acel = get_tile_data(&"speed_change")
		#
		#velocity += acel*delta
		#velocity = velocity.clampf(-max_speed, max_speed)
	var speed_change = get_tile_data(&"speed_change")
	if speed_change:
		velocity = speed_change
	
	var friction = get_tile_data(&"friction")
	if friction:
		if friction == 0:
			friction = 50
	else:
		friction = 50
	
	velocity = velocity.move_toward(Vector2.ZERO,friction*delta)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body is CharacterBody2D:
			velocity = collision.get_normal() * collision.get_collider_velocity().length()

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
