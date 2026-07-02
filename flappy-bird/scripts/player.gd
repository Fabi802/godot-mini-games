extends CharacterBody2D

var gravity: float = 800.0
var jump_force: float = -350.0
var max_fall_speed: float = 600.0
var rotation_speed: float = 3.0

var is_dead: bool = false

func _ready():
	load_skin()

func load_skin():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var skin_path = config.get_value("player", "skin", "")
		if skin_path != "":
			$Sprite2D.texture = load(skin_path)




func _physics_process(delta):
	if is_dead:
		return
	velocity.y += gravity * delta
	
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	move_and_slide()
	
	if velocity.y < 0:
		rotation = lerp(rotation, deg_to_rad(-25), rotation_speed * delta)
	else:
		rotation = lerp(rotation, deg_to_rad(90), rotation_speed * delta)
	
	for i in get_slide_collision_count():
		die()


func die():
	if is_dead:
		return
	
	is_dead = true
	get_node("/root/game/UI/death_menu").show_death_menu()
