extends StaticBody2D

const arrow = preload("res://scenes/Arrow.tscn")
const interval = 0.25

var timer = 0

func _physics_process(delta):
	timer += delta
	if timer > interval:
		timer = 0
		var instance = arrow.instance()
		instance.position = position + Vector2(0, 8)
		get_parent().add_child(instance)