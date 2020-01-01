find(param_collection,param_predicate,param_fromindex:=1) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    ; data setup
    shorthand := this.internal_differenciateShorthand(param_predicate, param_collection)
    if (short_hand != false) {
        boundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
    }

    ; perform
    for Key, Value in param_collection {
        if (param_fromindex > A_Index) {
            continue
        }
        ; regular function
        if (IsFunc(param_predicate)) {
            if (param_predicate.call(Value)) {
                return Value
            }
            continue
        }
        ; undeteriminable functor
        if (param_predicate.call(Value)) {
            return Value
        }
        ; shorthand
        if (shorthand) {
            if (boundFunc.call(Value)) {
                return Value
            }
            continue
        }
    }
    return false
}


; tests
users := [ { "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

assert.test(A.find(users, Func("fn_find1")), { "user": "barney", "age": 36, "active": true })
fn_find1(o) {
    if (o.active) { 
        return true 
    }
} 

; The A.matches iteratee shorthand.
assert.test(A.find(users, { "age": 1, "active": true }), { "user": "pebbles", "age": 1, "active": true })

; The A.matchesProperty iteratee shorthand.
assert.test(A.find(users, ["active", false]), { "user": "fred", "age": 40, "active": false })

; The A.property iteratee shorthand.
assert.test(A.find(users, "active"), { "user": "barney", "age": 36, "active": true })


; omit
assert.test(A.find(users, "active", 2), { "user": "pebbles", "age": 1, "active": true }) ;fromindex argument
