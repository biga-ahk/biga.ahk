matchesProperty(param_path,param_srcValue) {
    if (IsObject(param_srcValue)) {
        this.internal_ThrowException()
    }

    ; prepare the data
    l_array := []
    if (IsObject(param_path)) {
        l_matcheskey := ""
        for Key, Value in param_path {
            l_matcheskey .= Value "."
        }
        l_matcheskey := this.trimEnd(l_matcheskey, ".")
        l_array[l_matcheskey] := param_srcValue
        ; create the fn
        BoundFunc := ObjBindMethod(this, "internal_matchesProperty", l_array)
        return BoundFunc
    }
    ; create the fn
    if (!IsObject(param_path)) {
        l_array[param_path] := param_srcValue
        return this.matches(l_array)
    }

    
}

internal_matchesProperty(param_propertyMatches,param_itaree) {
    for Key, Value in param_propertyMatches {
        fn := this.property(Key)
        itareeValue := fn.call(param_itaree)
        ; msgbox, % "Comparison to " itareeValue " from " param_itaree "`n prop: " this.printObj(Key) "`n Value: " Value
        if (this.caseSensitive ? (itareeValue == Value) : (itareeValue = Value)) {
            return true
        }
    }
    return false
}


; tests
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
assert.test(A.find(objects, A.matchesProperty("a", 4)), { "a": 4, "b": 5, "c": 6 })
assert.test(A.filter(objects, A.matchesProperty("a", 4)), [{ "a": 4, "b": 5, "c": 6 }])

objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.find(objects, A.matchesProperty(["a", "b"], 1)), { "a": {"b": 1} })


; omit
fn := A.matchesProperty("a", 1)
assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))

fn := A.matchesProperty("b", 2)
assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))
assert.false(fn.call({ "a": 1 }))
assert.false(fn.call({}))
assert.false(fn.call([]))
assert.false(fn.call(""))
assert.false(fn.call(" "))
