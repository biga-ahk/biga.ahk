fill(param_array,param_value:="",param_start:=1,param_end:=-1) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_array)
	if (param_end == -1) {
		param_end := this.size(param_array)
	}

	; create
	for key, value in l_array {
		if (key >= param_start && key <= param_end) {
			l_array[key] := param_value
		}
	}
	return l_array
}


; tests
array := [1, 2, 3]
assert.test(A.fill(array, "a"), ["a", "a", "a"])
assert.test(A.fill([4, 6, 8, 10], "*", 2, 3), [4, "*", "*", 10])


; omit
assert.test(A.fill([]), [])
assert.test(array, [1, 2, 3])
; ensure that mutation did not occur