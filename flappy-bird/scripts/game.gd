extends Node

var score = 0
var highscore = 0

@onready var score_label = $UI/score
@onready var highscore_label = $UI/highscore

const SAVE_PATH = "user://highscore.save"

func _ready():
	load_highscore()
	update_ui()

func add_score(points):
	score += points
	if score > highscore:
		highscore = score
		save_highscore()
	update_ui()

func update_ui():
	score_label.text = "Score: " + str(score)
	highscore_label.text = "Highscore: " + str(highscore)

func save_highscore():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(highscore)
	file.close()

func load_highscore():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		highscore = file.get_var()
		file.close()
