extends PlayerState

func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = player.jump_velocity
		player.jump_buffer_timer = 0.0

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta

	# Variable Jump Height
	if player.velocity.y < 0 and Input.is_action_just_released("jump"):
		player.velocity.y *= 0.5

	# Air Movement
	var input_dir_x := Input.get_axis("move_left", "move_right")
	if input_dir_x:
		player.velocity.x = input_dir_x * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	# Landing
	if player.is_on_floor():
		if is_equal_approx(input_dir_x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		return
            
	# Coyote Time Jump
	if player.velocity.y > 0 and player.coyote_timer > 0 and Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_velocity
