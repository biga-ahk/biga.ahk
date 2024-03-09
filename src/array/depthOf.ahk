depthOf(param_array,param_depth := 1) {
    if (!isObject(param_array)) {
        this._internal_ThrowException()
    }

    max_depth := param_depth
    for key, value in param_array {
        if (isObject(value)) {
			; Increment depth for nested objects
            depth := this.depthOf(value, param_depth + 1) 
			; Update max_depth if necessary
            max_depth := this.max([depth, max_depth])
        }
    }

    return max_depth
}


; tests
assert.test(A.depthOf([1]), 1)
assert.test(A.depthOf([1, [2]]), 2)
assert.test(A.depthOf([1, [[2]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]], 5]]), 4)

; omit
assert.test(A.depthOf({"key": 1}), 1)
assert.test(A.depthOf([]), 1)
assert.test(A.depthOf([1, 2, 3]), 1)
assert.test(A.depthOf([[1, 2], [3, 4]]), 2)
assert.test(A.depthOf([[[1]], [[2]], [[3]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]]]]), 4)
