every(param_collection,param_predicate) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    ; data setup
    l_array := []
    short_hand := this.internal_differenciateShorthand(param_predicate, param_collection)
    if (short_hand != false) {
        BoundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
    }

    ; perform the action
    for Key, Value in param_collection {
        if (BoundFunc.call(Value, Key, param_collection) == true) {
            continue
        }
        return false
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
assert.label("UNDEFINED")
assert.true(A.every(["", "", ""], A.isUndefined))
assert.label("2")
assert.true(A.every([1, 2, 3], func("isPositive")))
isPositive(value) {
    if (value > 0) {
        return true
    }
    return false
}

votes := [true, false, true, true]
A.every(votes, Func("fn_istrue")) " was the result"
fn_istrue(value) {
    if (value == true) {
        return true
    } 
    return false
}


userVotes := [{"name":"fred", "votes": ["yes","yes"]}
            , {"name":"bill", "votes": ["no","yes"]}
            , {"name":"jake", "votes": ["no","yes"]}]

msgbox, % A.every(userVotes, ["votes.1", "yes"])
; => false
msgbox, % A.every(userVotes, ["votes.2", "yes"])
; => true

if (A.every(userVotes, "votes.2")) {
    msgbox, % "everyone voted yes on option #2"
}