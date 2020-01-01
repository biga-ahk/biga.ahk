max(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }

    vMax := false
    for Key, Value in param_array {
        if (vMax < Value || vMax == false) {
            vMax := Value
        }
    }
    return vMax
}


; tests
assert.test(A.max([4, 2, 8, 6]), 8)
assert.test(A.max([]), false)


; omit
