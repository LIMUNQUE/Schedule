extends VBoxContainer
@onready var cel = load("res://cel.tscn")

func _ready():
	pass

func chooseCel(index:int, color:Color, texto:String):
	get_child(index).fillCell(color,texto)

func nameColumn(day:String):
	get_child(0).set_text(day)

func addRows(cant:int):
	for n in cant:
		var celContent = cel.instantiate()
		add_child(celContent)
