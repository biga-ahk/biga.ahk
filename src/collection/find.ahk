find(param_collection,param_iteratee,param_fromindex := 1) {
    Loop, % param_collection.MaxIndex() {
        if (param_fromindex > A_Index) {
            continue
        }
        if (param_iteratee is string) {
            if (param_collection[A_Index][param_iteratee]) {
                return param_collection[A_Index]
            }
        }
        if (IsFunc(param_iteratee)) {
            if (%param_iteratee%(param_collection[A_Index])) {
                return param_collection[A_Index]
            }
        }
        if (param_iteratee.Count() > 0) {
            ; for Key, Value in param_func {
            ;     msgbox, % Key
            ;     msgbox, % Value
            ;     if (param_collection[A_Index][param_func]) {
            ;         return % this.info_Array.push(param_collection[A_Index])
            ;     }
            ; }
        }
    }
}

; tests
users := [ { "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

assert.test(A.find(users,"active"), { "user": "barney", "age": 36, "active": true })
assert.test(A.find(users,"active",2), { "user": "pebbles", "age": 1, "active": true }) ;fromindex argument
assert.test(A.find(users,Func("fn_filter1")), { "user": "barney", "age": 36, "active": true })
