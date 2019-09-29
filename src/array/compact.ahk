compact(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    l_array := []

    for key, value in param_array {
        if (value != "" && value != 0 && value != false) {
            l_array.push(value)
        }
    }
    return l_array
}


; tests

assert.test(A.compact([0, 1, false, 2, "", 3]),[1, 2, 3])
