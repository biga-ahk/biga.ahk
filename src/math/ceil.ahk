ceil(param_number,param_precision:=0) {
	if (!this.isNumber(param_number) || !this.isNumber(param_precision)) {
		this._internal_ThrowException()
	}

	if (param_precision == 0) { ; regular ceil
		return ceil(param_number)
	}

	l_offset := 0.5 / (10**param_precision)
	if (param_number < 0 && param_precision >= 1) {
		l_offset /= 10 ; adjust offset for negative numbers and positive param_precision
	}
	if (param_precision >= 1) {
		l_decChar := strLen( substr(param_number, inStr(param_number, ".") + 1) ) ; count the number of decimal characters
		l_sum := format("{:." this.max([l_decChar, param_precision]) + 1 "f}", param_number + l_offset)
	} else {
		l_sum := param_number + l_offset
	}
	l_sum := trim(l_sum, "0") ; trim zeroes
	l_value := (subStr(l_sum, 0) = "5") && param_number != l_sum ? subStr(l_sum, 1, -1) : l_sum ; if last char is 5 then remove it unless it is part of the original string
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
