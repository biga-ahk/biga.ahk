head(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    return param_array[1]
}


; tests
assert.test(A.head([1, 2, 3]), 1)
assert.test(A.head([]), "")
