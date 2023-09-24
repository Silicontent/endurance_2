class_name EnemyState
extends State

# declare a variable that will hold a reference to the enemy
var enemy: Enemy


func _ready() -> void:
	# wait until the enemy has entered the scene tree
	await(owner.ready)
	# make the variable enemy reference the enemy (owner)
	enemy = owner as Enemy
	# make sure the enemy exists
	assert(enemy != null)
