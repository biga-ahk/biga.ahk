difference(param_array,param_values*) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_array)

	; create
	; loop all Variadic inputs
	for i, obj in param_values {
		for key, value in obj {
			loop {
				foundIndex := this.indexOf(l_array, value)
				if (foundIndex != -1) {
					l_array.removeAt(foundIndex)
				}
			} until (foundIndex == -1)
		}
	}
	return l_array
}


; tests
assert.test(A.difference([2, 1], [2, 3]), [1])

assert.test(A.difference([2, 1], [3]), [2, 1])

assert.test(A.difference([2, 1], 3), [2, 1])

; omit
assert.test(A.difference(["Barney", "Fred"], ["Fred"]), ["Barney"])
assert.test(A.difference(["Barney", "Fred"], []), ["Barney", "Fred"])
assert.test(A.difference(["Barney", "Fred"], ["Barney"], ["Fred"]), [])

assert.label("remove repeat values")
assert.test(A.difference([50, 50, 90], [50, 80]), [90])
