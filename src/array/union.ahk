union(param_arrays*) {

	; prepare
	l_array := []

	; create
	for key, array in param_arrays {
		if (isObject(array)) {
			l_array := this.concat(l_array, array)
		} else {
			l_array.push(array)
		}
	}
	return this.uniq(l_array)
}


; tests
assert.test(A.union([2], [1, 2]), [2, 1])


; omit
assert.test(A.union(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
assert.test(A.union("hello!"), ["hello!"])

assert.label("Arrays with no common elements")
assert.test(A.union([1, 2, 3], [4, 5, 6]), [1, 2, 3, 4, 5, 6])

assert.label("Arrays with some common elements")
assert.test(A.union([1, 2, 3], [3, 4, 5]), [1, 2, 3, 4, 5])

assert.label("Arrays with all elements identical")
assert.test(A.union([1, 2, 3], [1, 2, 3]), [1, 2, 3])

assert.label("Arrays with identical elements but in different orders")
assert.test(A.union([1, 2, 3], [3, 2, 1]), [1, 2, 3])

assert.label("Empty arrays")
assert.test(A.union([], []), [])
