extends Area2D
@export var nextLevel = "Levels/Level1"
var loading_next_scene = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_body_entered(body):
	if(loading_next_scene): return
	print("collide")
	if(body.is_in_group("player")):
		AudioHandler.play(get_tree().get_root(), LevelInfo.level_complete)
		SceneTransition.load_scene(nextLevel)
		loading_next_scene = true
		return
