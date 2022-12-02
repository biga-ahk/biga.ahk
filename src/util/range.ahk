range(param_start:=0,param_end:=0,param_step:=1) {
	if (!this.isNumber(param_start) || !this.isNumber(param_end) || !this.isNumber(param_step)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []
	; A step of -1 is used if a negative start is specified without an end or step.
	if (param_start < 0 && param_end == 0 && param_step == 1) {
		param_step := -1
	}
	if (param_start == 0 && param_end == 0) {
		return l_array
	}
	if (param_end == 0) {
		param_end := param_start
		param_start := 0
	}
	l_currentStep := param_start
	if (param_end > param_start) {
		l_negativeFlag := true
	}
	; where step is 0, end at the array count
	if (param_step == 0) {
		zeroStepFlag := true
	}


	; create
	if (zeroStepFlag == true) {
		loop, % param_end - 1 {
			l_array.push(l_currentStep)
			l_currentStep += param_step
		}
	} else {
		while (l_currentStep != param_end) {
			l_array.push(l_currentStep)
			l_currentStep += param_step
		}
	}
	return l_array
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
