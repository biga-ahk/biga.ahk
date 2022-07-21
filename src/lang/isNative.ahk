; ###incomplete###
isNative(param_value) {
	if (isFunc(&param_value)) {
		return true
	}
	return false
}


; tests
boundfunc := inStr.bind("test", "t")
assert.true(A.isNative(boundfunc))
assert.false(A.isNative(A))


; omit
