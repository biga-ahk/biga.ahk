subtract(param_minuend,param_subtrahend) {
	if (IsObject(param_minuend) || IsObject(param_subtrahend)) {
		this._internal_ThrowException()
	}

	; create
	param_minuend -= param_subtrahend
	return param_minuend
}


; tests
assert.test(A.subtract(6, 4), 2)


; omit
assert.test(A.subtract(10, -1), 11)
assert.test(A.subtract(-10, -10), 0)
assert.test(A.subtract(10, 0.01), 9.99)
