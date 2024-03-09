without(param_array,param_values*) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_array)

	; create
	for i, val in param_values {
		while ((foundIndex := this.indexOf(l_array, val)) != -1) {
			l_array.removeAt(foundIndex)
		}
	}
	return l_array
}


; tests
assert.label("Array with multiple instances of the excluded elements")
assert.test(A.without([2, 1, 2, 3], 1, 2), [3])


; omit
assert.label("Array with single instance of the excluded element")
assert.test(A.without([2, 1, 2, 3], 1), [2, 2, 3])

assert.label("Array with no excluded elements")
assert.test(A.without([2, 1, 2, 3], 4), [2, 1, 2, 3])

assert.label("Empty array")
assert.test(A.without([], 1, 2), [])
