reverse(param_collection) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_collection := this.cloneDeep(param_collection)
	l_array := []

	; create
	while (l_collection.count() != 0) {
		l_array.push(l_collection.pop())
	}
	return l_array
}


; tests
assert.label("Array with strings")
assert.test(A.reverse(["a", "b", "c"]), ["c", "b", "a"])
assert.label("Array with mixed types including objects")
assert.test(A.reverse([{"foo": "bar"}, "b", "c"]), ["c", "b", {"foo": "bar"}])
assert.label("Array with nested arrays")
assert.test(A.reverse([[1, 2, 3], "b", "c"]), ["c", "b", [1, 2, 3]])

; omit
assert.label("Ensure no mutation")
reverseVar := [1,2,3]
assert.test(A.reverse(reverseVar), [3, 2, 1])
assert.test(reverseVar, [1,2,3])

assert.label("Empty array")
assert.test(A.reverse([]), [])

assert.label("Array with a single element")
assert.test(A.reverse(["a"]), ["a"])

assert.label("Array with multiple elements")
assert.test(A.reverse(["a", "b", "c"]), ["c", "b", "a"])

assert.label("Array with nested arrays")
assert.test(A.reverse([[1, 2], [3, 4], [5, 6]]), [[5, 6], [3, 4], [1, 2]])

assert.label("Array with mixed types")
assert.test(A.reverse(["a", 1, true]), [true, 1, "a"])
