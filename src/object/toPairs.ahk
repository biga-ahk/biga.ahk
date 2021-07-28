toPairs(param_object) {
	if (!isObject(param_object)) {
		this._internal_ThrowException()
	}

	l_array := []
	for key, value in param_object {
		l_array.push([key, value])
	}
	return l_array
}


; tests
assert.test(A.toPairs({"a": 1, "b": 2}), [["a", 1], ["b", 2]])


; omit


assert.label("alias")
assert.test(A.entries({"a": 1, "b": 2}), [["a", 1], ["b", 2]])
