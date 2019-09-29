matches(param_source) {
    if (!IsObject(param_source)) {
        this.internal_ThrowException()
    }

    ; this.matchesObj := this.cloneDeep(param_source)
    ; for Key, Value in param_source {
    ;     BoundFunc := this.internal_matches.Bind(Value)
    ;     if (BoundFunc.Call()) {
    ;         l_array.push(BoundFunc.Call())
    ;     } else {
    ;         l_array.push(param_iteratee.Call(Value))
    ;     }
    ; }
    ; return Func(this.matchesObj)
    ; BoundFunc := Func.Bind(Param1, Param2, ...)
}

internal_matches(input1) {
    
}

; tests
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]


function := A.matches({ "a": 4, "c": 6 })
assert.test(A.filter(objects, function),[{ "a": 4, "b": 5, "c": 6 }])
