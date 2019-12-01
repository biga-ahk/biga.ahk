ceil(param_number,param_precision:=0) {
    if (IsObject(param_number) || IsObject(param_precision)) {
        this.internal_ThrowException()
    }

	if (param_precision == 0) { ; regular ceil
		return ceil(param_number)
    }

	offset := 0.5 / (10**param_precision)
	if (param_number < 0 && param_precision >= 1) {
		offset //= 10 ; adjust offset for negative numbers and positive param_precision
    }
	if (param_precision >= 1) {
		n_dec_char := strlen( substr(param_number, instr(param_number, ".") + 1) ) ; count the number of decimal characters
		sum := format("{:." this.max([n_dec_char, param_precision]) + 1 "f}", param_number + offset)
	} else {
		sum := param_number + offset
    }
	sum := trim(sum, "0") ; trim zeroes
	value := (SubStr(sum, 0) = "5") && param_number != sum ? SubStr(sum, 1, -1) : sum ; if last char is 5 then remove it unless it is part of the original string
    result := Round(value, param_precision)
    return result
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
