tool

extends CanvasLayer

onready var btnA = get_node("btnA")
onready var btnB = get_node("btnB")
onready var textureA = get_node("btnA/textureA")
onready var textureB = get_node("btnB/textureB")

func _ready():
	print(get_property_list())
	pass

func _on_btnA_draw():
	btnA.draw_circle(btnA.get_size()/2, btnA.get_size().x/2, Color(0,1,0,1) )
func _on_btnB_draw():
	btnB.draw_circle(btnB.get_size()/2, btnB.get_size().x/2, Color(1,0,0,1) )

func show():
	set_layer(1)
	pass
func hide():
	set_layer(-2)
	pass
		