pad(param_string:="",param_length:=0,param_chars:=" ") {
	if (!this.isStringLike(param_string) || !this.isNumber(param_length) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_length <= strLen(param_string)) {
		return param_string
	}
	param_length := param_length - strLen(param_string)
	l_start := this.floor(param_length / 2)
	l_end := this.ceil(param_length / 2)


	; create
	l_start := this.padStart("", l_start, param_chars)
	l_end := this.padEnd("", l_end, param_chars)
	return l_start param_string l_end
}


; tests
assert.test(A.pad("abc", 8), "  abc   ")
assert.test(A.pad("abc", 8, "_-"), "_-abc_-_")
assert.test(A.pad("abc", 3), "abc")


; omit
assert.test(A.pad("abc", 4), "abc ")
assert.test(A.pad("abc", 9), "   abc   ")
