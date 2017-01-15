extends Node2D

func _on_area_body_enter( body ):
	if body.is_in_group("enemy") or body.is_in_group("player"):
		body.take_damage(6,self)
	if body.is_in_group("cracked_wall"):
		# TODO: break the wall
		pass