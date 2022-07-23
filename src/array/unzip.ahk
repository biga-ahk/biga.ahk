unzip(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; prepare
	l_array := []

	; create
	for key, value in param_array[1] {
		l_array[key] := this.map(param_array, key)
	}
	return l_array
}


; tests
zipped := A.zip(["a", "b"], [1, 2], [true, false])
; => [["a", 1, true], ["b", 2, true]]
assert.test(A.unzip(zipped), [["a", "b"], [1, 2], [true, false]])


; omit
