multiply(param_multiplier,param_multiplicand) {
    if (IsObject(param_multiplier) || IsObject(param_multiplicand)) {
        this.internal_ThrowException()
    }

    ; create the return
    vValue := param_multiplier * param_multiplicand
    return vValue
}


; tests
assert.test(A.multiply(6, 4), 24)


; omit
assert.test(A.multiply(10, -1), -10)
assert.test(A.multiply(-10, -10), 100)
