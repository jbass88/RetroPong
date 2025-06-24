extends Node

enum PaddleControlType {NONE, PLAYER_1, PLAYER_2, AI_EASY, AI_MEDIUM, AI_HARD}
enum SceneType {ADD_CHILD_SCENE,CHANGE_SCENE,LOAD_MAIN_MENU,REMOVE_CHILD_SCENE}

const MAIN_MENU_PATH : String = "res://scenes/menu/main_menu_scene.tscn"
const LOADING_SCREEN_PATH : String = "res://scenes/menu/loading_scene.tscn"

var PaddleControlLeft : PaddleControlType = PaddleControlType.NONE
var PaddleControlRight : PaddleControlType = PaddleControlType.NONE
var PaddleScoreLeft : int = 0
var PaddleScoreRight : int = 0
