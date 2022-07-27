lt(param_value, param_other) {
	if (!this.isNumber(param_value) || !this.isNumber(param_other)) {
		this._internal_ThrowException()
	}

	; create
	if (param_value < param_other) {
		return true
	}
	return false
}


; tests
assert.true(A.lt(1, 3))
assert.false(A.lt(3, 3))
assert.false(A.lt(3, 1))

; omit
