intersection(param_arrays*) {
	if (!isObject(param_arrays[1])) {
		this._internal_ThrowException()
	}

	; prepare
	tempArray := this.cloneDeep(param_arrays[1])
	; no need to check 1st array against itself
	; this does not mutate the input arg as variadic creates a new parent array
	param_arrays.removeAt(1)
	l_array := []

	; create
	for key, value in tempArray { ;for each value in first array
		for key2, value2 in param_arrays { ;for each array sent to the method
			; search all arrays for value in first array
			if (this.indexOf(value2, value) != -1) {
				found := true
			} else {
				found := false
				break
			}
		}
		if (found && this.indexOf(l_array, value) == -1) {
			l_array.push(value)
		}
	}
	return l_array
}


; tests
assert.test(A.intersection([2, 1], [2, 3]), [2])


; omit
assert.label("many arrays")
assert.test(A.intersection([2, 1], [2, 3], [1, 2], [2]), [2])
assert.label("no intersecting values")
assert.test(A.intersection([1,2,3], [0], [1,2,3]), [])
assert.label("keyed object")
intersectionVar := {"a": 1, "b": 2}
assert.test(A.intersection([1,2,3], intersectionVar), [1,2])

assert.test(A.intersection([], [1, 2, 3]), [], "one empty array input")
assert.test(A.intersection([1, 2, 3], []), [], "one empty array input")
assert.test(A.intersection([1, 2, 2, 3], [2, 3, 3, 4]), [2, 3], "duplicate interestions")
assert.test(A.intersection(["a", "b", "c"], ["b", "c", "d"]), ["b", "c"], "non-numeric input")

assert.label("no mutation of input")
intersectionVar := [1,2,3]
assert.test(A.intersection(intersectionVar, [1]), [1])
assert.test(intersectionVar, [1,2,3])
