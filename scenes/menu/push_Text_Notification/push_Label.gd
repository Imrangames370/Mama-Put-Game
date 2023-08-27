extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
#	text = message
	$AnimationPlayer.stop()
	$AnimationPlayer.play("fade")
	$Tween.interpolate_property(self, "rect_position:y", rect_position.y, rect_position.y - (rect_position.y/2) , 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Label/Tween.interpolate_property($Label, "rect_position", $Label.rect_position, $Label.rect_position - Vector2(0, 80), 1)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $Tween.is_active():
		queue_free()
		pass
