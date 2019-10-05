sampleSize(param_collection,param_SampleSize := 1) {
    if (!IsObject(param_collection)) {
        this.internal_ThrowException()
    }

    if (param_SampleSize > param_collection.MaxIndex()) {
        return % param_collection
    }

    l_array := []
    tempArray := []
    loop, %param_SampleSize%
    {
        Random, randomNum, 1, param_collection.MaxIndex()
        while (this.indexOf(tempArray,randomNum) != -1) {
            tempArray.push(randomNum)
            Random, randomNum, 1, param_collection.MaxIndex()
        }
        l_array.push(param_collection[randomNum])
        param_collection.RemoveAt(randomNum)
    }
    return l_array
}


; tests
output := A.sampleSize([1, 2, 3], 2)
assert.test(output.length(), 2)

output := A.sampleSize([1, 2, 3], 4)
assert.test(output.length(), 3)
