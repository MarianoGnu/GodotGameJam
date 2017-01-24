extends Node

export(PackedScene) var item_scene
export(Texture) var icon


var instance
var player
var current_slot = 0
export (bool) var expendable = true
export (int) var max_stock = 20
export (int) var current_stock = 10
func _ready():
	if instance == null:
		instance = item_scene.instance()
	get_node("icon").set_texture(icon)

func equip(slot):
	if slot == INVENTORY.SLOT_NONE or slot == current_slot:
		HUD.update_value(slot, -1) # Setting the slot to -1 disables quantity display
		unequip()
		return
	if player == null:
		player = Globals.get("player")
	if instance.get_parent() == null:
		player.item_container.add_child(instance)
	if current_slot != slot && current_slot != INVENTORY.SLOT_NONE:
		HUD.update_value(slot, -1)
		unequip()
	current_slot = slot
	if slot == INVENTORY.SLOT_A:
		player.item_a = instance
		HUD.textureA.set_texture(icon)
		if player.item_a.expendable: # if item can be counted
			HUD.update_value(INVENTORY.SLOT_A, player.item_a.current_stock)
	elif slot == INVENTORY.SLOT_B:
		player.item_b = instance
		HUD.textureB.set_texture(icon)
		if player.item_b.expendable:
			HUD.update_value(INVENTORY.SLOT_B, player.item_b.current_stock)

func unequip():
	if player == null:
		player = Globals.get("player")
	if current_slot == INVENTORY.SLOT_NONE:
		return
	if instance.get_parent() == null:
		player.item_container.add_child(instance)
	print("trying to remove", instance.get_name())
	instance.get_parent().remove_child(instance)
	if current_slot == INVENTORY.SLOT_A:
		player.item_a = null
		HUD.update_value(INVENTORY.SLOT_A, -1)
		HUD.textureA.set_texture(null)
	elif current_slot == INVENTORY.SLOT_B:
		player.item_b = null
		HUD.update_value(INVENTORY.SLOT_B, -1)
		HUD.textureB.set_texture(null)
	current_slot = INVENTORY.SLOT_NONE
