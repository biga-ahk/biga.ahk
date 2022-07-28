lastIndexOf(param_array,param_value,param_fromIndex:=0) {
	if (param_fromIndex == 0) {
		param_fromIndex := param_array.count()
	}

	; create
	for index, value in param_array {
		Index -= 1
		l_negativeIndex := param_array.count() - index
		;skip search
		if (l_negativeIndex > param_fromIndex) {
			continue
		}
		if (this.isEqual(param_array[l_negativeIndex], param_value)) {
			return l_negativeIndex
		}
	}
	return -1
}


; tests
assert.test(A.lastIndexOf([1, 2, 1, 2], 2), 4)

; Search from the `fromIndex`.
assert.test(A.lastIndexOf([1, 2, 1, 2], 1, 2), 1)

StringCaseSense, On
assert.test(A.lastIndexOf(["fred", "barney"], "Fred"), -1)


; omit
StringCaseSense, Off
