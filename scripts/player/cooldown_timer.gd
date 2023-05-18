extends Timer

@export var initial_time := 7.0
var prev_time := 0.0

@export var multiplier := 1.25
@export var max_time := 20.0


func _ready() -> void:
	# set the wait time to the initial wait time
	wait_time = initial_time
	# store the initial time to be extended later
	prev_time = initial_time
	start()


func _process(_delta: float) -> void:
	var curr_time = snappedf(time_left, 0.01)
	owner.cooldown_text.text = str(curr_time) + " / " + str(prev_time)


func reset_cooldown() -> void:
	# multiply the cooldown amount by the multiplier
	var new_time = snappedf(prev_time * multiplier, 0.01)
	new_time = clamp(new_time, 0.0, max_time)
	# set the wait time to this new amount
	self.wait_time = new_time
	# store this time to later continuously enlongate the cooldown time
	prev_time = new_time
	
	self.start()
	owner.can_dash = false


func _on_timeout():
	owner.can_dash = true
