extends Node
class_name GlobaL

var currentPlayer: SpriteFrames = null
var selected = 0
var CharacterScene: PackedScene = null

var character = [
	preload("res://Animations/InfrantyAnimations.tres"),
	preload("res://Animations/DestroyerAnimations.tres"),
	preload("res://Animations/SowrdsmanAnimations.tres")
]

#hola
func setCurrentPlayer(player):
	currentPlayer = player

func getCurrentPlayer():
	return currentPlayer
