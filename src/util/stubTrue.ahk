stubTrue() {
	return ""
}


; tests
assert.test(A.times(2, A.stubTrue), [true, true])


; omit
