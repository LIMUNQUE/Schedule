extends ColorRect
signal load_data
func _ready():
	print(get_tree().get_nodes_in_group("grupo1"))

func _on_btn_atras_pressed():
	_on_btn_limpiar_pressed()
	set_visible(false)

func _on_btn_limpiar_pressed():
	for n in $VBox.get_children():
		n.clean_all()

func _on_btn_ingresar_pressed():
	emit_signal("load_data")
	
func _write_data():
	var menu =[]
	var diaIn = []
	var diaOut = []
	for n in $VBox.get_children():
		var data = n.get_data()
		menu.append(data[0])
		diaIn.append(data[1])
		diaOut.append(data[2])
	return [menu, diaIn, diaOut]
