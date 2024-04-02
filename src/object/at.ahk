at(param_object,param_paths) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []

	; create
	for key, value in param_paths {
		val := this.get(param_object, value)
			l_array.push(val)
	}
	return l_array
}


; tests
object := {"a": [{ "b": {"c": 3} }, 4]}
assert.test(A.at(object, ["a[1].b.c", "a[2]"]), [3, 4])


; omit
assert.test(A.at(object, ["a[1]", "a[2]"]), [{ "b": {"c": 3} }, 4])
assert.label("retrieve non-existant path")
assert.test(A.at(object, ["a[1]", "a.c.b"]), [{ "b": {"c": 3} }, ""])
