every(param_collection,param_predicate) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    ; data setup
    l_array := []
    short_hand := this.internal_differenciateShorthand(param_predicate, param_collection)
    if (short_hand != false) {
        fn := this.internal_createShorthandfn(param_predicate, param_collection)
    }
    if (IsFunc(param_predicate)) {
        fn := param_predicate.clone()
    }

    ; perform the action
    for Key, Value in param_collection {
        if (fn.call(Value, Key, param_collection) == false) {
            return false
        }
    }
    return true
}


; tests
users := [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": false }]

; The `A.matches` iteratee shorthand
assert.false(A.every(users, { "user": "barney", "age": 36, "active": false }))

; The `A.matchesProperty` iteratee shorthand.
assert.true(A.every(users, ["active", false]), ["barney", "fred"])

; The `A.property` iteratee shorthand.
assert.false(A.every(users, "active"))


; omit
assert.label("hey")
assert.true(A.every(["", "", ""], A.isUndefined))
assert.true(A.every([1, 2, 3], func("isPositive")))
isPositive(value) {
    if (value > 0) {
        return true
    }
    return false
}
