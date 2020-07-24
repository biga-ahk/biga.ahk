join(param_array,param_sepatator:=",") {
	if (!IsObject(param_array) || IsObject(param_sepatator)) {
		this._internal_ThrowException()
	}

	; create
	l_array := this.clone(param_array)
	for l_key, l_value in l_array {
		if (l_key == 1) {
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
