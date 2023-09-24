extends Node2D

# emitted whenever an enemy under this manager is killed
signal killed(reward)

# gets a reference to the player
@export var player_ref: Player


func _ready() -> void:
	# loop over each enemy that is a child of this manager
	for enemy in get_children():
		# give the enemies a reference to the player
		enemy.player = player_ref
		# set the enemy's manager as this manager
		enemy.manager = self
