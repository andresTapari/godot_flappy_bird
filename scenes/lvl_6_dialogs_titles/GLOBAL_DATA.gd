extends Node

# Puntajes de partida:
var topScore: int 		= 0		# Puntaje maximo de todas las partiads
var currentScore: int 	= 0		# Puntaje maximo de la partida

# Puntajes maximos:
var elementA = {"name": "Andres",
				"score":10}
var elementB = {"name": "Carlos",
				"score":30}
var elementC = {"name": "Santi",
				"score":20}

#Lista de puntajes maximos:
var topScoreList: Array = [elementA,elementB,elementC]

func _ready():
	sortTopScoreList()
	print(getMinimumScore())

func sortTopScoreList() -> void:
	topScoreList.sort_custom(self, "customComparison")
	print(topScoreList)

func customComparison(a, b) -> bool:
	if typeof(a["score"]) != typeof(b["score"]):
		return typeof(a["score"]) < typeof(b["score"])
	else:
		return a["score"] < b["score"]

func getMinimumScore() -> int:
	sortTopScoreList()
	return topScoreList[0]["score"]

func setNewHighScore(newName: String, newScore: int) -> void:
	
	pass
