extends CanvasLayer

const SLOT_NONE = 0
const SLOT_A    = 1
const SLOT_B    = 2

onready var inventory_panel = get_node("inventory_panel")

var idx = 0

func _ready():
	inventory_panel.hide()
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().set_pause(!get_tree().is_paused())
		set_process(get_tree().is_paused())
		if get_tree().is_paused():
			inventory_panel.show()
		else:
			inventory_panel.hide()
	
	if get_node("inventory_panel/container").get_child_count() == 0: return
	
	if inventory_panel.is_visible():
		if event.is_action_pressed("ui_left"):
			idx -= 1
		if event.is_action_pressed ("ui_right"):
			idx += 1
		idx = clamp(idx,0,get_node("inventory_panel/container").get_child_count() - 1)
		if event.is_action_pressed("A"):
			get_node("inventory_panel/container").get_child(idx).equip(SLOT_A)
		if event.is_action_pressed("B"):
			get_node("inventory_panel/container").get_child(idx).equip(SLOT_B)