extends CharacterBody2D

@export var speed: float = 200.0

func _process(delta):
	position.x -= speed * delta
	

	if position.x < -get_viewport_rect().size.x:
		queue_free()




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		get_parent().add_score(1)
