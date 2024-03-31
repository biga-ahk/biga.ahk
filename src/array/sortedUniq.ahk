sortedUniq(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []

	; create
	for key, value in param_array {
		l_printedElement := this._internal_stringify(value)
		if (l_temp != l_printedElement) {
			l_temp := l_printedElement
			l_array.push(value)
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

assert.label("Array with multiple duplicates")
arr := [1, 2, 3, 3, 4, 4, 5, 6, 7, 7, 7, 8, 8, 9, 10]
arr2 := A.sortedUniq(arr)
assert.test(arr.count(), 15)
assert.test(arr2.count(), 10)

assert.test(A.sortedUniq([4, 1, 2, 3]), [4, 1, 2, 3])

assert.label("Array with no duplicates")
assert.test(A.sortedUniq([1, 2, 3]), [1, 2, 3])

assert.label("With unsorted input")
assert.test(A.sortedUniq([1, 1, 2, 1]), [1, 2, 1])

assert.label("Array with string types and duplicates")
assert.test(A.sortedUniq(["apple", "banana", "banana", "orange", "orange", "orange", "peach"]), ["apple", "banana", "orange", "peach"])

assert.label("Empty array")
assert.test(A.sortedUniq([]), [])

assert.label("No mutation of input array")
arr := [1, 2, 2, 3, 3, 3]
A.sortedUniq(arr)
assert.test(arr, [1, 2, 2, 3, 3, 3])
