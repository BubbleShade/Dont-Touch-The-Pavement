extends CanvasLayer

var all_cutscene = [
	[
"Uh oh, looks like I forgot to wear my shoes on my walk to work again.",
"I dont want to burn my feet on the pavement, so i'll have to be sure to walk [i]in the shadows[/i].",
"Looks like I'll have to use my trusty [i]Sun Manipulator[/i] in order to move the sun and transform the shadows,
I'll have to be careful about how much [i]Elixir[/i] I use though, as I only have enough to get to work."]
	]
var i = 0
var j = 0
var deltaText = 0
@export var Cutscene = 0
@onready var Textbox = get_node("Panel/Textbox")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	Textbox.text = ""
	if(get_parent().get_node("LevelUI") != null):
		get_parent().get_node("LevelUI").visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var textList = all_cutscene[Cutscene]
	if(j < len(textList[i])):
		deltaText += delta
		for index in range(min(
			floor(deltaText/0.01)-j,
			len(textList[i])-j
			)):
			if(textList[i][j] == "["):
				while(textList[i][j] != "]"):
					Textbox.text += textList[i][j]
					j+= 1
			if(textList[i][j] != '\n'):
				Textbox.text += textList[i][j]
			j+= 1
		if(Input.is_action_just_pressed("next")):
			Textbox.text = textList[i]
			j= len(textList[i])
	elif(Input.is_action_just_pressed("next")):
		i += 1
		if(i >= len(textList)): 
			if(get_parent().get_node("LevelUI") != null):
				get_parent().get_node("LevelUI").visible = true
			get_tree().paused = false
			queue_free()
		j = 0
		Textbox.text = ""
		deltaText = 0
			
	pass
