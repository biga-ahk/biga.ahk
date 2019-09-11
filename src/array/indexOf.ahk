indexOf(param_array,param_searchTerm,fromIndex := 1) {
    for Index, Value in param_array {
        if (Index < fromIndex) {
            continue
        }
        if (this.caseSensitive ? (Value == param_searchTerm) : (Value = param_searchTerm)) {
            return %Index%
        }
    }
    return -1
}

; tests
assert.test(A.indexOf([1, 2, 1, 2], 2),"2")

; Search from the `fromIndex`.
assert.test(A.indexOf([1, 2, 1, 2], 2, 3),"4")

assert.test(A.indexOf(["fred", "barney"], "pebbles"),"-1")
