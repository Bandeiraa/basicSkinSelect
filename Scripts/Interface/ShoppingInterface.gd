extends Control

onready var animator = get_node("ArrowAnimator")
onready var currentSprite = get_node("ShoppingBackground/CurrentRealSprite")
onready var previousSprite = get_node("ShoppingBackground/PreviousRealSprite")
onready var nextSprite = get_node("ShoppingBackground/NextRealSprite")
onready var swipeAnimator = get_node("SwipeAnimator")

var arrowCount = 0

func _ready():
	animator.play("ArrowIdleAnimation")

func _process(_delta):
	if arrowCount == 0:
		$ShoppingBackground/LeftArrowButton.set_disabled(true)
		previousSprite.set_visible(false)
	elif arrowCount == 5:
		$ShoppingBackground/RightArrowButton.set_disabled(true)
		nextSprite.set_visible(false)
		
func onLeftArrowPressed():
	if arrowCount == 0:
		$ShoppingBackground/LeftArrowButton.set_disabled(true)
	else:
		swipeAnimator.play("leftSwipe")
		nextSprite.set_visible(true)
		arrowCount -= 1
		$ShoppingBackground/RightArrowButton.set_disabled(false)
		
func onRightArrowPressed():
	if arrowCount == 5:
		$ShoppingBackground/RightArrowButton.set_disabled(true)
	else:
		swipeAnimator.play("rightSwipe")
		previousSprite.set_visible(true)
		arrowCount += 1
		$ShoppingBackground/LeftArrowButton.set_disabled(false)
		
func canSwap():
	currentSprite.texture = load("res://Sprites/Character/character" + str(arrowCount) + ".png")
	if arrowCount >= 1:
			previousSprite.texture = load("res://Sprites/Character/character" + str(arrowCount - 1) + ".png")
	if arrowCount <= 4:
		nextSprite.texture = load("res://Sprites/Character/character" + str(arrowCount + 1) + ".png")
