extends AspectRatioContainer

onready var dish_ingredients = $VBoxContainer/DishIngredients
onready var dish_cook_timer = $DishCookTimer

export(int) var dish_cook_time := 20

func _ready():
	dish_cook_timer.wait_time = dish_cook_time

func _on_MakeButton_button_down():
	if dish_cook_timer.is_stopped() and dish_ingredients.get_child_count() > 0:
		for child in dish_ingredients.get_children():
			if child is Ingredient:
				if child.is_ingredient_avialable():
					continue
				else:
					return

		dish_cook_timer.start()
		print("Cook")
		for child in dish_ingredients.get_children():
			if child is Ingredient:
				child.item_left -= 1


func _on_DishCookTimer_timeout():
	# Upadate Dish Count
	pass # Replace with function body.
