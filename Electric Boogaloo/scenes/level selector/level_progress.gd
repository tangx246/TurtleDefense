extends Node

var unlockedLevel : int = 0

const key : String = "unlockedLevel"

func _ready():
	unlockedLevel = PlayerPrefs.get_value(key, 0)

func save():
	PlayerPrefs.set_value(key, unlockedLevel)
	PlayerPrefs.save()
	
func setCurrentProgress(level : int):
	unlockedLevel = level
	save()

func getCurrentProgress() -> int:
	return unlockedLevel
