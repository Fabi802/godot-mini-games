extends Button

signal button_change(button)

var main: Control
var value : String = ""

@onready var background = $Panel
@onready var border = $Panel2

func _ready() -> void:
	self_modulate.a = 0
	

func draw_x():
	var x = get_tree().create_tween()
	self_modulate = Color("00ffff")
	self_modulate.a = 0
	text = "X"
	value = "X"
	x.tween_property(self, "self_modulate:a",1,0.5)

func draw_O():
	var O = get_tree().create_tween()
	self_modulate = Color("ffff00")
	self_modulate.a = 0
	text = "O"
	value = "O"
	O.tween_property(self, "self_modulate:a",1,0.5)

func draw_button():
	if main.game: return
	if value == "":
		match main.turn:
			0:
				main.turn = 1
				draw_x()
			1:
				main.turn= 0
				draw_O()
	
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	button_change.emit(self)


func glow(color):
	var tween = get_tree().create_tween()
	background.modulate = color
	background.modulate.a = 0
	tween.tween_property(background,"modulate:a", 1, 0.5)
	
