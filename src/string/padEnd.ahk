padEnd(param_string:="",param_length:=0,param_chars:=" ") {
	if (!this.isStringLike(param_string) || !this.isNumber(param_length) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_length <= strLen(param_string)) {
		return param_string
	}

	; create
	l_pad := this.slice(param_chars)
	l_string := param_string
	while (strLen(l_string) < param_length) {
		l_pos++
		if (l_pos > l_pad.count()) {
			l_pos := 1
		}
		l_string .= l_pad[l_pos]
	}
	return l_string
}


; tests
assert.test(A.padEnd("abc", 6), "abc   ")
assert.test(A.padEnd("abc", 6, "_-"), "abc_-_")
assert.test(A.padEnd("abc", 3), "abc")


; omit
