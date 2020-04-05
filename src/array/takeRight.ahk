takeRight(param_array,param_n:=1) {
    if param_n is not number 
    {
        this.internal_ThrowException()
    }

    if (IsObject(param_array)) {
        param_array := this.clone(param_array)
    }
    if (param_array is alnum) {
        param_array := StrSplit(param_array)
    }
    l_array := []

    ; create the slice
    loop, % param_n
    {
        if (param_array.Count() == 0) {
            continue
        }
        vValue := param_array.pop()
        l_array.push(vValue)
    }
    ; return empty array if empty
    if (l_array.Count() == 0 || param_n == 0) {
        return []
    }
    return this.reverse(l_array)
}


; tests
assert.test(A.takeRight([1, 2, 3]), [3])
assert.test(A.takeRight([1, 2, 3], 2), [2, 3])
assert.test(A.takeRight([1, 2, 3], 5), [1, 2, 3])
assert.test(A.takeRight([1, 2, 3], 0), [])
assert.test(A.takeRight("fred"), ["d"])
assert.test(A.takeRight(100), ["0"])

; omit
assert.test(A.takeRight([]), [])
assert.test(A.takeRight("fred", 3), ["r","e","d"])
assert.test(A.takeRight("fred", 4), ["f","r","e","d"])
