without(param_array,param_values*) {
	if (!IsObject(param_array)) {
		this._internal_ThrowException()
	}
	
	; prepare
	l_array := this.clone(param_array)

	; create
	for i, val in param_values {
		while (foundindex := this.indexOf(l_array, val) != -1) {
			l_array.RemoveAt(foundindex)
		}
	}
	return l_array
}


; tests
assert.test(A.without([2, 1, 2, 3], 1, 2), [3])


; omit
assert.test(A.without([2, 1, 2, 3], 1), [2, 3])
assert.test(A.without([2, 1, 2, 3], 1, 2, 3), [])
