truncate(param_string,param_options:="") {
	if (!this.isString(param_string)) {
		this._internal_ThrowException()
	}

	; prepare
	if (!isObject(param_options)) {
		param_options := {}
		param_options.length := 30
	}
	if (!param_options.hasKey("omission")) {
		param_options.omission := "..."
	}

	; check that length is even worth working on, skip if separator is defined
	if (strLen(param_string) < param_options.length && !param_options.separator) {
		return param_string
	}

	; create
	; cut length of the string by character count + the omission's length
	l_string := subStr(param_string, 1, param_options.length)

	; Regex separator
	if (this._internal_JSRegEx(param_options.separator)) {
		param_options.separator := this._internal_JSRegEx(param_options.separator)
	}
	; handle string or Regex seperator
	if (param_options.separator) {
		return regexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission
	}

	; omission
	if (strLen(l_string) < strLen(param_string)) {
		l_string := subStr(l_string, 1, (strLen(l_string) - strLen(param_options.omission) + 1))
		l_string := l_string . param_options.omission
	}
	return l_string
}


; tests
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string), "hi-diddly-ho there, neighbor...")

assert.test(A.truncate(string, {"length": 24, "separator": " "}), "hi-diddly-ho there,...")

assert.test(A.truncate(string, {"length": 24, "separator": "/, /"}), "hi-diddly-ho there...")

; omit
string := "the quick red fox jumped into something"
assert.test(A.truncate(string, {"length": A.size(string) - 1, "omission":""}), "the quick red fox jumped into somethin")
