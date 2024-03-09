drop(param_array,param_n:=1) {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_array)) {
		l_array := this.clone(param_array)
	}
	if (this.isStringLike(param_array)) {
		l_array := strSplit(param_array)
	}

	; create
	l_array.removeAt(1, param_n)
	; return empty array if empty
	if (l_array.count() == 0) {
		return []
	}
	return l_array
}


; tests
assert.test(A.drop([1, 2, 3]), [2, 3])
assert.test(A.drop([1, 2, 3], 2), [3])
assert.test(A.drop([1, 2, 3], 5), [])
assert.test(A.drop([1, 2, 3], 0), [1, 2, 3])
assert.test(A.drop("fred"), ["r", "e", "d"])
assert.test(A.drop(100), ["0", "0"])


; omit
assert.test(A.drop([]), [])
assert.test(A.drop([1, 2, 3], 3), [])
assert.test(A.drop(["a", "b", "c", "d"], 2), ["c", "d"], "non-numeric values")
; lodash .drop does not work with associative arrays
