extends TextureRect
class_name Ingredient

export(int) var max_item := 7
export(float) var price := 200.0

var item_left: int setget set_item_left

func _ready():
	self.item_left = max_item

func set_item_left(value):
	item_left = value
	$Label.text = "%d" % item_left

func is_ingredient_avialable() -> bool:
	return item_left > 0

