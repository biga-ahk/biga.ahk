findIndex(param_array,param_value,fromIndex:=1) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    
    ; data setup
    short_hand := this.internal_differenciateShorthand(param_value, param_array)
    if (short_hand != false) {
        BoundFunc := this.internal_createShorthandfn(param_value, param_array)
    }
    if (IsFunc(param_value)) {
        BoundFunc := param_value
    }
    if (IsObject(param_value) && !IsFunc(param_value)) { ; do not convert objects that are functions
        vSearchingobjects := true
        param_value := this.printObj(param_value)
    }

    ; create the return
    for Index, Value in param_array {
        if (Index < fromIndex) {
            continue
        }

        if (short_hand == ".matchesProperty" || short_hand == ".property") {
            if (BoundFunc.call(param_array[Index]) == true) {
                return Index
            }
        }
        if (vSearchingobjects) {
            Value := this.printObj(param_array[Index])
        }
        if (IsFunc(BoundFunc)) {
            if (BoundFunc.call(param_array[Index]) == true) {
                return Index
            }
        }
        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
            return Index
        }
    }
    return -1
}


; tests
assert.test(A.findIndex([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.findIndex([1, 2, 1, 2], 2, 3), 4)

assert.test(A.findIndex(["fred", "barney"], "pebbles"), -1)

A.caseSensitive := true
assert.test(A.findIndex(["fred", "barney"], "Fred"), -1)
assert.test(A.findIndex([{"name": "fred"}, {"name": "barney"}], {"name": "barney"}), 2)

users := [ { "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]
assert.test(A.findIndex(users, Func("findIndexFunc")), 1)
findIndexFunc(o) {
    return o.user == "barney"
}


; omit
A.caseSensitive := false
assert.test(A.findIndex([{name: "fred"}, {name: "barney"}], {name: "fred"}), 1)

users := [{"user": "barney", "active": true}
    , {"user": "fred", "active": false}
    , {"user": "pebbles", "active": false}]

assert.test(A.findIndex(users, ["active", false]), 2)
