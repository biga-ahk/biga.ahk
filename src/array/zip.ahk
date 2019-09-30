zip(param_arrays*) {
    if (!IsObject(param_arrays)) {
        this.internal_ThrowException()
    }
    l_array := []
    
    ; loop all Variadic inputs
    for Key, Value in param_arrays {
        ; for each value in the supplied set of array(s)
        for Key2, Value2 in Value {
            loop, % param_arrays.Count() {
                if (Key2 == A_Index) {
                    ; create array if not encountered yet
                    if (!IsObject(l_array[A_Index])) {
                        l_array[A_Index] := []
                    }
                    ; push values onto the array for their position in the supplied arrays
                    l_array[A_Index].push(Value2)
                }
            }
        }
    }
    return l_array
}


; tests
assert.test(A.zip(["a", "b"], [1, 2], [true, true]),[["a", 1, true], ["b", 2, true]])
