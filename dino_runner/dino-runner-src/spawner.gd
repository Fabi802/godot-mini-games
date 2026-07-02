extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var spawn_point = $Marker2D

var cactus_scene = [
	preload("res://cactus.tscn"),
	preload("res://cactus_2.tscn"),
	preload("res://cactus_3.tscn"),
	preload("res://pterodactylus.tscn"),
	preload("res://pterodactylus_2.tscn")
	]

func _ready():
	randomize()

	spawn_timer.timeout.connect(spawn_cactus)

	start_spawn_timer()

func spawn_cactus():
	var random_cactus = cactus_scene.pick_random()

	var cactus = random_cactus.instantiate()

	cactus.position = spawn_point.position

	add_child(cactus)

	start_spawn_timer()

func start_spawn_timer():
	spawn_timer.wait_time = randf_range(2.0, 4.5)

	spawn_timer.start()
