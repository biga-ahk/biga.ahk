split(param_string:="",param_separator:=",",param_limit:=0) {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_separator) || !this.isNumber(param_limit)) {
		this._internal_ThrowException()
	}

	; prepare inputs if regex detected
	if (this._internal_JSRegEx(param_separator)) {
		param_string := this.replace(param_string, param_separator, ",")
		param_separator := ","
	}

	; create
	oSplitArray := strSplit(param_string, param_separator)
	if (!param_limit) {
		return oSplitArray
	} else {
		oReducedArray := []
		loop, % param_limit {
			if (A_Index <= oSplitArray.count()) {
				oReducedArray.push(oSplitArray[A_Index])
			}
		}
	}
	return oReducedArray
}


; tests
assert.test(A.split("a-b-c", "-", 2), ["a", "b"])
assert.test(A.split("a--b-c", "/[\-]+/"), ["a", "b", "c"])


; omit
assert.test(A.split("concat.ahk", "."), ["concat", "ahk"])
assert.test(A.split("a--b-c", ","), ["a--b-c"])
assert.label("blank seperator")
assert.test(A.split("a--b-c", ""), ["a","-","-","b","-","c"])
assert.label("whitespace seperator")
assert.test(A.split("one     two", "/\s+/"), ["one", "two"])
