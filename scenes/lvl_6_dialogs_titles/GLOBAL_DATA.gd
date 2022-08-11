extends Node

# Puntajes de partida:
var topScore: int 		= 0		# Puntaje maximo de todas las partiads
var currentScore: int 	= 0		# Puntaje maximo de la partida

# Puntajes maximos:
var dictionaryElement = {"name":"",
						 "score": 0}

var elementA = {"name": "Andres",
				"score":2}
var elementB = {"name": "Carlos",
				"score":4}
var elementC = {"name": "Santi",
				"score":5}

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
	var newElement = dictionaryElement.duplicate() 
	newElement["name"]  = newName
	newElement["score"] = newScore
	topScoreList.append(newElement)
	sortTopScoreList()
	topScoreList.remove(0)
	print(topScoreList)