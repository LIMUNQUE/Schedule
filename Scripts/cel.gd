extends NinePatchRect

func _ready():
	fillCell(Color(1,1,1,1),"")

func fillCell(bgColor:Color, textContent:String):
	$ColorRect.set_color(bgColor)
	$Label.set_text(textContent)
