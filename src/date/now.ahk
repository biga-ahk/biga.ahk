now() {

	; prepare
	nowUTC := A_NowUTC

	; create
	nowUTC -= 19700101000000, s
	return nowUTC "000"
}


; tests



; omit
assert.label("timestamps have 13 digits")
assert.test(A.size(A.now()), 13)
