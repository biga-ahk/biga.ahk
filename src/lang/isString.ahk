isString(param) {
	if (isObject(param)) {
		return false
	}
	if (ObjGetCapacity([param], 1) == "") {
		return false
	}
	return true
}


; tests
assert.true(A.isString("abc"))
assert.false(A.isString(1))

; omit
assert.true(A.isString("."))
