round(param_number,param_precision:=0) {
	if (!this.isNumber(param_number) || !this.isNumber(param_precision)) {
		this._internal_ThrowException()
	}

	; create
	return round(param_number, param_precision)
}


; tests
assert.label("without precision")
assert.test(A.round(4.006), 4)
assert.label("with precision")
assert.test(A.round(4.006, 2), 4.01)
assert.test(A.round(4060, -2), 4100)


; omit
