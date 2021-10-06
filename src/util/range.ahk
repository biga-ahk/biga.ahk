; ###incomplete###
range(param_start:=0,param_end:=0,param_step:=1) {
	if (!this.isNumber(param_start) || !this.isNumber(param_end) || !this.isNumber(param_step)) {
		this._internal_ThrowException()
	}

	; prepare
	return_array := []
	if (param_start == 0 && param_end == 0) {
		return return_array
	}
	if (param_end == 0) {
		param_end := param_start
		param_start := 0
	}
	l_currentStep := param_start

	; create
	while (param_start <= param_end || param_start == param_end) {
		return_array.push(l_currentStep)
		if (param_step == 0) {
			param_start += 1
		} else {
			param_start += param_step
			l_currentStep += param_step
		}
	}
	return return_array
}


; tests
assert.test(A.range(4), [0, 1, 2, 3])

assert.test(A.range(-4), [0, -1, -2, -3])

assert.test(A.range(1, 5), [1, 2, 3, 4])

assert.test(A.range(0, 20, 5), [0, 5, 10, 15])

assert.test(A.range(0, -4, -1), [0, -1, -2, -3])

assert.test(A.range(1, 4, 0), [1, 1, 1])

assert.test(A.range(0), [])


; omit
