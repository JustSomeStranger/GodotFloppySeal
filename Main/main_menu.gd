extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_quit_button_up() -> void:
	get_tree().quit()


# Smoothly closes the menu
func close_menu() -> void:
	var fade_tween = create_tween()
	fade_tween.tween_property($".", "modulate:a", 0, 0.1)  # This changes opacity for some reason


