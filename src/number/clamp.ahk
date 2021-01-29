clamp(param_number,param_lower,param_upper) {
	if (!this.isNumber(param_number) || !this.isNumber(param_lower) || !this.isNumber(param_upper)) {
		this._internal_ThrowException()
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

assert.label("parameter mutation")
value := 10
A.clamp(value, -5, 5)
assert.test(value, 10)
