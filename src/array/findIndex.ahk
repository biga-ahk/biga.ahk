findIndex(param_array,param_value,fromIndex := 1) {
    if (IsObject(param_value)) {
        vSearchingobjects := true
        param_value := this.printObj(param_value)
    }
    for Index, Value in param_array {
        if (Index < fromIndex) {
            continue
        }
        if (vSearchingobjects) {
            Value := this.printObj(Value)
        }
        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
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

A.caseSensitive := true
assert.test(A.indexOf(["fred", "barney"], "Fred"),"-1")

assert.test(A.indexOf([{name: "fred"},{name: "barney"}], {name: "barney"}),"2")
; omit
A.caseSensitive := false
