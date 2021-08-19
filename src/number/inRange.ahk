inRange(param_number,param_start:=0,param_end:="") {
	if (!this.isNumber(param_number) || !this.isNumber(param_start) || isObject(param_end)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_end == "") {
		param_end := param_start
		param_start := 0
	}
	if (param_start > param_end) {
		l_temp := param_start
		param_start := param_end
		param_end := l_temp
	}

	; perform
	if (param_number > param_start && param_number < param_end) {
		return true
	}
	return false
}


; tests
assert.true(A.inRange(3, 2, 4))
assert.true(A.inRange(4, 8))
assert.false(A.inRange(4, 2))
assert.false(A.inRange(2, 2))
assert.true(A.inRange(1.2, 2))
assert.false(A.inRange(5.2, 4))
assert.true(A.inRange(-3, -2, -6))


; omit
