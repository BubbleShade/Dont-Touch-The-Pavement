extends Node
var sceneActive = false
var NodeName = ""
# https://www.youtube.com/watch?v=jfRoLL0mEzY
func genScene(path, nodeName):
	var TheRoot = get_node("/root")  # need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/Main")
	LevelInfo.back_screen = ThisScene # Variable in auto load script
	TheRoot.remove_child(ThisScene)
	var NextScene = load(path)
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)
	sceneActive = true
	NodeName = nodeName
func returnToScene():
	var TheRoot = get_node("/root")
	var ThisScene = get_node("/root/%s" % NodeName)
	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	var NextScene = LevelInfo.back_screen
	TheRoot.add_child(NextScene)
	sceneActive = false
	
