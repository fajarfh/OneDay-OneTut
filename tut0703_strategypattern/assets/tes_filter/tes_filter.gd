extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	var list = [1,3,6,-7,3.14,1.08, 5,19,-20,2025,20.25]
	print("list awal: ", str(list))
	
	var filter = DecimalNumFilter.new()
	print("list akhir: ", str(lets_filter(list,filter)))

func lets_filter(list:Array[Variant], filter:NumFilter):
	
	var new_list = []
	for x in list:
		if !filter.is_filtered(x):
			new_list.append(x)
	
	return new_list
