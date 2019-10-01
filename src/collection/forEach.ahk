forEach(param_collection,param_iteratee := "baseProperty") {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    ; check what kind of param_iteratee being worked with
    if (!IsFunc(param_iteratee)) {
        BoundFunc := param_iteratee.Bind(this)
    }

    ; prepare data
    l_paramAmmount := param_iteratee.MaxParams
    if (l_paramAmmount == 3) {
        collectionClone := this.cloneDeep(param_collection)
    }

    ; run against every value in the collection
    for Key, Value in param_collection {
        if (!BoundFunc) { ; is property/string
            ;nothing currently
        }
        if (l_paramAmmount == 3) {
            if (!BoundFunc.Call(Value, Key, collectionClone)) {
                vIteratee := param_iteratee.Call(Value, Key, collectionClone)
            }
        }
        if (l_paramAmmount == 2) {
            if (!BoundFunc.Call(Value, Key)) {
                vIteratee := param_iteratee.Call(Value, Key)
            }
        }
        if (l_paramAmmount == 1) {
            if (!BoundFunc.Call(Value)) {
                vIteratee := param_iteratee.Call(Value)
            }
        }
        ; exit iteration early by explicitly returning false
        if (vIteratee == false) {
            return param_collection
        }
    }
    return param_collection
}


; tests


; omit
assert.test(A.forEach([1, 2], Func("forEachFunc1")), [1, 2])
forEachFunc1(value) {
   ; msgbox, % value
}
; returns `1` then `2`
