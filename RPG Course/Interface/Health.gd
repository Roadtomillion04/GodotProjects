extends Control

onready var health_bar = $HealthBar
onready var update_tween = $Tween

onready var Health_Tween = $HealthBarUnder
onready var HP = $HP


func _ready():
	health_bar.value = PlayerStats.CurrentHealth
	_on_max_health_updated()

func _process(delta):
	_on_health_updated(PlayerStats.CurrentHealth)

func _on_health_updated(health):
	health_bar.value = PlayerStats.CurrentHealth
	HP.text = str(PlayerStats.CurrentHealth) + " HP/" + str(PlayerStats.MaxHealth) + " HP"
	update_tween.interpolate_property(Health_Tween, "value", Health_Tween.value, health, 0.05, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()

func _on_max_health_updated():
	health_bar.max_value = PlayerStats.MaxHealth
	Health_Tween.max_value = PlayerStats.MaxHealth
