extends Node2D

@onready var score_label = $score_label

var score : int = 0


func _process(delta):

	score += int(delta * 100)

	score_label.text = "Score: " + str(score)
