truncate(param_string, param_options := "") {
    if (param_options.separator && this.includes(param_string, param_options.separator)) {
        param_string := StrSplit(param_string, param_options.separator)[1]
    }
    if (param_options.length > 0 && param_string.length > param_options.length) {
        param_string := SubStr(param_string, 1 , param_options.length)
    }
    return % param_string
}

; tests
assert.test(A.truncate("hi-diddly-ho there, neighborino"),"hi-diddly-ho there, neighbo...")
assert.test(A.truncate("hi-diddly-ho there, neighborino",{
,  "length": 24,
,  "separator": " "}),"hi-diddly-ho there,...")
