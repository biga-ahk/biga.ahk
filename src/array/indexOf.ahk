indexOf(param_array,param_value,fromIndex := 1) {
    for Index, Value in param_array {
        if (Index < fromIndex) {
            continue
        }
        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
            return % Index + 0
        }
    }
    return % -1 + 0
}


; tests
assert.test(A.indexOf([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.indexOf([1, 2, 1, 2], 2, 3), 4)

assert.test(A.indexOf(["fred", "barney"], "pebbles"), -1)

A.caseSensitive := true
assert.test(A.indexOf(["fred", "barney"], "Fred"), -1)


; omit
A.caseSensitive := false
