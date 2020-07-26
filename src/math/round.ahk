round(param_number,param_precision:=0) {
	if (IsObject(param_number) || IsObject(param_precision)) {
		this._internal_ThrowException()
	}

	; create
	return round(param_number, param_precision)
}


; tests
assert.test(A.round(4.006), 4)
assert.test(A.round(4.006, 2), 4.01)
assert.test(A.round(4060, -2), 4100)


; omit
