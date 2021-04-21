flattenDeep(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_depth := this.depthOf(param_array)

	; create
	return this.flattenDepth(param_array, l_depth)
}


; tests
assert.test(A.flattenDeep([1]), [1])
assert.test(A.flattenDeep([1, [2]]), [1, 2])
assert.test(A.flattenDeep([1, [2, [3, [4]], 5]]), [1, 2, 3, 4, 5])

; omit
assert.test(A.flattenDeep({"key": 1}), [1])
