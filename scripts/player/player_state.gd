class_name PlayerState
extends State

# declare a variable that will hold a reference to the player
var player: Player


func _ready() -> void:
	# wait until the player has entered the scene tree
	await(owner.ready)
	# make the variable player reference the player (owner)
	player = owner as Player
	# make sure the player exists
	assert(player != null)
