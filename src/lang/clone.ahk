clone(param_value) {
    return param_value.Clone()
}

; tests
object := [{ "a": 1 }, { "b": 2 }]
assert.test(A.clone(object),[{ "a": 1 }, { "b": 2 }])

shallow := A.clone(object)
if (shallow == object) {
    bool := true
}
assert.true(bool)
