extends CanvasLayer
const border = 65
const days =["Lunes","Martes","Miercoles","Jueves","Viernes"]
var hours =[]

func _ready():
	fillNames()
	var emitter = get_node("AddMenu")
	emitter.load_data.connect(load)

func _process(delta):
	pass

func fillNames():
	for i in range(7,17,1):
		hours.append(str(i)+":00")
		hours.append(str(i)+":30")
	
	for n in range(len(days)):
		$Scroll/Weeks.get_child(n+1).nameColumn(days[n])
		$Scroll/Weeks.get_child(n+1).addRows(len(hours)-1);
	

	for n in range(len(hours)):
		var element = $Scroll/Weeks/Columm.get_child(n+1)
		var data = Label.new()
		data.set_text(hours[n])
		data.set_position(element.position-Vector2(border,0))
		element.add_child(data)

func _on_btn_añadir_pressed():
	$AddMenu.set_visible(true)

func load():
	var info = $AddMenu._write_data()
	var dia = info[0]
	const a = Color(1,1,1,1)
	$AddMenu._on_btn_limpiar_pressed()
	$Scroll/Weeks.get_child(dia[0]+1).chooseCel(1, a, "prueba")
