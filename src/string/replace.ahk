replace(param_string:="",param_needle:="",param_replacement:="") {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_needle) || !this.isStringLike(param_replacement)) {
		this._internal_ThrowException()
	}

	; prepare
	l_string := param_string

	; create
	if (l_needle := this._internal_JSRegEx(param_needle)) {
		return regexReplace(param_string, l_needle, param_replacement, , this.limit)
	}
	output := strReplace(l_string, param_needle, param_replacement, , this.limit)
	return output
}


; tests
assert.test(A.replace("Hi Fred", "Fred", "Barney"), "Hi Barney")
assert.test(A.replace("1234", "/(\d+)/", "numbers"), "numbers")


; omit
assert.label("blank parameters")
assert.test(A.replace("Hi Barney"), "Hi Barney")
assert.test(A.replace(), "")
