gte(param_value, param_other) {
	if (!this.isNumber(param_value) || !this.isNumber(param_other)) {
		this._internal_ThrowException()
	}

	; create
	if (param_value >= param_other) {
		return true
	}
	return false
}


; tests
assert.true(A.gte(3, 1))
assert.true(A.gte(3, 3))
assert.false(A.gte(1, 3))

; omit
