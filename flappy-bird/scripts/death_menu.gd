extends Control

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func show_death_menu():
	visible = true
	get_tree().paused = true
