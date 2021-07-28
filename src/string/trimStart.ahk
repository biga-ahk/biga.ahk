trimStart(param_string,param_chars:="") {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; create
	if (param_chars = "") {
		return regexReplace(param_string, "^(\s+)") ;trim beginning whitespace
	} else {
		l_array := strSplit(param_chars, "")
		for key, value in l_array {
			if (this.includes(value, "/[a-zA-Z0-9]/")) {
				l_removechars .= value
			} else {
				l_removechars .= "\" value
			}
		}
		; replace leading characters
		l_string := this.replace(param_string, "/^([" l_removechars "]+)/", "")
		return l_string
	}
}


; tests
assert.test(A.trimStart("  abc  "), "abc  ")
assert.test(A.trimStart("-_-abc-_-", "_-"), "abc-_-")
