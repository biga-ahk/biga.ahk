map(param_collection,param_iteratee) {
    l_Array := []
    Loop, % param_collection.MaxIndex() {
        if (IsFunc(param_iteratee)) {
                l_Array.push(%param_iteratee%(param_collection[A_Index]))
        }
        if (param_iteratee is string) {
            l_Array.push(param_collection[A_Index][param_iteratee])
        }
    }
    return % l_Array
}

; tests
users = [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users,"user"),["barney","fred"])
