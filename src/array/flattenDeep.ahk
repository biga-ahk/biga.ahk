flattenDeep(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }

    ; data setup
    ; l_obj := this.cloneDeep(param_array)
    l_depth := this.checkDepth(param_array)
    
    ; create the return
    ; while (this.checkDepth(l_obj) != 1) {
    ;     l_obj := this.flatten(l_obj)
    ; }
    return this.flattenDepth(param_array, l_depth)
}


checkDepth(param_obj) {
    ; maxDepth := 0
    currentDepth := 1
    for Key, Value in param_obj {
        if (IsObject(Value)) {
            currentDepth += this.checkDepth(Value)
            ; if (currentDepth > maxDepth) {
            ;     maxDepth := currentDepth
            ; }
        }
    }
    return currentDepth
}


; tests
assert.test(A.flattenDeep([1]), [1])
assert.test(A.flattenDeep([1, [2]]), [1, 2])
assert.test(A.flattenDeep([1, [2, [3, [4]], 5]]), [1, 2, 3, 4, 5])

; omit
assert.test(A.checkDepth([1]), 1)
assert.test(A.checkDepth([1, [2]]), 2)
assert.test(A.checkDepth([1, [[2]]]), 3)
assert.test(A.checkDepth([1, [2, [3, [4]], 5]]), 4)