extends Control

var selected_skin = ""

func _ready():
	if selected_skin == "":
		selected_skin = "res://assets/skins/skin1.png"
	load_skin()
	update_ui()


func _on_skin_1_pressed() -> void:
	selected_skin = "res://assets/skins/skin1.png"
	save_skin()
	update_ui()


func _on_skin_2_pressed() -> void:
	selected_skin = "res://assets/skins/skin2.png"
	save_skin()
	update_ui()


func _on_skin_3_pressed() -> void:
	selected_skin = "res://assets/skins/skin3.png"
	save_skin()
	update_ui()


func save_skin():
	var config = ConfigFile.new()
	config.set_value("player", "skin", selected_skin)
	config.save("user://settings.cfg")

func load_skin():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		selected_skin = config.get_value("player", "skin", "")

func update_ui():

	$GridContainer/Skin1.modulate = Color(0.7,0.7,0.7,1)
	$GridContainer/Skin2.modulate = Color(0.7,0.7,0.7,1)
	$GridContainer/Skin3.modulate = Color(0.7,0.7,0.7,1)

	if selected_skin == "res://assets/skins/skin1.png":
		$GridContainer/Skin1.modulate = Color(1,1,1,1)
	elif selected_skin == "res://assets/skins/skin2.png":
		$GridContainer/Skin2.modulate = Color(1,1,1,1)
	elif selected_skin == "res://assets/skins/skin3.png":
		$GridContainer/Skin3.modulate = Color(1,1,1,1)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
