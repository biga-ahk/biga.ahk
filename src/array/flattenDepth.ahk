flattenDepth(param_array,param_depth:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := this.cloneDeep(param_array)

	; create
	loop, % param_depth {
		l_obj := this.flatten(l_obj)
	}
	return l_obj
}


; tests
assert.test(A.flattenDepth([1, [2, [3, [4]], 5]], 1), [1, 2, [3, [4]], 5])
assert.test(A.flattenDepth([1, [2, [3, [4]], 5]], 2), [1, 2, 3, [4], 5])

; omit
