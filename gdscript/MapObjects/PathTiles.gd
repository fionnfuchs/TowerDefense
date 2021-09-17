extends TileMap

func _ready():
	Entities.path_tiles = self

func is_free_position(x,y):
	if self.get_cellv(self.world_to_map(Vector2(x,y))) >= 0:
		return false
	else:
		return true
