join(param_array,param_sepatator := ",") {
    if (!IsObject(param_array) || IsObject(param_sepatator)) {
        this.internal_ThrowException()
    }
    l_array := this.clone(param_array)
    loop, % l_array.Count() {
        if (A_Index == 1) {
            l_string := "" l_array[A_Index]
            continue
        }
        l_string := l_string param_sepatator l_array[A_Index]
    }
    return l_string
}


; tests
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")
assert.test(A.join(["a", "b", "c"]), "a,b,c")
