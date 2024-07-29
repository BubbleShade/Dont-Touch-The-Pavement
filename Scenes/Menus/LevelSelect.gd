extends CanvasLayer

func openLevel(level):
	SceneTransition.load_scene("Levels/%s" % level, "DropDown")
	await get_tree().create_timer(1).timeout
	MenuHandler.clearScenes()
func _ready():
	for i in range(10):
		if(LevelInfo.levelsCompleted[i]):
			var apple = "Lvl%s" % (i+1)
			get_node("Panel/Lvl%s" % (i+1)).get_node("Star").visible = true
