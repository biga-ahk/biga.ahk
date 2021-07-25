stubFalse() {
	return false
}


; tests
assert.test(A.times(2, A.stubFalse), [false, false])


; omit
