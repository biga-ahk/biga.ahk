take(param_array,param_n:=1) {
	if (!this.isNumber(param_n)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_array)) {
		param_array := this.clone(param_array)
	}
	if (this.isStringLike(param_array)) {
		param_array := strSplit(param_array)
	}
	l_array := []

	; create
	for key, value in param_array {
		if (param_n < A_Index) {
			break
		}
		l_array.push(value)
	}
	; return empty array if empty
	if (l_array.count() == 0 || param_n == 0) {
		return []
	}
	return l_array
}


; tests
assert.test(A.take([1, 2, 3]), [1])
assert.test(A.take([1, 2, 3], 2), [1, 2])
assert.test(A.take([1, 2, 3], 5), [1, 2, 3])
assert.test(A.take([1, 2, 3], 0), [])
assert.test(A.take("fred"), ["f"])
assert.test(A.take(100), ["1"])
; omit
assert.test(A.take([]), [])
