extends Node

# Puntajes de partida:
var topScore: int 		= 0		# Puntaje maximo de todas las partiads
var currentScore: int 	= 0		# Puntaje actual de la partida

# Puntajes maximos:
var dictionaryElement = {"name":"",
						 "score": 0}

var elementA = {"name": "...",
				"score":0}
var elementB = {"name": "...",
				"score":0}
var elementC = {"name": "...",
				"score":0}


# lvl_8_save: Cargamos clase del sistema de guardado
onready var fs = FileSystem.new()

#Lista de puntajes maximos:
var topScoreList: Array = [elementA ,elementB ,elementC]

func _ready():
	sortTopScoreList()
	
	# Ver lvl_8_save:
	var tempData = fs.loadFromFile()
	if !tempData.empty():
		topScoreList = tempData
	
func sortTopScoreList() -> void:
	topScoreList.sort_custom(self, "customComparison")

func customComparison(a, b) -> bool:
	if typeof(a["score"]) != typeof(b["score"]):
		return typeof(a["score"]) < typeof(b["score"])
	else:
		return a["score"] < b["score"]

func getMinimumScore() -> int:
	sortTopScoreList()
	return topScoreList[0]["score"]

func setNewHighScore(newName: String) -> void:
	var newElement = dictionaryElement.duplicate() 
	newElement["name"]  = newName
	newElement["score"] = currentScore
	topScoreList.append(newElement)
	sortTopScoreList()
	topScoreList.remove(0)
	fs.saveToFile(topScoreList)
