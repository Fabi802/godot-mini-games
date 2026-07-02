extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if get_tree().paused and Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		get_tree().reload_current_scene()
