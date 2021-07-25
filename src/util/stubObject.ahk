stubObject() {
	return {}
}


; tests
assert.test(A.times(2, A.stubObject), [ {}, {} ])


; omit
