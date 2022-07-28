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
