stubArray() {
	return []
}


; tests
assert.test(A.times(2, A.stubArray), [[], []])


; omit
