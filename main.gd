extends Node

@export var ball_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Divider.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ball_match_over(winner):
	$ScoreSound.play()
	get_node("P" + str(winner)).score += 1
	$HUD.set_score(winner == 1, get_node("P" + str(winner)).score)
	spawn_ball()


func _on_hud_start_game(is_ai):
	$Divider.show()
	$P1.score = 0
	$P2.score = 0
	$P2.is_ai = is_ai
	$HUD.reset_scores()
	$P1.start(Vector2(8, 64))
	$P2.start(Vector2(248, 64))
	spawn_ball()


func _on_hud_exit_game():
	$Divider.hide()
	$P1.hide()
	$P2.hide()
	get_tree().call_group("ball", "queue_free")


func spawn_ball():
	var ball = ball_scene.instantiate()
	ball.position = Vector2(32, 64)
	ball.match_over.connect(_on_ball_match_over)
	add_child(ball)
