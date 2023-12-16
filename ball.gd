extends CharacterBody2D

signal match_over(winner)

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	velocity.x = rng.randi_range(25, 75)
	velocity.y = rng.randi_range(25, 75)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		var normal = collision_info.get_normal()
		velocity = velocity.bounce(normal)
		$BonkSound.play()


func _on_visible_on_screen_notifier_2d_screen_exited():
	var winner = 1 if velocity.x > 0 else 2
	match_over.emit(winner)
	queue_free()
