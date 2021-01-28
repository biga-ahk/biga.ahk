matches(param_source) {
	if (!isObject(param_source)) {
		this._internal_ThrowException()
	}

	BoundFunc := ObjBindMethod(this, "internal_matches", param_source)
	return BoundFunc
}

internal_matches(param_matches,param_itaree) {
	for Key, Value in param_matches {
		if (param_matches[Key] != param_itaree[Key]) {
			return false
		}
	}
	return true
}


; tests
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
assert.test(A.filter(objects, A.matches({ "a": 4, "c": 6 })), [{ "a": 4, "b": 5, "c": 6 }])
functor := A.matches({ "a": 4 })
assert.test(A.filter(objects, functor), [{ "a": 4, "b": 5, "c": 6 }])
assert.false(functor.call({ "a": 1 }))


; omit
