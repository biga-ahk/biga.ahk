clone(param_value) {
    return param_value.Clone()
}

; tests
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2
assert.test(shallowclone,[{ "a": 1 }, { "b": 2 }])
