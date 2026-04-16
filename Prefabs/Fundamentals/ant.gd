extends Entity
class_name Ant



func drop_item():
	if not item_held:
		return false
	
	#functionality here !!
	
	item_held = null
	return true

func grab(item):
	if item_held:
		drop_item()
	
	#functionality here !!
	
	item_held = item
