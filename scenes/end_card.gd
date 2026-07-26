extends Node2D

@onready var space_ship_1: Area2D = $CanvasLayer/SpaceShip1
@onready var space_ship_2: Area2D = $CanvasLayer/SpaceShip2
@onready var space_ship_3: Area2D = $CanvasLayer/SpaceShip3
@onready var space_ship_4: Area2D = $CanvasLayer/SpaceShip4

func _on_ship_4_timer_timeout() -> void:
	space_ship_4.launch()

func _on_ship_3_timer_timeout() -> void:
	space_ship_3.launch()

func _on_ship_2_timer_timeout() -> void:
	space_ship_2.launch()

func _on_ship_1_timer_timeout() -> void:
	space_ship_1.launch()
