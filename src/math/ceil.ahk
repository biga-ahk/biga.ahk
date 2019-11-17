ceil(param_number,param_precision:=0) {
    if (IsObject(param_number) || IsObject(param_precision)) {
        this.internal_ThrowException()
    }

    offset := 0.5
    if (param_precision != 0) {
        offset := offset / (10 ** param_precision)
    }
    ; trim trailing 0s
    sum := Trim(param_number+offset . "", "0")
    ; if last char is 5 then remove it
    value := (SubStr(sum, 0) = "5") ? SubStr(sum, 1, -1) : sum
    result := round(value, param_precision)
    return result
}


; tests
assert.test(A.ceil(4.006), 5)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6040, -2), 6100)


; omit
assert.test(A.ceil(4.1), 5)
assert.test(A.ceil(4.5), 5)
assert.test(A.ceil(41), 41)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6.004, 1), 6.1)
assert.test(A.ceil(6040, -3), 7000)
assert.test(A.ceil(2.22, 2), 2.22)
