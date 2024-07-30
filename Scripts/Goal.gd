extends Area2D
@export var nextLevel = "Levels/Level1"
@export var id = 0
var loading_next_scene = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_body_entered(body):
	if(loading_next_scene): return
	print("collide")
	if(body.is_in_group("player")):
		LevelInfo.levelsCompleted[id] = true
		AudioHandler.play(get_tree().get_root(), LevelInfo.level_complete)
		if(nextLevel != "End"):
			SceneTransition.load_scene(nextLevel, "FadeWipe")
			loading_next_scene = true
			return
		if(LevelInfo.allLevelComplete()):
			SceneTransition.load_scene("Menus/GameComplete", "FadeWipe")
		else:
			SceneTransition.load_scene("Menus/GameUncomplete", "FadeWipe")
