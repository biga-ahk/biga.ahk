sampleSize(param_collection,param_SampleSize:=1) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; return immediately if array is smaller than requested sampleSize
	if (param_SampleSize > param_collection.count()) {
		return param_collection
	}

	; prepare
	l_collection := this.clone(param_collection)
	l_array := []
	l_order := A.shuffle(this.keys(param_collection))

	; create
	loop, % param_SampleSize
	{
		ordervalue := l_order.pop()
		l_array.push(l_collection[ordervalue])
	}
	return l_array
}


; tests
output := A.sampleSize([1, 2, 3], 2)
assert.test(output.count(), 2)

output := A.sampleSize([1, 2, 3], 4)
assert.test(output.count(), 3)


; omit
output := A.sampleSize({1:1, 8:2, "key":"value"}, 2)
assert.test(output.count(), 2)

output := A.sampleSize({1:1, 8:2, "key":"value"}, 3)
assert.true(A.includes(output, 1))
assert.true(A.includes(output, 2))
assert.true(A.includes(output, "value"))
