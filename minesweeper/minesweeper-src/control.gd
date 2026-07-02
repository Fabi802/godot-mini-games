extends Control

@export var width = 10
@export var height = 10
@export var mine_count = 15

var cells = []

@onready var grid = $GridContainer
@onready var win = $CanvasLayer/win
@onready var lost = $CanvasLayer/lost
@onready var restart = $CanvasLayer/Button

func _ready():
	create_grid()
	place_mines()
	calculate_numbers()


func create_grid():
	for y in range(height):
		for x in range(width):
			var cell = preload("res://cell.tscn").instantiate()
			cell.grid_position = Vector2i(x,y)
			cell.connect("cell_clicked", on_cell_clicked)
			grid.add_child(cell)
			cells.append(cell)

func place_mines():
	var placed = 0
	while placed < mine_count:
		var index = randi() % cells.size()
		if not cells[index].has_mine:
			cells[index].has_mine = true
			placed += 1

func calculate_numbers():
	for cell in cells:
		if cell.has_mine:
			continue
		var count = 0
		for other in cells:
			if other.has_mine and abs(cell.grid_position.x - other.grid_position.x) <= 1 \
			and abs(cell.grid_position.y - other.grid_position.y) <= 1 and cell != other:
				count += 1
		cell.neighbor_mines = count


func on_cell_clicked(cell):
	if cell.revealed:
		return
	cell.revealed = true
	if cell.has_mine:
		cell.text ="💣"
		lost.visible = true
		restart.visible = true
	else:
		if cell.neighbor_mines > 0:
			cell.text = str(cell.neighbor_mines)
			set_number_color(cell)
			set_background_color(cell)
		else:
			set_background_color(cell)
			reveal_empty_neighbors(cell)


func reveal_empty_neighbors(cell):
	for other in cells:
		if not other.revealed and not other.has_mine \
		and abs(cell.grid_position.x - other.grid_position.x) <= 1 \
		and abs(cell.grid_position.y - other.grid_position.y) <= 1:
			other.revealed = true
			if other.neighbor_mines > 0:
				other.text = str(other.neighbor_mines)
				set_background_color(other)
				set_number_color(other)
			else:
				set_background_color(other)
				reveal_empty_neighbors(other)
		check_win()


func set_number_color(cell):
	match cell.neighbor_mines:
		1:
			cell.add_theme_color_override("font_color", Color(0,0,1))
		2:
			cell.add_theme_color_override("font_color", Color(0,0.6,0))
		3:
			cell.add_theme_color_override("font_color", Color(1,0,0))
		4:
			cell.add_theme_color_override("font_color", Color(0,0,0.5))
		5:
			cell.add_theme_color_override("font_color", Color(0.5,0,0))

func set_background_color(cell):
	cell.add_theme_stylebox_override("normal", create_gray_style())

func create_gray_style():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.3,0.3,0.3)
	return style

func check_win():
	for cell in cells:
		if cell.has_mine and not cell.flagged:
			return
	restart.visible = true
	win.visible = true


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
