extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func player_died(player_position) -> void:
	position = player_position
	$Frames.show()
	$Frames.play()
	await $Frames.animation_finished
	$Frames.hide()
