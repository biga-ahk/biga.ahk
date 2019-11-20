sample(param_collection) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    ; prepare data
    vSampleArray := this.sampleSize(param_collection)
    l_array := []
    for Key, Value in param_collection {
        l_array.push(Value)
    }

    ; create
    vSampleArray := this.sampleSize(l_array)
    return vSampleArray[1]
}


; tests


; omit
output := A.sample([1, 2, 3])
assert.test(A.size(output), 1)
assert.false(IsObject(output))
