clamp(param_number,param_lower,param_upper) {
	if (IsObject(param_number) || IsObject(param_lower) || IsObject(param_upper)) {
		this.internal_ThrowException()
	}

	; check the lower bound
	if (param_number < param_lower) {
		param_number := param_lower
	}
	; check the upper bound
	if (param_number > param_upper) {
		param_number := param_upper
	}
	return param_number
}


; tests
assert.test(A.clamp(-10, -5, 5), -5)
assert.test(A.clamp(10, -5, 5), 5)


; omit
; ensure no change to params
var := -10
assert.test(A.clamp(var, -5, 5), -5)
assert.test(var, -10)
