extends PlayerState


func enter(_msg := {}) -> void:
	player.state_display.text = "Dead"
	player.visible = false
	player.die()
