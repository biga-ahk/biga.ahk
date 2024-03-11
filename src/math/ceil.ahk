ceil(param_number, param_precision := 0) {
	; Check if parameters are numbers
	if (!this.isNumber(param_number) || !this.isNumber(param_precision)) {
		this._internal_ThrowException()
	}
	; Regular ceil if precision is 0
	if (param_precision == 0) {
		return ceil(param_number)
	}

	; create
	l_offset := 0.5 / (10 ** param_precision)
	if (param_number < 0 && param_precision >= 1) {
		; Adjust offset for negative numbers and positive param_precision
		l_offset /= 10
	}
	; Calculate sum based on precision
	l_sum := (param_precision >= 1)
			? format("{:." this.max([strLen(subStr(param_number, inStr(param_number, ".") + 1)), param_precision]) + 1 "f}", param_number + l_offset)
			: param_number + l_offset
	; Trim zeroes and adjust value based on last char
	l_sum := trim(l_sum, "0")
	l_value := (subStr(l_sum, 0) = "5" && param_number != l_sum) ? subStr(l_sum, 1, -1) : l_sum
	return round(l_value, param_precision)
}


; tests
assert.test(A.ceil(4.006), 5)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6040, -2), 6100)


; omit
assert.test(A.ceil(4.1), 5)
assert.test(A.ceil(4.5), 5)
assert.test(A.ceil(41), 41)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6.004, 1), 6.1)
assert.test(A.ceil(6040, -3), 7000)
assert.test(A.ceil(2.22, 2), 2.22)

assert.test(A.ceil(-2.22000000000000020, 2), -2.22)
assert.test(A.ceil(2.22000000000000020, 2), 2.23)
