replace(param_string:="",param_needle:="",param_replacement:="") {
	if (IsObject(param_string)) {
		this._internal_ThrowException()
	}

	; prepare
	l_string := param_string
	
	; create
	if (l_needle := this._internal_JSRegEx(param_needle)) {
		return  RegExReplace(param_string, l_needle, param_replacement, , this.limit)
	}
	output := StrReplace(l_string, param_needle, param_replacement, , this.limit)
	return output
}


; tests
assert.test(A.replace("Hi Fred", "Fred", "Barney"), "Hi Barney")
assert.test(A.replace("1234", "/(\d+)/", "numbers"), "numbers")
