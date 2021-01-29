multiply(param_multiplier,param_multiplicand) {
	if (!this.isNumber(param_multiplier) || !this.isNumber(param_multiplicand)) {
		this._internal_ThrowException()
	}

	; create
	return param_multiplier * param_multiplicand
}


; tests
assert.test(A.multiply(6, 4), 24)


; omit
assert.label("negative numbers")
assert.test(A.multiply(10, -1), -10)
assert.test(A.multiply(-10, -10), 100)
