extends Node2D

var EXPLOSION_SCENE := preload("res://Explosion/explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# ALERT: Something is funky with the explosion position
func player_died(player_position) -> void:
	var instance = EXPLOSION_SCENE.instantiate()
	var instance_frames = instance.get_node("Frames")


	instance.position = player_position
	add_child(instance)
	instance.show()
	instance_frames.play()
	await instance_frames.animation_finished
	instance.queue_free()
