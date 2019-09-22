extends Area2D

signal hit_player

const velocity = Vector2(0, 100)

func _ready():
	connect("hit_player", LevelSequencer, "_on_Arrow_hit_player")

func _physics_process(delta):
	position += velocity * delta

func _on_body_entered(body):
	if not body.is_in_group("shooters"):
		if body.is_in_group("players"):
			emit_signal("hit_player")
		queue_free()
