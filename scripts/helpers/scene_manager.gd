extends Node

var _child_scene : Node
var _loading_scene : Node
var _scene_path : String
var _scene_type : GlobalData.SceneType

func add_child_scene(target: String) -> void:
	_scene_path = target
	_scene_type = GlobalData.SceneType.ADD_CHILD_SCENE
	
	show_loading_scene()
	ResourceLoader.load_threaded_request(_scene_path)
	
func change_scene(target: String) -> void:
	_scene_path = target
	_scene_type = GlobalData.SceneType.CHANGE_SCENE
	
	show_loading_scene()
	ResourceLoader.load_threaded_request(_scene_path)

func hide_loading_scene() -> void:
	_loading_scene.loading_process.disconnect(loading_process)
	get_tree().current_scene.remove_child(_loading_scene)
	_loading_scene.queue_free()
	
func load_main_menu() -> void:
	_scene_path = GlobalData.MAIN_MENU_PATH
	_scene_type = GlobalData.SceneType.LOAD_MAIN_MENU
	
	show_loading_scene()
	ResourceLoader.load_threaded_request(_scene_path)

func loading_process() -> void:
	var status = ResourceLoader.load_threaded_get_status(_scene_path)
	
	match status:
		ResourceLoader.THREAD_LOAD_LOADED:
			next_scene_loaded()
			
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			hide_loading_scene()
			show_error_message("Invalid resource")
			
		ResourceLoader.THREAD_LOAD_FAILED:
			hide_loading_scene()
			show_error_message("Load failed")
			
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			pass

func next_scene_loaded() -> void:
	# Remove loading screen
	hide_loading_scene()
	
	# Handle each scene type
	match _scene_type:
		GlobalData.SceneType.ADD_CHILD_SCENE:
			# New scene
			var new_scene = ResourceLoader.load_threaded_get(_scene_path)
			var new_node = new_scene.instantiate()
			
			var current_scene = get_tree().current_scene
			current_scene.add_child(new_node)
			get_tree().current_scene = new_node
			_child_scene = new_node
			
		GlobalData.SceneType.CHANGE_SCENE:
			get_tree().change_scene_to_file(_scene_path)
		
		GlobalData.SceneType.LOAD_MAIN_MENU:
			get_tree().change_scene_to_file(GlobalData.MAIN_MENU_PATH)
			
		GlobalData.SceneType.REMOVE_CHILD_SCENE:
			var current_scene = get_tree().current_scene
			current_scene.remove_child(_child_scene)
			_child_scene.queue_free()

func show_loading_scene() -> void:
	_loading_scene = preload(GlobalData.LOADING_SCREEN_PATH).instantiate()
	_loading_scene.loading_process.connect(loading_process)
	
	var current_scene = get_tree().current_scene
	if current_scene:
		current_scene.add_child(_loading_scene)

func show_error_message(errorMessage : String) -> void:
	var error_dialog_box = AcceptDialog.new()
	
	var current_scene = get_tree().current_scene
	current_scene.add_child(error_dialog_box)
	
	error_dialog_box.title = "Error"
	error_dialog_box.dialog_text = errorMessage
	error_dialog_box.popup_centered()
