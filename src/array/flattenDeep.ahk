flattenDeep(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_depth := this.depthOf(param_array)

	; create
	return this.flattenDepth(param_array, l_depth)
}


; tests
assert.test(A.flattenDeep([1]), [1])
assert.test(A.flattenDeep([1, [2]]), [1, 2])
assert.test(A.flattenDeep([1, [2, [3, [4]], 5]]), [1, 2, 3, 4, 5])

; omit
assert.test(A.flattenDeep({"key": 1}), [1])
assert.label("multiple levels of nesting")
assert.test(A.flattenDeep([1, [2, [3, [4, [5]]]]]), [1, 2, 3, 4, 5])
assert.label("deeply nested arrays and mixed data types")
assert.test(A.flattenDeep([1, [2, [3, [4, ["five", [6]]]]]]), [1, 2, 3, 4, "five", 6])
assert.label("deeply nested arrays and empty arrays")
assert.test(A.flattenDeep([1, [2, [3, [4, [], [5, []]]]]]), [1, 2, 3, 4, 5])
assert.label("deeply nested arrays and null/undefined elements")
assert.test(A.flattenDeep([1, [2, [3, [4, ["", ""], [5, [""]]]]]]), [1, 2, 3, 4, "", "", 5, ""])
assert.label("deeply nested arrays and arrays containing only non-array elements")
assert.test(A.flattenDeep([1, [2, [3, [4, [5], [6]], [7, 8, 9]]]]), [1, 2, 3, 4, 5, 6, 7, 8, 9])
assert.test(A.flattenDeep([]), [], "an empty array")
