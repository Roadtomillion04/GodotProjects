extends Node

signal LeverChanged

func LeverChanged():
	emit_signal("LeverChanged")
