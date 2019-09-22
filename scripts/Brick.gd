extends KinematicBody2D

var velocity = Vector2(0, 0)
var players = []

func _physics_process(delta):
	for player in players:
		var diff = player.position - position
		if abs(diff.x) > abs(diff.y):
				velocity.x += player.velocity.x
		else:
			velocity.y += player.velocity.y
	
	var step = Vector2(0, 0)
	if velocity.x == 0 and velocity.y != 0:
		var snap_x = (int(position.x + 4) % 8)
		velocity.x -= sign(snap_x - (4 * sign(position.x))) * 2
	if velocity.x != 0 and velocity.y == 0:
		var snap_y = (int(position.y + 4) % 8)
		velocity.y -= sign(snap_y - (4 * sign(position.y))) * 2
	
	move_and_slide(velocity)
	velocity *= 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("players"):
		players.append(body)

func _on_Area2D_body_exited(body):
	if body.is_in_group("players"):
		players.remove(players.find(body))