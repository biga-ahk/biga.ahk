flatten(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := []

	; create
	for index, object in param_array {
		if (isObject(object)) {
			for index2, object2 in object {
				l_obj.push(object2)
			}
		} else {
			l_obj.push(object)
		}
	}
	return l_obj
}


; tests
assert.test(A.flatten([1, [2, [3, [4]], 5]]), [1, 2, [3, [4]], 5])
assert.test(A.flatten([[1, 2, 3], [4, 5, 6]]), [1, 2, 3, 4, 5, 6])

; omit
assert.test(A.flatten([]), [], "Flatten an empty array")
assert.test(A.flatten([[], [], []]), [], "Flatten an array with nested empty arrays")
assert.test(A.flatten([1, ["", ""], [3, 4]]), [1, "", "", 3, 4], "Flatten an array with undefined elements")
