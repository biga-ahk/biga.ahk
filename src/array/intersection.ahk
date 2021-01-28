intersection(param_arrays*) {
	for Key, Value in param_arrays {
		if (!isObject(Value)) {
			this._internal_ThrowException()
		}
	}

	; prepare
	tempArray := A.cloneDeep(param_arrays[1])
	param_arrays.RemoveAt(1) ;no need to check 1st array against itself, this does not mutate the input args
	l_array := []

	; create
	for Key, Value in tempArray { ;for each value in first array
		for Key2, Value2 in param_arrays { ;for each array sent to the method
			; search all arrays for value in first array
			if (this.indexOf(Value2, Value) != -1) {
				found := true
			} else {
				found := false
				break
			}
		}
		if (found && this.indexOf(l_array, Value) == -1) {
			l_array.push(Value)
		}
	}
	return l_array
}


; tests
assert.test(A.intersection([2, 1], [2, 3]), [2])


; omit
assert.test(A.intersection([2, 1], [2, 3], [1, 2], [2]), [2])
assert.test(A.intersection([{"name": "Barney"}, {"name": "Fred"}], [{"name": "Barney"}]), [{"name": "Barney"}])
assert.test(A.intersection([1,2,3], [0], [1,2,3]), [])
intersectionVar := [1,2,3]
assert.test(A.intersection(intersectionVar, [1]), [1])
assert.test(intersectionVar, [1,2,3])
