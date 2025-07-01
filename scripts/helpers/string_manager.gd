extends Node

func format_paddle_control_type(input: GlobalData.PaddleControlType):
	# PaddleControlType {NONE, PLAYER_1, PLAYER_2, AI_EASY, AI_MEDIUM, AI_HARD}
	if input == GlobalData.PaddleControlType.NONE:
		return "None"
	elif input == GlobalData.PaddleControlType.PLAYER_1:
		return "Player 1"
	elif input == GlobalData.PaddleControlType.PLAYER_2:
		return "Player 2"
	elif input == GlobalData.PaddleControlType.AI_EASY:
		return "AI Easy"
	elif input == GlobalData.PaddleControlType.AI_MEDIUM:
		return "AI Medium"
	elif input == GlobalData.PaddleControlType.AI_HARD:
		return "AI Hard"
	else:
		return "Error"
