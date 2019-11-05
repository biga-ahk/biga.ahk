pick(param_object,param_paths) {
    if (!IsObject(param_object)) {
        this.internal_ThrowException()
    }

    ; data setup
    l_obj := {}
    for Key, Value in param_paths {

    }

    ; create the return
    if (IsObject(param_paths)) {
        for Key, Value in param_paths {
            vValue := this.internal_property(Value, param_object)
            l_obj[Value] := vValue
        }
    } else {
        vValue := this.internal_property(param_paths, param_object)
        l_obj[param_paths] := vValue
    }
    return % l_obj
}


; tests
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.pick(object, ["a", "c"]), {"a": 1, "c": 3})


; omit
assert.test(A.pick(object, "a"), {"a": 1})
