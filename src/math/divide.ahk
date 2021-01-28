divide(param_dividend,param_divisor) {
	if (!this.isNumber(param_dividend) || !this.isNumber(param_divisor)) {
		this._internal_ThrowException()
	}

	; create
	return param_dividend / param_divisor
}


; tests
assert.test(A.divide(6, 4), 1.5)


; omit
assert.test(A.divide(10, -1), -10)
assert.test(A.divide(-10, -10), 1)
