flattenDeep(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_depth := this.depthOf(param_array)

	; create
	return this.flattenDepth(param_array, l_depth)
}


depthOf(param_obj,param_depth:=1) {
	for Key, Value in param_obj {
		if (isObject(Value)) {
			param_depth++
			param_depth := this.depthOf(Value, param_depth)
		}
	}
	return param_depth
}


; tests
assert.test(A.flattenDeep([1]), [1])
assert.test(A.flattenDeep([1, [2]]), [1, 2])
assert.test(A.flattenDeep([1, [2, [3, [4]], 5]]), [1, 2, 3, 4, 5])

; omit
assert.test(A.depthOf([1]), 1)
assert.test(A.depthOf([1, [2]]), 2)
assert.test(A.depthOf([1, [[2]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]], 5]]), 4)
