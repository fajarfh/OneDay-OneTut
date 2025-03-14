extends Node2D

@onready var http_request = $HTTPRequest
@onready var rich_text_label = $RichTextLabel
@onready var button_container = $ScrollContainer/button_container

var url := "https://www.dnd5eapi.co"
var page := "/api/"

@export var button : PackedScene

func _ready():
	http_request.request(url + page)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if result == 0 and response_code == 200:
		for key in json:
			var new_button = button.instantiate()
			
			new_button.info.connect(display_data)
			new_button.text = key
			new_button.page = json[key]
			
			button_container.add_child(new_button)
			
func display_data(data):
	rich_text_label.clear()
	
	for outer_key in data["results"]: # "results" itu dari data json nya
		for key in outer_key:
			var data_text = str(key , " : " , outer_key[key])
			rich_text_label.add_text(data_text)
			rich_text_label.newline()
		rich_text_label.newline()
	
	
