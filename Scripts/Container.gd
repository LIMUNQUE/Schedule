extends HBoxContainer

@onready var popupMenu = $MenuButton.get_popup()
var index=null
func _ready():
	clean_all()
	popupMenu.id_pressed.connect(item_pressed)

func _process(delta):
	pass

func item_pressed(id):
	$MenuButton.set_text(popupMenu.get_item_text(id))
	index=id
	
func clean_all():
	$MenuButton.set_text("Día")
	$horaIn.set_text("")
	$horaOut.set_text("")

func get_data():
	return [index, $horaIn.get_text(), $horaOut.get_text()]
