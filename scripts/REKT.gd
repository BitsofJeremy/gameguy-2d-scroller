extends CanvasLayer

export(String, FILE, "*.tscn") var next_world

func _ready():
	print('Player dead, score reset to 0')
	global_var.score = 0
	$MarginContainer/VBoxContainer3/VBoxContainer/start_button.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer3/VBoxContainer/start_button.is_hovered() == true:
		$MarginContainer/VBoxContainer3/VBoxContainer2/exit_button.grab_focus()
	if $MarginContainer/VBoxContainer3/VBoxContainer2/exit_button.is_hovered() == true:
		$MarginContainer/VBoxContainer3/VBoxContainer2/exit_button.grab_focus()
		

func _on_start_button_pressed():
	get_tree().change_scene(next_world)

func _on_exit_button_pressed():
	print("player tried to quit")
	get_tree().quit()
