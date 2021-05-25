isInteger(param) {
	if param is integer
	{
		if (!this.isString(param)) {
			return true
		}
	}
	return false
}


; tests
assert.true(A.isInteger(1))
assert.false(A.isInteger("1"))

; omit
assert.label("omit")
; assert.true(A.isInteger(1.0000))
assert.true(A.isInteger(-1))
assert.true(A.isInteger(-10))
assert.false(A.isInteger(1.00001))
assert.false(A.isInteger([]))
assert.false(A.isInteger({}))
