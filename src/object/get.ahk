get(param_object,param_path,param_defaultValue:="") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	regex := "/[.\[\]]/"
	larr := this.compact(this.split(param_path, regex))

	; create
	for key, value in larr {
		param_object := param_object[value]
	}
	return param_object
}


; tests
object := {"a": [{ "b": { "c": 3} }]}

assert.test(A.get(object, "a[1].b.c"), 3)


; omit
