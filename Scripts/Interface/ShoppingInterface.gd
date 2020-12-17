extends Control

onready var animator = get_node("ArrowAnimator")
onready var swipeAnimator = get_node("SwipeAnimator")

onready var currentSprite = get_node("ShoppingBackground/CurrentCharacterSprite")
onready var previousSprite = get_node("ShoppingBackground/PreviousCharacterSprite")
onready var nextSprite = get_node("ShoppingBackground/NextCharacterSprite")
onready var afterNextSprite = get_node("ShoppingBackground/AfterNextCharacterSprite")

var path = "res://Sprites/Character/"
var dir = Directory.new()
var arrowCount = 0
var characterArray = []
var key = false

func _ready():
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var fileName = dir.get_next()
		if fileName == "":
			break
		elif !fileName.begins_with(".") and !fileName.ends_with(".import"):
			characterArray.append(load(path + "/" + fileName))
	dir.list_dir_end()
	animator.play("ArrowIdleAnimation")

func onRightArrowPressed():
	arrowCount += 1
	print(arrowCount)
	if arrowCount <= characterArray.size() and key == false:
		nextSprite.texture = characterArray[arrowCount]
		currentSprite.texture = characterArray[arrowCount - 1]
		if arrowCount >= 2:
			previousSprite.set_visible(true)
			previousSprite.texture = characterArray[arrowCount - 2]
		else:
			previousSprite.texture = characterArray[characterArray.size() - 1]
		if arrowCount <= characterArray.size() - 2:
			afterNextSprite.texture = characterArray[arrowCount + 1]
		if arrowCount == characterArray.size() - 1:
			afterNextSprite.texture = characterArray[0]
			key = true
	elif key == true:
		previousSprite.texture = characterArray[characterArray.size() - 2]
		if arrowCount == characterArray.size():
			currentSprite.texture = characterArray[arrowCount - 1]
			nextSprite.texture = characterArray[0]
			afterNextSprite.texture = characterArray[1]
			arrowCount = 0
			key = false
	swipeAnimator.play("rightSwipe")
