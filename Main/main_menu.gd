extends Control

var increment := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftSidePadding/PressToStart.pivot_offset = Vector2(155/2, 23/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	increment += 1.5 * delta
	$LeftSidePadding/PressToStart.rotation = 0.1 * sin(increment)
	# $LeftSidePadding/PressToStart.size += Vector2(sin(increment), sin(increment))



func _on_quit_button_up() -> void:
	get_tree().quit()


# Smoothly closes the menu
func close_menu() -> void:
	var fade_tween = create_tween()
	fade_tween.tween_property($".", "modulate:a", 0, 0.1)
	await fade_tween.finished
	hide()


# Smoothly opens the menu
func open_menu() -> void:
	var fade_tween = create_tween()
	fade_tween.tween_property($".", "modulate:a", 1, 0.1)  # This changes opacity for some reason
	await fade_tween.finished
	show()



func _on_game_started():
	close_menu()
