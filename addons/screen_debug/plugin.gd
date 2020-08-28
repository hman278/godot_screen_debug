tool
extends EditorPlugin

"""
NOTE: VBoxContainer may scale down/up due to its parent being transformed
"""

func _enter_tree():
	add_autoload_singleton('Debug', 'res://addons/screen_debug/debug.gd')
	connect('scene_changed', self, '__on_scene_changed')

func _exit_tree():
	remove_autoload_singleton('Debug')

func __on_scene_changed(root: Node) -> void:
	if root:
		# create a container for scenes that don't have it
		var containers: Array = []
		for child in root.get_children():
			if child.is_in_group('_container'):
				containers.append(child)

		if containers.size() == 0:
			var container = VBoxContainer.new()
			root.add_child(container)
			container.set_owner(root)
			container.add_to_group('_container', true)
			container.alignment = HALIGN_LEFT
			
		
		elif containers.size() == 1:
			return
