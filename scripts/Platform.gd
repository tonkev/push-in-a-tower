extends Area2D

signal is_rising

const speed = 100

var bricks = []
var players = []
var is_rising = false

func _ready():
	connect("is_rising", LevelSequencer, "_on_Platform_is_rising")

func _on_body_entered(body):
	if body.is_in_group("bricks"):
		bricks.append(body)
	if body.is_in_group("players"):
		players.append(body)

func _on_body_exited(body):
	if body.is_in_group("bricks"):
		bricks.remove(bricks.find(body))
	if body.is_in_group("players"):
		players.remove(players.find(body))

func _process(delta):
	if is_rising:
		_rise(self, delta)
		for brick in bricks:
			_rise(brick, delta)
		for player in players:
			_rise(player, delta)
	elif bricks.size() > 0 and players.size() > 0:
		pause_mode = PAUSE_MODE_PROCESS
		get_tree().paused = true
		is_rising = true
		emit_signal("is_rising")

func _rise(body, delta):
	body.position.y -= speed * delta