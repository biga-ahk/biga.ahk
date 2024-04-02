sortedIndexOf(param_array, value) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	low := 1
	high := param_array.count()

	; create
	while (low <= high) {
		mid := low + (high - low) // 2
		midValue := param_array[mid]

		if (midValue < value) {
			low := mid + 1
		} else if (midValue > value) {
			high := mid - 1
		} else {
			return mid
		}
	}
	return -1
}



; tests
assert.test(A.sortedIndexOf([4, 5, 5, 6], 5), 2)

; omit
assert.equal(A.sortedIndexOf([4, 5, 5, 5, 6], 4), 1)
assert.equal(A.sortedIndexOf([4, 5, 5, 5, 6], 7), -1)
assert.equal(A.sortedIndexOf([1, 2, 3, 4, 5], 3), 3)
assert.equal(A.sortedIndexOf([1, 2, 3, 4, 5], 0), -1)
assert.equal(A.sortedIndexOf([1, 2, 3, 4, 5], 6), -1)
assert.equal(A.sortedIndexOf([1], 1), 1)
assert.equal(A.sortedIndexOf([], 5), -1)
