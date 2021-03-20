union(param_arrays*) {

	; prepare
	l_array := []

	; create
	for key, Array in param_arrays {
		if (isObject(Array)) {
			l_array := this.concat(l_array, Array)
		} else {
			l_array.push(Array)
		}
	}
	return this.uniq(l_array)
}


; tests
assert.test(A.union([2], [1, 2]), [2, 1])


; omit
assert.test(A.union(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
assert.test(A.union("hello!"), ["hello!"])
