truncate(param_string, param_options := "") {
    if (!IsObject(param_options)) {
        param_options := {}
        param_options.length := 30
        param_options.omission := "..."
    } 

    if (StrLen(param_string) < param_options.length) {
        return param_string
    }
    l_array := StrSplit(param_string,"")
    l_string := ""
    loop, % l_array.MaxIndex() {
        if (A_Index > param_options.length + StrLen(param_options.omission)) {
            l_string := l_string param_options.omission
            break
        }
        l_string := l_string l_array[A_Index]
    }
    ; if (param_string, param_options.separator)) {
    ;     [1]
    ; }
    return l_string



    ; if (param_options.omission && this.includes(param_string, param_options.separator)) {
    ;     param_string := StrSplit(param_string, param_options.omission)[1]
    ; }
    ; if (param_options.length > 0 && param_string.length > param_options.length) {
    ;     param_string := SubStr(param_string, 1 , param_options.length)
    ; }
    ; return % param_string
}

; tests
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string),"hi-diddly-ho there, neighbo...")

options := {"length": 24, "separator": " "}
assert.test(A.truncate(string,options),"hi-diddly-ho there,...")

options := {"length": 24, "separator": "/,? +/"}
assert.test(A.truncate(string,options),"hi-diddly-ho there...")
