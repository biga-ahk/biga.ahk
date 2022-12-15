upperFirst(param_string:="") {
	if (!this.isStringLike(param_string)) {
		this._internal_ThrowException()
	}

	; create
	return this.toUpper(subStr(param_string, 1, 1)) subStr(param_string, 2)
}


; tests
assert.test(A.upperFirst("fred"), "Fred")
assert.test(A.upperFirst("FRED"), "FRED")


; omit
assert.test(A.upperFirst("--foo-bar--"), "--foo-bar--")
assert.test(A.upperFirst("fooBar"), "FooBar")
assert.test(A.upperFirst("__FOO_BAR__"), "__FOO_BAR__")
