trim(param_string,param_chars:="") {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; create
	if (param_chars == "") {
		return this.trim(param_string, "`r`n" A_space A_tab)
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
assert.label("multiple types of whitespace")
assert.test(A.trim(A_space A_tab "  abc  " A_tab), "abc")
assert.label("multiple types of newline")
assert.test(A.trim("  `rabc`n  "), "abc")
