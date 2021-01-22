sortedUniq(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []

	; create
	for Key, Value in param_collection {
		printedelement := this._printObj(param_collection[Key])
		if (l_temp != printedelement) {
			l_temp := printedelement
			l_array.push(Value)
		}
	}
	return l_array
}


; tests
assert.test(A.sortedUniq([1, 1, 2]), [1, 2])


; omit
StringCaseSense, On
assert.test(A.sortedUniq(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
StringCaseSense, off

arr := [1, 2, 3, 3, 4, 4, 5, 6, 7, 7, 7, 8, 8, 9, 10]
arr2 := A.sortedUniq(arr)
assert.test(arr.Count(), 15)
assert.test(arr2.Count(), 10)
