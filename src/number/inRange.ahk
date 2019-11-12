inRange(param_number,param_lower,param_upper) {
    if (IsObject(param_number) || IsObject(param_lower) || IsObject(param_upper)) {
        this.internal_ThrowException()
    }


    ; prepare data
    if (param_lower > param_upper) {
        x := param_lower
        param_lower := param_upper
        param_upper := x
    }
    
    ; check the bounds
    if (param_number > param_lower && param_number < param_upper) {
        return true
    }
    return false
}


; tests
assert.test(A.inRange(3, 2, 4), true)
assert.test(A.inRange(4, 0, 8), true)
assert.test(A.inRange(4, 0, 2), false)
assert.test(A.inRange(2, 0, 2), false)
assert.test(A.inRange(1.2, 0, 2), true)
assert.test(A.inRange(5.2, 0, 4), false)
assert.test(A.inRange(-3, -2, -6), true)


; omit
