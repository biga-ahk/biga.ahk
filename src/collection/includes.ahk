includes(param_collection,param_value,param_fromIndex:=1) {
    if (IsObject(param_collection)) {
        for Key, Value in param_collection {
            if (param_fromIndex > A_Index) {
                continue
            }
            if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
                return true
            }
        }
        return false
    } else {
        ; RegEx
        if (RegEx_value := this.internal_JSRegEx(param_value)) {
            return RegExMatch(param_collection, RegEx_value, RE, param_fromIndex)
        }
        ; Normal string search
        if (InStr(param_collection, param_value, this.caseSensitive, param_fromIndex)) {
            return true
        } else {
            return false
        }
    }
}


; tests
assert.true(A.includes([1, 2, 3], 1))
assert.true(A.includes({ "a": 1, "b": 2 }, 1))
assert.true(A.includes("InStr", "Str"))
A.caseSensitive := true
assert.false(A.includes("InStr", "str"))
; RegEx object
assert.true(A.includes("hello!", "/\D/"))


; omit
A.caseSensitive := false
assert.false(A.includes("InStr", "Other"))
