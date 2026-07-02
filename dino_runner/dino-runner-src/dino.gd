extends CharacterBody2D

const JUMP_VELOCITY = -300.0
@onready var sprite = $AnimatedSprite2D
@onready var collisionshape = $CollisionShape2D
var is_dead : bool = false
var sneak : bool = false



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Animationen
	if not is_on_floor():
		if sprite.animation != "jump":
			sprite.play("jump")

	elif Input.is_action_pressed("sneak"):
		if not sneak:
			sneak = true
			collisionshape.shape.size = Vector2(20, 12)
			collisionshape.position.y = 4

		if sprite.animation != "sneak":
			sprite.play("sneak")


	else:
		if sneak:
			sneak = false
			collisionshape.shape.size = Vector2(20, 20)
			collisionshape.position.y = 0

		if sprite.animation != "run":
			sprite.play("run")
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("cactus"):
			die()
	



func die():
	if is_dead:
		return
	
	is_dead = true
	sprite.play("death")
	get_tree().paused = true
