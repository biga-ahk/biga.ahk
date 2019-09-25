reverse(param_collection) {
    if (!IsObject(param_collection)) {
        throw Exception("Type Error", -1)
    }
    this.info_Array := []
    while (param_collection.MaxIndex() != "") {
        this.info_Array.push(param_collection.pop())
    }
    return % this.info_Array
}


; tests
assert.test(A.reverse(["a","b","c"]), ["c","b","a"])
assert.test(A.reverse([{"foo":"bar"},"b","c"]), ["c","b",{"foo":"bar"}])
assert.test(A.reverse([[1,2,3],"b","c"]), ["c","b",[1,2,3]])
