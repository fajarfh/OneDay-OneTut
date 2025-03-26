extends Control

@onready var pixelized = $pixelized
@onready var monochrome = $monochrome
@onready var chromatic_abber = $chromatic_abber
@onready var blur = $blur


func _on_v_slider_value_changed(value):
	pixelized.material.set_shader_parameter("size_x", value)
	pixelized.material.set_shader_parameter("size_y", value)


func _on_v2_slider_value_changed(value):
	monochrome.material.set_shader_parameter("darkness", value)


func _on_v3_slider_value_changed(value):
	chromatic_abber.material.set_shader_parameter("offset", value)


func _on_v4_slider_value_changed(value):
	blur.material.set_shader_parameter("strength", value)


func _on_v5_slider_2_value_changed(value):
	blur.material.set_shader_parameter("mix_percentage", value)
