zip(param_arrays*) {
	if (!isObject(param_arrays)) {
		this._internal_ThrowException()
	}
	l_array := []

	; loop all Variadic inputs
	for key, value in param_arrays {
		; for each value in the supplied set of array(s)
		for key2, value2 in value {
			loop, % value.count() {
				if (key2 == A_Index) {
					; create array if not encountered yet
					if (isObject(l_array[A_Index]) == false) {
						l_array[A_Index] := []
					}
					; push values onto the array for their position in the supplied arrays
					l_array[A_Index].push(value2)
				}
			}
		}
	}
	return l_array
}


; tests
assert.test(A.zip(["a", "b"], [1, 2], [true, true]),[["a", 1, true], ["b", 2, true]])


; omit
obj1 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
obj2 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
assert.test(A.zip(obj1, obj2),[["one", "one"], ["two", "two"], ["three", "three"], ["four", "four"], ["five", "five"], ["six", "six"], ["seven", "seven"], ["eight", "eight"], ["nine", "nine"], ["ten", "ten"]])
