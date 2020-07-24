flattenDeep(param_array) {
	if (!IsObject(param_array)) {
		this._internal_ThrowException()
	}

	; data setup
	l_depth := this.depthOf(param_array)

	; create the return
	return this.flattenDepth(param_array, l_depth)
	; l_obj := this.cloneDeep(param_array)
	; while (this.depthOf(l_obj) != 1) {
	;     l_obj := this.flatten(l_obj)
	; }
}


depthOf(param_obj,param_depth:=1) {
	for Key, Value in param_obj {
		if (IsObject(Value)) {
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
