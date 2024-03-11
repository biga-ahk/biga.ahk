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
assert.label("smaller first number")
assert.false(A.gte(1, 2))

assert.label("zero as first number")
assert.false(A.gte(0, 1))

assert.label("zero as second number")
assert.true(A.gte(1, 0))

assert.label("negative numbers")
assert.true(A.gte(-1, -2))

assert.label("equal negative numbers")
assert.true(A.gte(-1, -1))

assert.label("negative and positive number")
assert.false(A.gte(-1, 1))

assert.label("fractions")
assert.true(A.gte(0.5, 0.2))

assert.label("equal fractions")
assert.true(A.gte(0.5, 0.5))

assert.label("smaller fraction as first number")
assert.false(A.gte(0.2, 0.5))

assert.label("large numbers")
assert.true(A.gte(1000000, 999999))

assert.label("equal large numbers")
assert.true(A.gte(1000000, 1000000))
