findIndex(param_array,param_value,fromIndex := 1) {
    if (IsFunc(param_value)) {
        vFunctionparam := true
    }
    if (IsObject(param_value) && !vFunctionparam) { ; do not convert objects that are functions
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
        if (vFunctionparam) {
            if (param_value.Call(param_array[A_Index])) {
                return % Index + 0
            }
        }
        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
            return % Index + 0
        }
    }
    return % -1 + 0
}


; tests
assert.test(A.findIndex([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.findIndex([1, 2, 1, 2], 2, 3), 4)

assert.test(A.findIndex(["fred", "barney"], "pebbles"), -1)

A.caseSensitive := true
assert.test(A.findIndex(["fred", "barney"], "Fred"), -1)

assert.test(A.findIndex([{name: "fred"}, {name: "barney"}], {name: "barney"}), 2)

users := [ { "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

assert.test(A.findIndex(users, Func("findIndexFunc")), 1)
findIndexFunc(o) {
    return % o.user == "barney"
}


; omit
A.caseSensitive := false
assert.test(A.findIndex([{name: "fred"}, {name: "barney"}], {name: "fred"}), 1)
