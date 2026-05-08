extends Entity
class_name Ant


var hunger: float
var item_held: Item


func drop_item():
	if not item_held:
		return false
	
	item_held.reparent(Globals.world.entity_node)
	item_held.is_held = false
	#functionality here !!
	
	item_held = null
	return true

func grab(item: Item):
	if item.is_held:
		return
	if item_held:
		return
	print(item.amount)
	if item.amount > stats.capacity:
		item.amount -= stats.capacity
		item = item.duplicate()
		add_child(item)
		item.amount = stats.capacity
	else:
		item.reparent(self)
	item.is_held = true
	item.global_position = position
	
	#functionality here !!
	
	item_held = item
