class_name TileInfo
extends Control


export (NodePath) onready var _name = get_node(_name) as Label
export (NodePath) onready var _cost = get_node(_cost) as Label


func show_tile(tile: Tile) -> void:
	if tile:
		visible = true
		_name.text = str(tile.type.name)
		_cost.text = str(tile.cost)
	else:
		visible = false
