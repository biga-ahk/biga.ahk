map(param_collection,param_iteratee) {
    if (!IsObject(param_collection)) {
        throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
    }
    l_array := []
    for Key, Value in param_collection
    {
        if (IsFunc(param_iteratee)) {
            l_array.push(%param_iteratee%(Value))
        }
        if (param_iteratee is string) {
            l_array.push(param_collection[A_Index][param_iteratee])
        }
    }
    return l_array
}

; tests
square(n) {
  return % n * n
}

assert.test(A.map([4,8],Func("square")),[16, 64])
assert.test(A.map({ "a": 4, "b": 8 },Func("square")),[16, 64])

users := [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users,"user"),["barney","fred"])
