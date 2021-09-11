toArray(param_value) {

	; create
	if (isObject(param_value)) {
		return this.map(param_value)
	} else if (this.isString(param_value)) {
		return strSplit(param_value)
	}
	return []
}


; tests
assert.test(A.toArray({"a": 1, "b": 2}), [1, 2])
assert.test(A.toArray("abc"), ["a", "b", "c"])
assert.test(A.toArray(1), [])
assert.test(A.toArray(""), [])

; omit
assert.test(A.toArray("123"), [1, 2, 3])
assert.test(A.toArray(99), [])