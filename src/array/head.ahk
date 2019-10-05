head(param_array) {

    if (IsObject(param_array)) {
        return param_array[1]
    }
    if (param_array is alnum) {
        l_array := StrSplit(param_array)
        return l_array[1]
    }
}


; tests
assert.test(A.head([1, 2, 3]), 1)
assert.test(A.head([]), "")
assert.test(A.head("fred"), "f")
assert.test(A.head(100), "1")
