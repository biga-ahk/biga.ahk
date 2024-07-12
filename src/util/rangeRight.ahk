rangeRight(param_start:=0, param_end:=0, param_step:=1) {
	if (!this.isNumber(param_start) || !this.isNumber(param_end) || !this.isNumber(param_step)) {
		this._internal_ThrowException()
	}

	return this.reverse(this.range(param_start, param_end, param_step))
}


; tests
assert.test(A.rangeRight(4), [3, 2, 1, 0])

assert.test(A.rangeRight(-4), [-3, -2, -1, 0])

assert.test(A.rangeRight(1, 5), [4, 3, 2, 1])

assert.test(A.rangeRight(0, 20, 5), [15, 10, 5, 0])

assert.test(A.rangeRight(0, -4, -1), [-3, -2, -1, 0])

assert.test(A.rangeRight(1, 4, 0), [1, 1, 1])

assert.test(A.rangeRight(0), [])


; omit
assert.label("negative step omitted")
assert.test(A.rangeRight(-2, -6), [-5, -4, -3, -2])

assert.label("for step = 0")
assert.test(A.rangeRight(1, 4, 0), [1, 1, 1])

assert.label("all parameters omitted")
assert.test(A.rangeRight(), [])

assert.label("start negative and step 1")
assert.test(A.range(-6, -2), [-6, -5, -4, -3])

assert.label("unreachable end with 0 step")
assert.test(A.range(4, 1, 0), [])

assert.label("negative step required")
assert.test(A.rangeRight(50, 48), [49, 50])
