parseInt(param_string:="0") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; prepare
	l_int := this.trimStart(param_string, " 0_")

	; create
	if (this.size(l_int) == 0 && inStr(param_string, "0")) {
		return 0
	}
	if (this.isNumber(l_int)) {
		return l_int
	}
	l_int := this.replace(l_int, "/\D+/")
	if (this.isNumber(l_int)) {
		return l_int
	}
	return ""
}


; tests
assert.test(A.parseInt("08"), 8)
assert.test(A.map(["6", "08", "10"], A.parseInt), [6, 8, 10])


; omit
assert.test(A.parseInt("0"), 0)

assert.label("decimal places")
assert.test(A.parseInt("1.0"), 1.0)
assert.test(A.parseInt("1.0001"), 1.0001)

assert.label("string representations")
assert.test(A.parseInt("10,00"), 1000)
assert.test(A.parseInt(" 10 00"), 1000)
assert.test(A.parseInt(" 10+10"), 1010)

assert.label("invalid input")
assert.test(A.parseInt(" "), "")
