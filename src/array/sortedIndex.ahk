sortedIndex(param_array, value) {
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
    return low
}


; tests
assert.label("Insert value into sorted array at the middle")
assert.test(A.sortedIndex([30, 50], 40), 2)


; omit
assert.label("Insert value into sorted array at the beginning")
assert.test(A.sortedIndex([30, 50], 20), 1)

assert.label("Insert value into sorted array at the end")
assert.test(A.sortedIndex([30, 50], 99), 3)

assert.label("Insert value into an empty array")
assert.test(A.sortedIndex([], 42), 1)

assert.label("Insert value into a single-element array (less than the element)")
assert.test(A.sortedIndex([50], 20), 1)

assert.label("Insert value into a single-element array (greater than the element)")
assert.test(A.sortedIndex([50], 70), 2)

assert.label("Insert value that already exists in the array")
assert.test(A.sortedIndex([30, 50, 70], 50), 2)

assert.label("Insert value less than all elements in the array")
assert.test(A.sortedIndex([30, 50, 70], 10), 1)

assert.label("Insert value greater than all elements in the array")
assert.test(A.sortedIndex([30, 50, 70], 80), 4)
