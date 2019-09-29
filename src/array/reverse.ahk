reverse(param_collection) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    l_array := []
    while (param_collection.MaxIndex() != "") {
        l_array.push(param_collection.pop())
    }
    return % l_array
}


; tests
assert.test(A.reverse(["a","b","c"]), ["c","b","a"])
assert.test(A.reverse([{"foo":"bar"},"b","c"]), ["c","b",{"foo":"bar"}])
assert.test(A.reverse([[1,2,3],"b","c"]), ["c","b",[1,2,3]])
