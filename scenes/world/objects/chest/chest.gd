extends StaticBody2D

const HEALTH  = 0
const KEY     = 1
const BOMB    = 2
const SPECIAL = 3

var empty = false
export (int,"Health,Key,Bomb,SPECIAL") var content_type = HEALTH
export (PackedScene) var special_btn # what item will it add to inventory
export (Texture) var texture_health
export (Texture) var texture_key
export (Texture) var texture_bomb
onready var anim = get_node("anim")
onready var icon = get_node("icon")

func _init():
	add_to_group("interactable")

func interact():
	if empty:
		return false
	if Globals.get("player").facing != 2: # Character is facing UP ?
		return false
	
	if   content_type == HEALTH:
		# TODO: add health
		icon.set_texture(texture_health)
		empty = true
	elif content_type == KEY:
		# TODO: add a key
		icon.set_texture(texture_key)
		empty = true
	elif content_type == BOMB:
		# TODO: add bombs
		icon.set_texture(texture_bomb)
		empty = true
	elif content_type == SPECIAL:
		var item = special_btn.instance()
		INVENTORY.add_item(item)
		icon.set_texture(item.icon)
		empty = true
	if empty:
		var p = Globals.get("player")
		MUSIC.start_play("got item")
		anim.play("open")
		p.set_fixed_process(false)
		yield(anim,"finished")
		icon.set_texture(null)
		p.set_fixed_process(true)
	else:
		get_node("lid").set_texture(preload("res://scenes/world/objects/chest/sprite_by_hc/chest_lid.png"))
	return true
