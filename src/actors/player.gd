class_name Player extends CharacterBody2D

@export var speed := 300.0
@export var jump_velocity := -400.0
@export var coyote_time := 0.1
@export var jump_buffer_time := 0.1

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0

var state_machine: StateMachine

func _ready() -> void:
	print("DEBUG: Player _ready started")
	# Initialize State Machine dynamically
	state_machine = StateMachine.new()
	state_machine.name = "StateMachine"
	
	# Create States
	var idle_state = load("res://src/actors/player_states/idle.gd").new()
	idle_state.name = "Idle"
	idle_state.player = self # Explicit injection
	state_machine.add_child(idle_state)
	
	var run_state = load("res://src/actors/player_states/run.gd").new()
	run_state.name = "Run"
	run_state.player = self # Explicit injection
	state_machine.add_child(run_state)
	
	var air_state = load("res://src/actors/player_states/air.gd").new()
	air_state.name = "Air"
	air_state.player = self # Explicit injection
	state_machine.add_child(air_state)
	
	state_machine.initial_state = idle_state
	
	# Add to tree LAST - this triggers _ready() on SM and States
	add_child(state_machine)

func _physics_process(delta: float) -> void:
	# Global Input Buffers
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta
	
	# Flip Sprite based on velocity
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	# StateMachine updates velocity in its own _physics_process (or via manual call if preferred).
	# Since StateMachine is a child, its _physics_process usually runs after the parent's,
	# but for velocity updates to frame-sync correctly with move_and_slide, 
	# we want the velocity to be updated BEFORE we move.
	
	# To ensure strictly correct frame behavior:
	# 1. StateMachine calculates desired velocity.
	# 2. Player moves.
	
	# Currently, StateMachine._physics_process runs independently. 
	# If it runs AFTER this, the velocity change applies next frame. This is acceptable for now.
	move_and_slide()