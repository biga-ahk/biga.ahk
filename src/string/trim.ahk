trim(param_string,param_chars:="") {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; create
	if (param_chars == "") {
		return trim(param_string)
	} else {
		; replace starting characters
		l_string := this.trimStart(param_string, param_chars)
		; replace ending characters
		l_string := this.trimEnd(l_string, param_chars)
		return l_string
	}
}


; tests
assert.test(A.trim("  abc  "), "abc")
assert.test(A.trim("-_-abc-_-", "_-"), "abc")
assert.test(A.map([" foo  ", "  bar  "], A.trim), ["foo", "bar"])


; omit
assert.test(A.trim(A_Tab A_Tab "  abc  " A_Tab), "abc")
