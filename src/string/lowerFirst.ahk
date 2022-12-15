lowerFirst(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	return this.tolower(subStr(param_string, 1, 1)) subStr(param_string, 2)
}


; tests
assert.test(A.lowerFirst("Fred"), "fred")
assert.test(A.lowerFirst("FRED"), "fRED")


; omit
assert.test(A.lowerFirst("--foo-bar--"), "--foo-bar--")
assert.test(A.lowerFirst("fooBar"), "fooBar")
assert.test(A.lowerFirst("__FOO_BAR__"), "__FOO_BAR__")
