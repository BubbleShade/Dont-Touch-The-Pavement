extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



############################# button redirects
############################# https://youtu.be/tmSBGJGDUuQ

# https://forum.godotengine.org/t/change-scene-without-lose-the-previous-scene/17585/3
func _on_settings_pressed():
	#get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")
	var TheRoot = get_node("/root")  # need this as get_node will stop work once you remove your self from the Tree
	var ThisScene = get_node("/root/Main")
	LevelInfo.back_screen = ThisScene # Variable in auto load script
	TheRoot.remove_child(ThisScene)
	var NextScene = load("res://Scenes/Menus/settings.tscn")
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)

# https://forum.godotengine.org/t/change-scene-without-lose-the-previous-scene/17585/3
func _resume():
	var TheRoot = get_node("/root")
	var ThisScene = get_node("/root/Settings")
	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	var NextScene = LevelInfo.back_screen
	TheRoot.add_child(NextScene)

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main menu.tscn")


func _on_start_pressed():
	SceneTransition.load_scene("Levels/Level1")
