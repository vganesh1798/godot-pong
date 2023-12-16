extends CanvasLayer

signal start_game(is_ai)
signal exit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExitButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_singleplayer_button_pressed():
	$SingleplayerButton.hide()
	$MultiplayerButton.hide()
	$ExitButton.show()
	start_game.emit(true)


func _on_multiplayer_button_pressed():
	$SingleplayerButton.hide()
	$MultiplayerButton.hide()
	$ExitButton.show()
	start_game.emit(false)


func _on_exit_button_pressed():
	$SingleplayerButton.show()
	$MultiplayerButton.show()
	$ExitButton.hide()
	exit_game.emit()


func set_score(is_player_one, score):
	var player_label = $PlayerOneScore if is_player_one else $PlayerTwoScore
	player_label.text = str(score)


func reset_scores():
	$PlayerOneScore.text = "0"
	$PlayerTwoScore.text = "0"
