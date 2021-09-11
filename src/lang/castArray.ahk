castArray(param_value:="__default") {

	; prepare
	if (this.isArray(param_value)) {
		return param_value.clone()
	} else if (param_value == "__default") {
		return []
	}

	; create
	return [param_value]
}


; tests
assert.test(A.castArray(1), [1])
assert.test(A.castArray({"a": 1}), {"a": 1})
assert.test(A.castArray("abc"), ["abc"])
assert.test(A.castArray(""), [""])


; omit
assert.test(A.castArray([1, 2, 3]), [1, 2, 3])
