fromPairs(param_pairs) {
	if (!isObject(param_pairs)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := {}

	; create
	for Key, Value in param_pairs {
		l_obj[Value[1]] := Value[2]
	}
	return l_obj
}


; tests
assert.test(A.fromPairs([["a", 1], ["b", 2]]), {"a": 1, "b": 2})
