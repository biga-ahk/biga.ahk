includes(param_collection,param_value,param_fromIndex := 1) {
    if (IsObject(param_collection)) {
        loop, % param_collection.MaxIndex() {
            if (param_fromIndex > A_Index) {
                continue
            }
            if (param_collection[A_Index] = param_value) {
                return true
            }
        }
        return false
    } else {
        ; RegEx
        if (param_value := this.internal_JSRegEx(param_value)) {
            return % RegExMatch(param_collection, param_value, RE, param_fromIndex)
        }
        ; Normal string search
        stringFoundVar := InStr(param_collection, param_value, this.caseSensitive, param_fromIndex)
        if (stringFoundVar == 0) {
            return false
        } else {
            return true
        }
    }
}

; tests
assert.true(A.includes([1,2,3],3))
assert.true(A.includes("InStr","Str"))
assert.false(A.includes("InStr","Other"))
    ; RegEx object
assert.true(A.includes("hello!","/\D/"))