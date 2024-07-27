extends Node

signal restartLevel
var walk_sound_effect_grass = load("res://Sound/GrassWalk.wav")
var walk_sound_concrete = load("res://Sound/WalkConcrete.wav")
var synth = load("res://Sound/synth(1).wav")
var restart_sound = load("res://Sound/RestartLevel.wav")

var ShadowProgress : float = 0.5
var maxElixir: float = 100
var elixir: float = 100
var sound_player := AudioStreamPlayer.new()
