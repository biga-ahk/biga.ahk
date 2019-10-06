find(param_collection,param_iteratee,param_fromindex := 1) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    loop, % param_collection.MaxIndex() {
        if (param_fromindex > A_Index) {
            continue
        }
        ; A.property handling
        if (param_iteratee is string) {
            if (param_collection[A_Index][param_iteratee]) {
                return param_collection[A_Index]
            }
        }
        if (IsFunc(param_iteratee)) {
            if (param_iteratee.call(param_collection[A_Index])) {
                return param_collection[A_Index]
            }
            continue
        }
        ; .matches shorthand
        if (param_iteratee.Count() > 0) {
            fn := this.matches(param_iteratee)
            if (fn.call(param_collection[A_Index])) {
                return param_collection[A_Index]
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
