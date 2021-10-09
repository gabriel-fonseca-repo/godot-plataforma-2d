extends Node

func _ready():
	pass

func _on_Button_pressed():
	Socket.connect_to_server()

func _on_Button2_pressed():
	Socket.write_text("1 Sobe\n")
