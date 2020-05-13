fill(param_array,param_value:="",param_start:=1,param_end:=-1) {
	if (!IsObject(param_array)) {
		this.internal_ThrowException()
	}

	; prepare data
	l_array := this.clone(param_array)
	if (param_end == -1) {
		param_end := this.size(param_array)
	}

	; create the array
	for Key, Value in l_array {
		if (Key >= param_start && Key <= param_end) {
			l_array[Key] := param_value
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