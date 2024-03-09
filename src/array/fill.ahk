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
assert.test(A.fill([1, 2, 3], "a"), ["a", "a", "a"])
assert.test(A.fill([4, 6, 8, 10], "*", 1, 3), ["*", "*", "*", 10])
assert.test(A.fill([4, 6, 8, 10], "*", 0, 3), ["*", "*", "*", 10], "if zero index is specified")
assert.test(A.fill([4, 6, 8, 10], "*", 3, 1), [4, 6, 8, 10], "param_start is geater than param_end")

assert.label("ensure that mutation did not occur")
assert.test(array, [1, 2, 3])
