extends GridContainer

var heart
var hearts = []
var info = [0,0,0] # filled hearts, transition heart and empty hearts
func _ready():
	heart = preload("res://scenes/HUD/HEALTH_DISPLAY/heart.tscn")
#	if Globals.get("player") != null:
#		generate_hearts(Globals.get("player"))
	pass

func generate_hearts(actor):
	hearts = []
	for child in get_children():
		child.queue_free()
	var nhearts = (actor.max_health/4) # There already exists one heart when the scene starts
	print("hearts: ",nhearts)
	for i in range(nhearts):
		var heartI = heart.instance()
		hearts.append(heartI)
		add_child(hearts[hearts.size()-1])
	update_health(actor)
	pass
func update_health(actor):
	var health = actor.health
	var nhearts = hearts.size()
	var heart_steps = 0
	var step = 32
	var xOffset =9
	var heart_value = 4
	info[0] = actor.health/heart_value
	info[1] = (actor.max_health - actor.health)%heart_value
	info[2] = (actor.max_health - actor.health)/heart_value
	if info[0] > 0:
		for i in range(info[0]):
			var texture = hearts[i].get_texture()
			texture.set_region(Rect2((step*xOffset)+(step*4),step,step,step))
			hearts[i].set_texture(texture)
	if info[1] > 0:
		var heart_steps = info[0]
		var texture = hearts[heart_steps].get_texture().duplicate()
		texture.set_region(Rect2((step*xOffset)+(step*(actor.health%heart_value)),step,step,step))
		hearts[heart_steps].set_texture(texture)
	for i in range(info[0]+info[1],actor.max_health/heart_value):
		var texture = hearts[i].get_texture()
		texture.set_region(Rect2((step*xOffset)+(step*0),step,step,step))
		hearts[i].set_texture(texture)