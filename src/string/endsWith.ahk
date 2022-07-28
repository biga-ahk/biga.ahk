endsWith(param_string,param_needle,param_fromIndex:=0) {
	if (!this.isString(param_string) || !this.isString(param_needle) || !this.isNumber(param_fromIndex)) {
		this._internal_ThrowException()
	}

	; prepare defaults
	if (param_fromIndex == 0) {
		param_fromIndex := strLen(param_string)
	}
	if (strLen(param_needle) > 1) {
		param_fromIndex := strLen(param_string) - strLen(param_needle) + 1
	}

	; create
	l_endChar := subStr(param_string, param_fromIndex, strLen(param_needle))
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
