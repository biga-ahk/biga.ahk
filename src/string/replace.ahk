replace(param_string:="",param_needle:="",param_replacement:="") {
	l_string := param_string
	; RegEx
	if (l_needle := this._internal_JSRegEx(param_needle)) {
		return  RegExReplace(param_string, l_needle, param_replacement, , this.limit)
	}
	output := StrReplace(l_string, param_needle, param_replacement, , this.limit)
	return output
}


; tests
assert.test(A.replace("Hi Fred", "Fred", "Barney"), "Hi Barney")
assert.test(A.replace("1234", "/(\d+)/", "numbers"), "numbers")
