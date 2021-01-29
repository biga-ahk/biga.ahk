subtract(param_minuend,param_subtrahend) {
	if (!this.isNumber(param_minuend) || !this.isNumber(param_subtrahend)) {
		this._internal_ThrowException()
	}

	; create
	param_minuend -= param_subtrahend
	return param_minuend
}


; tests
assert.test(A.subtract(6, 4), 2)


; omit
assert.label("negtive number")
assert.test(A.subtract(10, -1), 11)
assert.test(A.subtract(-10, -10), 0)

assert.label("decimal")
assert.test(A.subtract(10, 0.01), 9.99)

assert.label("parameter mutation")
g_value := 10
assert.test(A.subtract(g_value, 10), 0)
assert.test(g_value, 10)
