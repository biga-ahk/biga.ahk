trimEnd(param_string,param_chars:="") {
	if (param_chars = "") {
		l_string := param_string
		return  regexreplace(l_string, "(\s+)$") ;trim ending whitespace
	} else {
		l_array := StrSplit(param_chars, "")
		for Key, Value in l_array {
			if (this.includes(Value, "/[a-zA-Z0-9]/")) {
				l_removechars .= Value
			} else {
				l_removechars .= "\" Value
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
