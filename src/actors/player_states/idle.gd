extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
		return
	
	if Input.is_action_just_pressed("jump") or player.jump_buffer_timer > 0:
		state_machine.transition_to("Air", {do_jump = true})
