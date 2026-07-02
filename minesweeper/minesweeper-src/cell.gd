extends Button

var has_mine = false
var revealed = false
var flagged = false
var neighbor_mines = 0
var grid_position : Vector2i

signal cell_clicked(cell)

func _ready():
	text = ""

func _pressed(): 
	emit_signal("cell_clicked",self)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			flagged = !flagged
			text = "🚩" if flagged else ""
