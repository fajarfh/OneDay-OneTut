extends Node2D

@onready var rich_text_label = $RichTextLabel
@onready var button_container = $ScrollContainer/button_container

@export var button : PackedScene
@export var json_path : String

func _ready():
	load_buttons()

func display_data(button_id):
	rich_text_label.clear()
	
	var json_data = load_json_data(json_path).get("Sheet1")
	if json_data != null:
		
		var button_data = json_data.get(button_id)
		
		if button_data != null:
			for key in button_data: # "results" itu dari data json nya
				var data_text = str(key , " : " , button_data[key])
				print(data_text)
				rich_text_label.add_text(data_text)
				rich_text_label.newline()
	
func load_json_data(data:String):
	var file_string = FileAccess.get_file_as_string(data)
	print(data)
	var json_data
	if file_string != null:
		json_data = JSON.parse_string(file_string)
	
	else:
		push_warning("File data tidak ada. load_json_data memanggil file dari: ", data)
		
	if json_data == null:
		push_warning("Isi file kosong/tidak bisa di-parse. load_json_data memanggil file dari: ", data)
	
	return json_data

func load_buttons():
	var our_data = load_json_data(json_path)
	
	if our_data != null:
		var data_sheet = our_data.get("Sheet1")
		
		if data_sheet != null:
	
			for key in data_sheet:
				var new_button = button.instantiate()
				
				new_button.info.connect(display_data)
				new_button.text = data_sheet[key]["NAME"]
				new_button.button_id = key
				
				button_container.add_child(new_button)	
