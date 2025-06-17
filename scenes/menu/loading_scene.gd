extends CanvasLayer

signal loading_process

var _emitLoadingProcessed : bool
var _ellipseCount : int = 1

# Constructor
func _init():
	_emitLoadingProcessed = false

func _on_ellipse_timer_timeout() -> void:
	if (not _emitLoadingProcessed):
		_emitLoadingProcessed = true
		loading_process.emit()
	
	if (_ellipseCount == 1):
		$%EllipseLabel.text = "."
		_ellipseCount += 1
	elif (_ellipseCount == 2):
		$%EllipseLabel.text = ".."
		_ellipseCount += 1
	else:
		$%EllipseLabel.text = "..."
		_ellipseCount = 1
