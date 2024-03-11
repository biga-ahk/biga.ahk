isError(param_value) {

	; create
	if (param_value.hasKey("message")
	&& param_value.hasKey("what")
	&& param_value.hasKey("file")
	&& param_value.hasKey("line")) {
		return true
	}
	return false
}


; tests
assert.true(A.isError(Exception("something broke")))


; omit
assert.false(A.isError({"message": "", "what":"", "file":""}))

assert.label("object with blank values")
assert.true(A.isError({"message": "", "what":"", "file":"", "line": 10}))
