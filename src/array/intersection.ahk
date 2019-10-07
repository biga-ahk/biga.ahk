intersection(param_arrays*) {
    if (!IsObject(param_arrays)) {
        this.internal_ThrowException()
    }

    ; prepare data
    tempArray := A.cloneDeep(param_arrays[1])
    l_array := []

    ; create the slice
    for Key, Value in tempArray { ;for each value in first array
        for Key2, Value2 in param_arrays { ;for each array sent to the method
            ; search entire array for value in first array
            if (this.indexOf(Value2, Value) != -1) {
                found := true
            } else {
                found := false
            }
        }
        if (found) {
            l_array.push(Value)
        }
    }
    return l_array
}


; tests
assert.test(A.intersection([2, 1], [2, 3]), [2])


; omit
assert.test(A.intersection([2, 1], [2, 3], [1, 2], [2]), [2])
; assert.test(A.intersection([{"name": "Barney"}, {"name": "Fred"}], [{"name": "Barney"}]), [{"name": "Barney"}])
assert.test(A.intersection(["hello", "hello"], []))
