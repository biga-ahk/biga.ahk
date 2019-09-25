split(param_string := "",param_separator := ",", param_limit := 0) {
    if (IsObject(param_string) || IsObject(param_string) || IsObject(param_limit)) {
        throw Exception("Type Error", -1)
    }
    ; regex
    if (this.internal_JSRegEx(param_separator)) {
        param_string := this.replace(param_string,param_separator,",")
        param_separator := ","
    }

    oSplitArray := StrSplit(param_string, param_separator)
    if (!param_limit) {
        return oSplitArray
    } else {
        oReducedArray := []
        loop, % param_limit {
            if (A_Index <= oSplitArray.MaxIndex()) {
                oReducedArray.push(oSplitArray[A_Index])
            }
        }
    }
    return oReducedArray
}

; tests
assert.test(A.split("a-b-c","-",2),["a", "b"])

assert.test(A.split("a--b-c","/[\-]+/"),["a", "b", "c"])

; omit

assert.test(A.split("concat.ahk","."),["concat", "ahk"])

assert.test(A.split("a--b-c",","),["a--b-c"])
