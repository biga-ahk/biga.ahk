join(param_array,param_sepatator:=",") {
	if (!isObject(param_array) || isObject(param_sepatator)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := this.clone(param_array)

	; create
	for l_key, l_value in l_array {
		if (A_Index == 1) {
			l_string := "" l_value
			continue
		}
		l_string := l_string param_sepatator l_value
	}
	return l_string
}


; tests
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")
assert.test(A.join(["a", "b", "c"]), "a,b,c")


; omit
assert.test(A.join({"first": 1, "second": 2, "third": 3}), "1,2,3")
assert.test(A.join({"first": 1, "second": 2, "third": 3}, "~"), "1~2~3")
