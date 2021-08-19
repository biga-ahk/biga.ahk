intersection(param_arrays*) {
	for key, value in param_arrays {
		if (!isObject(value)) {
			this._internal_ThrowException()
		}
	}

	; prepare
	tempArray := this.cloneDeep(param_arrays[1])
	param_arrays.removeAt(1) ;no need to check 1st array against itself, this does not mutate the input args
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
assert.label("array of objects")
assert.test(A.intersection([{"name": "Barney"}, {"name": "Fred"}], [{"name": "Barney"}]), [{"name": "Barney"}])
assert.label("no intersecting values")
assert.test(A.intersection([1,2,3], [0], [1,2,3]), [])
assert.label("no mutation of input")
intersectionVar := [1,2,3]
assert.test(A.intersection(intersectionVar, [1]), [1])
assert.test(intersectionVar, [1,2,3])
