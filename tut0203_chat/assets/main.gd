extends Node2D


@onready var text_edit = $Control/HBoxContainer/VBoxContainer/TextEdit
@onready var message = $Control/HBoxContainer/VBoxContainer/HBoxContainer2/Message
@onready var send = $Control/HBoxContainer/VBoxContainer/HBoxContainer2/Send
@onready var host = $Control/HBoxContainer/VBoxContainer/HBoxContainer/Host
@onready var join = $Control/HBoxContainer/VBoxContainer/HBoxContainer/Join
@onready var username = $Control/HBoxContainer/VBoxContainer/HBoxContainer/Username
@onready var h_box_container_2 = $Control/HBoxContainer/VBoxContainer/HBoxContainer2

var usrnm : String
var msg : String



func _on_host_pressed():
	if username.text == "":
		username.text = "HOST"
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(1027)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	joined()

func _on_join_pressed():
	
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1",1027)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	if username.text == "":
		username.text = "CLIENT1"
	joined()
	
	

@rpc("any_peer","call_local")
func message_rpc(username, data):
	text_edit.text += str(username," : ", data,"\n")
	text_edit.scroll_vertical = text_edit.get_line_count()

func _on_send_pressed():
	rpc("message_rpc", usrnm, message.text)
	message.text = ""

func joined():
	
	host.hide()
	username.hide()
	join.hide()
	usrnm = username.text
	h_box_container_2.show()
