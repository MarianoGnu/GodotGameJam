extends CanvasLayer

onready var btnA = get_node("btnA")
onready var btnB = get_node("btnB")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_btnA_draw():
	btnA.draw_circle(btnA.get_size()/2, btnA.get_size().x/2, Color(0,1,0,1) )
func _on_btnB_draw():
	btnB.draw_circle(btnB.get_size()/2, btnB.get_size().x/2, Color(1,0,0,1) )
