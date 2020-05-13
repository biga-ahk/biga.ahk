trimStart(param_string,param_chars:="") {
	if (param_chars = "") {
		return  regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
	} else {
		l_array := StrSplit(param_chars, "")
		for Key, Value in l_array {
			if (this.includes(Value, "/[a-zA-Z0-9]/")) {
				l_removechars .= Value
			} else {
				l_removechars .= "\" Value
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
