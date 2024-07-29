extends CanvasLayer

func openLevel(level):
	SceneTransition.load_scene("Levels/Level1", "DropDown")
	MenuHandler.clearScenes()
