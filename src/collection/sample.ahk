sample(param_collection) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }
    
    vSampleArray := this.sampleSize(param_collection)
    return vSampleArray[1]
}


; tests


; omit
output := A.sample([1, 2, 3])
assert.test(A.size(output), 1)
assert.false(IsObject(output))
