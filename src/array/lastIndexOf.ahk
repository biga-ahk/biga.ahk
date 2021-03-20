lastIndexOf(param_array,param_value,param_fromIndex:=0) {
	if (param_fromIndex == 0) {
		param_fromIndex := param_array.count()
	}

	; create
	for Index, value in param_array {
		Index -= 1
		vNegativeIndex := param_array.count() - Index
		if (vNegativeIndex > param_fromIndex) { ;skip search
			continue
		}
		if (this.isEqual(param_array[vNegativeIndex], param_value)) {
			return vNegativeIndex
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
