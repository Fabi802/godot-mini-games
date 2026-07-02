extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var pipe_speed: float = 200.0
@export var min_y: float = 150.0
@export var max_y: float = 450.0

var timer: float = 0.0

var pipe_count: int = 0

func _process(delta):
	timer += delta
	
	if timer >= spawn_interval:
		spawn_pipe()
		timer = 0.0

func spawn_pipe():
	pipe_count += 1
	var pipe = pipe_scene.instantiate()
	var screen_width = get_viewport_rect().size.x
	var random_y = randf_range(min_y, max_y)
	
	pipe.position = Vector2(screen_width + 100, random_y)
	if pipe_count % 10 == 0:
		spawn_interval *= 0.95
		pipe_speed += 15
	get_parent().add_child(pipe)
