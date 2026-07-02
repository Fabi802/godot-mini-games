extends Control

var button = preload("res://button.tscn")

var play : String = "1P"

var buttons : Array= []
var turn : int = 0
var game : bool = false

func _ready() -> void:
	for count in range(9):
		var button = button.instantiate()
		button.main = self
		$GridContainer.add_child(button)
		buttons.append(button)
		button.button_change.connect(_on_button_change)

func _on_button_change(button):
	randomize()
	var match_result = check_match()
	if match_result:
		game = true
		start_win(match_result)
	elif play == "1P" and turn == 1:
		var ai_button = buttons[randi()%buttons.size()]
		if ai_button.value == "":
			ai_button.draw_button()
		else: 
			_on_button_change(button)



func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func check_match():
	for h in range(3):
		if buttons[0+3*h].value ==  "X" and buttons[1+3*h].value ==  "X" and buttons[2+3*h].value ==  "X":
			return["X", 1+3*h, 2+3*h,3+3*h]
	for v in range(3):
		if buttons[0+v].value == "X" and buttons[3+v].value == "X" and buttons[6+v].value == "X":
			return["X", 1+v, 4+v, 7+v]
	if buttons[0].value == "X" and buttons[4].value == "X" and buttons[8].value == "X":
		return["X", 1, 5, 9]
	elif buttons[2].value == "X" and buttons[4].value == "X" and buttons[6].value == "X":
		return["X", 3, 5, 7]
	
	for h in range(3):
		if buttons[0+3*h].value ==  "O" and buttons[1+3*h].value ==  "0" and buttons[2+3*h].value ==  "0":
			return["0", 1+3*h, 2+3*h,3+3*h]
	for v in range(3):
		if buttons[0+v].value == "0" and buttons[3+v].value == "0" and buttons[6+v].value == "0":
			return["0", 1+v, 4+v, 7+v]
	if buttons[0].value == "0" and buttons[4].value == "0" and buttons[8].value == "0":
		return["0", 1, 5, 9]
	elif buttons[2].value == "0" and buttons[4].value == "0" and buttons[6].value == "0":
		return["0", 3, 5, 7]
	
	var full = true
	for button in buttons:
		if button.value == "":
			full = false
	
	if full : return["Draw", 0, 0, 0]
	

func start_win(match_result:Array):
	var color: Color
	if match_result[0]=="X":
		color = Color.BLUE
	elif match_result[0] == "0":
		color = Color.RED
	
	for c in range(3):
		buttons[match_result[c+1]-1].glow(color)


func _on_check_button_pressed() -> void:
	if $CheckButton.toggle_mode == true:
		play = "2P"
	else:
		play = "1P"
