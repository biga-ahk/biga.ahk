uniq(param_collection) {
	if (!isObject(param_collection)) {
		this._internal_ThrowException()
	}

	; prepare
	tempArray := []
	l_array := []

	; create
	for key, value in param_collection {
		l_printedElement := this._internal_MD5(param_collection[key])
		if (this.indexOf(tempArray, l_printedElement) == -1) {
			tempArray.push(l_printedElement)
			l_array.push(value)
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
assert.test(arr.count(), 15)
assert.test(arr2.count(), 14)

assert.label("Array with duplicate elements")
assert.test(A.uniq([2, 1, 2]), [2, 1])

assert.label("Array with no duplicate elements")
assert.test(A.uniq([1, 2, 3]), [1, 2, 3])

assert.label("Array with all elements identical")
assert.test(A.uniq([1, 1, 1]), [1])

assert.label("Empty array")
assert.test(A.uniq([]), [])
