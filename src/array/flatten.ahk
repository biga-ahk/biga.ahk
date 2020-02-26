flatten(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }

    ; data setup
    l_obj := []
    
    ; create the return
    for Index, Object in param_array {
        if (IsObject(Object)) {
            for Index2, Object2 in Object {
                l_obj.push(Object2)
            }
        } else {
            l_obj.push(Object)
        }
    }
    return l_obj
}


; tests
assert.test(A.flatten([1, [2, [3, [4]], 5]]), [1, 2, [3, [4]], 5])
assert.test(A.flatten([[1, 2, 3], [4, 5, 6]]), [1, 2, 3, 4, 5, 6])

; omit
