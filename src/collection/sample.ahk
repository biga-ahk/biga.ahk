sample(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}
	
	; prepare
	l_array := []
	for Key, Value in param_collection {
		l_array.push(Value)
	}
	
	; create
	randomIndex := this.random(1, l_array.Count())
	return l_array[randomIndex]
}


; tests


; omit
output := A.sample([1, 2, 3])
assert.test(A.size(output), 1)
assert.false(IsObject(output))

output := A.sample([{"obj": 1} , {"obj": 2}, {"obj": 3}])
assert.test(A.size(output), 1)
assert.true(IsObject(output))
