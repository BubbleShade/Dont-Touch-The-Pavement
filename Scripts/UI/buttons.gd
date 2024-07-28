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
func _on_settings_pressed_menu():
	#get_tree().change_scene_to_file("res://Scenes/Menus/settings.tscn")
	MenuHandler.switchScene("res://Scenes/Menus/settings.tscn", "Settings", "MainMenu")
func _on_settings_pressed_pause():
	MenuHandler.switchScene("res://Scenes/Menus/settings.tscn", "Settings", "PauseMenu")
func _unpause():
	get_tree().paused = false
# https://forum.godotengine.org/t/change-scene-without-lose-the-previous-scene/17585/3
func _on_back_pressed():
	print("Back")
	MenuHandler.returnToScene()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/main menu.tscn")
	MenuHandler.clearScenes()

func _open_menu(name: String, nodeName: String):
	MenuHandler.genScene("res://Scenes/Menus/%s.tscn" % name, nodeName)
func _switch_menu(name: String, nodeName: String, currentNodeName: String):
	MenuHandler.switchScene("res://Scenes/Menus/%s.tscn" % name, nodeName, currentNodeName)



