get(param_object,param_path,param_defaultValue:="") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	regex := "/[.\[\]]/"
	if (!isObject(param_path)) {
		l_array := this.compact(this.split(param_path, regex))
		param_path := []
		; remove undefined elements from array
		for key, value in l_array {
			if (value != "") {
				param_path.push(value)
			}
		}
	}

	; create
	for key, value in param_path {
		param_object := param_object[value]
	}
	if (param_object == "") {
		param_object := param_defaultValue
	}
	return param_object
}


; tests
object := {"a": [{ "b": { "c": 3} }]}

assert.test(A.get(object, "a[1].b.c"), 3)
assert.test(A.get(object, ["a", "1", "b", "c"]), 3)
assert.test(A.get(object, "a.b.c", "default"), "default")


; omit
