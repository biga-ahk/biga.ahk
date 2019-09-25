concat(param_array,param_values*) {
    if (!IsObject(param_array)) {
        throw Exception("Type Error", -1)
    }
    l_array := this.clone(param_array)
    for i, obj in param_values
    {
        if (!IsObject(obj)) {
            ; push on any plain values
            l_array.push(obj)
        } else {
            loop, % obj.MaxIndex() {
                l_array.push(obj[A_Index])
            }
        }
    }
    return l_array
}

; tests
array := [1]
assert.test(A.concat(array, 2, [3], [[4]]),[1, 2, 3, [4]])
assert.test(A.concat(array),[1])

; omit

assert.test(A.concat(array, 1),[1, 1])
