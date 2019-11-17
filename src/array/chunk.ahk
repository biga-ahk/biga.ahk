chunk(param_array,param_size:=1) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }
    l_array := []
    param_array := this.clone(param_array)

    ; keep working till the parameter array is empty
    while (this.size(param_array) > 0) {
        l_InnerArr := []
        ; fill the Inner Array to the max size of the size parameter
        loop, % param_size {
            ; exit loop if there is nothing left in parameter array to work with
            if (this.size(param_array) == 0) {
                break
            }
            l_InnerArr.push(param_array.RemoveAt(1))
        }
    l_array.push(l_InnerArr)
    }
    return l_array
}


; tests
assert.test(A.chunk(["a", "b", "c", "d"], 2), [["a", "b"], ["c", "d"]])
assert.test(A.chunk(["a", "b", "c", "d"], 3), [["a", "b", "c"], ["d"]])
