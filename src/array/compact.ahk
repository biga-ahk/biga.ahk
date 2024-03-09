compact(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}
	l_array := []

	; create
	for key, value in param_array {
		if (value == "" || value == 0) {
			continue
		}
		l_array.push(value)
	}
	return l_array
}


; tests
assert.test(A.compact([0, 1, false, 2, "", 3]), [1, 2, 3])


; omit
assert.test(A.compact([1, 2, 3, 4, 5, 6, "", "", ""]), [1, 2, 3, 4, 5, 6])
assert.test(A.compact([]), [])
assert.test(A.compact(["", 0, false]), [])
assert.test(A.compact(["", 0, "hello", "", 1]), ["hello", 1])
assert.test(A.compact([false, 0, ""]), [])
