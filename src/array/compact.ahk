compact(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    l_array := []

    for Key, Value in param_array {
        if (Value != "" && Value != 0 && Value != false) {
            l_array.push(Value)
        }
    }
    return l_array
}


; tests
assert.test(A.compact([0, 1, false, 2, "", 3]), [1, 2, 3])
