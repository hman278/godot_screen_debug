tool
extends Node

func add_on_screen_debug_message(
	text: String, duration: float, color: Color = Color.aqua) -> void:
	
	var root
	var container: VBoxContainer
	
	if Engine.editor_hint:
		root = get_tree().get_edited_scene_root()
		
		if root:
			for child in root.get_children():
				if child.is_in_group('_container'):
					container = child
	else:
		root = get_tree().get_root()
	
		if root:
			for child in root.get_children():
				if child.get_children().size() != 0:
					for _child in child.get_children():
						if _child.is_in_group('_container'):
							container = _child
	
	container.margin_left   = 20
	container.margin_top    = 20
	
	var label = Label.new()
	label.text = text
	label.add_color_override('font_color', color)
	
	container.add_child(label)
	label.set_owner(container)
	
	get_tree().create_timer(
		duration, false).connect('timeout', self, '__on_label_timer_timeout', [label])

func __on_label_timer_timeout(label: Label) -> void:
	label.queue_free()
