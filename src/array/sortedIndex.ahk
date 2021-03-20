sortedIndex(param_array,param_value) {

	; prepare
	if (param_value < param_array[1]) {
		return 1
	}

	; create
	loop, % param_array.count() {
		if (param_array[A_Index] < param_value && param_value < param_array[A_Index+1]) {
			return A_Index + 1
		}
	}
	return param_array.count() + 1
}


; tests
assert.test(A.sortedIndex([30, 50], 40),2)
assert.test(A.sortedIndex([30, 50], 20),1)
assert.test(A.sortedIndex([30, 50], 99),3)
