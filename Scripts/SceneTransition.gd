extends CanvasLayer
@onready var colorRect = $ColorRect
@onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func load_scene(Scene, anim = "Fade"):
	animPlayer.play(anim)
	await animPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/%s.tscn" % Scene)
	animPlayer.play_backwards(anim)
