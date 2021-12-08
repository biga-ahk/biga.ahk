indexOf(param_array,param_value,fromIndex:=1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	if (isObject(param_value)) {
		param_value := this._internal_MD5(param_value)
		param_array := this.map(param_array, this._internal_MD5)
	}

	; create
	for index, value in param_array {
		if (A_Index < fromIndex) {
			continue
		}
		if (value != param_value) {
			continue
		} else {
			return index
		}
	}
	return -1
}


; tests
assert.test(A.indexOf([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.indexOf([1, 2, 1, 2], 2, 3), 4)

assert.test(A.indexOf(["fred", "barney"], "pebbles"), -1)

StringCaseSense, On
assert.test(A.indexOf(["fred", "barney"], "Fred"), -1)


; omit
StringCaseSense, Off

assert.label("array of empty object")
assert.test(A.indexOf([{}], {}), 1)
