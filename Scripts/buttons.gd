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
	MenuHandler.genScene("res://Scenes/Menus/settings.tscn", "Settings")

# https://forum.godotengine.org/t/change-scene-without-lose-the-previous-scene/17585/3
func _resume():
	MenuHandler.returnToScene()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main menu.tscn")


func _on_start_pressed():
	SceneTransition.load_scene("Levels/Level1")
