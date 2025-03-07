extends NumFilter
class_name EvenNumFilter

func is_filtered(num) -> bool:
	return (typeof(num) == TYPE_INT) && (num % 2 == 0)
