lastIndexOf(param_array,param_value,param_fromIndex := 0) {
    if (param_fromIndex == 0) {
        param_fromIndex := param_array.Count()
    }
    for Index, Value in param_array {
        Index -= 1
        vNegativeIndex := param_array.Count() - Index
        if (vNegativeIndex > param_fromIndex) { ;skip search if 
            continue
        }
        if (this.caseSensitive ? (param_array[vNegativeIndex] == param_value) : (param_array[vNegativeIndex] = param_value)) {
            return vNegativeIndex + 0
        }
    }
    return -1 + 0
}


; tests
assert.test(A.lastIndexOf([1, 2, 1, 2], 2), 4)

; Search from the `fromIndex`.
assert.test(A.lastIndexOf([1, 2, 1, 2], 1, 2), 1)

A.caseSensitive := true
assert.test(A.lastIndexOf(["fred", "barney"], "Fred"), -1)


; omit
A.caseSensitive := false
