join(param_collection,param_sepatator := ",") {
    if (!IsObject(param_collection)) {
        return false
    }
    l_Array := ""
    loop, % param_collection.MaxIndex() {
        if (A_Index == param_collection.MaxIndex()) {
            return % l_Array param_collection[A_Index]
        }
        l_Array := param_collection[A_Index] param_sepatator l_Array
    }
}

; tests
assert.test(A.join(["a", "b", "c"], "~"),"a~b~c")