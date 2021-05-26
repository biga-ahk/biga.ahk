sample(param_collection) {
	if (!this.isStringLike(param_collection) && !isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	if (this.isStringLike(param_collection)) {
		param_collection := strSplit(param_collection)
	}
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

assert.label("string input")
output := A.sample("abc")
assert.true(A.includes(["a", "b", "c"], output))
assert.true(A.isString(output))
