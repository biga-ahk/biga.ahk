nth(param_array,param_n:=1) {
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
	if (param_n == 0) {
		param_n := 1
	}

	; create
	if (l_array.count() < param_n) { ;return "" if n is greater than the array's size
		return ""
	}
	if (param_n > 0) {
		return l_array[param_n]
	}
	; return empty array if empty
	if (l_array.count() == 0) {
		return ""
	}
	; if called with negative n, call self with reversed array and positive number
	l_array := this.reverse(l_array)
	param_n := 0 - param_n
	return this.nth(l_array, param_n)
}


; tests
assert.test(A.nth([1, 2, 3]), 1)
assert.test(A.nth([1, 2, 3], -3), 1)
assert.test(A.nth([1, 2, 3], 5), "")
assert.test(A.nth("fred"), "f")
assert.test(A.nth(100), "1")
assert.test(A.nth([1, 2, 3], 0), 1)


; omit
assert.test(A.nth([]), "")
