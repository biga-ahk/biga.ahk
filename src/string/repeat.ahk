repeat(param_string,param_number:=1) {
	if (IsObject(param_string)) {
		this._internal_ThrowException()
	}
	
	if (param_number == 0) {
		return ""
	}
	return StrReplace(Format("{:0" param_number "}", 0), "0", param_string)
}


; tests
assert.test(A.repeat("*", 3), "***")
assert.test(A.repeat("abc", 2), "abcabc")
assert.test(A.repeat("abc", 0), "")
