parseInt(param_string:="0") {
	if (IsObject(param_string)) {
		this.internal_ThrowException()
	}

	l_int := this.trimStart(param_string, " 0_")
	if (this.size(l_int) = 0) {
		return 0
	}
	return l_int + 0
}


; tests
assert.test(A.parseInt("08"), 8)
assert.test(A.map(["6", "08", "10"], A.parseInt), [6, 8, 10])


; omit
assert.test(A.parseInt("0"), 0)
