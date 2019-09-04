truncate(param_string, param_options := "") {
    if (!IsObject(param_options)) {
        param_options := {}
        param_options.length := 30
    }
    if (!param_options.omission) {
        param_options.omission := "..."
    }

    ; check that length is even worth working on
    ; if (StrLen(param_string) + StrLen(param_options.omission) < param_options.length && !param_options.separator) {
    ;     msgbox, % "truncate returning original string"
    ;     return param_string
    ; }
    
    l_array := StrSplit(param_string,"")
    l_string := ""
    ; cut length of the string by character count
    if (param_options.length) {
        loop, % l_array.MaxIndex() {
            if (A_Index > param_options.length + StrLen(param_options.omission)) {
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
        reversestring := this.join(this.reverse(StrSplit(l_string)),"")
        param_options.reverseseparator := this.join(this.reverse(StrSplit(param_options.separator)),"")
        l_match := RegExMatch(reversestring, "P)" param_options.reverseseparator, RE_Match)
        msgbox, % "REGEX: " RE_MatchPos1 " / " RE_MatchLen1 "/" l_match "`n-" param_options.separator "-`n`n" param_string "`n" l_string
        if (l_match) {
            param_options.regexmatchposition := l_match
        }
        if (RE_MatchPos1) {
            param_options.regexmatchposition := RE_MatchPos1
        }
        ; msgbox, % param_options.regexmatchposition
        if (param_options.regexmatchposition) {
            l_string := SubStr(reversestring, param_options.regexmatchposition + StrLen(param_options.separator))
            return % this.join(this.reverse(StrSplit(l_string)),"") . param_options.omission
        }
    }
    return l_string
}

; tests
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string),"hi-diddly-ho there, neighbo...")

assert.test(A.truncate(string, {"length": 24, "separator": " "}),"hi-diddly-ho there,...")

; options := {"length": 24, "separator": "/,? +/"}
; assert.test(A.truncate(string,options),"hi-diddly-ho there...")

assert.test(A.truncate(string, {"length": 24, "separator": "/, /"}),"hi-diddly-ho there...")
