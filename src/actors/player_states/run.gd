extends PlayerState

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	var input_dir_x := Input.get_axis("move_left", "move_right")
	
	if is_equal_approx(input_dir_x, 0.0):
		state_machine.transition_to("Idle")
		return
	else:
		player.velocity.x = input_dir_x * player.speed
	
	if Input.is_action_just_pressed("jump") or player.jump_buffer_timer > 0:
		state_machine.transition_to("Air", {do_jump = true})
