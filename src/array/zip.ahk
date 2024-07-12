zip(param_arrays*) {
	if (!this.isArray(param_arrays)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []
	; a slower but readable idea
	; max_length := this.max(this.map(param_arrays, this.size))
	max_length := 0
	for key, array in param_arrays {
		if (array.count() > max_length) {
			max_length := array.count()
		}
	}

	; create
	loop, % max_length {
		current_index := A_Index
		; Initialize the sub-array
		sub_array := []
		for key, array in param_arrays {
			; Add the element at the current index or an empty string if the index is out of bounds
			if (current_index <= array.count()) {
				sub_array.push(array[current_index])
			} else {
				sub_array.push("")
			}
		}
		; Add the sub-array to the resulting array
		l_array.push(sub_array)
	}
	return l_array
}


; tests
assert.test(A.zip(["a", "b"], [1, 2], [true, true]), [["a", 1, true], ["b", 2, true]])


; omit
obj1 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
obj2 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
assert.test(A.zip(obj1, obj2),[["one", "one"], ["two", "two"], ["three", "three"], ["four", "four"], ["five", "five"], ["six", "six"], ["seven", "seven"], ["eight", "eight"], ["nine", "nine"], ["ten", "ten"]])

assert.label("arrays of different lengths")
assert.test(A.zip(["a", "b", "c"], [1, 2], [true, false, true]), [["a", 1, true], ["b", 2, false], ["c", "", true]])
