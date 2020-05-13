truncate(param_string,param_options:="") {
	if (IsObject(param_string)) {
		this.internal_ThrowException()
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
	if (this.internal_JSRegEx(param_options.separator)) {
		param_options.separator := this.internal_JSRegEx(param_options.separator)
	}
	if (param_options.separator) {
		return  RegexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission
		; reversestring := this.join(this.reverse(StrSplit(l_string)), "")
		; param_options.reverseseparator := this.join(this.reverse(StrSplit(param_options.separator)), "")
		; l_match := RegExMatch(reversestring, "P)" param_options.reverseseparator, RE_Match)
		; ; msgbox, % "REGEX: " RE_MatchPos1 " / " RE_MatchLen1 "/" l_match "`n-" param_options.separator "-`n`n" param_string "`n" l_string
		; if (l_match) {
		;     param_options.regexmatchposition := l_match
		; }
		; if (RE_MatchPos1) {
		;     param_options.regexmatchposition := RE_MatchPos1
		; }
		; if (param_options.regexmatchposition) {
		;     l_string := SubStr(reversestring, param_options.regexmatchposition + StrLen(param_options.separator))
		;     return  this.join(this.reverse(StrSplit(l_string)), "") . param_options.omission
		; }
	}
	return l_string
}


; tests
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string), "hi-diddly-ho there, neighbo...")

assert.test(A.truncate(string, {"length": 24, "separator": " "}), "hi-diddly-ho there,...")

assert.test(A.truncate(string, {"length": 24, "separator": "/, /"}), "hi-diddly-ho there...")
