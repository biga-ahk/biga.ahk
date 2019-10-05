tail(param_array) {

    if (IsObject(param_array)) {
        l_array := this.clone(param_array)
    }
    if (param_array is alnum) {
        l_array := StrSplit(param_array)
    }

    ; remove Index 1 of array
    l_array.RemoveAt(1)
    ; return empty array if empty
    if (l_array.Count() == 0) {
        return []
    }
    return l_array
}


; tests
assert.test(A.tail([1, 2, 3]), [2, 3])
assert.test(A.tail("fred"), ["r", "e", "d"])
assert.test(A.tail(100), ["0", "0"])

; omit
assert.test(A.tail([]), [])
