floor(param_number,param_precision:=0) {
	if (!this.isNumber(param_number) || !this.isNumber(param_precision)) {
		this._internal_ThrowException()
	}

	if (param_precision == 0) { ; regular floor
		return floor(param_number)
	}

	l_offset := -0.5 / (10**param_precision)
	if (param_number < 0 && param_precision >= 1) {
		l_offset /= 10 ; adjust offset for negative numbers and positive param_precision
	}
	if (param_precision >= 1) {
		l_decChar := strlen( substr(param_number, instr(param_number, ".") + 1) ) ; count the number of decimal characters
		l_sum := format("{:." this.max([l_decChar, param_precision]) + 1 "f}", param_number + l_offset)
	} else {
		l_sum := param_number + l_offset
	}
	l_sum := trim(l_sum, "0") ; trim zeroes
	l_value := (SubStr(l_sum, 0) = "5") && param_number != l_sum ? SubStr(l_sum, 1, -1) : l_sum ; if last char is 5 then remove it unless it is part of the original string
	return Round(l_value, param_precision)
}


; tests
assert.test(A.floor(4.006), 4)
assert.test(A.floor(0.046, 2), 0.04)
assert.test(A.floor(4060, -2), 4000)


; omit
assert.test(A.floor(4.1), 4)
assert.test(A.floor(4.6), 4)
assert.test(A.floor(41), 41)
assert.test(A.floor(45), 45)
assert.test(A.floor(6.004, 2), 6.00)
assert.test(A.floor(6.004, 1), 6.0)
assert.test(A.floor(6040, -3), 6000)
assert.test(A.floor(2.22, 1), 2.2)

assert.test(A.floor(-2.22000000000000020, 2), -2.22)
assert.test(A.floor(2.22000000000000020, 2), 2.22)