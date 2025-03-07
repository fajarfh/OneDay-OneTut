extends NumFilter
class_name TrisNumFilter

func is_filtered(num) -> bool:
	return (typeof(num) == TYPE_INT) && (num % 3 == 0)
