sampleSize(param_collection,param_SampleSize:=1) {
	if (!IsObject(param_collection)) {
		this.internal_ThrowException()
	}

	; return immediately if array is smaller than requested sampleSize
	if (param_SampleSize > param_collection.Count()) {
		return param_collection
	}

	; prepare data
	l_collection := this.clone(param_collection)
	l_array := []
	tempArray := []
	loop, % param_SampleSize
	{
		Random, randomNum, 1, l_collection.Count()
		while (this.indexOf(tempArray, randomNum) != -1) {
			tempArray.push(randomNum)
			Random, randomNum, 1, l_collection.Count()
		}
		l_array.push(l_collection[randomNum])
		l_collection.RemoveAt(randomNum)
	}
	return l_array
}


; tests
output := A.sampleSize([1, 2, 3], 2)
assert.test(output.length(), 2)

output := A.sampleSize([1, 2, 3], 4)
assert.test(output.length(), 3)
