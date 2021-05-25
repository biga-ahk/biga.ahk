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
; assert.false(A.isString(1.0000))
; assert.false(A.isString(1.0001))
assert.true(A.isString("1.0000"))
