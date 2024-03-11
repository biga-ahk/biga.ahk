slice(param_array,param_start:=0,param_end:=0) {
	if (!this.isNumber(param_start) || !this.isNumber(param_end)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []
	if (this.isStringLike(param_array)) {
		param_array := strSplit(param_array)
	}

	; parameter adjustment
	if (param_start > 0) {
		begin := param_start
	} else if (param_start < 0) {
		begin := param_array.count() + param_start + 1
	} else {
		begin := 1
	}

	if (param_end > 0) {
		last := param_end
	} else if (param_end < 0) {
		last := param_array.count() + param_end
	} else {
		last := param_array.count()
	}

	; create
	for index, value in param_array {
		if (index >= begin && index <= last) {
			l_array.push(value)
		}
	}
	return l_array
}


; tests
assert.test(A.slice([1, 2, 3], 1, 2), [1, 2])
assert.test(A.slice([1, 2, 3], 1), [1, 2, 3])
assert.test(A.slice([1, 2, 3], 5), [])
assert.test(A.slice("fred"), ["f", "r", "e", "d"])
assert.test(A.slice(100), ["1", "0", "0"])


; omit
