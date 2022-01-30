extends NinePatchRect


export var invest_coins = 100
export var time = 5
var invest_pressed = false
var claimed = false
var time_in_min = 0

func _ready():
	$ClaimButton.disabled = true
	$Timer.wait_time = time

func _process(delta):
	if invest_pressed:
		$TimerLabel.text = "TIME LEFT " + str($Timer.time_left).pad_decimals(2)
		
		if time > 60: #When above 60 sec we are converting to min by dividing
			time_in_min = time / 60.0
			$TimerLabel.text = "TIME LEFT " + str(time_in_min) + " MINS" # it works!
				

func _on_InvestButton_pressed():
	if not invest_pressed:
		invest_pressed = true
		$Timer.start()

func _on_ClaimButton_pressed():
	if not claimed:
		Global.coins += invest_coins
		$CoinsLabel.text = "coins = " + str(Global.coins)
		
		$ClaimButton.disabled = true
		$InvestButton.disabled = false
		invest_pressed = false
		

func _on_Timer_timeout():   #Now Both buttons swap their disabled!
	$InvestButton.disabled = true
	$ClaimButton.disabled = false
