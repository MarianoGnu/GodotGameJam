extends Node2D

func _on_area_body_enter( body ):
	print(body.get_name())
	if body.is_in_group("enemy") or body.is_in_group("player"):
		body.take_damage(4,self)
	if body.is_in_group("cracked_wall"):
		print("WE GOT THE CRACKED WALL!")
		body.destroy()
		pass