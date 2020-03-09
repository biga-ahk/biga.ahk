size(param_collection) {
    
    ; create the return
    if (param_collection.Count() > 0) {
        return param_collection.Count()
    }
    if (param_collection.MaxIndex() > 0) {
        return  param_collection.MaxIndex()
    }
    return StrLen(param_collection)
}


; tests
assert.test(A.size([1, 2, 3]), 3)
assert.test(A.size({ "a": 1, "b": 2 }), 2)
assert.test(A.size("pebbles"), 7)


; omit
users := [{"user": "barney", "active": true}
    , {"user": "fred", "active": false}
    , {"user": "pebbles", "active": false}]
assert.test(A.size(users), 3)
