extends TileMap

func _ready() -> void:
	var filled_tiles := get_used_cells(0)
	
	var directions := [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i(-1, -1),
		Vector2i(1, -1),
		Vector2i(-1, 1),
		Vector2i(1, 1)
	]

	for filled_tile in filled_tiles:
		for dir in directions:
			var neighbor: Vector2i = filled_tile + dir
			if get_cell_source_id(0, neighbor) == -1:
				set_cell(0, neighbor, 0, Vector2i.ZERO)  
