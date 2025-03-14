extends Button

@onready var http_request = $HTTPRequest

var url := "https://www.dnd5eapi.co"
var page := "/api"


signal info(data)

func _on_pressed():
	http_request.request(url + page)
	


#result = code indikator keberhasilan koneksi dengan server
# 0 -> bagus; angka lain -> jelek
#response = code jenis respon dari server
# 200 -> oke; angka lain -> jelek (mis: 404, 500, dll)
# headers buat autentifikasi, body isi dari laman api yang di-request (url+page)
func _on_request_completed(result, response_code, headers, body):
	var data = JSON.parse_string(body.get_string_from_utf8())
	#print(body.get_string_from_utf8())
	#print(data)
	#print(typeof(body.get_string_from_utf8()))
	#print(typeof(data))
	info.emit(data)
