extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# https://www.youtube.com/watch?v=jfRoLL0mEzY
	# https://www.reddit.com/r/godot/comments/cjigi4/how_do_i_make_hitting_the_esc_key_exit_the_game/?rdt=47979
	if Input.is_action_just_pressed("ui_cancel"):
		Buttons._on_settings_pressed()
