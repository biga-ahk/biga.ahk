isMatch(param_obj,param_iteratee) {
    for Key, Value in param_iteratee {
        if (param_obj[key] == Value) {
            continue
        } else {
            return false
        }
    }
    return true
}


; tests
object := { "a": 1, "b": 2, "c": 3 }
assert.true(A.isMatch(object, {"b": 2}))
assert.true(A.isMatch(object, {"b": 2, "c": 3}))

assert.false(A.isMatch(object, {"b": 1}))
assert.false(A.isMatch(object, {"b": 2, "z": 99}))