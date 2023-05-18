extends PlayerState


func enter(_msg := {}) -> void:
	player.state_display.text = "Dead"
	player.visible = false
	player.cooldown_bar.visible = false
	player.cooldown_text.visible = false
	player.die()
