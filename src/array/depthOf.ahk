depthOf(param_array,param_depth:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	for key, value in param_array {
		if (isObject(value)) {
			param_depth++
			param_depth := this.depthOf(value, param_depth)
		}
	}
	return param_depth
}


; tests
assert.test(A.depthOf([1]), 1)
assert.test(A.depthOf([1, [2]]), 2)
assert.test(A.depthOf([1, [[2]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]], 5]]), 4)

; omit
assert.test(A.depthOf({"key": 1}), 1)
