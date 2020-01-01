min(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }

    vMin := false
    for Key, Value in param_array {
        if (vMin > Value || vMin == false) {
            vMin := Value
        }
    }
    return vMin
}


; tests
assert.test(A.min([4, 2, 8, 6]), 2)
assert.test(A.min([]), false)


; omit
