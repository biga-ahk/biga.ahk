size(param_collection) {
    if (param_collection.MaxIndex() > 0) {
        return  param_collection.MaxIndex()
    }

    if (param_collection.Count() > 0) {
        return param_collection.Count()
    }
    return StrLen(param_collection)
}


; tests
assert.test(A.size([1, 2, 3]), 3)
assert.test(A.size({ "a": 1, "b": 2 }), 2)
assert.test(A.size("pebbles"), 7)
assert.test(A.size(200), 0)
