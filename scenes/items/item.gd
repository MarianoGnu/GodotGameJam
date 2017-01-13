extends Node

export(PackedScene) var item_scene
export(Texture) var icon

var instance
var player
var current_slot = 0
export (bool) var expendable = true
export (int) var max_stock
export (int) var current_stock
func _ready():
	if instance == null:
		instance = item_scene.instance()
	get_node("icon").set_texture(icon)

func equip(slot):
	if slot == INVENTORY.SLOT_NONE or slot == current_slot:
		unequip()
		return
	if player == null:
		player = Globals.get("player")
	if instance.get_parent() == null:
		player.item_container.add_child(instance)
	if current_slot != slot && current_slot != INVENTORY.SLOT_NONE:
		unequip()
	current_slot = slot
	if slot == INVENTORY.SLOT_A:
		player.item_a = instance
		HUD.textureA.set_texture(icon)
	elif slot == INVENTORY.SLOT_B:
		player.item_b = instance
		HUD.textureB.set_texture(icon)

func unequip():
	if player == null:
		player = Globals.get("player")
	if current_slot == INVENTORY.SLOT_NONE:
		return
	instance.get_parent().remove_child(instance)
	if current_slot == INVENTORY.SLOT_A:
		player.item_a = null
		HUD.textureA.set_texture(null)
	elif current_slot == INVENTORY.SLOT_B:
		player.item_b = null
		HUD.textureB.set_texture(null)
	current_slot = INVENTORY.SLOT_NONE
