sampleSize(param_collection,param_SampleSize) {
    if (!IsObject(param_collection)) {
        return false
    }
    if (param_SampleSize > param_collection.MaxIndex()) {
        return % param_collection
    }

    this.info_Array := []
    l_dummyArray := []
    loop, %param_SampleSize%
    {
        Random, randomNum, 1, param_collection.MaxIndex()
        while (this.indexOf(l_dummyArray,randomNum) != -1) {
            l_dummyArray.push(randomNum)
            Random, randomNum, 1, param_collection.MaxIndex()
        }
        this.info_Array.push(param_collection[randomNum])
        param_collection.RemoveAt(randomNum)
    }
    return % this.info_Array
}

; tests
assert.test(A.sampleSize([1, 2, 3], 2), [3, 1])
assert.test(A.sampleSize([1, 2, 3], 4), [2, 3, 1])
