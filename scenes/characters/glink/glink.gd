extends "res://scenes/characters/character.gd"

const STATE_NORMAL  = 0
const STATE_GRAB    = 1
const STATE_HOLDING = 2

var item_a
var item_b
var state = STATE_NORMAL

onready var ray_interact = get_node("ray_interact")

func _init():
	add_to_group("player")
	Globals.set("player", self)

func _ready():
	set_process_input(true)
	ray_interact.add_exception(self)

func _input(event):
	dir = Vector2()
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	
	if anim.get_current_animation() == "attack":
		dir.normalized()
		return
	
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0: set_facing(RIGHT)
		else: set_facing(LEFT)
	elif abs(dir.x) < abs(dir.y):
		if dir.y > 0: set_facing(DOWN)
		else: set_facing(UP)
	dir.normalized()
	
	if state == STATE_NORMAL:
		if event.is_action_pressed("A"):
			if not interact():
				if item_a != null:
					item_a.use()
		if item_a != null && event.is_action_released("A"):
			item_a.release()
		if item_b != null && event.is_action_pressed("B"):
			item_b.use()
		if item_b != null && event.is_action_released("B"):
			item_b.release()
	elif state == STATE_HOLDING:
		if event.is_action_pressed("A") or event.is_action_pressed("B"):
			Globals.get("crane_arm").throw()

func _fixed_process(delta):
	# Override character's method to allow push objects
	var mov = Vector2()
	if state != STATE_GRAB:
		 mov = move(dir * WALK_SPEED * delta)
	if state == STATE_NORMAL:
		if ray_interact.is_colliding():
			if ray_interact.get_collider() != null and ray_interact.get_collider() .is_in_group("pushable"):
				var dir_facing = ray_interact.get_cast_to()
				if mov.x != 0 and dir_facing.x != 0:
					ray_interact.get_collider().push(delta,1,dir_facing.normalized())
				elif mov.y != 0 and dir_facing.y != 0:
					ray_interact.get_collider().push(delta,1,dir_facing.normalized())

func set_facing(new_dir):
	if new_dir == UP:
		ray_interact.set_cast_to(Vector2(0,-20))
	elif new_dir == DOWN:
		ray_interact.set_cast_to(Vector2(0,20))
	elif new_dir == LEFT:
		ray_interact.set_cast_to(Vector2(-20,0))
	elif new_dir == RIGHT:
		ray_interact.set_cast_to(Vector2(20,0))
	.set_facing(new_dir) # Call character.gd 's set_facing function

func interact():
	if not ray_interact.is_colliding():
		return false
	if ray_interact.get_collider().is_in_group("interactable"):
		return ray_interact.get_collider().interact()
	else:
		return false