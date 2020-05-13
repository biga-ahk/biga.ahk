toPairs(param_object) {
	if (!IsObject(param_object)) {
		this.internal_ThrowException()
	}

	l_array := []
	for Key, Value in param_object {
		l_array.push([Key, Value])
	}
	return l_array
}


; tests
assert.test(A.toPairs({"a": 1, "b": 2}), [["a", 1], ["b", 2]])
