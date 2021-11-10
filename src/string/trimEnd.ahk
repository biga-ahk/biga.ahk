trimEnd(param_string,param_chars:="") {
	if (!this.isStringLike(param_string) || !this.isStringLike(param_chars)) {
		this._internal_ThrowException()
	}

	; create
	if (param_chars = "") {
		l_string := param_string
		return regexreplace(l_string, "(\s+)$") ;trim ending whitespace
	} else {
		l_array := strSplit(param_chars, "")
		for key, value in l_array {
			if (this.includes(value, "/[a-zA-Z0-9]/")) {
				l_removechars .= value
			} else {
				l_removechars .= "\" value
			}
		}
		; replace ending characters
		l_string := this.replace(param_string, "/([" l_removechars "]+)$/", "")
		return l_string
	}
}


; tests
assert.test(A.trimEnd("  abc  "), "  abc")
assert.test(A.trimEnd("-_-abc-_-", "_-"), "-_-abc")


; omit
assert.test(A.trimEnd("filename.txt", ".txt"), "filename")
assert.test(A.trimEnd(1000.00, 0), 1000.)
