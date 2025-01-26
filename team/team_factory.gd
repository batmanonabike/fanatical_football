extends Resource

class_name Team

@export var name: String
@export var nickname: String
@export var score: int
# first two players will always start kickoff.
@export var players: Array
# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_name = "", p_nick = "", p_score = 0, p_players: Array = []):
	name = p_name
	nickname = p_nick
	score = p_score
	players = p_players

func add_score(amount: int = 1):
	score += 1

func add_player(player: CharacterBody2D):
	players.append(player)
