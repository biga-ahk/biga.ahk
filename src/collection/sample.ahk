sample(param_collection) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	if (param_collection.count() != param_collection.length()) {
		l_array := this.map(param_collection)
	} else {
		l_array := param_collection.clone()
	}

	; create
	randomIndex := this.random(1, l_array.count())
	return l_array[randomIndex]
}


; tests


; omit
output := A.sample([1, 2, 3])
assert.test(A.size(output), 1)
assert.false(isObject(output))

output := A.sample([{"obj": 1} , {"obj": 2}, {"obj": 3}])
assert.test(A.size(output), 1)
assert.true(isObject(output))

output := A.sample([{"obj": "value"} , {"obj": "value"}, {"obj": "value"}])
assert.true(A.includes(output, "value"))
