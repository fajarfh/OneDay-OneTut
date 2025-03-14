extends TextureRect
@onready var panel = $Panel

var original_texture = texture
var origin = false


func _get_drag_data(at_position): # terpicu saat user nge-klik dan drag objek dari area
	
	# bikin texture dan control buat nampilin preview saat didrag
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = size
	
	var preview = Control.new()
	
	preview.add_child(preview_texture)
	preview_texture.position -= Vector2(at_position.x, at_position.y)
	
	set_drag_preview(preview) # yang nampilin preview drag
	
	texture = null
	var data = {}
	
	data["texture"] = preview_texture.texture
	data["asal"] = self
	 # mengembalikan data tekstur objek untuk didrag
									# karena texture udah dibikin null, jadi pake yang preview
									
	origin = true
	return data
	
func _can_drop_data(at_position, data): # terpicu saat user nge-hover sambil ngedrag objek di atas area
	return data["texture"] is Texture2D # ngecek apakah objek yang didrag bisa didrop atau ga
	
func _drop_data(at_position, data): # terpicu saat user ngedrop objek ke area
	data["asal"].origin = false
	texture = data["texture"] # ngeset texture sesuai objek yang didrag
	print(at_position)
	
func _notification(what):
	# saat drag gagal, balikin tekstur ke asal
	if what == NOTIFICATION_DRAG_END and not is_drag_successful():
		if origin:
			texture = original_texture
			
