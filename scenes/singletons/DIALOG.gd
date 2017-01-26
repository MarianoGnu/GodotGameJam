extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# This functions just sends the parameters to the real function inside the dialog plugin
func show_text(chapter, dialog, start_at=0):
	HUD.hide()
	get_node("dialog").show_text(chapter,dialog, start_at)
	yield(get_node("dialog"),"finished")
	HUD.show()