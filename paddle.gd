extends CharacterBody2D


const SPEED = 100

@export var player = 0
var is_ai = false
var score = 0


func _ready():
	hide()


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_ai:
		var ball = get_tree().get_nodes_in_group("ball")[0]
		if ball:
			var time_to_reach = (position.x - ball.position.x) / ball.velocity.x
			var y_on_reach = ball.position.y + ball.velocity.y*time_to_reach
			if y_on_reach <= 128 and y_on_reach >= 0:
				var direction = sign(y_on_reach - position.y)
				velocity.y = direction * SPEED
				move_and_slide()
			elif y_on_reach == position.y:
				velocity.y = 0
	else:
		if Input.is_action_pressed("p%s_move_down" % player) and not is_ai:
			velocity.y = 1 * SPEED
		elif Input.is_action_pressed("p%s_move_up" % player) and not is_ai:
			velocity.y = -1 * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()


func start(pos):
	position = pos
	show()
