extends KinematicBody2D

const walk_acc = 2000
const friction = 0.5

var velocity = Vector2(0, 0)

func _physics_process(delta):
	var step = Vector2(0, 0)
	if Input.is_action_pressed("gp_left"):
		step -= Vector2(1, 0)
		if $AnimationPlayer.current_animation != "WalkWest":
			$AnimationPlayer.play("WalkWest")
	if Input.is_action_pressed("gp_right"):
		step += Vector2(1, 0)
		if $AnimationPlayer.current_animation != "WalkEast":
			$AnimationPlayer.play("WalkEast")
	if Input.is_action_pressed("gp_up"):
		step -= Vector2(0, 1)
		if step.x == 0 and $AnimationPlayer.current_animation != "WalkNorth":
			$AnimationPlayer.play("WalkNorth")
	if Input.is_action_pressed("gp_down"):
		step += Vector2(0, 1)
		if step.x == 0 and $AnimationPlayer.current_animation != "WalkSouth":
			$AnimationPlayer.play("WalkSouth")
	if step == Vector2(0, 0):
		$AnimationPlayer.stop(false)
	step = step.normalized()
	
	velocity += step * walk_acc * delta
	move_and_slide(velocity)
	velocity *= friction