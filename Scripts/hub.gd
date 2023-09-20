extends CanvasLayer
const border = 65
func _ready():
	fillNames()

func _process(delta):
	pass

func fillNames():
	const days =["Lunes","Martes","Miercoles","Jueves","Viernes"]
	var hours =[]
	
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

