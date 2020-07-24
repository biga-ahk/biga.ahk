truncate(param_string,param_options:="") {
	if (IsObject(param_string)) {
		this._internal_ThrowException()
	}

	; prepare default options object
	if (!IsObject(param_options)) {
		param_options := {}
		param_options.length := 30
	}
	if (!param_options.omission) {
		param_options.omission := "..."
	}

	; check that length is even worth working on
	if (StrLen(param_string) + StrLen(param_options.omission) < param_options.length && !param_options.separator) {
		return param_string
	}
	
	l_array := StrSplit(param_string, "")
	l_string := ""
	; cut length of the string by character count + the omission's length
	if (param_options.length) {
		loop, % l_array.Count() {
			if (A_Index > param_options.length - StrLen(param_options.omission)) {
				l_string := l_string param_options.omission
				break
			}
			l_string := l_string l_array[A_Index]
		}
	}

	; separator
	if (this._internal_JSRegEx(param_options.separator)) {
		param_options.separator := this._internal_JSRegEx(param_options.separator)
	}
	if (param_options.separator) {
		return  RegexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission
	}
	return l_string
}


; tests
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string), "hi-diddly-ho there, neighbo...")

assert.test(A.truncate(string, {"length": 24, "separator": " "}), "hi-diddly-ho there,...")

assert.test(A.truncate(string, {"length": 24, "separator": "/, /"}), "hi-diddly-ho there...")
