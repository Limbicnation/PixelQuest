class_name PlayerState extends State

var player

func _ready() -> void:
	if not owner.is_node_ready():
		await owner.ready
	player = owner as CharacterBody2D
	assert(player != null, "PlayerState must be used within a Player scene.")
