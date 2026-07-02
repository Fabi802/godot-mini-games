extends Sprite2D

@export var speed := 150.0

func _process(delta):
	region_rect.position.x += speed * delta
