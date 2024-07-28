extends Node

signal restartLevel
var walk_sound_effect_grass = load("res://Sound/GrassWalk.wav")
var walk_sound_concrete = load("res://Sound/WalkConcrete.wav")
var synth = load("res://Sound/synth(1).wav")
var restart_sound = load("res://Sound/RestartLevel.wav")
var button_click = load("res://Sound/ButtonClick.wav")
var button_hover = load("res://Sound/ButtonHover.wav")
var slider_change = load("res://Sound/SliderChange.wav")
var text_sound = load("res://Sound/TextSound.wav")
var level_complete = load("res://Sound/LevelFinish.wav")

var ShadowProgress : float = 0.5
var maxElixir: float = 100
var elixir: float = 100
var sound_player := AudioStreamPlayer.new()
var pickup : Node
var volume = 5
