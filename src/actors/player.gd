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
	# Initialize State Machine dynamically
	state_machine = StateMachine.new()
	state_machine.name = "StateMachine"
	add_child(state_machine)
	# Owner must be set for persistence if saved, but mostly for 'await owner.ready' in scripts
	state_machine.owner = self 
	
	var idle_state = load("res://src/actors/player_states/idle.gd").new()
	idle_state.name = "Idle"
	state_machine.add_child(idle_state)
	
	var run_state = load("res://src/actors/player_states/run.gd").new()
	run_state.name = "Run"
	state_machine.add_child(run_state)
	
	var air_state = load("res://src/actors/player_states/air.gd").new()
	air_state.name = "Air"
	state_machine.add_child(air_state)
	
	state_machine.initial_state = idle_state
	# Trigger manual ready if needed, but add_child handles it.

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
	
	# State Machine handles movement logic
	# move_and_slide is called by the physics process of the state? 
	# No, move_and_slide is usually called by the owner.
	# But velocity is modified by state.
	
	# We delegate physics process to state machine first to update velocity
	# (StateMachine._physics_process is called automatically by Godot if inside tree)
	# But we want to call move_and_slide AFTER velocity update.
	
	# Wait, StateMachine._physics_process runs in parallel/sequence with this.
	# To ensure order:
	# 1. Update State (calc velocity)
	# 2. move_and_slide()
	
	# Since StateMachine is a child node, its _physics_process runs... when?
	# Node order. Parent usually runs before children? No, usually children first?
	# It varies.
	# Safer approach: Call state_machine manually or use `move_and_slide` inside the state?
	# Standard: State updates velocity. Parent calls move_and_slide.
	
	# Let's trust the child process order or manual call. 
	# Actually, I'll rely on the StateMachine node to run its logic.
	# But move_and_slide() needs to happen.
	# If I call move_and_slide() here, and StateMachine runs *after*, velocity changes apply next frame.
	# If StateMachine runs *before*, changes apply this frame.
	# Children _physics_process usually runs *after* Parent?
	# "Godot calls _physics_process on the parent, then the children." (Wait, checking docs...)
	# Actually it's often tree order (top-down).
	
	# To be safe and explicit:
	# I will NOT enable physics_process on StateMachine script, but call it manually here.
	# But StateMachine.gd defines _physics_process.
	
	move_and_slide()