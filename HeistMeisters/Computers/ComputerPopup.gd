extends Popup

onready var displayText = $NinePatchRect/CenterContainer/NinePatchRect/Label #this dosent work IDK why?

func set_text(combination):
	$NinePatchRect/CenterContainer/NinePatchRect/Label.text = ("Will you stop forgetting your access code I've set it to "
	+ PoolStringArray(combination).join("") + " ,But this is very last time!"
	)
