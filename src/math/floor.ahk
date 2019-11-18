floor(param_number,param_precision:=0) {
    if (IsObject(param_number) || IsObject(param_precision)) {
        this.internal_ThrowException()
    }

    if (param_precision == 0 && this.parseint(param_number) == param_number) {
        return floor(param_number)
    }
    offset := -0.5
    if (param_precision != 0) {
        offset := offset / (10 ** param_precision)
    }
    ; trim trailing 0s
    sum := Trim(param_number + offset . "", "0")
    ; if last char is 5 then remove it
    value := (SubStr(sum, 0) = "5") ? SubStr(sum, 1, -1) : sum
    result := round(value, param_precision)
    return result
}


; tests
assert.test(A.floor(4.006), 4)
assert.test(A.floor(0.046, 2), 0.04)
assert.test(A.floor(4060, -2), 4000)


; omit
assert.test(A.floor(4.1), 4)
assert.test(A.floor(4.5), 4)
assert.test(A.floor(41), 41)
assert.test(A.floor(45), 45)
assert.test(A.floor(6.004, 2), 6.00)
assert.test(A.floor(6.004, 1), 6.0)
assert.test(A.floor(6040, -3), 6000)
assert.test(A.floor(2.22, 1), 2.2)
