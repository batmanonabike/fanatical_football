extends Node2D

var team1: Team
var team2: Team
var time: int

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game = self
	_begin()

func _run_per_second():
	time -= 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
## This will be refactored when multiplayer is added.
func _begin(team1Name: String = "Supercalifragilisticexpialadocious", team2Name: String = "Pneumoultramicroscopicsilicovolcanoconiosis", team1Nick: String = "SU", team2Nick: String = "PN", time: int = 300):
	team1 = Team.new(team1Name, team1Nick, 0, [])
	team2 = Team.new(team2Name, team2Nick, 0, [])
	
	var player_scene: PackedScene = preload("res://player/player.tscn")
	var npc_scene: PackedScene = preload("res://player/npc.tscn")
	for l in range(2):
		# repeat twic3
		for i in range(10):
			var player: CharacterBody2D = player_scene.instantiate() if i == 0 and l == 0 else npc_scene.instantiate()
			player.role = floor(i / 3) # first 3 are striker, second 3 are midfield, third 3 are defense, 1 is goali
			player.side = i % 3 # 0 = left`, 1 is middle, 2 is right
			player.team = 0 if l == 0 else 1 # Make them one team  if first ten, otherwise second ten	
			player.global_position = $TeamOne/Spawn.global_position
			
			if l == 0:
				$TeamOne.add_child(player)
			else:
				$TeamTwo.add_child(player)
			
	$Timer.start()

func _kickoff(team):
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
