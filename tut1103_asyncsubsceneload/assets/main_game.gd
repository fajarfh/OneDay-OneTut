extends Control

@onready var loading = $"../Panel"
@onready var player = $CharacterBody2D
@onready var current_map = $map1

var map_idx = 0
var async_path = ""
var new_map_name = ""

var maps : Dictionary = {
	"map1" : "res://assets/map1.tscn",
	"map2" : "res://assets/map2.tscn",
	"map3" : "res://assets/map3.tscn"
}

func _ready():
	map_idx = -1
	swap_scenes_basic()
	

func _on_button_pressed():
	swap_scenes_basic()
	
func swap_scenes_basic():
	map_idx += 1
	
	player.visible = false
	
	if map_idx > maps.size()-1:
		map_idx = 0

	new_map_name = maps.keys()[map_idx]
	print(new_map_name)
	
	async_path = maps[new_map_name]
	
	var tween = create_tween().tween_property(current_map, "modulate:a", 0, 0.05)
	
	await tween.finished
	
	loading.visible = true
	
	remove_child(current_map)
	
	ResourceLoader.load_threaded_request(async_path)
	
	
func _process(_delta):
	if loading.visible:
		if ResourceLoader.load_threaded_get_status(async_path) == ResourceLoader.THREAD_LOAD_LOADED:
			var loaded_map = ResourceLoader.load_threaded_get(async_path)
			current_map = loaded_map.instantiate()
			current_map.name = new_map_name
			current_map.connect("pindah_ah", signal_catcher)
			await get_tree().create_timer(1.5).timeout
			
			add_child(current_map)
			current_map.modulate.a = 0
			loading.visible = false
			
			var tween = create_tween().tween_property(current_map, "modulate:a", 1.0, 0.05)
			
			await tween.finished
			
			player.global_position = current_map.spawn.global_position
			player.visible = true
			
	
func signal_catcher():
	swap_scenes_basic()
	
	
