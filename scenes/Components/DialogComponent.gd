extends RichTextLabel

onready var tween := $Tween

# KNOW: Might be used or removed in later future
signal dialog_started
signal dialog_changed
signal dialog_ended

export (float) var text_speed := 0.05
export (String, FILE, "*json") var dialog_file_path

var current_text

func _ready():
	current_text = load_dialog_file()[0].text

func load_dialog_file() -> Array:
	var file = File.new()

	# Check If Dialog File Exists
	assert(file.file_exists(dialog_file_path), "Dialog File Path is Missing! Please specify a file path")

	file.open(dialog_file_path, File.READ)

	var dialog_text = parse_json(file.get_as_text())

	return dialog_text if typeof(dialog_text) == TYPE_ARRAY else []

func display_text() -> void:
	bbcode_text = current_text
	tween.interpolate_property(self, "percent_visible", 0.0, 1.0, len(current_text) * text_speed, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.start()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		display_text()
