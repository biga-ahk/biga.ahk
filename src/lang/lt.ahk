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
assert.label("equal numbers")
assert.false(A.lt(1, 1))

assert.label("smaller first number")
assert.true(A.lt(1, 2))

assert.label("zero as first number")
assert.true(A.lt(0, 1))

assert.label("zero as second number")
assert.false(A.lt(1, 0))

assert.label("negative numbers")
assert.false(A.lt(-1, -2))

assert.label("negative and positive number")
assert.true(A.lt(-1, 1))

assert.label("fractions")
assert.false(A.lt(0.5, 0.2))

assert.label("equal fractions")
assert.false(A.lt(0.5, 0.5))

assert.label("large numbers")
assert.false(A.lt(1000000, 999999))
