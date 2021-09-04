at(param_object,param_paths,param_defaultValue:="") {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []

	; create
	for key, value in param_paths {
		l_array.push(this.get(param_object, value))
	}
	return l_array
}


; tests
object := {"a": [{ "b": { "c": 3} }, 4]}

assert.test(A.at(object, ["a[1].b.c", "a[2]"]), [3, 4])


; omit
