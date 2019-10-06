find(param_collection,param_predicate,param_fromindex := 1) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    ; data setup
    shorthand := this.internal_differenciateShorthand(param_predicate)
    if (shorthand == ".matches") {
        fn := this.matches(param_predicate)
    }

    ; create the return
    for Key, Value in param_collection {
        if (param_fromindex > A_Index) {
            continue
        }
        ; .matches shorthand
        if (shorthand == ".matches") {
            if (fn.call(param_collection[Key])) {
                return param_collection[Key]
            }
            continue
        }
        ; .matchesProperty shorthand
        ; not yet

        ; regular function
        if (IsFunc(param_predicate)) {
            if (param_predicate.call(param_collection[Key])) {
                return param_collection[Key]
            }
        }
        ; .property shorthand
        if (shorthand == ".property") {
            if (param_collection[Key][param_predicate]) {
                return param_collection[Key]
            }
        }
    }
}


; tests
users := [ { "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

assert.test(A.find(users, Func("fn_find1")), { "user": "barney", "age": 36, "active": true })
fn_find1(param_interatee) {
    if (param_interatee.active) { 
        return true 
    } 
} 

; The `A.matches` iteratee shorthand.
assert.test(A.find(users, { "age": 1, "active": true }), { "user": "pebbles", "age": 1, "active": true })

; The `A.property` iteratee shorthand.
assert.test(A.find(users, "active"), { "user": "barney", "age": 36, "active": true })


; omit
assert.test(A.find(users, "active", 2), { "user": "pebbles", "age": 1, "active": true }) ;fromindex argument
