meanBy(param_array,param_iteratee:="baseProperty") {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    ; check what kind of param_iteratee being worked with
    if (!IsFunc(param_iteratee)) {
        BoundFunc := param_iteratee.Bind(this)
    }

    ; prepare data
    l_paramAmmount := param_iteratee.MaxParams
    if (l_paramAmmount == 3) {
        arrayClone := this.cloneDeep(param_array)
    }
    l_TotalVal := 0


    ; run against every value in the array
    for Key, Value in param_array {
        
        if (!BoundFunc) { ; is property/string
            ;nothing currently
        }
        if (l_paramAmmount == 3) {
            if (!BoundFunc.call(Value, Key, arrayClone)) {
                vIteratee := param_iteratee.call(Value, Key, arrayClone)
            }
        }
        if (l_paramAmmount == 2) {
            if (!BoundFunc.call(Value, Key)) {
                vIteratee := param_iteratee.call(Value, Key)
            }
        }
        if (l_paramAmmount == 1) {
            if (!BoundFunc.call(Value)) {
                vIteratee := param_iteratee.call(Value)
            }
        }
        l_TotalVal += vIteratee 
    }
    return l_TotalVal / param_array.Count()
}


; tests
array := [{"n": 4}, {"n": 2}, {"n": 8}, {"n": 6}]
assert.test(A.meanBy(array, Func("meanByFunc1")), 5)
meanByFunc1(value)
{
    return value.n
}

; omit
