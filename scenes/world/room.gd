tool

extends Area2D

export(bool) var current setget make_current,is_current
onready var tween = Tween.new()

func _init():
	add_to_group("rooms")

func _ready():
	tween.set_tween_process_mode(tween.TWEEN_PROCESS_FIXED)
	add_child(tween)
	set_pause_mode(PAUSE_MODE_PROCESS)
	if current:
		call_deferred("initialize")
	else:
		call_deferred("connect","body_enter",self,"_on_body_enter")
	

func initialize():
	var cam = get_viewport().get_camera()
	var rect = Rect2(get_global_pos(),Vector2())
	for p in get_node("room_shape").get_polygon():
		rect = rect.expand(get_global_pos()+p)
	var cam = Globals.get("player").get_node("cam")
	cam.set_limit(MARGIN_LEFT,rect.pos.x)
	cam.set_limit(MARGIN_RIGHT,rect.pos.x+rect.size.x)
	cam.set_limit(MARGIN_TOP,rect.pos.y)
	cam.set_limit(MARGIN_BOTTOM,rect.pos.x+rect.size.y)
	call_deferred("connect","body_enter",self,"_on_body_enter")
	return

func make_current(curr):
	if !is_inside_tree():
		current = curr
		return
	if curr and current:
		return
	if curr:
		for r in get_tree().get_nodes_in_group("rooms"):
			if r != self:
				r.make_current(false)
		current = true
	else:
		current = false
	if get_tree().is_editor_hint():
		return
	if current:
		var rect = Rect2(get_global_pos(),Vector2())
		for p in get_node("room_shape").get_polygon():
			rect = rect.expand(get_global_pos()+p)
		var player = Globals.get("player")
		var cam = player.get_node("cam")
		print(str(cam.get("limit/bottom")))
		tween.stop_all()
		var center = cam.get_camera_screen_center()
		var size = get_viewport_rect().size / 2
		tween.interpolate_property(cam,"limit/left",(center-size).x,rect.pos.x,0.5,tween.TRANS_LINEAR,tween.EASE_IN,0.2)
		tween.interpolate_property(cam,"limit/right",(center+size).x,rect.pos.x+rect.size.x,0.5,tween.TRANS_LINEAR,tween.EASE_IN,0.2)
		tween.interpolate_property(cam,"limit/top",(center-size).y,rect.pos.y,0.5,tween.TRANS_LINEAR,tween.EASE_IN,0.2)
		tween.interpolate_property(cam,"limit/bottom",(center+size).y,rect.pos.y+rect.size.y,0.5,tween.TRANS_LINEAR,tween.EASE_IN,0.2)
		var mov = Vector2()
		if player.get_global_pos().x < rect.pos.x:
			mov = Vector2(32,0)
		if player.get_global_pos().x > rect.pos.x+rect.size.x:
			mov = Vector2(-32,0)
		if player.get_global_pos().y < rect.pos.y:
			mov = Vector2(0,32)
		if player.get_global_pos().y > rect.pos.y+rect.size.y:
			mov = Vector2(0,-32)
		tween.interpolate_property(player,"transform/pos",player.get_pos(),player.get_pos()+mov,1,tween.TRANS_LINEAR,tween.EASE_IN,0.2)
		get_tree().get_root().get_node("INVENTORY").set_pause_mode(PAUSE_MODE_STOP)
		cam.set_pause_mode(PAUSE_MODE_PROCESS)
		get_tree().set_pause(true)
		tween.start()
		yield(tween,"tween_complete")
		get_tree().get_root().get_node("INVENTORY").set_pause_mode(PAUSE_MODE_PROCESS)
		player.dir = Vector2()
		cam.set_pause_mode(PAUSE_MODE_INHERIT)
		get_tree().set_pause(false)

func is_current():
	return current

func _on_body_enter( body ):
	if body.is_in_group("player"):
		make_current(self)
