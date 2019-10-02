tail(param_array) {
    if (!IsObject(param_array)) {
        this.internal_ThrowException()
    }

    l_array := this.clone(param_array)

    ; remove Index 1 of array
    l_array.RemoveAt(1)
    ; return empty array if empty
    if (l_array.Count() == 0) {
        return []
    }
    return l_array
}


; tests
assert.test(A.tail([1, 2, 3]), [2, 3])

; omit
assert.test(A.tail([]), [])
