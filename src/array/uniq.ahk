uniq(param_collection) {
	if (!IsObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare data
	tempArray := []
	l_array := []
	
	; create the slice
	for Key, Value in param_collection {
		printedelement := this._internal_MD5(this._printObj(param_collection[Key]))
		if (this.indexOf(tempArray, printedelement) == -1) {
			tempArray.push(printedelement)
			l_array[Key] := Value
		}
	}
	return l_array
}


; tests
assert.test(A.uniq([2, 1, 2]), [2, 1])


; omit
assert.test(A.uniq(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])

arr := [70, 88, 12, 52, 27, 14, 86, 54, 24, 55, 29, 33, 33, 25, 99]
arr2 := A.uniq(arr)
assert.test(arr.Count(), 15)
assert.test(arr2.Count(), 14)
