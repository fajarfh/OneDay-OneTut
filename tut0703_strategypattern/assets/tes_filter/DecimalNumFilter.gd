extends NumFilter
class_name DecimalNumFilter

func is_filtered(num) -> bool:
	return num != floor(num)
