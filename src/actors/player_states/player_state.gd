class_name PlayerState extends State

var player: CharacterBody2D

func _ready() -> void:
	if not player:
		# Fallback: Assume State -> StateMachine -> Player hierarchy
		var sm = get_parent()
		if sm and sm.get_parent() is CharacterBody2D:
			player = sm.get_parent()
	
	if not player:
		push_warning("PlayerState: Player reference not set for " + name)
