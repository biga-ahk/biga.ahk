fromPairs(param_pairs) {
	if (!isObject(param_pairs)) {
		this._internal_ThrowException()
	}

	; prepare
	l_obj := {}

	; create
	for key, value in param_pairs {
		l_obj[value[1]] := value[2]
	}
	return l_obj
}


; tests
assert.test(A.fromPairs([["a", 1], ["b", 2]]), {"a": 1, "b": 2})

; omit
assert.label("Empty array")
assert.test(A.fromPairs([], {}), {})

assert.label("Single pair")
assert.test(A.fromPairs([["a", 1]], {"a": 1}), {"a": 1})

assert.label("Multiple pairs with unique keys")
assert.test(A.fromPairs([["a", 1], ["b", 2], ["c", 3]]), {"a": 1, "b": 2, "c": 3})

assert.label("Multiple pairs with duplicate keys")
assert.test(A.fromPairs([["a", 1], ["b", 2], ["a", 3]]), {"a": 3, "b": 2})

assert.label("With keys of different types (string, number, boolean)")
assert.test(A.fromPairs([["a", 1], [2, "two"], [true, false]]), {"1": false, "a": 1, "2": "two"})

assert.label("With empty strings as keys")
assert.test(A.fromPairs([["", 1], ["b", 2]]), {"": 1, "b": 2})

assert.label("With empty values")
assert.test(A.fromPairs([["a", ""], ["b", ""], ["c", ""]]), {"a": "", "b": "", "c": ""})

assert.label("With keys containing special characters")
assert.test(A.fromPairs([["$key", 1], ["key_2", 2], ["key-3", 3]]), {"$key": 1, "key_2": 2, "key-3": 3})
