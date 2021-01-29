endsWith(param_string,param_needle,param_fromIndex:=0) {
	if (!this.isString(param_string) || !this.isString(param_needle) || !this.isNumber(param_fromIndex)) {
		this._internal_ThrowException()
	}

	; prepare defaults
	if (param_fromIndex == 0) {
		param_fromIndex := StrLen(param_string)
	}
	if (StrLen(param_needle) > 1) {
		param_fromIndex := StrLen(param_string) - StrLen(param_needle) + 1
	}

	; create
	l_endChar := SubStr(param_string, param_fromIndex, StrLen(param_needle))
	if (this.isEqual(l_endChar, param_needle)) {
		return true
	}
	return false
}


; tests
assert.true(A.endsWith("abc", "c"))
assert.false(A.endsWith("abc", "b"))
assert.true(A.endsWith("abc", "b", 2))


; omit

assert.label("ahk `; comment detection")
assert.true(A.endsWith("String;", ";"))
assert.true(A.endsWith("String;", "ing;"))
assert.true(A.endsWith("String;", "String;"))

assert.label("fromIndex")
assert.true(A.endsWith("String;", "g", 6))
