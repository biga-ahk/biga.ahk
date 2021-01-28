inRange(param_number,param_lower,param_upper) {
	if (!this.isNumber(param_number) || !this.isNumber(param_lower) || !this.isNumber(param_upper)) {
		this._internal_ThrowException()
	}


	; prepare
	if (param_lower > param_upper) {
		l_temp := param_lower
		param_lower := param_upper
		param_upper := l_temp
	}

	; check the bounds
	if (param_number > param_lower && param_number < param_upper) {
		return true
	}
	return false
}


; tests
assert.test(A.inRange(3, 2, 4), true)
assert.test(A.inRange(4, 0, 8), true)
assert.test(A.inRange(4, 0, 2), false)
assert.test(A.inRange(2, 0, 2), false)
assert.test(A.inRange(1.2, 0, 2), true)
assert.test(A.inRange(5.2, 0, 4), false)
assert.test(A.inRange(-3, -2, -6), true)


; omit
